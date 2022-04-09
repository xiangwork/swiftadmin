<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>  Apache 2.0 License Code
// +----------------------------------------------------------------------
namespace app\api\controller;
use app\ApiController;

/**
 * API接口前端示例文件
 */
class Index extends ApiController
{
    // 首页展示
    public function index()
    {
        return ajax_return('Hallo SwiftAdmin APIs');
    }

}
