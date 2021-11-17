<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> MIT License Code
// +----------------------------------------------------------------------
namespace app\admin\controller\system;


use app\AdminController;
use app\common\model\system\User  as UserModel;
use app\common\model\system\UserGroup  as UserGroupModel;
class User extends AdminController 
{
   
    // 初始化函数
    public function initialize() 
    {
        parent::initialize();
        $this->model = new UserModel();
        $this->userGroup = UserGroupModel::select()->toArray();
    }
  
	/**
	 * 获取资源
	 */
	public function index() 
    {

		if (request()->isAjax()) {

            // 获取数据
            $post = input();
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;
            $status = !empty($post['status']) ? $post['status']-1:1;
            
            // 生成查询条件
            $where = array();
            if (!empty($post['name'])) {
                $where[] = ['name','like','%'.$post['name'].'%'];
            }

            if (!empty($post['group_id'])) {
                $where[] = ['group_id','find in set',$post['group_id']];
            }

            // 生成查询数据
            $where[]=['status','=',$status];
            $count = $this->model->where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;
            $list = $this->model->where($where)->order("id asc")->limit($limit)->page($page)->select()->toArray();

            // 循环处理数据
            foreach ($list as $key => $value) {
                $list[$key]['region'] = query_client_ip( $list[$key]['loginip']); 
                $result = list_search($this->userGroup,['id'=>$value['group_id']]);
                if (!empty($result)) {
                    $list[$key]['group'] = $result['title'];
                }
            }

			// TODO..
			return $this->success('查询成功', "", $list, $count, 0);
		}

		return view('',[
            'userGroup'=> $this->userGroup,
        ]);
    }

    /**
     * 添加会员
     */
    public function add() 
    {

        if (request()->isPost()) {
			$post = input('post.');
            $post = safe_field_model($post,$this->model::class);
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }

            // 禁止重复注册
            $whereName[] = ['name','=',$post['name']];
            $whereEmail[] = ['email','=',$post['email']];
			if($this->model->whereOr([$whereName,$whereEmail])->find()) {
				return $this->error('该用户ID或邮箱已经存在！');
            }

            if ($this->model->create($post)) {
                return $this->success('注册成功！');
            }

            return $this->error('注册失败！');
        }
    }

    /**
     * 编辑会员
     */
    public function edit() 
    {

        if (request()->isPost()) {
			$post = input();
            $post = safe_field_model($post,$this->model::class);
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }
            // 查询数据
            $data = $this->model->find($post['id']);
            if ($data['name'] != $post['name']) {
                $whereName[] = ['name','=',$post['name']];
                if($this->model->where($whereName)->find()) {
                    return $this->error('该用户ID已经存在！');
                }
            }

            if ($data['email'] != $post['email']) {
                $whereEmail[] = ['email','=',$post['email']];
                if($this->model->where($whereEmail)->find()) {
                    return $this->error('该用户邮箱已经存在！');
                }
            }

            // 修改密码
            if (!empty($data) && $data['pwd'] != $post['pwd']) {
                $post['pwd'] = hash_pwd($post['pwd']);
            }

            if ($this->model->update($post)) {
                return $this->success('更新成功！');
            }

            return $this->error('更新失败！');
        }        
    }

    /**
     * 删除会员
     */
    public function del()
    {
        $this->error('不允许删除会员');
    }

}   
