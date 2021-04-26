<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;

/**
 * @mixin \think\Model
 */
class Recyclebin extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    /**
     * 回收站文件
     * @access  public
     * @param   object $data
     * @return  void
     */
    public static function recycleData($array)
    {
        $data = [
            'oid' => $array->id,
            'cid' => $array->cid,
            'pid' => $array->pid,
            'title'=> $array->title,
            'channel'=> $array->channel->title,
            'category'=> $array->category->title,
        ];

        return self::create($data);
    }
}
