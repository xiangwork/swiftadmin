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
use app\common\library\ResultCode;
class Content
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
        $pid = request()->param('pid');
        if (!empty($pid) && intval($pid)) {

            if (!is_array($pid)) {
                $pid = explode(',',$pid);
            }
            
            if (!$pid || !Auth::instance()->check_rulecates_node($pid,
                'cates','private')) {
                if(request()->isAjax()) {
                    return json(ResultCode::AUTH_ERROR);
                }
                else {
                    return abort(403);
                }
            }
        }
		
		return $next($request);
    }

}