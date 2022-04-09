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

// 系统默认规则 
Route::get('$','Index/index')->cache(3600);
