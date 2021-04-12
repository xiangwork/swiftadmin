<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2019-2020 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.NET High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>，河北赢图网络科技版权所有
// +----------------------------------------------------------------------
namespace app;
use think\facade\Db;
use think\facade\View;
use think\facade\Session;
use app\common\library\Auth;
use app\common\model\system\Systemlog;

// 后台全局控制器基类
class AdminController extends BaseController 
{

    /**
     * 数据库实例
     * @var object
     */
	public $model = null;

    /**
     * 是否验证
     * @var bool
     */
	public $isValidate = true;

    /**
     * 验证场景
     * @var string
     */
	public $scene = '';

    /**
     * 数据表名称
     * @var string
     */
	public $tableName = '';

    /**
     * 操作状态
     * @var int
     */
	public $status = false;

    /**
     * 错误消息
     * @var string
     */
	public $error = '';

    /**
     * 权限验证类
     * @var object
     */
    public $auth = null;

    /**
     * 不需要鉴权的方法
     * @var array
     */
	public $noNeedLogin = [
		'/index/index', // 后台首页
	];

    // 后台应用全局初始化
    protected function initialize()
    {
		$AdminLogin = session::get('AdminLogin');
		if (!isset($AdminLogin['id'])) {
			// 非登录跳转页面
			return $this->redirect(url('/login')->suffix(false));
		}

		$app = strtolower(str_replace('/','',request()->root()));
		$controller = request()->controller(true);		
		$action  = request()->action(true);
		$authURL = '/'.$controller.'/'.$action;
		
		// 校验权限
		if (!in_array($authURL,$this->noNeedLogin)) {
	
			$this->auth = Auth::instance();
			if (!$this->auth->SuperAdmin() 
					&& !$this->auth->checkauth($authURL,$this->getLoginId())) {
				if(request()->isAjax()) {
					return $this->error('没有权限!');
				}
				else {
					$this->throwError('没有权限！',403);
				}
			}
		}
		
		// 初始化字段信息
		$this->sysfield();
		$this->writeLogs();
		View::assign(['app'=>$app,'controller'=>$controller,'action'=>$action,'AdminLogin'=>$AdminLogin]);
	}

	/**
	 * 登录Id
	 */
	public function getLoginId() 
	{
		return $this->getAdminLogin('id');
	}

	/**
	 * 管理员信息
	 */
	public function getAdminLogin($key = null) 
	{
		$session = session('AdminLogin');
		return $key ? $session[$key] : $session;
	}

	/**
	 * 获取资源
	 */
	public function index() 
	{

		if (request()->isAjax()) {

			$param = input();
			$param['page'] = input('page/d');
			$param['limit'] = input('limit/d');

			/**
			 * 筛选字段
			 */
            $where = array();
            if (!empty(input('title'))) {
                $where[] = ['title','like','%'.input('title').'%'];
			}
			
			if (!empty(input('status'))) {
				if(input('status') == 1){
					$where[]=['status','=','1'];
				}elseif(input('status') == 2){
					$where[]=['status','=','0'];
				}		
			}

			$count = $this->model->where($where)->count();
			$limit = is_empty($param['limit']) ? 10 : $param['limit'];
			$page = ($count <= $limit) ? 1 : $param['page'];
			$list = $this->model->where($where)->order("id asc")->limit($limit)->page($page)->select()->toArray();

			// TODO..
			return $this->success('查询成功', "", $list, $count, 0);
		}

		return view();
	}

	/**
	 * 添加资源
	 */
	public function add() 
	{
		if (request()->isPost()) {

			$post = input();
			$validate = $this->isValidate ? $this->model::class : $this->isValidate;
            $post = safe_field_model($post,$validate,$this->scene);
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }

            Db::startTrans();
			try {
                $this->status = $this->model->create($post);
                Db::commit();
            } catch (\PDOException $e) {
                Db::rollback();
                return $this->error($e->getMessage());
            } catch (\Throwable $th) {
                Db::rollback();
                return $this->error($th->getMessage());
            }
			
			return $this->status ? $this->success() : $this->error();
		}

		return view('',['data'=> $this->getField()]);
	}

	/**
	 * 编辑资源
	 */
	public function edit() 
	{

        if (request()->isPost()) {
			$post = input();
			$validate = $this->isValidate ? $this->model::class : $this->isValidate;
            $post = safe_field_model($post,$validate,$this->scene);
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
			}

            Db::startTrans();
			try {
                $this->status = $this->model->update($post);
                Db::commit();
            } catch (\PDOException $e) {
                Db::rollback();
                return $this->error($e->getMessage());
            } catch (\Throwable $th) {
                Db::rollback();
                return $this->error($th->getMessage());
            }
			
			return $this->status ? $this->success() : $this->error();
		}
		
		// iframe页面
        $id = input('id/d');
		$data = $this->model->find($id);
		return View('add',['data'=>$data]);	
	}

	/**
	 * 删除资源
	 */
    public function del() 
	{

        $id = input('id'); 
        !is_array($id) && ($id = array($id));

        if (!empty($id) && is_array($id)) {

            Db::startTrans();
			try {
                $where[] = ['id','in',implode(',',$id)];
                $list = $this->model->where($where)->select();
                foreach ($list as $index => $item) {
                    $this->status += $item->delete();
                }
                Db::commit();
            } catch (\PDOException $e) {
                Db::rollback();
                return $this->error($e->getMessage());
            } catch (\Throwable $th) {
                Db::rollback();
                return $this->error($th->getMessage());
            }
            
            $this->status && $this->success();
        }

        return $this->error();
	}
	
    /**
     * 查看回收站
     * @access protected
     * @param  null      		
     * @return string		
     */	
	public function recyclebin() 
	{

        if (request()->isAjax()) {
            $where = [];
            if (input('name/s')) {
                $where[] = ['name','like','%'.input('name/s').'%'];
			}

			try {
				$list = $this->model->onlyTrashed()->where($where)->select();
            } catch (\PDOException $e) {
                return $this->error($e->getMessage());
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
            
            return $this->success('查询成功', "", $list, count($list), 0);
        }

		$controller = \strtolower(request()->Controller());
		$controller= (string)url('/'.$controller.'/',[],false);
		return view('/public/recyclebin',['controller'=>$controller]);
    }

    /**
     * 恢复数据/资源
     * @access protected
     * @param  null      		
     * @return string		
     */	
	public function restore() 
	{

        if (request()->isAjax()) {
            
			Db::startTrans();
			try {
                $list = $this->model->onlyTrashed()
                                    ->where($this->_before_where())
                                    ->select();
                foreach ($list as $index => $item) {
                    $this->status += $item->restore();
                }

                Db::commit();
            } catch (\PDOException $e) {
                Db::rollback();
                return $this->error($e->getMessage());
            } catch (\Throwable $th) {
                Db::rollback();
                return $this->error($th->getMessage());
            }
            
            $this->status && $this->success();
        }

        return $this->error();
	}

    /**
     * 删除资源/清空回收站
     * @access protected
     * @param  null      		
     * @return string		
     */	
	public function destroy() 
	{

        if (request()->isAjax()) {
            Db::startTrans();
			try {
                $list = $this->model->onlyTrashed()
                                    ->where($this->_before_where())
                                    ->select();
                foreach ($list as $index => $item) {
                    $this->status += $item->force()->delete();
                }
                Db::commit();
            } catch (\PDOException $e) {
                Db::rollback();
                return $this->error($e->getMessage());
            } catch (\Throwable $th) {
                Db::rollback();
                return $this->error($th->getMessage());
            }
            
            $this->status && $this->success();
        }

        return $this->error();
	}

	/**
	 * 修改资源状态
	 */
	public function status() 
	{
		if (request()->isAjax()) {

			$array = array();
			$array['id'] = input('id/d');	
			$array['status'] = input('status/d');

			Db::startTrans();
			try {
				$this->status = $this->model->update($array);
                Db::commit();
            } catch (\PDOException $e) {
                Db::rollback();
                return $this->error($e->getMessage());
            } catch (\Throwable $th) {
                Db::rollback();
                return $this->error($th->getMessage());
            }
            
            $this->status && $this->success();	
		}

		return $this->error();
	}
    
    /**
     * 数据预处理
     * @access protected
     * @param  array     	$where   查询条件
     * @return array
     */	
    private function _before_where($where = []) 
	{
        $ids = input('id') ?? 'all';
        if (is_array($ids) && !empty($ids)) {
            $where[] = ['id','in',\implode(',',$ids)];
        }
        else if ($ids == 'all') {
            $where[] = ['id','<>','null'];
        }else if (\is_numeric($ids)) {
            $where[] = ['id','=',$ids];
        }
        return $where;
	}

	/**
	 * 递归查询父节点
     * @access protected
     * @param  int       		$pid   		查询条件
     * @param  array       		$array   返回数组
     * @return array
	 */
	public function parentNode($pid, &$array=[]) 
	{

		$result = $this->model->where('id',$pid)->find()->toArray();
		if (!empty($result)) {
			/**
			 * 多语言字段
			 */
			if (isset($result['title'])) {
				$result['title'] = __($result['title']);
			}
			
			$array[] = $result;
			if ($result['pid'] !== 0) {
				$this->parentNode($result['pid'], $array);
			}
		}

		return $array;
	}
	
	/**
	 * 生成字典
	 */
	public function sysfield() 
	{
		$debug = env('app_debug') || 0;
		if(!is_file(config_path().'sysfield.php') ||  $debug = 1) {
			// 查询所有表
			$mysql_base = config('database.connections.mysql.database');
			$mysql_prefix = config('database.connections.mysql.prefix'); 
			$mysql_table = db::query('SHOW TABLES FROM'.' '.$mysql_base);
			
			// 获取查询数据表
			if (!empty($mysql_table) && is_array($mysql_table)) {

				$field = array();
				$tables = 'Tables_in_'.strtolower($mysql_base);
				foreach ($mysql_table as $key => $value) {
					
					// 替换表前缀下划线 / 转换小写
					$scname = \strtolower(str_replace(array($mysql_prefix,'_'),'',$value[$tables])); //schema
					$schema = db::query('SHOW FULL COLUMNS FROM `'.$value[$tables].'`'); 
					foreach ($schema as $keys => $elem) {
						$field[$scname][$elem['Field']] = $elem['Type'];
					}
				}
				
				// 写入到配置信息
				arr2file('../config/sysfield.php', $field);
			}			
		}
	}

	/**
	 * 写入系统操作日志
	 */
	public function writeLogs() 
	{
		if (config('system.logs.admin_log_status')) {
			$array = get_system_logs();
			$array['type'] = 2;

			Systemlog::write($array);
		}
	}

	/**
     * 获取初始化字段数组
     * @access protected
     * @return array|string|true
     * @throws ValidateException
     */	
	protected function getField($controller = null) 
	{
		
		$controller = $controller ?? \strtolower(request()->Controller());
		if (($begin = strrchr($controller,'.'))) {
			$controller = \str_replace('.','',$begin);
		}
		
		$fieldArray = config('sysfield.'.$controller);	

		if (!empty($fieldArray)) {
			foreach ($fieldArray as $key => $val) {
				$fieldArray[$key] = '';
			}

			$fieldArray['status'] = 1;
			$fieldArray['addtime'] = time();
			$fieldArray['lasttime'] = time();
			
		}else {
			return $this->error('未获取到数据,请刷新缓存！');
		}
		
		return $fieldArray;
	}

}
