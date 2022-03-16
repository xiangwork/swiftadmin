<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\model\Pivot;

/**
 * @mixin \think\Model
 */
class TagsMapping extends Pivot
{
    /**
     * 关键词映射
     *
     * @param integer $id
     * @param string $tags
     * @param string $type
     * @return void
     */
    public static function writeRelation(int $id = 0,mixed $tags = '', string $type = 'aid')
    {
        if (!$tags) {
            return false;
        }

        if (!is_array($tags)) {
            $tags = explode(',',(string)$tags);
        }

        // 写入标签
        $tagsList = Tags::queryTagsRelation($tags);
        $mapsList = self::where($type, $id)->select()->toArray();

        if (!empty($mapsList)) {
            $mapsList = array_column($mapsList, 'tag_id');
        }
        
        $mapArray = [];
        foreach ($tagsList as $key => $tag) {

            // 是否已经存在
            if (in_array($tag['id'], $mapsList)) {
                unset($mapsList[$key]);
            } else {
                $mapArray[$key] = [
                    $type => $id,
                    'tag_id' => $tag['id'],
                ];
            }
        }
        

        if (!empty($mapArray)) {
            (new self())->saveAll($mapArray);
        }

        // 删除冗余关联
        if (!empty($mapsList)) {
            self::where([[$type, '=', $id],['tag_id', 'in', $mapsList]])->delete();
        }

        return true;
    }
}
