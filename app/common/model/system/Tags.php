<?php

declare(strict_types=1);

namespace app\common\model\system;

use think\Model;

/**
 * @mixin \think\Model
 */
class Tags extends Model
{
    // 定义时间戳字段名
    protected $createTime = 'createtime';

    /**
     * 默认关联模型
     * @access  public
     * @return  void
     */
    public function map()
    {
        return $this->hasMany(TagsMapping::class,'tag_id','id');
    }

    /**
     * 数据新增前
     * @access  public
     * @param   object 
     * @return  void
     */
    public static function onBeforeInsert($data)
    {
        if (!isset($data['pinyin']) || empty($data['pinyin'])) {
            $pinyin = pinyin($data['name']);

            // 适合最左原则
            $total  = self::where('pinyin','like', $pinyin.'%')->count();
            $data['pinyin'] = !$total ? $pinyin : $pinyin.'_'.$total;
        }
    }

    /**
     * 返回关键词ID
     *
     * @param array $tags
     * @return array
     */
    public static function queryTagsRelation(array $tags = [])
    {
        if (!$tags) {
            return [];
        }

        $listArr = self::where([
            ['type', '=', 1],
            ['status', '=', 1],
            ['name', 'in', $tags]
        ])->select()->toArray();
        
        $total = self::count();

        $name = array_column($listArr, 'name');
        $Diff = array_diff($tags, $name);
        
        foreach ($Diff as $key => $tag) {

            $res = self::create([
                'name'   => $tag,
                'sort'   => $total + ($key + 1)
            ]);

            array_push($listArr, [
                'id'   => $res['id'],
                'name' => $res['name']
            ]);
        }

        return $listArr;
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

    /**
     * 获取文档数量
     *
     * @return void
     */
    public function getTotalAttr($value, $data)
    {
        return TagsMapping::where('tag_id',$data['id'])->count();
    }
}
