<?php

declare(strict_types=1);

namespace app\common\model\system;

use think\Model;

/**
 * @mixin \think\Model
 */
class AdminGroup extends Model
{
    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';

    /**
     * 获取无限极分类
     * @access public static   
     * @param string  $tips    名称格式
     * @param int     $pid     栏目父ID
     * @param array   $array   引用数组
     * @param string  $blank   替换字符
     * @param int     $level   栏目等级   
     * @return json
     */
    public static function getListGroup($tips = '', $pid = 0, &$array = [], $blank = 0, $level = 0)
    {
        // 获取所有分类
        $result = self::where('pid', $pid)->select()->toArray();
        foreach ($result as $key => $value) {
            if (!empty($tips)) {
                //自定义名称显示格式
                $catename = $tips . $value['title'];
                $value['title'] = str_repeat('', $blank) . $catename;
            }
            $value['_level'] = $level;
            $array[] = $value;
            unset($result[$key]);
            self::getListGroup($tips, $value['id'], $array, $blank + 1, $level + 1);
        }

        return $array;
    }
}
