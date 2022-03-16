<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class Navmenu extends Model
{
    // 软删除字段
    use SoftDelete;
    
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

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
    public static function getListNav($tips='',$pid=0, &$array=[], $blank=0,$level = 0)
    {
		$result = self::where('pid',$pid)->order('sort asc')->select()->toArray();
        foreach ($result as $key => $value) {
			if(!empty($tips)) { 
                $catename = $tips.$value['title'];				
				$value['title'] = str_repeat('',$blank).$catename;
			}
			$value['_level'] = $level;
            $array[] = $value; unset($result[$key]);
            self::getListNav($tips,$value['id'], $array, $blank+1,$level+1);
        }

       return $array;
    }
    
	/**
	 * 树形分类
	 */
	public static function getListTree() 
    {
        $array = self::select()->toArray();
		if (is_array($array) && !empty($array)) {
			return list_to_tree($array);
		}
    }    
    
    // 字段修改器
    public function setSortAttr($value) 
    {
        if (is_empty($value)) {
            return self::count('id') + 1;
        }
        return $value;
    }
}
