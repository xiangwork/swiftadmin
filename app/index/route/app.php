<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
use think\facade\Route;

// 全局变量规则
Route::pattern(['name'=>'\w+','id'=>'\d+']);
Route::get('captcha/[:config]','\\think\\captcha\\CaptchaController@index');

// 加载自定义路由
Route::get('$','Index/index');
if (is_file(app_path().'route/cms.php')) {
    require_once app_path().'route/cms.php';
}

// 系统默认规则 
Route::get('$','Index/index')->cache(3600);
Route::get('<dir>/$','category/index');
Route::get('<dir>/list_<page>','category/index')->ext('html');
Route::get('<parent>/<dir>/$','category/index');
Route::get('<parent>/<dir>/list_<page>','category/index')->ext('html');

// 定义错误路由
Route::miss(function() {
    abort(404, '页面不存在');
});
