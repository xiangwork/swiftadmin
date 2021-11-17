<?php

// 全局应用公共文件
use app\common\library\Auth;
use think\facade\Db;
use think\facade\Cache;
use think\facade\Config;
use think\facade\Request;
use app\common\model\system\Channel as ChannelModel;
use app\common\model\system\Category as CategoryModel;
use app\common\model\system\Content as ContentModel;
use app\common\model\system\Dictionary as DictionaryModel;

// 全局系统常量
const REWRITE   =  1;
const STATICS   =  2;
const NAMESPACELIBRARY = '\\app\\common\\library\\';
const NAMESPACEMODELSYSTEM = '\\app\\common\\model\\system\\';

// +----------------------------------------------------------------------
// | 文件操作函数开始
// +----------------------------------------------------------------------
if (!function_exists('read_file')) 
{
    /**
     * 获取文件内容
     * @param  string $file 文件路径
     * @return content
     */	
	function read_file($file){
		return @file_get_contents($file);
	}	
}

if (!function_exists('arr2file')) {
    /**
     * 数组写入文件
     * @param  string $file  文件路径
     * @param  array  $array 数组数据 
     * @return content
     */	
	function arr2file($file, $array='') 
	{
		if(is_array($array)){
			$cont = var_exports($array,true);
		} else{
			$cont = $array;
		}
		$cont = "<?php\nreturn $cont;";
		write_file($file, $cont);
	}
}

if (!function_exists('arr2router')) {
    /**
     * 数组写入路由文件
     * @param  string $file  	文件路径
     * @param  array  $string 	字符串数据 
     * @return content
     */	
	function arr2router($file, $array='') 
	{
		if(is_array($array)){
			$cont = var_exports($array,true);
		} else{
			$cont = $array;
		}
		$cont = "<?php\nuse think\\facade\\Route;\n\n$cont";
		write_file($file, $cont);
	}
}
if (!function_exists('var_exports')) {
	/**
     * 数组语法(方括号)
     * @param  array $expression  	数组
     * @param  bool  $return 		返回类型 
     * @return array
     */	
	function var_exports($expression, $return = true) {
		$export = var_export($expression, true);
		$patterns = [
			"/array \(/" => '[',
			"/^([ ]*)\)(,?)$/m" => '$1]$2',
			"/=>[ ]?\n[ ]+\[/" => '=> [',
			"/([ ]*)(\'[^\']+\') => ([\[\'])/" => '$1$2 => $3',
		];
		$export = preg_replace(array_keys($patterns), array_values($patterns), $export);
		if ((bool)$return) return $export; else echo $export;
	}
}
if (!function_exists('write_file')) {
    /**
     * 数据写入文件
     * @param  string  $file    文件路径
     * @param  string  $content 文件数据 
     * @return content
     */		
	function write_file($file, $content='') 
	{
		$dir = dirname($file);
		if(!is_dir($dir)){
			mkdirss($dir);
		}
		return @file_put_contents($file, $content);
	}
}

if (!function_exists('mkdirss')) {
    /**
     * 递归创建文件夹
     * @param  string  $file    文件路径
     * @param  intval  $mode    文件夹权限 
     * @return bool
     */		
	function mkdirss($path,$mode=0777) 
	{
		if (!is_dir(dirname($path))){
			mkdirss(dirname($path));
		}
		if(!file_exists($path)){
			return mkdir($path,$mode);
		}
		return true;
	}
}
if (!function_exists('traverse_scandir')) {
    /**
     * 递归遍历文件夹   scandir  函数
	 * @param  bool    $bool    是否递归
     * @param  string  $dir     文件夹路径
     * @return array
     */	
	function traverse_scandir($dir,$bool = true)
	{
		$list = [];
		$array = scandir($dir);
		foreach ($array as $key => $file) {
			# code...
			if ($file != '.' && $file != '..') {
				$child = $dir.'/'.$file;
				if (is_dir($child && $bool)) {
					$list[$file] = traverse_scandir($child);
				}else {
					$list[] = $file;
				}
			}
		}
		
		return $list;
	}
}

if (!function_exists('traverse_opendir')) {
    /**
	 * 此递归算法优于	scandir
     * 递归遍历文件夹   opendir  函数
	 * @param  bool    $bool    是否递归
     * @param  string  $dir     文件夹路径
     * @return array
     */	
	function traverse_opendir($dir,$bool = true) 
	{

		$array = [];
		$handle = opendir($dir);
		while (($file = readdir($handle)) !== false) {
			# code...
			if ($file != '.' && $file != '..') {
				$child = $dir.'/'.$file;
				if (is_dir($child) && $bool) {
					$array[$file] = traverse_opendir($child);
				}else {
					$array[] = $file;
				}
			}
		}

		return $array;
	}
}

if (!function_exists('recursive_delete')) {
    /**
     * 递归删除目录
     */
    function recursive_delete($dir) 
	{

        // 打开指定目录
      if ($handle = @opendir($dir)){
   
        while (($file = readdir($handle)) !== false) {
            if (($file == ".") || ($file == "..")){
              continue;
            }
            if (is_dir($dir . '/' . $file)){ // 递归
              recursive_delete($dir . '/' . $file);
            }
            else{
              unlink($dir . '/' . $file); // 删除文件
            }
        }
        
        @closedir($handle);
        rmdir($dir); 
      }
   }
}

if (!function_exists('is_really_writable')) {

    /**
     * 判断文件或文件夹是否可写
     * @param string $file 文件或目录
     * @return    bool
     */
    function is_really_writable($file)
    {
        if (DIRECTORY_SEPARATOR === '/') {
            return is_writable($file);
        }
        if (is_dir($file)) {
            $file = rtrim($file, '/') . '/' . hash('sha256',mt_rand());
            if (($fp = @fopen($file, 'ab')) === false) {
                return false;
            }
            fclose($fp);
            @chmod($file, 0777);
            @unlink($file);
            return true;
        } elseif (!is_file($file) or ($fp = @fopen($file, 'ab')) === false) {
            return false;
        }
        fclose($fp);
        return true;
    }
}

/**
 * 查询某个文件夹下后缀文件的函数
 * (glob('*.*') as $filename)
 */

if (!function_exists('template')) {
    /**
     * 获取模板文件夹
     * @return string
     */		
	function template() 
	{
		$list = [];
		$dir = '../template';
		$array = scandir($dir);
		foreach ($array as $key => $file) {
			# code...
			if ($file != '.' && $file != '..') {
				$child = $dir.'/'.$file;
				if (is_dir($child)) {
					$list[] = $file;
				}
			}
		}

		return $list;
	}
}

// +----------------------------------------------------------------------
// | 字符串函数开始
// +----------------------------------------------------------------------
// 
if (!function_exists('delNr')) {
    /**
     * 去掉换行
     * @param  string $str 字符串 
     * @return string
     */		
	function delNr($str)
	{
		$str = str_replace(array("<nr/>","<rr/>"),array("\n","\r"),$str);
		return trim($str);
	}
}

if (!function_exists('delNt')) {
    /**
     * 去掉连续空白
     * @param  string $str 字符串 
     * @return string
     */		
	function delNt($str)
	{
		$str = str_replace("　",' ',str_replace("",' ',$str));
		$str = preg_replace("/[\r\n\t ]{1,}/",' ',$str);
		return trim($str);
	}
}

if (!function_exists('strtoJs')) {
    /**
     * 转换成JS
     * @param  string $str 字符串 
     * @return bool   $mark 标记/直接返回转移代码
     */		
	function strtoJs($str, $mark = true)
	{
		$str = str_replace(array("\r", "\n"), array('', '\n'), addslashes($str));
		return $mark ? "document.write(\"$str\");" : $str;
	}
}

if (!function_exists('url_raw')) {
    /**
     * 转换成JS
     * @param  string $str 字符串 
     * @return bool   $mark 标记/直接返回转移代码
     */		
	function url_raw($str)
	{
		if (is_empty($str)) {
			return;
		}
		return str_replace('.html','',url($str,[],false));
	}
}

if (!function_exists('msubstr')) {
    /**
     * 字符串截取(同时去掉HTML与空白)
     * @param  string $str 
     * @param  string $str 	 
     * @return string
     */	
	function msubstr($str, $start = 0, $length = 100, $charset="utf-8", $suffix=true)
	{
		
		$str = strip_tags_clear($str);

		// 直接返回
		if ($start == -1) {
			return $str;
		}

		if(function_exists("mb_substr")){
			$slice= mb_substr($str, $start, $length, $charset);
		}elseif(function_exists('iconv_substr')) {
			$slice= iconv_substr($str,$start,$length,$charset);
			
		}else{
			$re['utf-8'] = "/[x01-x7f]|[xc2-xdf][x80-xbf]|[xe0-xef][x80-xbf]{2}|[xf0-xff][x80-xbf]{3}/";
			$re['gb2312'] = "/[x01-x7f]|[xb0-xf7][xa0-xfe]/";
			$re['gbk'] = "/[x01-x7f]|[x81-xfe][x40-xfe]/";
			$re['big5'] = "/[x01-x7f]|[x81-xfe]([x40-x7e]|xa1-xfe])/";
			preg_match_all($re[$charset], $str, $match);
			$slice = join("",array_slice($match[0], $start, $length));
		}
		
		$fix='';
		if(strlen($slice) < strlen($str)){
			$fix='...';
		}
		return $suffix ? $slice.$fix : $slice;
	}
}

if (!function_exists('strip_tags_clear')) {
    /**
     * 格式化HTML标签
     * @return string
     */
	function strip_tags_clear(string $str = null) {
		$str = preg_replace('/<[^>]+>/','',preg_replace("/[\r\n\t ]{1,}/",' ',delNt(strip_tags($str)))); 
		$str = preg_replace('/&(\w{4});/i','',$str);
		return $str;
	}
}

if (!function_exists('get_upload_Http_Perfix')) {

    /**
     * 获取远程图片前缀
     * @return string
     */
	function get_upload_Http_Perfix() {
		return saenv('upload_http_prefix');
	}
}

if (!function_exists('http_images_url')) {
    /**
     * 替换文章内容图片地址
     * @param 		string $content 内容
     * @return    	string
     */
    function http_images_url($content = null, $url = null)
    {
        if (!empty($content)) {
			if (empty($url)) {

				if (saenv('upload_ftp') || saenv('cloud.status')) {
					$url = get_upload_Http_Perfix();
				}
				else {

					// 默认为网站域名
					$url = request()->domain();
				}
			}
            $pregRule = "/<img(.*?)src(\s*)=(\s*)[\'|\"]\/(.*?(?:[\.jpg|\.jpeg|\.png|\.gif|\.bmp|\.ico|\.webp]))[\'|\"](.*?)[\/]?(\s*)>/i";
			$content  = preg_replace($pregRule, '<img${1}src="'.$url.'/${4}"${5}/>', $content);
        }

        return $content;
    }
}

if (!function_exists('letter_first')) {
    /**
     * 生成首字母前缀
     * @param  string $str 字符串 
     * @return string
     */		
	function letter_first($string)
	{
		$firstchar_ord=ord(strtoupper($string[0])); 
		if (($firstchar_ord>=65 and $firstchar_ord<=91)or($firstchar_ord>=48 and $firstchar_ord<=57)) return $string[0]; 
		$s=iconv("UTF-8","gb2312", $string); 
		$asc=ord($s[0])*256+ord($s[1])-65536; 
		if($asc>=-20319 and $asc<=-20284)return "A";
		if($asc>=-20283 and $asc<=-19776)return "B";
		if($asc>=-19775 and $asc<=-19219)return "C";
		if($asc>=-19218 and $asc<=-18711)return "D";
		if($asc>=-18710 and $asc<=-18527)return "E";
		if($asc>=-18526 and $asc<=-18240)return "F";
		if($asc>=-18239 and $asc<=-17923)return "G";
		if($asc>=-17922 and $asc<=-17418)return "H";
		if($asc>=-17417 and $asc<=-16475)return "J";
		if($asc>=-16474 and $asc<=-16213)return "K";
		if($asc>=-16212 and $asc<=-15641)return "L";
		if($asc>=-15640 and $asc<=-15166)return "M";
		if($asc>=-15165 and $asc<=-14923)return "N";
		if($asc>=-14922 and $asc<=-14915)return "O";
		if($asc>=-14914 and $asc<=-14631)return "P";
		if($asc>=-14630 and $asc<=-14150)return "Q";
		if($asc>=-14149 and $asc<=-14091)return "R";
		if($asc>=-14090 and $asc<=-13319)return "S";
		if($asc>=-13318 and $asc<=-12839)return "T";
		if($asc>=-12838 and $asc<=-12557)return "W";
		if($asc>=-12556 and $asc<=-11848)return "X";
		if($asc>=-11847 and $asc<=-11056)return "Y";
		if($asc>=-11055 and $asc<=-10247)return "Z";
		return 0;//null
	}	
}

if (!function_exists('pinyin')) {
    /**
     * 获取拼音
     * @param string $str  需要转换的汉子
     * @param bool   $abbr 是否只要首字母
     * @param bool   $trim 是否清除空格
     * @return bool
     */
    function pinyin($str, $abbr = false, $first = false, $trim = true)
    {
		$obj = new \Overtrue\Pinyin\Pinyin();
		if (!$abbr) {
			$string =  $obj->sentence($str);
		}
		else {
			$string =  $obj->abbr($str);
		}

		if ($first) {
			return strtoupper(substr($string,0,1));
		}

		return $trim ? str_replace(' ','',$string) : $string;
		
    }
}

if (!function_exists('is_email')) {
    /**
     * 判断邮箱
     * @param string $str 要验证的邮箱地址
     * @return bool
     */
    function is_email($str)
    {
        return preg_match("/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/", $str);
    }
}

if (!function_exists('is_mobile')) {
    /**
     * 判断手机号
     * @param string $num 要验证的手机号
     * @return bool
     */
    function is_mobile($num)
    {
        return preg_match("/^1(3|4|5|6|7|8|9)\d{9}$/", $num);
    }
}

if (!function_exists('regname_filter')) {
    /**
     * 判断用户名
     * @param string $value 要验证的用户名
     * @return bool
     */
    function regname_filter($value)
	{
        // 屏蔽注册的用户名
		$reg_notallow = saenv('user_reg_notallow');
		$reg_notallow = explode(',',$reg_notallow);
		foreach ($reg_notallow as $k => $v) {
			if ($value == $v) { /*不合法返回true*/
				return false;
			}
		}
		return true;
    }
}

if (!function_exists('format_bytes')) {

    /**
     * 将字节转换为可读文本
     * @param int    $size      大小
     * @param string $delimiter 分隔符
     * @return string
     */
    function format_bytes($size, $delimiter = '')
    {
        $units = array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
        for ($i = 0; $size >= 1024 && $i < 6; $i++) {
            $size /= 1024;
        }
        return round($size, 2) . $delimiter . $units[$i];
    }
}
if (!function_exists('create_order_id')) {

    /**
     * 生成订单号
     * @return string
     */
	function create_order_id(bool $short = false) {

		if (!$short) {

			$gradual = 0;
			$orderId = date('YmdHis') . mt_rand(10000000,99999999);
			$length = strlen($orderId);
			// 循环处理随机数
			for($i=0; $i<$length; $i++){
				$gradual += (int)(substr($orderId,$i,1));
			}

			return $orderId . str_pad((100 - $gradual % 100) % 100,2,'0',STR_PAD_LEFT);
		}else {
			return date('Ymd').substr(implode('', array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
		}
	}
}

if (!function_exists('create_order_url')) {

    /**
     * 生成订单地址
     * @return string
     */
	function create_order_url(string $id, string $paytype = 'alipay', string $token = null) {

		$payUrl = saenv('site_http').'/order/index?id='.$id.'&paytype='.$paytype;
		if ($token) {
			$payUrl .= '&token='.$token;
		}
		return $payUrl;
	}
}

if (!function_exists('get_pay_logo')) {

    /**
     * 获取支付logo
     * @return string
     */
	function get_pay_logo(string $type = 'alipay') {
		$file = public_path().'static/images/pay/logo-'.$type.'.png';
		return is_file($file) ? $file : '/static/images/pay/pay.png';
	}
}

if (!function_exists('check_nav_active')) {
    /**
     * 检测会员中心导航是否高亮
     */
    function check_nav_active($url, $classname = 'active')
    {
        $requestUrl = request()->controller(true).'/'.request()->action(true);
        $url = str_replace('.','/',ltrim($url, '/'));
		$requestUrl = str_replace('.','/',$requestUrl);
        return $requestUrl === $url ? $classname : '';
    }
}


if (!function_exists('check_menu_active')) {
    /**
     * 检测前台菜单导航是否高亮
     */
    function check_menu_active($vo,$detail ,$classname = 'active')
    {
		if (empty($vo) || empty($detail)) {
			return false;
		}

		// 如果存拼音则判断
		if (isset($vo['pinyin']) && isset($detail['pinyin']) ) {
			if ($vo['pinyin'] == $detail['pinyin']) {
				return $classname;
			}
			else {

				// 如果是内容页
				if (isset($detail['category'])) {
					if ($vo['pinyin'] == $detail['category']['pinyin']) {
						return $classname;
					}
				}
			}
		}

		return false;
    }
}

if (!function_exists('hide_str')) {
    /**
     * 将一个字符串部分字符用*替代隐藏
     * @param string    $string   待转换的字符串
     * @param int       $bengin   起始位置，从0开始计数，当$type=4时，表示左侧保留长度
     * @param int       $len      需要转换成*的字符个数，当$type=4时，表示右侧保留长度
     * @param int       $type     转换类型：0，从左向右隐藏；1，从右向左隐藏；2，从指定字符位置分割前由右向左隐藏；3，从指定字符位置分割后由左向右隐藏；4，保留首末指定字符串中间用***代替
     * @param string    $glue     分割符
     * @return string   处理后的字符串
     */
    function hide_str($string, $bengin=3, $len = 4, $type = 0, $glue = "@")
    {
        if (empty($string)) {
            return false;
        }
        $array = array();
        if ($type == 0 || $type == 1 || $type == 4) {
            $strlen = $length = mb_strlen($string);
            while ($strlen) {
                $array[] = mb_substr($string, 0, 1, "utf8");
                $string = mb_substr($string, 1, $strlen, "utf8");
                $strlen = mb_strlen($string);
            }
        }
        if ($type == 0) {
            for ($i = $bengin; $i < ($bengin + $len); $i++) {
                if (isset($array[$i])) {
                    $array[$i] = "*";
                }
            }
            $string = implode("", $array);
        } elseif ($type == 1) {
            $array = array_reverse($array);
            for ($i = $bengin; $i < ($bengin + $len); $i++) {
                if (isset($array[$i])) {
                    $array[$i] = "*";
                }
            }
            $string = implode("", array_reverse($array));
        } elseif ($type == 2) {
            $array = explode($glue, $string);
            if (isset($array[0])) {
                $array[0] = hide_str($array[0], $bengin, $len, 1);
            }
            $string = implode($glue, $array);
        } elseif ($type == 3) {
            $array = explode($glue, $string);
            if (isset($array[1])) {
                $array[1] = hide_str($array[1], $bengin, $len, 0);
            }
            $string = implode($glue, $array);
        } elseif ($type == 4) {
            $left = $bengin;
            $right = $len;
            $tem = array();
            for ($i = 0; $i < ($length - $right); $i++) {
                if (isset($array[$i])) {
                    $tem[] = $i >= $left ? "" : $array[$i];
                }
            }
            $tem[] = '*****';
            $array = array_chunk(array_reverse($array), $right);
            $array = array_reverse($array[0]);
            for ($i = 0; $i < $right; $i++) {
                if (isset($array[$i])) {
                    $tem[] = $array[$i];
                }
            }
            $string = implode("", $tem);
        }
        return $string;
    }
}

if (!function_exists('create_rand')) {
    /**
     * 生成随机字符串
     * @param  intval $length 字符串长度
     * @return string
     */
	function create_rand($length = 10,$flag = false)
	{ 
		$str = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';//62个字符 
		if ($flag) {
			$str = '123456789';
		}
		$strlen = 62; 
		while($length > $strlen){ 
			$str .= $str; 
			$strlen += 62; 
		} 
		$str = str_shuffle($str); 
		return substr($str,0,$length); 
	} 
}

// +----------------------------------------------------------------------
// | MYSQL调用函数开始
// +----------------------------------------------------------------------

if (!function_exists('check_user_third')) {
    /**
     * 获取第三方登录
     * @param mixed $type
	 * @param int $id	 
     * @return array
     */	
	function check_user_third($type, $id = 0) 
	{
		if (!$id || !$type) {
			return false;
		}
		
		if (\app\common\model\system\UserThird::where('user_id',$id)->getByType($type)) {
			return true;
		}
		return false;

	}
}


if (!function_exists('mysql_content')) {
    /**
     * 公共类查询函数
     * @param  array $param 查询参数
     * @param  bool  $admin 调用标记	 
     * @return array
     */	
	function mysql_content($param, $admin = false){

		// 检查参数
		if (!is_array($param)) { 
			$param = parse_tag($param);
		}
		
        // 获取参数
		$field = !empty($param['field']) ? $param['field'] : '*';	
		$limit = !empty($param['limit']) ? $param['limit'] : '10';
		$model = !empty($param['model']) ? $param['model'] : 'article';
		$order = !empty($param['order']) ? $param['order'] : 'id desc';

		
		$model = ChannelModel::getChannelList(null,$model);
		if (empty($model)) {
			throw new \Exception('There is no model');
		}

		// 优先从缓存调用
		$param['cid'] = $model['id'];
		$page = Config::get('current.page') ?? 1;
		if(is_numeric($page) && $page <= 2 && saenv('url_model') !== STATICS) {
			
            // 数据缓存
			$data_cache_name = hash_hmac("sha256",implode(',',$param),saenv('auth_key'));
			$data_cache_content = system_cache($data_cache_name);
			if($data_cache_content) {
				return $data_cache_content;
			}
		}
        
		// 根据参数生成查询条件
		$where = array();
		if (!empty($param['status'])) {
			if($param['status'] == 1){
				$where[]=['status','=','1'];
			}elseif($param['status'] == 2){
				$where[]=['status','=','0'];
			}		
		}	
		
		if (!empty($param['ids'])) {
			$ids = explode(',',trim($param['ids']));
			if (count($ids)>1) {
				$where[] = ['id','in',$ids];
			}else{
				$where[] = ['id','in',$param['ids']];
			}
		}

		if (!empty($param['pid'])) {
			$pids = explode(',',trim($param['pid']));
			if (count($pids)>1) {
				$where[] = ['pid','in',$pids];
			}else{
				$where[] = ['pid','in',$param['pid']];
			}
		}
		
		if(!empty($param['desc'])){
			if($param['desc'] == 1){
				$where[] = ['seo_description','<>',''];
			}
		}		

		if(!empty($param['thumb'])){
			$where[] = ['thumb','<>',''];
		}
			
		if(!empty($param['banner'])){
			$where[] = ['banner','<>',''];
		}   

		if (!empty($param['year'])) {
			$year = explode(',',$param['year']);
			if (count($year) > 1) {
				$where[] = ['year','between',$year[0].','.$year[1]];
			}else{ 
				$where[] = ['year','=',$param['year']];
			}
		}

		if (!empty($param['class'])) {
			$where[] = ['class','like','%'.$param['class'].'%'];
		}	
		if (!empty($param['marks'])) {
			$where[] = ['marks','like','%'.$param['marks'].'%'];
		}
		if (!empty($param['actor'])) {
			$where[] = ['actor','like','%'.$param['actor'].'%'];
		}
		if (!empty($param['director'])) {
			$where[] = ['director','like','%'.$param['director'].'%'];
		}
		if (!empty($param['play'])) {
			$where[] = ['play','like','%'.$param['play'].'%'];
		}

		if (!empty($param['day'])) {
			$where[] = ['createtime','>=',linux_extime($param['day'])];
		}
		if (!empty($param['stars'])) {
			$where[] = ['stars','=',$param['stars']];
		}

		if (!empty($param['letter'])) {
			$where[] = ['letter','=',$param['letter']];
		}

		if (!empty($param['hits'])) {
			$hits = explode(',',$param['hits']);
			if (count($hits) > 1) {
				$where[] = ['hits','between',$hits[0].','.$hits[1]];
			}else{
				$where[] = ['hits','>',$param['hits']];
			}
		}
		if (!empty($param['up'])) {
			$up = explode(',',$param['up']);
			if (count($up)>1) {
				$where[] = ['up','between',$up[0].','.$up[1]];
			}else{
				$where[] = ['up','>',$up[0]];
			}
		}
		if (!empty($param['down'])) {
			$down = explode(',',$param['down']);
			if (count($down)>1) {
				$where[] = ['down','between',$down[0].','.$down[1]];
			}else{
				$where[] = ['down','>',$down[0]];
			}
		}
		if (!empty($param['gold'])) {
			$gold = explode(',',$param['gold']);
			if (count($gold) > 1) {
				$where[] = ['gold','between',$gold[0].','.$gold[1]];
			}else{
				$where[] = ['gold','>',$gold[0]];
			}
		}
		if (!empty($param['golder'])) {
			$golder = explode(',',$param['golder']);
			if (count($golder)>1) {
				$where[] = ['golder','between',$golder[0].','.$golder[1]];
			}else{
				$where[] = ['golder','>',$golder[0]];
			}
		}
		if (!empty($param['wd'])) {
			if ($model['attr'] == 'video') {
				// actor
				$where[] = ['title','like','%'.$param['wd'].'%'];
			}else {
				$where[] = ['title','like','%'.$param['wd'].'%'];
			}
		}

		if (!empty($param['author'])) {
			$where[] = ['author','like','%'.$param['author'].'%'];
		}

		// 查询总数
		$count = ContentModel::where($where)->count('id');
        if ($count < $limit || !$page) {
            Config::set(['page'=>$page], 'current');
        }

        // 查询数据
		$with = ['attr'];
		if ($model['attr'] !== 'none') {
			$with[] = $model['attr'];
		}

        $list = ContentModel::with($with)->where($where)->order($order)->field($field)->limit($limit)->page($page)->select()->toArray();

        // 分页调用
        if (isset($param['page']) && !empty($list)) {

			$currentUrl = Config::get('current.url');
			$maxPages   = saenv('max_page');
            $totalPages = ceil($count/$limit);

			if (!empty($maxPages) && $totalPages > $maxPages) {
				$totalPages = $maxPages;
			}

			// 自定义分页
			if (!empty($currentUrl)) { 
				$page = get_page($page,$totalPages,$currentUrl);
			}
			else {
				$page = build_request_url([],'list_style',['page'=>$page,'total'=>$totalPages]);
			}

			// 分配页码变量
			$list[0]['page'] = $page;
			$list[0]['total'] = $count;
			Config::set(['totalPages'=>$totalPages],'current');
        }

        // 设置缓存 
		if(is_numeric($page) && $page <= 2) {
			system_cache($data_cache_name,['data'=>$list,'total'=>$count],saenv('cache_time'));
		}
	
		return ['data'=>$list,'total'=>$count];
	}
}

if (!function_exists('mysql_comment')) {
    /**
     * 获取用户评论
     * @param  array $param 查询参数	 
     * @return array
     */	
	function mysql_comment($param, $admin = false) 
	{

		$where = array();
		$param = parse_tag($param);
		$field = !empty($param['field']) ? $param['field'] : '*';
		$limit = !empty($param['limit']) ? $param['limit'] : '10';
		$order = !empty($param['order']) ? $param['order'] : 'up desc, createtime desc';

		$where[] = ['pid','=','0'];
		if (!empty($param['cid'])) {
			$where[] = ['cid','=',$param['cid']];
		}
		
		if (!empty($param['sid'])) {
			$where[] = ['sid','=',$param['sid']];
		}
		
		if (!empty($param['uid'])) {
			$where[] = ['uid','=',$param['uid']];
		}

		// 获取某个时间段
		if (empty($param['time'])) {
			$param['time'] = time();
		}

		// 获取总数
		$count = Db::name('comment')->where($where)->count('id');

		// 分页调用
		if (!Config::get('comment')) {
			Config::set(['page'=>1],'comment');
		}

		// 首次查询
		$list = Db::name('comment')->alias('c')
				->leftJoin('user u','c.uid = u.id')
				->where('c.status',1)
				->where('c.createtime','<',$param['time'])
				->fieldRaw("c.*,ifnull(u.name,'游客') as name,ifnull(u.avatar,'/static/images/user_default.jpg') as avatar")
				->where($where)
				->order($order)
				->limit($limit)
				->page(Config::get('comment.page'))
				->select()
				->toArray();

		
		// 查询二级评论
		foreach ($list as $key => $value) {
			
			$list[$key]['_child'] = Db::name('comment')->alias('c')
									->leftJoin('user u','c.uid = u.id')
									->where('c.status',1)
									->where('pid',$value['id'])
									->fieldRaw("c.*,ifnull(u.name,'游客') as name,ifnull(u.avatar,'/static/images/user_default.jpg') as avatar")
									->order($order)
									->select()
									->toArray();
			// 存在则处理子数据
			if (!empty($list[$key]['_child'])) {

				foreach($list[$key]['_child'] as $keys => $_child) {

					if ($_child['rid'] != $_child['pid']) {

						$reply = list_search($list[$key]['_child'],['id'=>$_child['rid']]);
						if (!empty($reply['name'])) {
							$list[$key]['_child'][$keys]['replyname'] = $reply['name'];
						}else {
							$list[$key]['_child'][$keys]['replyname'] = '游客';
						}
					}

					$list[$key]['_child'][$keys]['createtime'] = differ_time($list[$key]['_child'][$keys]['createtime']);
				}
			}

			$list[$key]['createtime'] = differ_time($list[$key]['createtime']);
		}

		return ['data'=>$list,'total'=>$count];
	}
}
// +----------------------------------------------------------------------
// | 系统APP函数开始
// +----------------------------------------------------------------------
// 
if (!function_exists('__')) {
	/**
	 * 全局多语言函数
	 */
	function __($str, $vars = [], $lang = '')
	{
		if (is_numeric($str) || empty($str)) {
			return $str;
		}

        if (!is_array($vars)) {
            $vars = func_get_args();
            array_shift($vars);
            $lang = '';
        }
		
        return lang($str, $vars, $lang);
	}
}

if (!function_exists('saenv')) {
	/**
	 * 获取系统配置信息
	 * @param mixed|null $name
	 * @return mixed
	 */
	function saenv($name = null)
	{
		if (!empty($name)) {

			// 修改后需清空缓存
			$config = Cache::get('redis-system');
			if (empty($config)) {
				$config = config('system');
				Cache::set('redis-system',$config);
			}
			
			if (!is_array($name)) {
				$name = explode('.',$name);
			}

			foreach ($name as  $val) {
				if (isset($config[$val])) {
					$config = $config[$val];
				} else {

					// 父类数据
					$parent = $config;
					$recursive = function(&$base,&$key) use (&$recursive,&$config) {
						foreach ($base as $value) {
							if (is_array($value)) {
								
								// 找到KEY
								if (array_key_exists($key,$value)) {
									$config = $value[$key];
								}

								 // 存在子数组则进行递归
								else if(count($value) != count($value,1)) {
									$recursive($value,$key);
								}
							}
						}
					};
					
					$recursive($config, $val);
					// 数据相等则为空
					if ($config == $parent) {
						$config = [];
					}
				}
			}
			
			return $config;
		}
	
		return false;
	}
}

if (!function_exists('system_cache')) {
    /**
     * 全局缓存控制函数
     * @param  string ...cache
     * @return object||array
     */	
	function system_cache(string $name = null, $value = '', $options = null, $tag = null)
	{
		if (!saenv('cache_status')) {
			return false;
		}

		if (is_null($name)) {
			return app('cache');
		}

		if ('' === $value) {
			// 获取缓存
			return 0 === strpos($name, '?') ? Cache::has(substr($name, 1)) : Cache::get($name);
		} elseif (is_null($value)) {
			// 删除缓存
			return Cache::delete($name);
		}

		// 缓存数据
		if (is_array($options)) {
			$expire = $options['expire'] ?? null;
		} else {
			$expire = $options;
		}

		if (is_null($tag)) {
			return Cache::set($name, $value, $expire);
		} else {
			return Cache::tag($tag)->set($name, $value, $expire);
		}
	}
}

if (!function_exists('search_model')) {
    /**
     * 获取搜索模式
     *
     * @return mixed
     */
    function search_model(string $searchmodel = null)
    {
		$searchmodel = $searchmodel ?? saenv('search_model');
        return NAMESPACELIBRARY . $searchmodel;
    }
}

if (!function_exists('parse_tag')) {
    /**
     * 生成参数列表,以数组形式返回
     * @param  string $tag 字符串
     * @return array
     */	
	function parse_tag($tag = '')
	{
		if(is_array($tag)) { 
			return $tag;
		}
		$param = array(); //标签解析
		$array = explode(';', $tag);

		foreach ($array as $key => $val){
			if (!empty($val)) {
				$temp = explode(':',trim($val));
				$param[$temp[0]] = $temp[1];			
			}
		}
		
		if(!isset($param['status'])) { // 默认只查询已审核的
			$param['status'] = 1;
		}
		return $param;
	}	
}

if (!function_exists('parse_array_ini')) {
    /**
     * 解析数组到ini文件
	 * @param  array 	$array 		数组
	 * @param  string 	$content 	字符串
     * @return string	返回一个ini格式的字符串
     */
    function parse_array_ini($array,$content = '') 
	{

        foreach ($array as $key => $value) {
            if (is_array($value)) {
                // 分割符PHP_EOL
                $content .= PHP_EOL.'['.$key.']'.PHP_EOL;
                foreach ($value as $field => $data) {
                    $content .= $field .' = '. $data . PHP_EOL;
                }

            }else {
                $content .= $key .' = '. $value . PHP_EOL;
            }
        }

        return $content;
    }
}

if (!function_exists('list_search')) {
    /**
     * 从数组查找数据返回
     * @param  array  $list      原始数据
     * @param  array  $condition 规则['id'=>'??']	 
     * @return array
     */		
	function list_search($list,$condition) 
	{
		if(is_string($condition))
			parse_str($condition,$condition);
		// 返回的结果集合
		$resultSet = array();
		foreach ($list as $key=>$data){
			$find   =   false;
			foreach ($condition as $field=>$value){
				if(isset($data[$field])) {
					if(0 === strpos($value,'/')) {
						$find = preg_match($value,$data[$field]);
					}else if($data[$field]==$value){
						$find = true;
					}
				}
			}
			if($find)
				$resultSet[] = &$list[$key];
		}
		
		if (!empty($resultSet[0])) {
			return $resultSet[0];
		}else {
			return false;
		}
	}
}

if (!function_exists('list_search_value')) {
    /**
     * 查找一个二维数组的值
     * @param  array  $list      原始数据
     * @return array
     */		
	function list_search_value($list, $condition) 
	{
		foreach ($list as $key => $value) {
			if (stripos($value,$condition)) {
				return $value;
			}
		}

		return false;
	}
}

if (!function_exists('list_to_tree')) {
    /**
     * 根据ID和PID返回一个树形结构
     * @param  array  $list    数组结构	 
     * @return array
     */		
	function list_to_tree($list, $id='id', $pid = 'pid', $child = 'children', $level = 0) 
	{
		// 创建Tree
		$tree = $refer = array();
		if(is_array($list)) {
			// 创建基于主键的数组引用
			foreach ($list as $key => $data) {
				$refer[$data[$id]] = &$list[$key];
			}

			foreach ($list as $key => $data) {
				// 判断是否存在parent
				$parentId = $data[$pid];
				if ($level == $parentId) {
					$tree[] = &$list[$key];
				}else{
					if (isset($refer[$parentId])) {
						$parent = &$refer[$parentId];
						$parent[$child][] = &$list[$key];
					}
				}
			}
		}
		
		return $tree;
	}
}

if (!function_exists('tree_to_list')) {
    /**
     * 根据ID和PID返回一个数组结构
     * @param  array  $tree    多位数组 
     * @return array
     */	
	function tree_to_list($tree, $child = 'children', $order = 'id', &$list = array())
	{
		if (is_array($tree)) {
			$refer = array();
			foreach ($tree as $key => $value) {
				$reffer = $value;
				if (isset($reffer[$child])) {
					unset($reffer[$child]);
					tree_to_list($value[$child], $child, $order, $list);
				}
				$list[] = $reffer;
			}
			$list = list_sort_by($list, $order, $sortby = 'asc');
		}
		return $list;
	}
}

if (!function_exists('list_sort_by')) {
	/**
	 *----------------------------------------------------------
	 * 对查询结果集进行排序
	 *----------------------------------------------------------
	 * @access public
	 *----------------------------------------------------------
	 * @param  array   $list 查询结果
	 * @param  string  $field 排序的字段名
	 * @param  array   $sortby 排序类型
	 * @switch string  asc正向排序 desc逆向排序 nat自然排序
	 *----------------------------------------------------------
	 * @return array
	 *----------------------------------------------------------
	 */	
	function list_sort_by($list,$field, $sortby='asc') 
	{
	   if(is_array($list)){
		   $refer = $resultSet = array();
		   foreach ($list as $i => $data)
			   $refer[$i] = &$data[$field];
		   switch ($sortby) {
			   case 'asc': // 正向排序
					asort($refer);
					break;
			   case 'desc':// 逆向排序
					arsort($refer);
					break;
			   case 'nat': // 自然排序
					natcasesort($refer);
					break;
		   }
		   foreach ( $refer as $key=> $val)
			   $resultSet[] = &$list[$key];
		   return $resultSet;
	   }
	   return false;
	}
}

if (!function_exists('is_empty')) {
    /**
     * 判断是否为空值
     * @param array|string $value 要判断的值
     * @return bool
     */
    function is_empty($value)
    {
        if (!isset($value)) {
            return true;
        }

        if ($value === null) {
            return true;
        }

        if (trim($value) === '') {
            return true;
        }

        return false;
    }
}

if (!function_exists('is_notempty')) {
    /**
     * 判断变量是否不为空
     * @param array|string $value 要判断的值
     * @return bool
     */
    function is_notempty($value)
    {
		if (isset($value) && $value) {
			return $value;
		}
       
        return false;
    }
}

if (!function_exists('reply_face')) {
	/**
	 * 头像替换
	 */
	function reply_face($face,$content) 
	{
		
		if (is_array($face)) {
			foreach ($face as $key => $value) {
				$content = str_replace($value,'<img src="/static/images/face/'.$key.'.gif"/>',$content);
			}
		}
		return $content;
	}	
}

if (!function_exists('letter_avatar')) {
    /**
     * 首字母头像
     * @param $text
     * @return string
     */
    function letter_avatar($text)
    {
        $total = unpack('L', hash('adler32', $text, true))[1];
        $hue = $total % 360;
        list($r, $g, $b) = hsv2rgb($hue / 360, 0.3, 0.9);

        $bg = "rgb({$r},{$g},{$b})";
        $color = "#ffffff";
        $first = mb_strtoupper(mb_substr($text, 0, 1));
        $src = base64_encode('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="100" width="100"><rect fill="' . $bg . '" x="0" y="0" width="100" height="100"></rect><text x="50" y="50" font-size="50" text-copy="fast" fill="' . $color . '" text-anchor="middle" text-rights="admin" alignment-baseline="central">' . $first . '</text></svg>');
        $value = 'data:image/svg+xml;base64,' . $src;
        return $value;
    }
}

if (!function_exists('hsv2rgb')) {
    function hsv2rgb($h, $s, $v)
    {
        $r = $g = $b = 0;

        $i = floor($h * 6);
        $f = $h * 6 - $i;
        $p = $v * (1 - $s);
        $q = $v * (1 - $f * $s);
        $t = $v * (1 - (1 - $f) * $s);

        switch ($i % 6) {
            case 0:
                $r = $v;
                $g = $t;
                $b = $p;
                break;
            case 1:
                $r = $q;
                $g = $v;
                $b = $p;
                break;
            case 2:
                $r = $p;
                $g = $v;
                $b = $t;
                break;
            case 3:
                $r = $p;
                $g = $q;
                $b = $v;
                break;
            case 4:
                $r = $t;
                $g = $p;
                $b = $v;
                break;
            case 5:
                $r = $v;
                $g = $p;
                $b = $q;
                break;
        }

        return [
            floor($r * 255),
            floor($g * 255),
            floor($b * 255)
        ];
    }
}

if (!function_exists('reply_anti')) {
	/**
	 * 过滤脏话
	 */
	function reply_anti($content) 
	{
		$words = saenv('user_replace');
		$words = str_replace(array(',','/','|','，'),',',$words);
		$words = explode(',',$words);

		if (!empty($words) && is_array($words)) {
			foreach ($words as $k => $v) {
				$content = str_replace($v,'**',$content);
			}
		}
		return $content;
	}
}

if (!function_exists('build_request_url')) {
	/**
	 * 解析请求地址
	 * @param array 			$data		栏目|内容数据
	 * @param mixed|null 		$variable	标识
	 * @param array 			$param		附加参数
	 * @return mixed
	 */
	function build_request_url($data = [], $variable = null, $param = [])
	{
		$readurl = saenv($variable);
		$domain = saenv('url_domain') ? true : false;
		if (saenv('url_model') == TRUE) {
			
			
			// 替换规则
			$search	 = ['[listdir]','[sublist]','[id]'];
			if ($variable == 'content_style') {
				foreach (CategoryModel::getListCache() as $value) {
					if ($value['id'] == $data['pid']) {
						$category = $value;
					}
				}
			}
			else {
				$category = !empty($data) ? $data : Config::get('current.detail');
			}
			
			// 栏目数据备份
			$nextcategory = $category;
			if (strpos($readurl,'sublist') && $category['pid']) {

				// 查询顶级栏目
				foreach (CategoryModel::getListCache() as $value) {

					if (!$value['pid'] && $value['id'] == $category['pid']) {
						$category = $value;
						break;
					}
				}

			} else if ($nextcategory == $category) {
				$readurl = str_replace('/sublist/','/',$readurl);
			}

			$replace = [
				$category['pinyin']??'',
				$nextcategory['pinyin']??'',
				$data['id']??''
			];

			$readurl = str_replace($search,$replace,$readurl);
			$readurl = $domain ? saenv('site_http').$readurl : $readurl;
			if ($variable == 'list_style') {
				$readurl = get_page($param['page'],$param['total'],$readurl);
			}
		}
		else { 
			// 动态地址生成
			switch ($variable) {
				case 'category_style':
					$readurl = url("/category/index",['dir'=>$data['pinyin']])->domain($domain);
					break;	
				case 'list_style':
					$category = Config::get('current.detail');
					$readurl = url("/category/index",['dir'=>$category['pinyin'],'p'=>'page'])->domain($domain);
					$readurl = get_page($param['page'],$param['total'],$readurl);
					break;	
				case 'content_style':
					// $type = strpos($readurl,'id') ? 'id' : 'hash';
					$channel = ChannelModel::getChannelList($data['cid']);
					$readurl = url("/{$channel['template']}/read",['id'=>$data['id']])->domain($domain);
					break;	
				default:
					# TODO..
					break;
			}

			$readurl = str_replace(request()->server()['SCRIPT_NAME'],'/index.php',$readurl);
		}
		
		return  $readurl;
	}
}

if (!function_exists('get_read_url')) {
	/**
	 * 获取内容自定义地址
	 * @param mixed|null 		$url		路由规则
	 * @param array 			$param		访问参数
	 * @param bool 				$rules		是否既定规则
	 * @param mixed|null 		$readurl	返回访问地址
	 * @return string
	 */
	function get_read_url($url = null,$param = [], $rules = true, $readurl = null)
	{
		$char = substr($url,0,1);
		$readurl = $char != '/' ? '/'.$url : $url;
		$domain = saenv('url_domain')?true:false;

		if (saenv('url_model') == true) {
	
			if ($rules) {

				// 既定规则
				$url = trim($url,'/');
				$url = explode('/',$url);
				$readurl = array_merge([current($url)],$param);
				$replace = str_replace('/sublist/','/',saenv('content_style'));

				// 在这里读取地址信息
				$listdir = current($readurl);
				$param   = end($readurl);
				$readurl = str_replace('[listdir]',$listdir,$replace);
				$readurl = str_replace(['[id]','[hash]','[pinyin]'],$param,$readurl);
				
			} else {

				// 需要GET的地址
				$readurl = $readurl.'?'.http_build_query($param);
			}
	
			$readurl = $domain?saenv('site_http').$readurl:$readurl;
		}
		else {

			$readurl = (string)url($readurl,$param)->domain($domain);
			$readurl = str_replace(request()->server()['SCRIPT_NAME'],'/index.php',$readurl);
		}

		return $readurl;
	}
}

if (!function_exists('get_page')) {

	/**
	 * 获取分页
	 * @param mixed 		$currentPage	当前页
	 * @param mixed 		$totalPages		总页码
	 * @param mixed 		$pageUrl		分页地址
	 * @param int 			$halfPer		分页侧边长度
	 * @param mixed|null 	$linkPage		返回分页地址
	 * @return string
	 */
	function get_page($currentPage, $totalPages, $pageUrl, $halfPer = 3, $linkPage = null)
	{
		if ($currentPage <= 1) {
			$linkPage .= '<em>首页</em><em>上一页</em>';
		}
		else {
			$linkPage .= '<a href="'.str_replace('page',1,$pageUrl).'" class="first">首页</a>';
			$linkPage .= '<a href="'.str_replace('page',($currentPage-1),$pageUrl).'" class="prev">上一页</a>';
		}

		// 中间页码
		for($i = $currentPage - $halfPer, $i > 1 || $i=1, 
			$j = $currentPage + $halfPer, 
			$j < $totalPages || $j = $totalPages; $i < (int)$j+1; $i++){
			$linkPage .= ($i == $currentPage)?'<span>'.$i.'</span>':'<a href="'.str_replace('page',$i,$pageUrl).'">'.$i.'</a>'; 
		}

		// 当前页码小于总数
		if ($currentPage < $totalPages) {
			$linkPage .= '<a href="'.str_replace('page',($currentPage + 1),$pageUrl).'" class="next">下一页</a>';
			$linkPage .= '<a href="'.str_replace('page',$totalPages,$pageUrl).'" class="end">尾页</a>';
		}else {
			$linkPage .= '<em>下一页</em><em>尾页</em>';
		}
		
		// 祛除首页地址
		$linkPage = str_replace('list_1.html','',$linkPage);
		
		return $linkPage;
	}
}

if (!function_exists('get_usergroup_json')) {
	/**
	 * 获取用户组
	 */
	function get_usergroup_json()
	{
		return json_encode(\app\common\model\system\UserGroup::select()->toArray());
	}
}
if (!function_exists('get_category_json')) {

	/**
	 * 获取栏目JSON数据
	 * @param int 		$pid
	 * @param int 		$cid
	 * @param int 		$limit
	 * @param string 	$field
	 * @param string 	$order
	 * @return string|false
	 */
	function get_category_json($pid = 0,$cid = 0,$field = '*',$limit = 100,$order = 'id asc')
	{
		return Auth::instance()->getrulecatestree('cates','private');
	}
}

if (!function_exists('get_dictionary_alias')) {
    /**
     * 获取字典别名
     * @param  string $name 字符串
     * @return string|array
     */	
	function get_dictionary_alias(string $name = null) 
	{
		if (!$name) {
			return false;
		}

		$list = system_cache('dictionary');
		if (empty($list)) {
			$list = DictionaryModel::select()->toArray();
			system_cache('dictionary',$list);
		}

		if ($find = list_search($list,['name'=>$name])) {
			return $find['alias'];
		}
	}
}

if (!function_exists('get_dictionary_jump')) {
    /**
     * 生成字典跳转地址
     * @param  string $name 字符串
     * @return string
     */	
	function get_dictionary_jump(string $name)
	{
		$domain = saenv('url_domain') ? true : false;
		return (string)url('/jump/'.$name)->domain($domain);
	}
}

if (!function_exists('get_param_url')) {
    /**
     * 路径参数处理函数
     * @return array
     */		
	function get_param_url()
	{
		$where = array();
		$where['id'] = intval(input('id'));
		$where['cid'] = intval(input('cid'));
		$where['year'] = intval(input('year'));
		$where['type'] = urldecode(trim(input('type')));	
		$where['area'] = urldecode(trim(input('area')));
		$where['language'] = urldecode(trim(input('language')));
		$where['letter'] = htmlspecialchars(input('letter'));
		$where['actor'] = htmlspecialchars(urldecode(trim(input('actor'))));
		$where['director'] = htmlspecialchars(urldecode(trim(input('director'))));
		$where['wd'] = htmlspecialchars(urldecode(trim(input('wd'))));
		
		// 分页参数
		$where['limit'] = !empty(input('limit')) ? intval(input('limit')) : 10;
		$where['page'] = !empty(input('p')) ? intval(input('p')) : 1;
		$where['order'] = get_security_order(input('order'));
		return $where;
	}
}

if (!function_exists('get_jump_url')) {
    /**
     * 分页跳转参数处理
     * @param  where          $where 条件
     * @return array|string
     */	
	function get_jump_url($where)
	{
		if($where['id']){
			$jumpurl['id'] = $where['id'];
		}
		if($where['cid']){
			$jumpurl['cid'] = $where['cid'];
		}
		if($where['year']){
			$jumpurl['year'] = $where['year'];
		}		
		if($where['language']){
			$jumpurl['language'] = urlencode($where['language']);
		}
		if($where['type']){
			$jumpurl['type'] = urlencode($where['type']);
		}	
		if($where['area']){
			$jumpurl['area'] = urlencode($where['area']);
		}
		if($where['letter']){
			$jumpurl['letter'] = $where['letter'];
		}	
		if($where['actor']){
			$jumpurl['actor'] = urlencode($where['actor']);
		}
		if($where['director']){
			$jumpurl['director'] = urlencode($where['director']);
		}
		if($where['wd']){
			$jumpurl['wd'] = urlencode($where['wd']);
		}		
		if($where['order'] != 'createtime' && $where['order']){
			$jumpurl['order'] = $where['order'];
		}

		$jumpurl['p'] = 'page'; //var_dump($jumpurl);
		
		return $jumpurl;
	}
}

if (!function_exists('get_security_order')) {
    /**
     * 返回安全的order
     * @param  array          $order 排序
     * @return array|string
     */
	function get_security_order($order = 'createtime')
	{
		if(empty($order)){
			return 'createtime';
		}
		$array = array();
		$array['id'] = 'id';
		$array['up'] = 'up';
		$array['down'] = 'down';
		$array['gold'] = 'gold';
		$array['golder'] = 'golder';
		$array['year'] = 'year';
		$array['stars'] = 'stars';
		$array['letter'] = 'letter';
		$array['filmtime'] = 'filmtime';
		$array['hits'] = 'hits';
		$array['hits_month'] = 'hits_month';
		$array['hits_week'] = 'hits_week';
		$array['createtime'] = 'createtime';
		$array['updatetime'] = 'updatetime';
		return $array[trim($order)];
	}
}

if (!function_exists('array_filter_callback')) {
    /**
     * array_filter 回调函数，只过滤空值
     * @param mixed $val 需要过滤的值
     * @return bool
     */
    function array_filter_callback($val)
    {
        if ($val === '' || $val === 'NULL' || $val === null || $val === ' ') {
            return false;
        }
        return true;
    }
}

if (!function_exists('parse_attr')) {
    /**
     * 配置值解析成数组
     * @param string $value 配置值
     * @return array|string
     */
    function parse_attr($value = '')
    {
        if (is_array($value)) {
            return $value;
        }
        $array = preg_split('/[,;\r\n]+/', trim($value, ",;\r\n"));
        if (strpos($value, ':')) {
            $value  = array();
            foreach ($array as $val) {
                list($k, $v) = explode(':', $val);
                $value[$k]   = $v;
            }
        } else {
            $value = $array;
        }
        return $value;
    }
}

if (!function_exists('get_adwords')) {
	/**
	 * 获取广告代码
	 */
	function get_adwords($id,$charset = 'utf8')
	{
		$data_cache_name = hash('sha256',$id.'_ADWORDS');
		$data_cache_content = system_cache($data_cache_name);

		if (empty($data_cache_content)) {
			$data_cache_content = Db::name('adwords')->where('alias',$id)->find();
			system_cache($data_cache_name,$data_cache_content,saenv('cache_time'));
		}
		
		// 过期则不展现
		if ($data_cache_content['expirestime'] >= time()) {
			if (saenv('url_model') == 2) {
				return '<script type="text/javascript" src="/static/adwords/'.$id.'.js" charset="'.$charset.'"></script>';
			}else {
				echo $data_cache_content['content'];
			}
		}
	}
}

if (!function_exists('get_system_logs')) {
	/**
	 * 返回封装数据
	 */
	function get_system_logs()
	{
		$array['module'] = app()->http->getName();
		$array['controller'] = Request::controller(true);
		$array['action'] = Request::action(true);
		$array['params'] = serialize(Request::param());
		$array['method'] = Request::method(); 
		$array['url'] = Request::baseUrl(); 
		$array['ip'] = Request::ip();
		$array['name'] = session('AdminLogin.name');

		if (empty($array['name'])) {
			$array['name'] = 'system';
		}
		
		return $array;
	}
}

if (!function_exists('clear_api_cache')) {
    /**
     * 清理用户API权限缓存
     */
	function clear_api_cache($token = null)
	{
		if (is_array($token)) {
			$token['app_id'] = $token['user.app_id'] ?? $token['app_id'];
			$token['app_id'] = $token['user.app_id'] ?? $token['app_id'];

			$token = $token['app_id'].'.'.$token['app_secret'];
		}
		system_cache(md5_hash($token),null);
	}
}

if (!function_exists('check_referer_origin')) {
    /**
     * 检查跨域请求
     */
    function check_referer_origin()
    {
        if (isset($_SERVER['HTTP_ORIGIN']) && $_SERVER['HTTP_ORIGIN']) {
            $request = parse_url($_SERVER['HTTP_ORIGIN']);
            $domain = array_merge(config('app.cors_domain'),[request()->host(true)]);
            if (in_array("*", $domain) 
				|| in_array($_SERVER['HTTP_ORIGIN'], $domain) 
				|| (isset($request['host']) && in_array($request['host'], $domain))) {
                header("Access-Control-Allow-Origin: " . $_SERVER['HTTP_ORIGIN']);
            } else {
                header('HTTP/1.1 403 Forbidden');
                exit;
            }
            header('Access-Control-Allow-Credentials: true');
            header('Access-Control-Max-Age: 86400');
            if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
                if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'])) {
                    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
                }
                if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS'])) {
                    header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
                }
                exit;
            }
        }
    }
}

if (!function_exists('ajax_return')) {
    /**
    * Ajax方式返回数据到客户端
     * @access protected
     * @param  string           $msg  提示消息
     * @param  array|string     $data 返回数据
     * @param  integer          $code 消息代码
     * @return array|json
    */
	/**
	 * 使用格式
	 * ['list'=>$list,'count'=>$count] = 'data'=>['list','count'...]
	 * ['data'=>$list,'count'=>$count] = ['data'=>$list], ['count'=$count]
	 */
    function ajax_return($msg = null, $data = [], int $code = 200) 
    {
		if (is_array($msg)) {
			$result = $msg;
		} else if (!is_array($data)) {
            $result = [
                'msg'  => $msg,
                'data' => $data,
                'code' => $code,
            ];
        }
        else {
            $result['msg'] = $msg;
			$result['code'] = $code;
			if (!isset($data['data'])) {
				$result['data'] = $data;
			} else if ($data['data']) {
				$result['data'] = $data['data'];
				unset($data['data']);
				$result = array_merge($result,$data);
			}
        }

        header('Content-Type:text/json; charset=utf-8');
        exit(json_encode($result,JSON_UNESCAPED_UNICODE));
    }
}


// +----------------------------------------------------------------------
// | 数据加密函数开始
// +----------------------------------------------------------------------
if (!function_exists('hash_pwd')) {
    /**
     * hash - 密码加密
     */
	function hash_pwd($string)
	{
		return hash_hmac("sha256", $string, '!dJ&S6@GliG3');
	}
}

if (!function_exists('cookies_encrypt')) {
	// COOKIES加密
	function cookies_encrypt($data, $key='', $char='')
	{	
		$key = empty($key) ? '!1@9#8$3' : $key;
		$key  = hash("sha256", $key);
		$x  = 0;
		$str = '';
		$len = strlen($data);
		$l  = strlen($key);
		for ($i = 0; $i < $len; $i++){
				if ($x == $l) {
				 $x = 0;
				}
				$char .= $key[$x];
				$x++;
		}
		for ($i = 0; $i < $len; $i++){
			$str .= chr(ord($data[$i]) + (ord($char[$i])) % 256);
		}
		return base64_encode($str);
	}
}

if (!function_exists('cookies_decrypt')) {
	// COOKIES解密
	function cookies_decrypt($data, $key='', $char='')
	{
		$key = empty($key) ? '!1@9#8$3' : $key;
		$key  = hash("sha256", $key);
		$x = 0; $str = '';
		$data = base64_decode($data);
		$len = strlen($data);
		$l = strlen($key);
		for ($i = 0; $i < $len; $i++){
				if ($x == $l) {
				 $x = 0;
				}
				$char .= substr($key, $x, 1);
				$x++;
		}
		for ($i = 0; $i < $len; $i++){
				if (ord(substr($data, $i, 1)) < ord(substr($char, $i, 1))){
					$str .= chr((ord(substr($data, $i, 1)) + 256) - ord(substr($char, $i, 1)));
				}else {
					$str .= chr(ord(substr($data, $i, 1)) - ord(substr($char, $i, 1)));
				}
		}
		return $str;
	}
}

// +----------------------------------------------------------------------
// | 网络IP函数开始
// +----------------------------------------------------------------------
if (!function_exists('get_client_ip')) {
    /**
     * 获取访客IP
     * @return string
     */		
	function get_client_ip()
	{
	   if (getenv("HTTP_CLIENT_IP") && strcasecmp(getenv("HTTP_CLIENT_IP"), "unknown"))
		   $ip = getenv("HTTP_CLIENT_IP");
	   else if (getenv("HTTP_X_FORWARDED_FOR") && strcasecmp(getenv("HTTP_X_FORWARDED_FOR"), "unknown"))
		   $ip = getenv("HTTP_X_FORWARDED_FOR");
	   else if (getenv("REMOTE_ADDR") && strcasecmp(getenv("REMOTE_ADDR"), "unknown"))
		   $ip = getenv("REMOTE_ADDR");
	   else if (isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] && strcasecmp($_SERVER['REMOTE_ADDR'], "unknown"))
		   $ip = $_SERVER['REMOTE_ADDR'];
	   else
		   $ip = "unknown";
	   return htmlspecialchars($ip, ENT_QUOTES);
	}
}

if (!function_exists('query_client_ip')) {
    /**
     * 查询访客IP
     * @return string
     */		
	function query_client_ip($ip, $ips = [])
	{
		if (!empty($ip) || filter_var($ip, FILTER_VALIDATE_IP)) {
			$ip = \app\common\library\Ip2Region::instance()->memorySearch($ip);
			$ip = explode('|',$ip['region']);
			foreach ($ip as $value) {
				if ($value != '0') {
					$ips []= $value;
				}
			}

			$ips = array_unique($ips);
			$ips = implode(' ',$ips);
			return trim(str_replace('中国','',$ips));
		}
	}
}


// +----------------------------------------------------------------------
// | 时间相关函数开始
// +----------------------------------------------------------------------
if (!function_exists('linux_extime')) {
    /**
     * 获取某天前时间戳
     * @param  intval  $day    几天前
     * @return intval
     */			
	function linux_extime($day)
	{
		$day = intval($day);
		return mktime(23,59,59,intval(date("m")),intval(date("d"))-$day,intval(date("y")));
	}
}

if (!function_exists('today_seconds')) {
    /**
     * 返回今天还剩多少秒
     * @return intval
     */		
	function today_seconds() 
	{
		$mktime = mktime(23,59,59,intval(date("m")),intval(date("d")),intval(date("y")));
		return $mktime - time();
	}
}


if (!function_exists('is_today')) {
    /**
     * 判断当前是否为当天时间
     * @return intval
     */		
	function is_today($time) 
	{

		if (!$time) {
			return false;
		}

		$today = date('Y-m-d');
		if (strstr($time,'-')) {
			$time = strtotime($time);
		}

		if ($today == date('Y-m-d',$time)) {
			return true;
		}else {
			return false;
		}
	}
}

// 生成随机函数
function random_date($begintime, $endtime="", $now = true) 
{
	$begin = strtotime($begintime);  
	$end = $endtime == "" ? mktime() : strtotime($endtime);
	$timestamp = mt_rand($begin, $end);
	return $now ? date("Y-m-d H:i:s", $timestamp) : $timestamp;          
}

if (!function_exists('differ_time')) {
    /**
     * 比较时间戳时差
     * @param  intval  $time    时间戳
     * @return string
     */	
	function differ_time($time = 0) 
	{
		date_default_timezone_set('PRC');

		if (!is_integer($time)) {
			$time = strtotime((string)$time);
		}

		$differ = time() - $time;
		switch ($differ){
			case $differ <= 60:
				$string = '刚刚';
				break;
			case $differ > 60 && $differ <= 60 * 60:
				$string = floor($differ / 60) . ' 分钟前';
				break;
			case $differ > 60 * 60 && $differ <= 24 * 60 * 60:
				$string = date('Ymd',$time)==date('Ymd',time()) ? '今天 '.date('H:i',$time) : '昨天 '.date('H:i',$time);
				break;
			case $differ > 24 * 60 * 60 && $differ <= 2 * 24 * 60 * 60:
				$string = date('Ymd',$time)+1==date('Ymd',time()) ? '昨天 '.date('H:i',$time) : '前天 '.date('H:i',$time);
				break;
			case $differ > 2 * 24 * 60 * 60 && $differ <= 12 * 30 * 24 * 60 * 60:
				$string = date('Y',$time)==date('Y',time()) ? date('m-d H:i',$time) : date('Y-m-d H:i',$time);
				break;
			default: $string = date('Y-m-d H:i',$time);
		}
		return $string;
	}
}

// +----------------------------------------------------------------------
// | 系统安全函数开始
// +----------------------------------------------------------------------
if (!function_exists('safe_field_model')) {
    /**
     * 字段过滤XSS
     * @param  array  $data  POST数据
     * @param  class  $class 验证器类	 
     * @param  scene  $scene 验证场景	 
     * @param  array  $field 保留字段	
     * @return array|bool
     */		
	function safe_field_model($data = [], $valiclass = '', $valiscene = '',$field = [])
	{

		foreach ($data as $key => $value) {
			// 是否过滤非法字段
			if ($field != null && is_array($field)) {
				if (!in_array($key,$field)) {
					unset($data[$key]); 
					continue;
				}
			}
			
			// 过滤XSS跨站攻击
			$validata = remove_xss($data[$key]);
			if ($validata != $data[$key]) {
				return '您提交的数据不合法，请检查后再提交！';
			}
		}
		// 验证数据
		if (!is_empty($valiclass)) {
			if (!preg_match('/app\x{005c}(.*?)\x{005c}/',$valiclass,$macth)) {
				$valiclass = '\\app\\common\\validate\\'.ucfirst($valiclass);
			}else {
				$valiclass = str_replace("\\model\\", "\\validate\\", $valiclass);
			}
			try {
				if (is_file(root_path().$valiclass.'.php')) {
					$validate = new $valiclass;
					if (!$validate->scene($valiscene)->check($data)) {
						return $validate->getError();
					}
				}
			} catch (\Throwable $th) {
				return $th->getMessage();
			}
		}
		
		return $data;
	}
}

if (!function_exists('safe_validate_model')) {
    /**
     * 单独验证模型 // 此函数不会过滤XSS
     * @param  array  $data  POST数据
     * @param  class  $class 验证器类	 
     * @param  scene  $scene 验证场景	 
     * @return array|bool
     */	
	function safe_validate_model($data = [], $valiclass = '', $valiscene='') 
	{
		if (!is_empty($valiclass)) {
			if (!preg_match('/app\x{005c}(.*?)\x{005c}/',$valiclass,$macth)) {
				$valiclass = '\\app\\common\\validate\\'.ucfirst($valiclass);
				
			}else {
				$valiclass = str_replace("\\model\\", "\\validate\\", $valiclass);
			}
		
			try {
				if (is_file(root_path().$valiclass.'.php')) {
					$validate = new $valiclass;
					if (!$validate->scene($valiscene)->check($data)) {
						return $validate->getError();
					}
				}
			} catch (\Throwable $th) {
				return $th->getMessage();
			}
		}

		return $data;
	}
}

if (!function_exists('check_auth')) {
	/**
	 * 权限判断
	 */
	function check_auth($urls, $action = '', $attr = 'lay-url') 
	{
		$macth = [];
		$judge = false;
		$urls = (string)url($urls);
		$urls = str_replace('.html','',$urls);
		if (preg_match('/\/\w+.php(\/.*?\/.*?\w+[^\/\?]+)/',$urls, $macth)) {
			$judge = app\common\library\auth::instance()->checkAuths($macth[1]);
		}
		
		echo !$judge ? 'lay-noauth' : $attr .'="'.$urls.'"' . $action;
	}
}

if (!function_exists('remove_xss')) {
    /**
     * 清理XSS
     */
    function remove_xss($content, $is_image = false)
    {
        return \app\common\library\Security::instance()->xss_clean($content, $is_image);
    }
}
