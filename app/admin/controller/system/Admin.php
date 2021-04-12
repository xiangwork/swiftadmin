<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2019-2020 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>，河北赢图网络科技版权所有
// +----------------------------------------------------------------------

namespace app\admin\controller\system;


use app\AdminController;
use think\facade\Db;
use think\facade\request;
use app\common\library\Auth;
use app\common\model\system\Admin as AdminModel;
use app\common\model\system\AdminGroup as AdminGroupModel;
use app\common\model\system\AdminRules as AdminRulesModel;
use app\common\model\system\AdminAccess as AdminAccessModel;

class Admin extends AdminController
{

    // 分组数组
    protected $group;

	// 初始化函数
    public function initialize() 
    {
		parent::initialize();
        $this->model = new AdminModel();
        $this->group = AdminGroupModel::select()->toArray();
        foreach ($this->group as $k => $v) {
            $this->group[$k]['title'] = __($v['title']);
        }
		$this->middleware = [
			\app\admin\middleware\system\Admin::class,
	    ];
    }

    /**
     * 获取资源列表
     */
    public function index() 
    {
        // 判断isAjax
        if (request()->isAjax()) {

            // 获取数据
            $post = input();
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;
            
            // 生成查询条件
            $where = array();
            if (!empty($post['name'])) {
                $where[] = ['name','like','%'.$post['name'].'%'];
            }

            if (!empty($post['dep'])) {
                $where[] = ['dep_id','find in set',$post['dep']];
            }

            if (!empty($post['group_id'])) {
                $where[] = ['group_id','find in set',$post['group_id']];
            }

            if (!empty($post['status'])) {
                if($post['status'] == 1){
                    $where[]=['status','=','1'];
                }elseif($post['status'] == 2){
                    $where[]=['status','=','0'];
                }		
            }

            // 生成查询数据
            $count = $this->model->where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;
            $list = $this->model->where($where)->order("id asc")->limit($limit)->page($page)->select()->toArray();
        
            // 循环处理数据
            foreach ($list as $key => $value) {

                $list[$key]['loginip'] = long2ip($value['createip']);
                $groupIds = explode(',',$value['group_id']);
                foreach ($groupIds as $field => $group_id) {
                    if ($result = list_search($this->group,['id'=>$group_id])) {
                        $list[$key]['group'][$field] = $result;
                    }
                }

                if (!empty($list[$key]['group'])) {
                    $list[$key]['group'] = list_sort_by($list[$key]['group'],'id');
                }
               
            }
            
            return $this->success('查询成功', "", $list, $count, 0);
        }

        $depData = Db::name('Department')->select()->toArray();
        $depData = list_to_tree($depData);
		return view('',[
            'group'=> $this->group,
            'depData'=> json_encode($depData),
        ]);
    }

    /**
     * 添加管理员
     */
    public function add() 
    {
        if (request()->isPost()) {
            
            // 验证数据
            $post = input('post.');
            $post = safe_field_model($post,$this->model::class);
			if (!is_array($post)) {
				return $this->error($post);
            }

			$where[] = ['name','=',$post['name']];
			$where[] = ['email','=',$post['email']];
            if ($this->model->whereOr($where)->find()) {
                return $this->error('该用户名或邮箱已被注册！');
            }

            // 管理员加密
            $post['pwd'] = hasha($post['pwd']);
            $post['createip'] = ip2long(request()->ip());
            $data = $this->model->create($post);
            if (!is_empty($data->id)) {
                $access['uid'] = $data->id;
                $access['group_id'] = $data->group_id;
                AdminAccessModel::insert($access);
                return $this->success('添加管理员成功！');
            }else {
                return $this->error('添加管理员失败！');
            }
        }
        
        // 获取用户组
        return view('',['group'=> $this->group]);
    }

    /**
     * 更新管理员
     */
    public function edit() 
    {
		if (request()->isPost()) {

            $id = input('id/d');
            $post = input('post.');

			if (!empty($id) && is_numeric($id)) {
			
                // 验证数据
                $post = input('post.');
                $post = safe_field_model($post,$this->model::class);
                if (!is_array($post)) {
                    return $this->error($post);
                }

                // 修改密码
                $data = $this->model->find($id);
				if (!empty($data) && $data['pwd'] != $post['pwd']) {
					$post['pwd'] = hasha($post['pwd']);
                }

                if ($this->model->update($post)) {
                    $access['group_id'] = $post['group_id'];
                    AdminAccessModel::where('uid',$id)->update($access);
					return $this->success('更新管理员成功！');
				}else {
					return $this->error('更新管理员失败');
				}
			}
		}
    }

    /**
     * 获取用户组
     */
    public function getGroupOrJobs() 
    {
        if (request()->isAjax()) {

            $array = [];
            $authList = [];
            $ids = input('ids/s');
            $type = input('type/s');
            $ids = is_empty($ids) ? [] : explode(',',$ids);

            if ($type == 'jobs') {
                $array = \app\common\model\system\Jobs::select()->toArray();
            }
            else {
                $array = $this->group;
            }
            
            // 循环处理数据
            foreach ($array as $key => $value) {
                $authList[$key]['name'] = $value['title'];
                $authList[$key]['value'] = $value['id'];
                if (array_search($value['id'], $ids) !== false) {
                    $authList[$key]['selected'] = true;
                }
            }

            return json_encode($authList);
        }
    }

    /**
     * 获取私有权限
     */
    public function getPrivateRules() 
    {
        if (request()->isAjax()) {
            return Auth::instance()->getPrivateRules();
        }
    }   

    /**
     * 查询权限节点
     */
    public function queryRules($id) 
    {
        if (request()->isAjax()) {
            return json(Auth::instance()->getauthNode($id));
        }        
    }

    /**
     * 编辑权限
     */
    public function editRules() 
    {

        if (request()->isPost()) {

            $accessId  = input('id/d');
            $authGroup = input('GroupAuth') ?? [];
            $authPrivate = input('rules') ?? [];
            if (empty($authGroup)) {
                $authList = implode(',',$authPrivate);
            }else {
                $authList = array_diff(array_values($authPrivate), $authGroup);
                $authList = implode(',',$authList);
            }

            if (!empty($authList)) {
                if (!Auth::instance()->checkPrivateRules(explode(',',$authList))) {
                    return $this->error('非法操作!');
                }
            }
            
            $authRules = AdminAccessModel::where('uid',$accessId)->find();
            if (empty($authRules)) {
                $authRules = new AdminAccessModel();
            }

            $authRules->uid = $accessId;
            $authRules->rules = $authList;
            if ($authRules->save()) {
                return $this->success('更新权限成功！');
            }
            return $this->error('更新权限失败！');

        }
    }

    /**
     * 获取私有栏目权限
     */
    public function getPrivateCates() 
    {
        if (request()->isAjax()) {
            return Auth::instance()->getPrivateCateIds();
        }
    }   

    /**
     * 查询栏目权限节点
     */
    public function querycates($id) 
    {
        if (request()->isAjax()) {
            return json(Auth::instance()->getauthNode($id,'cateids'));
        }        
    }

    /**
     * 编辑栏目权限
     */
    public function editCates() 
    {

        if (request()->isPost()) {
            $accessId  = input('id/d');
            $authGroup = input('GroupAuth') ?? [];
            $authPrivate = input('cateids') ?? [];
            if (empty($authGroup)) {
                $authList = implode(',',$authPrivate);
            }else {
                $authList = array_diff(array_values($authPrivate), $authGroup);
                $authList = implode(',',$authList);
            }

            if (!empty($authList)) {
                if (!Auth::instance()->checkPrivateCateIds(explode(',',$authList))) {
                    return $this->error('非法操作!');
                }
            }
            
            $authRules = AdminAccessModel::where('uid',$accessId)->find();
            if (empty($authRules)) {
                $authRules = new AdminAccessModel();
            }

            // 更新权限
            $authRules->uid = $accessId;
            $authRules->cateids = $authList;
            if ($authRules->save()) {
                return $this->success('更新栏目权限成功！');
            }
            return $this->error('更新栏目权限失败！');
        }
    }

    /**
     * 获取用户菜单
     */
    public function getAuthMenus() 
    {
        if (request()->isAjax()) {
            
            $id = $this->getLoginId();
            $authNode = Auth::instance()->getauthNode($id);
            $authNode['UserGroupId'] = $this->getAdminLogin('group_id');

            $where[] = ['status','=','normal'];
            if (!Auth::instance()->SuperAdmin()) {
                if (!empty($authNode['UserRules'])) {
                    $where[] = ['id','in',$authNode['UserRules']];
                }    
                $list = AdminRulesModel::where($where)->whereOr('auth','0')->order('sort asc')->select()->toArray();         
            }
            else {
                $list = AdminRulesModel::where($where)->order('sort asc')->select()->toArray();
            }
        
            foreach ($list as $key => $value) {
                $authNode['UserAuth'][$key] = $value['alias'];
                $authNode['UserRouter'][$key] = $value['router'];
                $list[$key]['title'] = __($value['title']);
                /**
                 * 鉴权类尽量规避调用缓存
                 */
                $authNode['everycate'] = $value['router'] == 'everycate' ? true : false;
                $authNode['privateauth'] = $value['router'] == 'privateauth' ? true : false;
                if ($value['type'] !== 0 ) {
                    unset($list[$key]);
                }
            }

            // 缓存数据
            session('AdminLogin.AdminAuth',$authNode);
            $authNode['UserAuthMenu'] = list_to_tree($list);
            return json($authNode);
       }

       $this->throwError('',403);
    }

    /**
     * 模版页面
     */
    public function theme() 
    {
        return view();
    }

    /**
     * 消息模板
     */
    public function message() 
    {
        // 配置消息
        $msg = [
            'msg'=> [
                '0'=> [
                    'title'=>'你收到了几份周报！',
                    'type'=>'周报类型',
                    'createtime'=>'1周前',
                ],
                '1'=> [
                    'title'=>'你收到了来自女下属的周报',
                    'type'=>'周报类型',
                    'createtime'=>'2周前',
                ]
            ],
            'comment'=> [
                '0'=> [
                    'title'=>'一个领导评论了你',
                    'content'=>'小伙子不错，继续努力！',
                    'createtime'=>'1周前',
                ]
            ],
            'things'=> [
                '0'=> [
                    'title'=>'客户说尽快修复瞟了么APP闪退的问题...',
                    'type'=>'0',
                    'createtime'=>'1周前',
                ],
                '1'=> [
                    'title'=>'秦老板和经销商的下季度合同尽快签订！',
                    'type'=>'1',
                    'createtime'=>'2周前',
                ]
            ],
        ];
        

        return view('',[
            'list' => $msg
        ]);
    }

    /**
     * 个人中心
     */
    public function center() 
    {

        if (request()->isPost()) {
            $post = input(); // 获取POST数据
            $post['id'] = $this->getLoginId();
            if ($this->model->update($post)) {
                return $this->success();
            }

            return $this->error();
        }

        $title = [];
        $data = $this->model->find($this->getLoginId());
        if (!empty($data['group_id'])) {
            $group = AdminGroupModel::field('title')
                                    ->whereIn('id',$data['group_id'])
                                    ->select()
                                    ->toArray();
            foreach ($group as $key => $value) {
                $title[$key] = $value['title'];
            }
        }

        $data['group'] = implode('－',$title);
        $data['tags'] =  empty($data['tags']) ? $data['tags'] : unserialize($data['tags']);
        return view('',['data'=>$data]);

    }

    /**
     * 修改个人资料
     */
    public function modify() 
    {
        if (request()->isAjax()) {
            $post = input('post.');
            $id = $this->getLoginId();
            try {
                //code...
                switch ($post['field']) {
                    case 'face':
                        $id = $this->model->update(['id'=>$id,'face'=>$post['face']]);
                        break;
                    case 'mood':
                        $id = $this->model->update(['id'=>$id,'mood'=>$post['mood']]);
                        break;   
                    case 'tags':
                        if (\is_empty($post['tags'])) {
                            break;
                        }
                        $data = $this->model->field('tags')->find($id);
                        if (!empty($data['tags'])) {
                            $tags = unserialize($data['tags']);
                            if(!empty($post['del'])) { 
                                foreach ($tags as $key => $value) {
                                    if ($value == $post['tags']) {
                                        unset($tags[$key]);
                                    }
                                }
                            }else {
                                $merge = array($post['tags']);
                                $tags = array_unique(array_merge($merge,$tags));
                                if (count($tags) > 10) {
                                    throw new \think\Exception('最多拥有10个标签！');
                                }
                            }
                            $tags = serialize($tags);
                        }else {
                            $tags = serialize(array($post['tags']));
                        }
                        $id = $this->model->update(['id'=>$id,'tags'=>$tags]);
                        break;                     
                    default:
                        # code...
                        break;
                }
              
            } catch (\Exception $e) {
                return $this->error($e->getMessage());
            }

            return $id ? $this->success() : $this->error();
        }
    }

    /**
     * 修改密码
     */
    public function pwd() 
    {
        if (request()->isPost()) {
            
            $pwd = input('pwd/s');
            $post = Request::except(['pwd']);
            if ($post['pass'] !==  $post['repass']) {
                return $this->error('两次输入的密码不一样！');
            }

            // 查找数据
            $where[] = ['id','=',$this->getLoginId()];
            $where[] = ['pwd','=',hasha($pwd)];
            $result = $this->model->where($where)->find();

            if (!empty($result)) {
                $this->model->where($where)->update(['pwd'=>hasha($post['pass'])]);
                $this->success('更改密码成功！');
            }else {
                $this->error('原始密码输入错误');
            }

        }

        return view();
    }

    /**
     * 语言配置
     */
    public function language() 
    {
        $language = input('l/s');
        $env = root_path().'.env';
        $array = parse_ini_file($env,true);
        $array['LANG']['default_lang'] = $language;
        $content = parse_array_ini($array);
        if (write_file($env,$content)) {
            return json(['success']);
        }
    }

    /**
     * 更改状态
     */
	public function status() 
    {
		$id = input('id/d');
		$status = input('status/d');
		if ($id && is_int($id) && is_int($status)) {            
            $array['id'] = $id;
            $array['status'] = $status;
			if ($this->model->update($array)){
				return $this->success('修改成功！');
			}
		}

		return $this->error('修改失败,请检查您的数据！');		
	}

    /**
     * 删除管理员
     */
	public function del()
    {
        $id = input('id');
        !is_array($id) && ($id = array($id));
		if (!empty($id) && is_array($id)) {

            // 过滤权限
            if (array_search("1",$id) !== false) {
                return $this->error('禁止删除超管帐号！');
            }

			// 删除用户
			if ($this->model->destroy($id)) {
                $arr = implode(',',$id);
                $where[] = ['uid','in',$arr];
				AdminAccessModel::where($where)->delete();
				return $this->success('删除管理员成功！');
			}
		}
		
		return $this->error('删除管理员失败，请检查您的参数！');
    }


    /**
     * 清理系统缓存
     */
    public function clear() 
    {
        if (request()->isPost()) {

            $type = input('type/s');
            
            try {
                // 清理内容
                if ($type == 'all' || $type == 'content') {
                    recursiveDelete(root_path().'runtime');
                    \think\facade\Cache::clear();
                }

                // 清理模板
                if ($type == 'all' || $type == 'template') {
                    recursiveDelete(root_path().'runtime'.'\\temp');
                }

                // 清理插件缓存
                if ($type == 'all' || $type == 'plugin') {
                    plugin_refresh_hooks();
                }
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
        }
        
        return $this->success('清理缓存成功，请刷新页面！');
    }
}
