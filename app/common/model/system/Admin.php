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
namespace app\common\model\system;

use think\Model;
use think\facade\Db;
use think\facade\Request;
/**
 * @mixin \think\Model
 */
class Admin extends Model
{
	
    // 自动写入时间戳字段
	protected $autoWriteTimestamp = 'int';
	
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    /**
     * 根据用户名/密码 进行登录判断
     * @param string $User
     * @param string $Pwd
     */
	public static function checkLogin($user,$pwd)
	{
		// 密码加盐
		$where[] = ['pwd','=',hash_pwd(trim($pwd))];
		if(filter_var($user, FILTER_VALIDATE_EMAIL)){
			$where[] = ['email','=',htmlspecialchars(trim($user))];
		}else{
			$where[] = ['name','=',htmlspecialchars(trim($user))];
		}

		return Admin::where($where)->find();
	}

    /**
     * 根据用户名/验证码 进行数据查找
     * @param string $user
     * @param string $code
     */
	public static function checkforget($user,$code) 
	{
		// 校验格式
		if(filter_var($user, FILTER_VALIDATE_EMAIL)){
			$where[] = ['email','=',$user];
		}else {
			$where[] = ['mobile','=',$user];
		}
		
		$where[] = ['valicode','=',$code];
		return Admin::where($where)->find();
	}


	
}
