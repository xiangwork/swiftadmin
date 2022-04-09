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
namespace app\admin\controller;


use app\AdminController;
use app\common\library\Upload as Uploadlib;
use system\Random;

/**
 * 文件上传
 */
class Upload extends AdminController
{

    public function initialize()
    {
        parent::initialize();
        $this->token = session('AdminLogin');
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
            $avatarID = $this->token['id'].'Admin';
            $uploadFiles = Uploadlib::instance()->avatar($avatarID);

            if (!empty($uploadFiles)) {

                // 随机后缀
                $uploadFiles['url'] .= Random::alpha();
                return json($uploadFiles);
            }

            return $this->error(Uploadlib::instance()->getError());
		}
        echo 1;
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
