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

namespace app\admin\controller;

use app\AdminController;
use app\common\library\Upload as Uploadlib;

class Upload extends AdminController
{
	// 上传logo函数
	public function logo() 
	{
		if (request()->isPost()) {

            $logo = Uploadlib::instance()->logo();
            if (!$logo) {
                return $this->error(Uploadlib::instance()->getError());
            }

            return json($logo);
		}
	}

	// 用户头像上传
	public function avatar() 
	{
		if (request()->isPost()) {

            $filename = Uploadlib::instance()->avatar(session('AdminLogin.id').'Admin');
            if (!$filename) {
                return $this->error(Uploadlib::instance()->getError());
            }

            return json($filename);
		}
	}
	
	// 单文件上传函数
	public function upload()
	{
		$filename = Uploadlib::instance()->upload();
		if (!$filename) {
			return $this->error(Uploadlib::instance()->getError());
		}

		return json($filename);
	}
}