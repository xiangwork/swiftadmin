<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\facade\Cache;
use think\Model;

/**
 * @mixin \think\Model
 */
class Fulltext extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    public static function onAfterWrite()
    {
		self::setESCache();
    }    

    /**
     * 获取项目信息
     *
     * @param string|null $name
     * @param string $type
     * @return void
     */
    public static function getApp(string $name = null, string $type = 'XunSearch')
    {
        $list = Cache::get('redis-xselastic');
        if (empty($list)) {
            $list = self::setESCache();
        }

        $app = [];
        foreach ($list as $value) {
            if ($value['name'] == $name
            && $value['type'] == $type) {
                $app = $value;
            }
        }

        return $app;
    }

    /**
     * 设置缓存
     *
     * @return void
     */
    protected static function setESCache()
    {
        $list = self::select()->toArray();
        Cache::set('redis-xselastic',$list, 86400);
        return $list;
    }
}
