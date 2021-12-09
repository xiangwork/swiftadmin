<?php
declare (strict_types = 1);

namespace app\common\model\system;
use think\Model;

/**
 * @mixin \think\Model
 */
class Tags extends Model
{
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    /**
     * 返回TAGS表ID
     *
     * @param array $names
     * @return array
     */
    public static function queryTagsID(array $names)
    {
        if (!$names) {
            return [];
        }

        // 查询条件
        $where[] = ['type',  '=',1];
        $where[] = ['status','=',1];
        $where[] = ['name',  'in',$names];
        $listTAGS = self::where($where)->select()->toArray();
        
        if (count($listTAGS) < count($names)) {
            $column = array_column($listTAGS,'name');
            $tagsDiff = array_diff($names,$column);
            foreach ($tagsDiff as $value) {
                $res = self::create(['name'=>$value]);
                array_push($listTAGS,[
                    'id' => $res['id'],
                    'name' => $res['name']
                ]);
            }
        }

        return $listTAGS;
    }

    /**
     * 设置字段排序
     *
     * @param [type] $value
     * @return void
     */
    public function setSortAttr($value) 
    {
        if (is_empty($value)) {
            return self::count('id') + 1;
        }
        
        return $value;
    }    
}
