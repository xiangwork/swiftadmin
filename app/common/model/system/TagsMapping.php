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
    public static function writeMapID(int $id = 0,string|array $tags = '', string $type = 'cid')
    {
        if (!$tags) {
            return false;
        }

        if (!is_array($tags)) {
            $tags = explode(',',$tags);
        }

        // 自动写入标签
        $tagsList = Tags::queryTagsID($tags);
        $mapsList = self::where($type,$id)->select()->toArray();
        if (!empty($mapsList)) {
            $mapsList = array_column($mapsList,'tid');
        }   

        $mapsID = [];
        foreach ($tagsList as $key => $value) {
 
            if (array_search($value['id'],$mapsList) !== false) {
                unset($mapsList[$key]);
            }
            else {
                $mapsID[$key][$type] = $id;
                $mapsID[$key]['tid'] = $value['id'];
            }
        }

        if (!empty($mapsID)) {
            (new self())->saveAll($mapsID);
        }

        if (!empty($mapsList)) {
            self::where([
                [$type,'=',$id],
                ['tid','in',$mapsList]
            ])->delete();
        }

        return true;
    }
}
