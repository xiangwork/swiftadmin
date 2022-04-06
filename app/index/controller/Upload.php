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
namespace app\index\controller;


use app\HomeController;
use app\common\library\ResultCode;
use app\common\library\Upload as Uploadlib;
use system\Random;

/**
 * 文件上传
 */
class Upload extends HomeController
{
    
    /**
     * 鉴权控制器
     * 控制器单例鉴权
     */
    public $needLogin = false;

    /**
     * 鉴权方式
     *
     * @var [type]
     */
    public $token     = null;

    /**
     * 授权码
     *
     * @var [type]
     */
    public $auth_key  = null;

    public function initialize()
    {
        parent::initialize();
        $this->token = session('AdminLogin');
        if (!$this->auth->isLogin() && !isset($this->token['id'])) {
            return $this->error(ResultCode::AUTH_ERROR['msg']);
        }
        try {
            $this->userId = $this->auth->userInfo['id']; 
            $this->userInfo = $this->auth->userInfo;
        } catch (\Throwable $th) {}
        $this->auth_key = saenv('auth_key');
    }

	/**
     * 上传logo
     *
     * @return void
     */
	public function logo() 
	{
		if (request()->isPost()) {

            $logoFiles = Uploadlib::instance()->logo();
            if (!empty($logoFiles)) {
                return json($logoFiles);
            }
            return $this->error(Uploadlib::instance()->getError());
		}

        $this->throwError();
	}

	/**
     * 用户头像上传
     *
     * @return void
     */
	public function avatar() 
	{
		if (request()->isPost()) {

            $auth_key = request()->param('auth_key');
            if ($auth_key != $this->auth_key) {
                $avatarID = $this->userId;   
            } else {
                $avatarID = $this->token['id'].'Admin';
            }
            
            $uploadFiles = Uploadlib::instance()->avatar($avatarID);

            if (!empty($uploadFiles)) {

                // 随机后缀
                $uploadFiles['url'] .= Random::alpha(8);            
                return json($uploadFiles);
            }

            return $this->error(Uploadlib::instance()->getError());
		}

        $this->throwError();
	}
	
	/**
     * 单文件上传函数
     *
     * @return void
     */
	public function file()
	{
        if (request()->isPost()) {

            $uploadFiles = Uploadlib::instance()->upload();

            if (!empty($uploadFiles)) {
    
                return json($uploadFiles);
            }
    
            return $this->error(Uploadlib::instance()->getError());
        }

        $this->throwError();
		
	}

}
