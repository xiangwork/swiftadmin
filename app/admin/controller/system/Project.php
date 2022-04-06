<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> Apache 2.0 License Code
// +----------------------------------------------------------------------

namespace app\admin\controller\system;

use app\AdminController;
use app\common\model\system\Project as ProjectModel;
use system\Random;

class Project extends AdminController
{

	// 初始化函数
    public function initialize() 
    {
        parent::initialize();
        $this->model = new ProjectModel();
	}
	
    /**
     * 获取资源列表
     */
    public function index()
    {
        $list = $this->model->select()->toArray();
        return view('',[
            'list' => $list
        ]);
    }

    /**
     * 添加应用
     */
    public function add() 
    {
        if (request()->isPost()) {

            $post = input();
            if ($this->model->create($post)) {
                return $this->success();
            }

            return $this->error();
        }

        $data = $this->getTableFields(); // 生成默认数据
        $data['app_id'] = '1000000'+ $this->model->onlyTrashed()->count() + 1;
        $data['app_key'] = Random::alpha(16);
        return view('',['data'=> $data]);
    }
	
}
