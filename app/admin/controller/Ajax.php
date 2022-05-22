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
use app\common\library\Upload;

/**
 * Ajax类
 */
class Ajax extends AdminController
{
    public function initialize()
    {
        parent::initialize();
    }

    /**
     * 文件上传
     * @return mixed|\think\response\Json|void
     * @throws \Exception
     */
	public function upload()
	{
        if (request()->isPost()) {

            try {

                $uploadFiles = Upload::instance()->upload();
            } catch (\Throwable $th) {
                return $this->error(Upload::instance()->getError() ?: $th->getMessage());
            }

            if (!empty($uploadFiles)) {
                return json($uploadFiles);
            }
        }

        $this->throwError();
		
	}

    /**
     * 远程下载图片
     * @return mixed|\think\response\Json|void
     */
    public function getImage()
    {
        if (request()->isPost()) {

            try {
                $uploadFiles = Upload::instance()->download(input('url'));
            } catch (\Throwable $th) {
                return $this->error(Upload::instance()->getError() ?: $th->getMessage());
            }

            if (!empty($uploadFiles)) {
                return json($uploadFiles);
            }
        }

        $this->throwError();
    }

}
