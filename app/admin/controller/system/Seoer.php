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
use app\common\model\system\Article;
use app\common\model\system\Category;

class Seoer extends AdminController 
{
    // 初始化函数
    public function initialize() 
    {
        parent::initialize();
    }

    /**
     * 获取资源 
     */    
    public function index() 
    {
        return view();
    }

    /**
     * 查询站点
     */
    public function getsitelist() 
    {

    }

    /**
     * 查询目录
     */
    public function getsitedir()
    {

    }

    /**
     * 查询数据
     */
    public function getdata()
    {
        
    }

}   