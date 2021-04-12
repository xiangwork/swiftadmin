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
use app\common\library\Auth;
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
        $id = input('id/s'); 
		if ($request->isPost() && !empty($id)) {
            
            // 查询数据
            $groupIds = input('group_id/s');
            $data = AdminModel::find($id);

            if (!empty($data)) { 

                if (!empty($groupIds)) {
                    $groupIds = $data['group_id'];
                }
                else {
                    $groupIds = $groupIds.','.$data['group_id'];
                }

                $groupIds = array_unique(explode(',',$groupIds));
                if (!Auth::instance()->checkGroupDiffer($groupIds)) {
                    return json(['msg'=>'没有权限！','code'=>101]);
                }   
            }
		}
		
		return $next($request);
    }

}