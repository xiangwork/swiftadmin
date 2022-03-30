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
use app\common\model\system\Api;
use app\common\model\system\ApiGroup;

/**
 * API接口前端示例文件
 */

class Wiki extends ApiController
{
    /**
     * 非鉴权方法
     * @var array
     */
	public $noNeedLogin = ['index','home'];
    /**
     * 验证流程
     * @var bool
     */
	public $authWorkflow = false;

    /**
     * 是否需要登录
     * @var bool
     */
	public $needLogin = true;

    /**
     * 展示API页面
     * 默认应用ID为1
     * 如有其他应用请使用路由实现
     */
    public function index()
    {
        $where['app_id'] = 1;
        $list = ApiGroup::where($where)->select()->toArray();
        $apis = Api::where($where)->order('pid','asc')->select()->each(function($item) {
            
            // 避免主键冲突
            $item['id'] = 10000 + $item['id'];
            return $item;
        });

        $list = array_merge($list,$apis->toArray());
        return view('',[
            'apis' => $apis,
            'apinav' => json_encode(list_to_tree($list)),
        ]);
    }
}
