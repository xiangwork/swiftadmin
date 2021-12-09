<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class Dictionary extends Model
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
	protected $updateTime = 'updatetime';

    // 字段修改器
    public function setSortAttr($value) 
    {
        if (is_empty($value)) {
            return self::count('id') + 1;
        }
        return $value;
	}

    /**
     * 获取字典信息
     *
     * @param array $where
     * @param string $field
     * @param boolean $style
     * @return void
     */
    public static function queryDiction(array $where = [], string $field = '*', bool $style = true)
    {
        $dicCacheName = sha1(implode(',',$where).$field);
        $dicCacheData = system_cache($dicCacheName);

        if (empty($dicCacheData)) {
            if ($style == false) {
                $dicCacheData = self::where($where)->field($field)->find();
            }
            else {
                $dicCacheData = self::where($where)->field($field)->select()->toArray();
            }
            
            system_cache($dicCacheName,$dicCacheData,saenv('cache_time'));
        }

        return $dicCacheData;
    }

    /**
     * 返回最小id
     */
    public static function minId()
    {
        return (int)self::where('pid','0')->min('id');
    }
	
}
