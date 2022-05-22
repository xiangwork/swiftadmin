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

/**
 * @mixin \think\Model
 */
class Config extends Model
{
    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

    /**
     * 数据查询后
     *
     * @param [type] $news
     * @return void
     */
    public static function onAfterRead($data)
    {
    }

    /**
     * 获取系统配置
     *
     * @param bool $config
     * @return void
     */
    public static function all($group = false)
    {

        $config = [];
        $where = [];
        if ($group) {
            $where[] = ['group', '=', $group];
        }

        $list = self::where($where)->select()->toArray();

        foreach ($list as $option) {
            if (!is_empty($option['type']) && 'array' == trim($option['type'])) {
                $config[$option['name']] = json_decode($option['value'], true);
            } else {
                $config[$option['name']] = $option['value'];
            }
        }

        return $config;
    }
}
