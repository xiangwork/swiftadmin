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
namespace app\common\model\system;

use app\common\library\Content;
use think\Model;

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

    /**
     * 设置创建IP
     */
    public function setCreateipAttr($ip)
    {
        return Content::setIPAttr($ip);
    }

    /**
     * 获取创建IP
     */
    public function getCreateipAttr($ip)
    {
        return Content::getIPAttr($ip);
    }

    /**
     * 设置登录IP
     */
    public function setLoginipAttr($ip)
    {
        return Content::setIPAttr($ip);
    }

    /**
     * 获取登录IP
     */
    public function getLoginipAttr($ip)
    {
        return Content::getIPAttr($ip);
    }
	
}
