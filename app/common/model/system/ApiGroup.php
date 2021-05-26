<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
/**
 * @mixin \think\Model
 */
class ApiGroup extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    // 定义插件关联
    public function api()
    {
        return $this->hasMany(Api::class,'pid');
    }

	/**
	 * 树形分类
	 */
	public static function getListTree($where = []) 
    {
        $array = self::where($where)->select()->toArray();
		if (is_array($array) && !empty($array)) {
			return list_to_tree($array);
		}
	}

    // 字段修改器
    public function setSortAttr($value) 
    {
        if (is_empty($value)) {
            return self::count('id') + 1;
        }

        return $value;
    }
}
