<?php

namespace plugin\demo\controller;


use think\facade\View;

// 继承插件基础控制器
use think\plugin\PluginController;

class Index extends PluginController {

    public $userLogin = true;

    public function index() {
        
        return view('',[
            'tips'=>'SwiftAdmin 极速开发框架插件演示模板',
        ]);
    }

    public function list() {
        echo 'demo list action';
    }

    public function query() {
        echo 'demo query action';
    }

}