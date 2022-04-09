<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use app\common\library\Globals;

/**
 * @mixin \think\Model
 */
class Systemlog extends Model
{
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

    /**
     * 设置IP转换
     * @access  public
     * @param   string     $ip  IP地址
     * @return  string
     */
    public function setIPAttr($ip)
    {
        return Globals::setIPAttr($ip);
    }

    /**
     * 获取IP转换
     * @access  public
     * @param   int     $ip  整型
     * @return  string
     */
    public function getIPAttr($ip)
    {
        return Globals::getIPAttr($ip);
    }
}
