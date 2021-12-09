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
namespace app\index\controller;


use app\HomeController;
use app\common\model\system\User as UserModel;

/**
 * 前台会员控制器
 */
class User extends HomeController
{
    /**
     * 鉴权控制器
     */
    public $needLogin = true;
    
    /**
     * 非登录鉴权方法
     */
    public $noNeedLogin = ['login','register'];

	// 初始化函数
	public function initialize() {
        parent::initialize();
        $this->model = new UserModel();
    }        

    /**
     * 用户中心
     * @return void
     */
    public function index()
    {   
        echo 'TODO...';
    }
}
