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

class AdminGroup
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

      if (request()->isPost()) {
          
          $id = input('id');
          if (!empty($id) && $id >= 1) {
            if (!Auth::instance()->check_group_auth((array)$id)) {
              return json(ResultCode::AUTH_ERROR);
            }    
          }  
      }

      return $next($request);
    }
    
}