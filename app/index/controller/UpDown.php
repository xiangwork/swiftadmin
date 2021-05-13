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

namespace app\index\controller;

use app\HomeController;
use think\facade\Cookie;

class UpDown extends HomeController
{	
	// 顶踩函数
	public function show() 
	{
		// 获取参数
		$param = input();
		if (!isset($param['id']) 
            || !isset($param['model']) 
            || !isset($param['type']) ) {
			return $this->error("请求参数错误！");
		}
		
		// 组合COOKIE
		$cookies = 'up-'.md5hash($param['model'].'-updown-'.$param['id']);
		$content = cookie($cookies);
		if (!empty($content)) {
			if (stristr($content,$param['type'])) {
				return $this->error("您已操作过，晚点再试！");
			}
		}
		
        try {

			// 查询数据
			if (!stripos($param['model'],'.')) {
				$InstanceModel = "\\app\\common\\model\\".ucfirst($param['model']);
			}
			else {
				$InstanceModel = explode('.',$param['model']);
				$InstanceModel = "\\app\\common\\model\\".$InstanceModel[0].'\\'.ucfirst($InstanceModel[1]);
			}

			$InstanceObject = new $InstanceModel;
			$result = $InstanceObject::field('id')->find($param['id']);

			if (!empty($result)) {
				if ($param['type'] == 'up') {
					$content .= 'up';
					$InstanceObject->where('id',$result['id'])->inc('up')->update();
				}else if ($param['type'] == 'down') {
					$content .= 'down';
					$InstanceObject->where('id',$result['id'])->inc('down')->update();
				}

				// 设置COOKIE
				Cookie::set($cookies,$content, today_seconds());
			}

        } catch (\Throwable $th) {
			return $this->error($th->getMessage());
        }

		return $this->success("感谢您的参与，操作成功！",$result['up'].':'.$result['down']);
	}
}
