<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2019-2020 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>，河北赢图网络科技版权所有
// +----------------------------------------------------------------------

namespace app\index\controller;

use app\HomeController;

class Gold extends HomeController
{
	// js评分函数
	public function show() 
	{
		// 获取参数
		$param = input();
		if (!isset($param['id']) 
            || !isset($param['model']) 
            || !isset($param['value']) ) {
            return $this->error('请求参数错误！');
		}
		
		// 组合COOKIE
		$cookies = 'sa_gd_'.md5short($param['model'].'-gold-'.$param['id']);
		if (cookie($cookies)) {
            return $this->error("您已经评分过了");
		}

        try {
            /**
             * 新建模型,请自行调整模型的位置
             */
			// 查询数据
			if (!stripos($param['model'],'.')) {
				$InstanceModel = "\\app\\common\\model\\".ucfirst($param['model']);
			}
			else {
				$InstanceModel = explode('.',$param['model']);
				$InstanceModel = "\\app\\common\\model\\".$InstanceModel[0].'\\'.ucfirst($InstanceModel[1]);
			}

            $InstanceObject = new $InstanceModel;
            $result = $InstanceObject::field('id,gold,golder')->find($param['id']);

            if (!empty($result)) {
                if (!empty($param['value'])) {

                    $array['gold'] = number_format(($result['gold']*$result['golder'] + intval($param['value'])) / ($result['golder']+1),1);
                    $array['golder'] = $result['golder']+1;
                    $result->update($array);

                    // 设置COOKIE
                    cookie($cookies,create_rand(10),today_seconds());
                }
            } 
            else {
                $array['gold'] = 0.0;
                $array['golder'] = 0;
            }
            
            
            
        } catch (\Throwable $th) {
           return $this->error('操作异常！');
        }

        return $this->success('感谢您的评分！',null,$array);
	}
}
