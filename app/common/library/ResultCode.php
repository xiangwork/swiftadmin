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
namespace app\common\library;


/**
 * RESULT代码文件
 */

class ResultCode 
{
    CONST SUCCESS = [
        'code'=>200,
        'status'=>'SUCCESS',
        'msg'=>'请求成功',
    ];

    CONST AUTH_ERROR = [
        'code'=> -100,
        'status'=>'AUTH_ERROR',
        'msg'=>'没有权限',
    ];

    CONST INVALID = [
        'code'=> -101,
        'status'=>'INVALID',
        'msg'=>'操作失败',
    ];

    CONST PARAMERROR = [
        'code'=> -102,
        'status'=>'PARAMERROR',
        'msg'=>'请求参数错误',
    ];
    
    CONST TOKEN_INVALID = [
        'code'=> -103,
        'status'=>'TOKEN_INVALID',
        'msg'=>'token校验失败',
    ];

    CONST API_DISABLE = [
        'code'=> -104,
        'status'=>'API_DISABLE',
        'msg'=>'当前接口已禁用',
    ];

    CONST METHOD_INVALID = [
        'code'=> -105,
        'status'=>'METHOD_INVALID',
        'msg'=>'访问方式错误',
    ];

    CONST DAY_INVALID = [
        'code'=> -106,
        'status'=>'DAY_INVALID',
        'msg'=>'接口已达每日上限',
    ];

    CONST API_SPEED_INVALID = [
        'code'=> -107,
        'status'=>'API_SPEED_INVALID',
        'msg'=>'调用API接口速度过快',
    ];

    CONST CEILING_INVALID = [
        'code'=> -108,
        'status'=>'CEILING_INVALID',
        'msg'=>'调用总额已消费完',
    ];

    CONST USPWDERROR = [
        'code'=> -109,
        'status'=>'USPWDERROR',
        'msg'=>'用户名或密码错误',
    ];

    CONST STATUSEXCEPTION = [
        'code'=> -110,
        'status'=>'STATUSEXCEPTION',
        'msg'=>'当前用户已被禁用',
    ];

    CONST ACCESS_TOKEN_TIMEOUT = [
        'code'=> -300,
        'status'=>'ACCESS_TOKEN_TIMEOUT',
        'msg'=>'身份令牌过期',
    ];

    CONST ACCESS_TOKEN_INVALID = [
        'code'=> -301,
        'status'=>'ACCESS_TOKEN_INVALID',
        'msg'=>'获取token失败',
    ];

    CONST SESSION_TIMEOUT = [
        'code'=> -302,
        'status'=>'SESSION_TIMEOUT',
        'msg'=>'SESSION过期',
    ];

    CONST UNKNOWN = [
        'code'=> -990,
        'status'=>'UNKNOWN',
        'msg'=>'未知错误',
    ];

    CONST EXCEPTION = [
        'code'=> -991,
        'status'=>'EXCEPTION',
        'msg'=>'系统异常',
    ];

    CONST VERSION_ERROR = [
        'code'=> -992,
        'status'=>'VERSION_ERROR',
        'msg'=>'版本错误',
    ];

    CONST SYSTEM_DISABLE = [
        'code'=> -993,
        'status'=>'VERSION_ERROR',
        'msg'=>'禁止修改系统属性',
    ];

    CONST LACKPARAME = [
        'code'=> -996,
        'status'=>'LACKPARAME',
        'msg'=>'缺少请求参数',
    ];

}
