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
use app\common\model\system\Navmenu as NavmenuModel;

class Navmenu extends AdminController
{
	// 初始化操作
    public function initialize() 
    {
		parent::initialize();
        $this->model = new NavmenuModel();
    }

    /**
     * 获取资源列表
     */
    public function index()
    {

        if (request()->isAjax()) {

            // 获取数据
            $list = $this->model->getListNav();
            return $this->success('查询成功', "", $list, count($list), 0);
        }

		return view('',[
            'navmenu'=> json_encode($this->model->getListTree())
        ]);
    }

    /**
     * 添加导航
     */
    public function add () 
    {

		if (request()->isPost()) {
			$post = input('post.');
            $post = safe_field_model($post,get_class($this->model));
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }

            if ($this->model->create($post)){
                return $this->success();
            }

            return $this->error();
        }
    }

    /**
     * 编辑导航
     */
    public function edit() 
    {

        if (request()->isPost()) {
            
            $post = input('post.'); 
            $post = safe_field_model($post,get_class($this->model));
			if (empty($post) || !is_array($post)) {
				return $this->error($post);
            }
            
            if ($this->model->update($post)){
                return $this->success();
            }
            
            return $this->error();
        }
    }

}