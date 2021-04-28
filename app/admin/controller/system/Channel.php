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
use app\common\model\system\Channel  as ChannelModel;

class Channel extends AdminController
{

    public function initialize() 
    {
		parent::initialize();
        $this->model = new ChannelModel();
    }

    /**
     * 重载函数函数
     */
    public function del() 
    {
        $id = input('id/d');
		if ($id <= 5) {
			return $this->error('禁止删除系统内置模型！');
		}
		
		if ($this->model->destroy($id)){
			return $this->success();
		}
		else {
			return $this->error();
		}
    }
}