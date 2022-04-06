<?php

// 全局应用公共文件
use think\facade\Cache;

// 全局系统常量
const REWRITE  =  1;
const STATICS  =  2;

// 权限常量
const AUTHCATES = 'cates';
const AUTHRULES = 'rules';

// 命名空间
const NAMESPACELIBRARY 		= '\\app\\common\\library\\';
const NAMESPACEMODELSYSTEM	= '\\app\\common\\model\\system\\';
// +----------------------------------------------------------------------
// | 文件操作函数开始
// +----------------------------------------------------------------------
if (!function_exists('read_file')) 
{
    /**
     * 获取文件内容
     * @param  string $file 文件路径
     * @return false|string content
     */	
	function read_file($file){
		return !is_file($file)?'':@file_get_contents($file);
	}
}

if (!function_exists('arr2file')) {
    /**
     * 数组写入文件
     * @param  string $file  文件路径
     * @param  array  $array 数组数据 
     * @return void
     */	
	function arr2file($file, $array='') 
	{
		if(is_array($array)){
			$cont = var_exports($array);
		} else{
			$cont = $array;
		}
		$cont = "<?php\nreturn $cont;";
		return write_file($file, $cont);
	}
}

if (!function_exists('arr2router')) {
    /**
     * 数组写入路由文件
     * @param  string $file  	文件路径
     * @param  array  $string 	字符串数据 
     * @return void
     */	
	function arr2router($file, $array = []) 
	{
		if(is_array($array)){
			$cont = var_exports($array);
		} else{
			$cont = $array;
		}
		$cont = "<?php\nuse think\\facade\\Route;\n\n$cont";
		return write_file($file, $cont);
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
		if ($return) return $export; else echo $export;
	}
}
if (!function_exists('write_file')) {
    /**
     * 数据写入文件
     * @param  string  $file    文件路径
     * @param  string  $content 文件数据 
     * @return false|int
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
     * @param  int  $mode    文件夹权限
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
     * @return array|string|string[]   $mark 标记/直接返回转移代码
     */		
	function strtoJs($str, $mark = true)
	{
		$str = str_replace(array("\r", "\n"), array('', '\n'), addslashes($str));
		return $mark ? "document.write(\"$str\");" : $str;
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
		
		$str = preg_replace('/<[^>]+>/','',preg_replace("/[\r\n\t ]{1,}/",' ',delNt(strip_tags($str))));
        $str = preg_replace('/&(\w{4});/i','',$str);

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

if (!function_exists('cdn_Prefix')) {

    /**
     * 获取远程图片前缀
     * @return string
     */
	function cdn_Prefix() {
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
					$url = cdn_Prefix();
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

if (!function_exists('pinyin')) {
    /**
     * 获取拼音
     * @param string $str  需要转换的汉子
     * @param bool   $abbr 是否只要首字母
     * @param bool   $trim 是否清除空格
     * @return array|string|string[]
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

if (!function_exists('format_bytes')) {

    /**
     * 将字节转换为可读文本
     * @param int    $size      大小
     * @param string $delimiter 分隔符
     * @return string
     */
    function format_bytes($size, $delimiter = ' ')
    {
        $units = array('B', 'KB', 'MB', 'GB', 'TB', 'PB');
        for ($i = 0; $size >= 1024 && $i < 6; $i++) {
            $size /= 1024;
        }
        return round($size, 2) . $delimiter . $units[$i];
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
                $array[1] = hide_str($array[1], $bengin, $len);
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
					$recursive = function($base, &$key) use (&$recursive,&$config) {
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
     * @return string
     */
    function search_model(string $searchType = null)
    {
		$searchType = $searchType ?? saenv('search_model');
        return NAMESPACELIBRARY . $searchType;
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
        return 'data:image/svg+xml;base64,' . $src;
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

if (!function_exists('get_adwords')) {
	/**
	 * 获取广告代码
	 */
	function get_adwords($id,$charset = 'utf8')
	{
		// TODO..
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
if (!function_exists('member_encrypt')) {
    /**
     * hash - 密码加密
     */
	function member_encrypt($pwd, $salt = 'swift', $encrypt = 'md5')
	{
		return $encrypt($pwd . $salt);
	}
}

if (!function_exists('cookies_encrypt')) {
	/**
	 * COOKIES加密
	 *
	 * @param [type] $data
	 * @param string $key
	 * @param string $char
	 * @return void
	 */
	function cookies_encrypt($data, $key='', $char='')
	{	
		$key = empty($key) ? '!pass' : $key;
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
	/**
	 * COOKIES解密
	 *
	 * @param [type] $data
	 * @param string $key
	 * @param string $char
	 * @return void
	 */
	function cookies_decrypt($data, $key='', $char='')
	{
		$key = empty($key) ? '!pass' : $key;
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
				if (class_exists($valiclass)) {
					$validate = new $valiclass;
					if (!$validate->scene($valiscene)->check($data)) {
						return $validate->getError();
					}
				}
			} catch (Throwable $th) {
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
     * @return mixed
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
				if (class_exists($valiclass)) {
					$validate = new $valiclass;
					if (!$validate->scene($valiscene)->check($data)) {
						return $validate->getError();
					}
				}
			} catch (Throwable $th) {
				return $th->getMessage();
			}
		}

		return $data;
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
