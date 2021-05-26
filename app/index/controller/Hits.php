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
class Hits extends HomeController
{
	// JS点击调用函数
	public function show() {	
		
		// 获取参数
		$param = input();
		if (!isset($param['id']) || !isset($param['model'])) {
			return $this->error("请求参数错误！");
		}
		
        try {

            // 新建模型
			if (!stripos($param['model'],'.')) {
				$InstanceModel = "\\app\\common\\model\\".ucfirst($param['model']);
			}
			else {
				$InstanceModel = explode('.',$param['model']);
				$InstanceModel = "\\app\\common\\model\\".$InstanceModel[0].'\\'.ucfirst($InstanceModel[1]);
			}
            
            // 查询数据集
            $InstanceObject = new $InstanceModel;
            $result = $InstanceObject::find($param['id']);
            if (!$result) {
                return $this->error('操作失败！'); 
            }

            // 初始化点击
            $hits['hits'] = $result['hits'];
            $hits['hits_month'] = $result['hits_month'];
            $hits['hits_week'] = $result['hits_week'];
            $hits['hits_day'] = $result['hits_day'];

            
            // 获取时间戳
            $new = getdate();
            if ($result['hits_lasttime']) {
                $old = getdate($result['hits_lasttime']);
            }else {
                $old = getdate(time());
            }

            // 月点击
            if($new['year'] == $old['year'] && $new['mon'] == $old['mon']){
                $hits['hits_month'] ++;
            }else{
                $hits['hits_month'] = 1;
            }

            // 周点击  // 本周开始时间,本周日0点0  // 本周结束时间,本周六12点59
            $weekStart = mktime(0,0,0,$new["mon"],$new["mday"],$new["year"]) - ($new["wday"] * 86400);
            $weekEnd = mktime(23,59,59,$new["mon"],$new["mday"],$new["year"]) + ((6 - $new["wday"]) * 86400);
            if($result['hits_lasttime'] >= $weekStart && $result['hits_lasttime'] <= $weekEnd){
                $hits['hits_week'] ++;
            }else{
                $hits['hits_week'] = 1;
            }

            // 日点击
            if($new['year'] == $old['year'] 
                && $new['mon'] == $old['mon'] 
                && $new['mday'] == $old['mday']){
                $hits['hits_day'] ++;
            }else{
                $hits['hits_day'] = 1;
            }

            //更新数据库
            $hits['id'] = $result['id'];
            $hits['hits'] = $hits['hits']+1;
            $hits['hits_lasttime'] = time();
            $result->update($hits);

        } catch (\Throwable $th) {
            return $this->error($th->getMessage());
        }

        return $this->success('点击成功!');
	}
}
