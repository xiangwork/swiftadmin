<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.NET High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> MIT License Code
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
	public $tableName = null;

    /**
     * 控制器/类名
     * @var string
     */
	public $controller = null;

    /**
     * 控制器方法
     * @var string
     */
	public $action = null;

    /**
     * 控制器/方法名
     * @var string
     */
	public $method = null;

    /**
     * 操作状态
     * @var int
     */
	public $status = false;

    /**
     * 错误消息
     * @var string
     */
	public $error = null;

    /**
     * 管理员信息
     * @var array
     */
    public $admin = null;

    /**
     * 管理员会话标识
     * @var string
     */
    public $sename = 'AdminLogin';

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

    /**
     * 跳转URL地址
     * @var string
     */
	public $JumpUrl = '/';

    // 后台应用全局初始化
    protected function initialize()
    {
		$this->admin = Session::get($this->sename);
		if (!isset($this->admin['id'])) {
			// 非登录跳转页面
			return $this->redirect(url('/login')->suffix(false));
		}

		$app = strtolower(str_replace('/','',request()->root()));
		$this->controller = request()->controller(true);		
		$this->action  = request()->action(true);
		$this->method = '/'.$this->controller.'/'.$this->action;
		
		// 校验权限
		$this->auth = Auth::instance();
		if (!in_array($this->method,$this->noNeedLogin)) {
			if (!$this->auth->SuperAdmin() && !$this->auth->checkauth($this->method,$this->admin['id'])) {
				if(request()->isAjax()) {
					return $this->error('没有权限!');
				}
				else {
					$this->throwError('没有权限！',403);
				}
			}
		}
		
		// 初始化字段信
		// self::sysfield();

		// 系统日志
		if (saenv('admin_log_status')) {
			$array = get_system_logs();
			$array['type'] = 2;
			Systemlog::write($array);
		}
        // 获取站点数据
        foreach (saenv('site') as $key => $value) {
            $this->app->view->assign($key,$value);
        }
		
		View::assign(['app'=>$app,'controller'=>$this->controller,'action'=>$this->action,'AdminLogin'=>$this->admin]);
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
			$status = !empty($post['status']) ? $post['status']-1:1;

			/**
			 * 筛选字段
			 */
            $where = array();
            if (!empty(input('title'))) {
                $where[] = ['title','like','%'.input('title').'%'];
			}
			

			$where[]=['status','=',$status];
			$count = $this->model->where($where)->count();
			$limit = is_empty($param['limit']) ? 10 : $param['limit'];
			$page = ($count <= $limit) ? 1 : $param['page'];
			$list = $this->model->where($where)->order("id asc")->limit($limit)->page($page)->select()->toArray();

			// TODO..
			return $this->success('查询成功', null, $list, $count, 0);
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
				$this->status = $this->model->where('id',$array['id'])->update(['status'=>$array['status']]);
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
     * @access public
     * @param  array     	$where   查询条件
     * @return array
     */	
    public function _before_where($where = []) 
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
     * @access public
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
	public static function sysfield() 
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

}
