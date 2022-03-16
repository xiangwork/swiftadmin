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

use app\common\model\system\Tags;
use app\HomeController;
use think\facade\Db;

/**
 * Ajax控制器
 * @ 异步调用
 */
class Ajax extends HomeController
{
    /**
     * 标签调用
     *
     * @return void
     */
    public function getTags() {	
		
        if (request()->isAjax()) {
            $tag = input('tag');
            if (!empty($tag)) {
                $list = Tags::field('name')->where([['name','like','%'.$tag.'%']])->limit(10)->select()->toArray();
                return $this->success('获取成功',null,$list,count($list));
            }
        }
    }
}
