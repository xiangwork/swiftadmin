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
namespace app\api\Controller;
use app\ApiController;

/**
 * API接口前端示例文件
 */

class Index extends ApiController
{
    // 首页展示
    public function index()
    {
        return ajaxReturn('Hallo SwiftAdmin APIsdd');
    }

    // 列表页
    public function list()
    {
        return ajaxReturn('Hallo SwiftAdmin List APIs');
    }

    // 节点数据
    public function nodes()
    {
        return ajaxReturn('Hallo SwiftAdmin Nodes APIs');
    }

}
