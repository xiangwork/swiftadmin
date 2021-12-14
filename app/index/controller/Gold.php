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

use app\HomeController;
use app\common\model\system\Content;

class Gold extends HomeController
{
	// js评分函数
	public function show() 
	{
        if (request()->isAjax()) {
            // 获取参数
            $param = input();
            if (!isset($param['id']) || !isset($param['value']) ) {
                return $this->error('请求参数错误！');
            }
            // 组合COOKIE
            $cookieName = 'GD'.$param['id'].$param['value'];
            if (cookie($cookieName)) {
                return $this->error("您已经评分过了");
            }
            try {
                $result = Content::field('id,gold,golder')->find($param['id']);
                if (!empty($result)) {
                    $array['gold'] = number_format(($result['gold']*$result['golder'] + intval($param['value'])) / ($result['golder']+1),1);
                    $array['golder'] = $result['golder']+1;
                    $result->where('id',$param['id'])->update($array);
                    // 设置COOKIE
                    cookie($cookieName,create_rand(10),today_seconds());
                } 

            } catch (\Throwable $th) {
                return $this->error('操作异常');
            }

            return $this->success('感谢您的评分！',null, $array);
        }
	}
}
