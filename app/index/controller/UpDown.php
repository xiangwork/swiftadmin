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
/**
 * 顶踩控制器
 * @ 
 */
class UpDown extends HomeController
{	
	// 顶踩函数
	public function show() 
	{
		if (request()->isAjax()) {
			
			// 获取参数
			$param = input();
			if (!isset($param['id']) || !isset($param['type']) ) {
				return $this->error("请求参数错误！");
			}
			
			// 组合COOKIE
			$cookieName = 'UP'.$param['id'].$param['type'];
			$cookieData = cookie($cookieName);
			if (!empty($cookieData)) {
				if (stristr($cookieData,$param['type'])) {
					return $this->error("您已操作过，晚点再试！");
				}
			}
			
			try {

				// 查询数据
				$result = Content::field('id')->find($param['id']);

				if (!empty($result)) {
					if ($param['type'] == 'up') {
						$cookieData .= 'up';
						Content::where('id',$result['id'])->inc('up')->update();
					}else if ($param['type'] == 'down') {
						$cookieData .= 'down';
						Content::where('id',$result['id'])->inc('down')->update();
					}

					// 设置COOKIE
					cookie($cookieName,$cookieData, today_seconds());
				}

			} catch (\Throwable $th) {
				return $this->error($th->getMessage());
			}

			return $this->success("感谢您的参与，操作成功！",$result['up'].':'.$result['down']);			
		}
	}
}
