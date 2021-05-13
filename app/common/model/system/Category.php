<?php
declare (strict_types = 1);

namespace app\common\model\system;

use think\Model;
use think\model\concern\SoftDelete;
use app\common\library\Content;
use think\facade\Cache;

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
	
    public function channel()
    {
        return $this->hasOne(Channel::class,'id','cid');
    }

   /**
   * 获取无限极分类
   * @access public static   
   * @param int     $pid     栏目父ID
   * @param array   $array   引用数组
   * @param string  $blank   替换字符
   * @param int     $level   栏目等级   
   * @return json
   */
    public static function getListCate($pid = 0, $cid = 0, array $param = [], &$array=[], $blank=0, $level = 0)
    {
		// 获取字段
        $field = isset($param['field']) ? $param['field'] : '*';
        

        if (trim($field) != '*') {
            $field = explode(',',$field);
            if (!array_search('id' , $field)) {
                $field[] = 'id';
            }
            $field = implode(',',$field);
        }

        $order = isset($param['order']) ? $param['order'] : 'id asc';
        $limit = isset($param['order']) && $level < 1 ? $param['limit'] : 1000;
        $status = isset($param['status']) ? $param['status'] : '2';

		$result = self::where(function($query) use ($pid,$cid,$status) {
    
            if (!empty($cid) && $cid >= 1) {
                $where['cid'] = $cid;
            }

            $where['pid'] = $pid;
            $where['status'] = ((int)$status-1);
            $query->where($where);

        })->field($field)->order($order)->limit($limit)->select()->toArray();

        foreach ($result as $key => $value) {
			$value['_level'] = $level;
            $value['url'] = $value['title'];
            $array[] = $value; 
            unset($result[$key]);
            self::getListCate($value['id'],$cid, $param, $array, $blank+1,$level+1);
        }

       return $array;
	}

    /**
     * 树形分类
     * @access      public
     * @param       string       $field      字段信息
     * @return      tree||array
     */
	public static function getListTree(string $field = '')
    {
        if (empty($field)) {
            $field = '*';
        }

        $array = self::field($field)->select()->toArray();
		if (is_array($array) && !empty($array)) {
			return list_to_tree($array);
		}
	}

    /**
     * 获取栏目缓存
     * @access      public
     * @return      tree||array
     */

    public static function getListCache()
    {
        $name = hash('sha256','cate_cache');
        $data = Cache::get($name);
        if (empty($data)) {
            $data = self::where('status',1)->select();
            if (saenv('cache_status')) {
                Cache::set($name,$data);
            }
        }
        return $data;
    }

    /**
     * 获取指定模型栏目
     * @access      public
     * @param       model        $model      模型类型
     * @return      array
     */
    public static function getspecifiedcate($id)
    {
        $name = hash('sha256','specified');
        $data = Cache::get($name);
        if (empty($data)) {
            $data = self::where('cid',$id)->select()->toArray();
            if (saenv('cache_status')) {
                Cache::set($name,$data);
            }
        }
        return $data;
    }


    /**
     * 栏目统计
     * @access      public
     * @param       object       $model      数据模型
     * @param       array        $where      查询条件
     * @return      array
     */
	public static function getlistcount($model, $where) 
    {
		if (!empty($model) && is_array($where)) {
			return self::name($model)->where($where)->count();
		}
    }
    
    /**
     * 获取标题拼音
     * @access      public
     * @param       string       $pinyin      属性值
     * @param       array        $data        当前数组
     * @return      string
     */
    public function setPinyinAttr($pinyin, $data) 
    {
        return Content::setPinyinAttr($pinyin,$data);
    }

    /**
     * 修改图片
     * @access  public
     * @param   string  $image
     * @return  string
     */
    public function setImageAttr($image,$data)
    {
        return Content::setImageAttr($image,$data);
    }

    /**
     * 获取图片
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function getImageAttr($image)
    {
        return Content::getImageAttr($image);
    }

    /**
     * 获取Banner横图
     * @access  public
     * @param   string      $image
     * @return  string
     */
    public function getBannerAttr($image)
    {
        return Content::getImageAttr($image);
    }    

    /**
     * 修改内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function setContentAttr($content,$data)
    {
        return Content::setContentAttr($content,$data);
    }

    /**
     * 获取内容数据
     * @access  public
     * @param   string  $content
     * @return  string
     */
    public function getContentAttr($content,$data)
    {
        return Content::getContentAttr($content,$data);
    }

    /**
     * 字段排序
     * @access  public
     * @param   int  $sort
     * @return  int 
     */
    public function setSortAttr($sort) 
    {
        if (is_empty($sort)) {
            return self::count('id')+1;
        }
        return $sort;
    }

    public function getreadurlattr($readurl,$data)
    {
        if ($readurl) {
            return $readurl;
        }

        return build_request_url($data,'category_page');
    }
}
