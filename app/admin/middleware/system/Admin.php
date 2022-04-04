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

namespace app\admin\middleware\system;
use app\admin\library\Auth;
use app\common\library\ResultCode;
use app\common\model\system\Admin as AdminModel;

class Admin
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
        if ($request->isPost()) {

            $id = input('id/s');
            if ($data = AdminModel::getById($id)) {
                $group_id = input('group_id/s');
                $group_id = !empty($group_id) ? $group_id.','.$data['group_id'] : $data['group_id'];
                $group_id = array_unique(explode(',',$group_id));
                if (!Auth::instance()->checkRulesForGroup($group_id)) {
                    return json(ResultCode::AUTH_ERROR);
                }
            }
        }
		
		return $next($request);
    }

}