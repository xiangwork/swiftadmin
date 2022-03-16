<?php

declare(strict_types=1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> Apache 2.0 License Code
// +----------------------------------------------------------------------

namespace app\common\middleware;

use app\common\library\Auth as userAuth;
use think\exception\HttpException;

class Security
{

  /**
   * 需要过滤的值
   *
   * @var array
   */
  public $argvs = [
    '?s=index/think',
    'call_user_func_array',
    'vars[0]',
    'file_put_contents',
    '$_REQUEST',
    'file/write',
    'fputs',
    'base64_decode',
    'array_intersect_ukey',
  ];

  /**
   * 最大命中次数
   *
   * @var integer
   */
  public $targetCount = 0;

  /**
   * 处理请求
   *
   * @param \think\Request $request
   * @param \Closure       $next
   * @return Response
   */
  public function handle($request, \Closure $next)
  {
    $secreqs = $request->param();
    $secreqs = urldecode(\http_build_query($secreqs));

    foreach ($this->argvs as $value) {
      if (strpos($secreqs, $value)) {
        $this->targetCount += 1;
      }
    }
    /**
     * 这里可以自己DIY
     * 此方式适用于严格模式
     * 时间紧迫，后期迭代。。
     */
    if ($this->targetCount >= 2 && !userAuth::instance()->isLogin()) {
      if (!env('app_debug')) {
        http_response_code(404); die();
      } else {
        throw new \think\Exception("发送的数据不合法");
      }
    }

    return $next($request);
  }
}
