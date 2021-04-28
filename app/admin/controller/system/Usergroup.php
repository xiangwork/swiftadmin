<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>  MIT License Code
// +----------------------------------------------------------------------
namespace app\admin\controller\system;


use app\AdminController;
use app\common\model\system\UserGroup  as UserGroupModel;

class UserGroup extends AdminController 
{
   
    // 初始化函数
    public function initialize() 
	{
        parent::initialize();
        $this->model = new UserGroupModel();
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

			// 查询条件
			$where = array();
			if (!empty($param['title'])) {
				$where[] = ['title','like','%'.$param['title'].'%'];
			}
			if (!empty($param['alias'])) {
				$where[] = ['alias','like','%'.$param['alias'].'%'];
			}
			if (!empty($param['content'])) {
				$where[] = ['content','like','%'.$param['content'].'%'];
			}

			// 查询数据
            $count = $this->model->where($where)->count();
            $limit = is_empty($param['limit']) ? 10 : $param['limit'];
            $page = ($count <= $limit) ? 1 : $param['page'];
			$list = $this->model->where($where)->order("id asc")->limit($limit)->page($page)->select()->toArray();
			foreach ($list as $key => $value) {
				$list[$key]['title'] = __($value['title']);
			}

			return $this->success('查询成功', null, $list, $count, 0);
		}

        return view('system/user/group');
    }

}   