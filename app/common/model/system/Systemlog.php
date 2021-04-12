<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;

/**
 * @mixin \think\Model
 */
class Systemlog extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    

    // 写入日志
    public static function write($logs = null) 
    {
        if (!empty($logs) && is_array($logs)) {
            try {
                self::create($logs);
            } 
            catch (\Throwable $th) {
                if (preg_match('/\'(.*?)\'/',$th->getMessage(),$matches)) {
                    $logs[$matches[1]] = '0'; // 字节太长
                    self::write($logs);
                }
            }
        }
    }
}
