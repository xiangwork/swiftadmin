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
use app\common\library\ResultCode;
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
      if ($request->isPost()) {
              $where[] = ['id','=',input('id/d')];
              $where[] = ['isSystem','=',1];
              if (!empty(AdminRulesModel::where($where)->find())) {
                  return json(ResultCode::SYSTEM_DISABLE);
              }
      }
      
      return $next($request);
    }

}