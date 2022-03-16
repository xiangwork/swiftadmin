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

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    /**
     * 获取模型数据
     */
    public static function getChannelList($id = null, string $table = null, string $field = null) 
    {
        $data = system_cache('redis-channel');
        if (empty($data)) {
            $data = self::select()->toArray();
            foreach ($data as $key => $value) {
                $data[$key]['title'] = __($value['title']);
            }
            system_cache('redis-channel', $data);
        }

        // 判断数据
        if (!empty($id)) {
            $data = list_search($data, ['id'=>$id]);
        }
        
        if (!empty($table)) {
            $data = list_search($data, ['table'=>$table]);
        }
        
        if (!empty($field) && isset($data[$field])) {
            $data = $data[$field];
        }
        
        return $data; 
    }
}
