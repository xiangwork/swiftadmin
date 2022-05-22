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
namespace app\common\model\system;

use think\Model;
use app\common\library\Globals;

/**
 * @mixin \think\Model
 */
class Admin extends Model
{
    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

    /**
     * 关联管理组
     *
     * @return \think\model\relation\HasOne
     */
    public function group(): \think\model\relation\HasOne
    {
        return $this->hasOne(AdminGroup::class, 'id', 'group_id');
    }

    /**
     * 根据用户名/密码 进行登录判断
     * @param $user
     * @param $pwd
     * @return Admin|array|mixed|Model|null
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public static function checkLogin($user, $pwd)
    {
        $where[] = ['pwd', '=', encryptPwd(trim($pwd))];
        if (filter_var($user, FILTER_VALIDATE_EMAIL)) {
            $where[] = ['email', '=', htmlspecialchars(trim($user))];
        } else {
            $where[] = ['name', '=', htmlspecialchars(trim($user))];
        }

        return Admin::where($where)->find();
    }

    /**
     * 根据用户名/验证码 进行数据查找
     * @param string $user
     * @param string $code
     * @return Admin|array|mixed|Model|null
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public static function checkForget($user, $code)
    {
        // 校验格式
        if (filter_var($user, FILTER_VALIDATE_EMAIL)) {
            $where[] = ['email', '=', $user];
        } else {
            $where[] = ['mobile', '=', $user];
        }

        $where[] = ['valicode', '=', $code];
        return Admin::where($where)->find();
    }

    /**
     * 设置创建IP
     */
    public function setCreateIpAttr($ip)
    {
        return Globals::setIPAttr($ip);
    }

    /**
     * 获取创建IP
     */
    public function getCreateIpAttr($ip) 
    {
        return Globals::getIPAttr($ip);
    }

    /**
     * 设置登录IP
     */
    public function setLoginIpAttr($ip)
    {
        return Globals::setIPAttr($ip);
    }

    /**
     * 获取登录IP
     */
    public function getLoginIpAttr($ip) 
    {
        return Globals::getIPAttr($ip);
    }
}
