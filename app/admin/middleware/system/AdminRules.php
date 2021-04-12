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

namespace app\admin\middleware\system;
use app\common\model\system\AdminRules as AdminRulesModel;

class AdminRules
{
    /**
     * 处理请求
     *
     * @param \think\Request $request
     * @param \Closure       $next
     * @return Response
     */
    public function handle($request, \Closure $next)
    {
        // 过滤系统级属性
		if ($request->isPost()) {
            $where[] = ['id','=',input('id/d')];
            $where[] = ['isSystem','=',1];
            if (!empty(AdminRulesModel::where($where)->find())) {
                return json(['msg'=>'系统属性禁止修改！','code'=>101]);
            }
		}
		
		return $next($request);
    }

}