<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;
/**
 * @mixin \think\Model
 */
class Channel extends Model
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    /**
     * 获取模型数据
     */
    public static function getChannelList($id = null, string $tpl = null, string $field = null) 
    {
        $data = system_cache('channel');
        if (empty($data)) {
            $data = self::select()->toArray();
            foreach ($data as $key => $value) {
                $data[$key]['title'] = __($value['title']);
            }
            system_cache('channel', $data);
        }

        // 判断数据
        if (!empty($id)) {
            $data = list_search($data, ['id'=>$id]);
        }
        
        if (!empty($tpl)) {
            $data = list_search($data, ['template'=>$tpl]);
        }
        
        if (!empty($field) && isset($data[$field])) {
            $data = $data[$field];
        }
        
        return $data; 
    }
}
