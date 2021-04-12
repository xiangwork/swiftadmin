<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\facade\Db;
use think\model\concern\SoftDelete;

/**
 * @mixin \think\Model
 */
class Category extends Model
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
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
    public static function getListCate($tips='',$pid=0, &$array=[], $blank=0,$level = 0)
    {
		// 获取所有分类
		$result = self::where('pid',$pid)->order('sort asc')->select()->toArray();
        foreach ($result as $key => $value) {
			if(!empty($tips)) { 
			    //自定义名称显示格式
                $catename = $tips.$value['title'];				
				$value['title'] = str_repeat('',$blank).$catename;
			}
			$value['_level'] = $level;
            $array[] = $value; unset($result[$key]);
            self::getListCate($tips,$value['id'], $array, $blank+1,$level+1);
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

	/**
	 * 栏目统计
	 */
	public static function getListCount($model, $where) 
    {
		if (!empty($model) && is_array($where)) {
			return self::name($model)->where($where)->count();
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
