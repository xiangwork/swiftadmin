<?php

declare(strict_types=1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.NET High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> Apache 2.0 License Code
// +----------------------------------------------------------------------

namespace app\common\taglib;

use system\Random;
use think\facade\Db;
use think\template\TagLib;

/**
 * 注意：定界符结尾必须靠墙立正
 */

class Salibs extends TagLib
{

	/**
	 * 定义标签列表
	 */
	protected $tags   =  [
		// 标签定义： attr 属性列表 close 是否闭合（0 或者1 默认1） alias 标签别名 level 嵌套层次
		'variable'  	=> ['attr' => 'name', 'close' => 0], 						// 自定义变量	
		'company'   	=> ['attr' => 'name,alias', 'close' => 0], 				// 公司信息	
		'plugin'    	=> ['attr' => 'name,field', 'close' => 0], 				// 插件配置信息	
		'category'		=> ['attr' => 'id,cid,pid,typeid,field,limit,order,type,pages'], // 获取栏目
		'navlist'		=> ['attr' => 'id'],										// 导航标签
		'channel'		=> ['attr' => 'id'],										// 模型标签
		'customtpl'		=> ['attr' => 'id'],										// 自定义模板
		'usergroup'		=> ['attr' => 'id'],										// 用户组			
		'playlist'		=> ['attr' => 'id'],										// 播放器列表
		'serverlist'	=> ['attr' => 'id'],										// 服务器列表
		'arealist'		=> ['attr' => 'id'],										// 地区列表
		'yearlist'		=> ['attr' => 'id'],										// 年代列表
		'weeklist'		=> ['attr' => 'id'],										// 星期列表
		'language'		=> ['attr' => 'id'],										// 语言列表
		'friendlink'	=> ['attr' => 'id,type'],									// 获取友链
		'dictionary'	=> ['attr' => 'id,value'],							    	// 获取字典列表
	];

	/**
	 * 获取栏目标签
	 * @access public
	 * @param  string  $tags 值或变量
	 * @return string
	 */
	public function tagCategory($tags, $content)
	{
		$tags['id'] = !empty($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);
		$pid = isset($tags['pid']) ? $tags['pid'] : '0';
		$cid = isset($tags['cid']) ? $tags['cid'] : '';
		$type = isset($tags['type']) ? $tags['type'] : 'top';
		$typeid = isset($tags['typeid']) ? $tags['typeid'] : '';
		$field  = !empty($tags['field'])  ? $tags['field']  :  '*';
		$limit  = !empty($tags['limit'])  ? $tags['limit']  :  '10';
		$pages = !empty($tags['pages']) ? $tags['pages'] :  '0';
		$order  = !empty($tags['order'])  ? $tags['order']  :  'id asc';

		$_var = Random::alpha();
		$parse = '<?php ';
		if ($typeid) {
			$where[] = ['id', 'in', $typeid];
		}

		if ($cid) {
			$where[] = ['cid', 'in', $cid];
		}

		$where[] = ['pages', '=', $pages ?? 0];
		$where[] = ['pid', '=', $pid];
		$parse .= '$' . $_var . ' = \app\common\model\system\Category::where(' . var_exports($where) . ')->field("' . $field . '")->limit(' . $limit . ')->order("' . $order . '")->select();';
		$parse .= ' ?>';
		$parse .= '<?php foreach($' . $_var . ' as $key=>' . $id . '):?>';
		$parse .= $content;
		$parse .= '<?php endforeach; ?>';
		return $parse;
	}

	/**
	 * 获取导航标签
	 * @access public
	 * @param  string  $tags 值
	 * @param 	mixed 	$content
	 * @return string
	 */
	public function tagnavlist($tags, $content)
	{
		$id = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($id);

		$html = <<<EOD
		<?php
			\$_NAV_LIST = \app\common\model\system\Navmenu::getListNav();
			foreach (\$_NAV_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;

		return $html;
	}

	/**
	 * 获取地区
	 * @access public
	 * @param  string  $tags 值
	 * @param 	mixed 	$content
	 * @return string
	 */
	public function tagArealist($tags, $content)
	{
		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);

		$html = <<<EOD
		<?php
			\$_AREA_LIST = explode(',',saenv('play_area'));
			foreach (\$_AREA_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 获取年代
	 * @access public
	 * @param  string  $tags 值
	 * @param 	mixed 	$content
	 * @return string
	 */
	public function tagYearlist($tags, $content)
	{
		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);

		$html = <<<EOD
		<?php
			\$_YEAR_LIST = explode(',',saenv('play_year'));
			foreach (\$_YEAR_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 获取星期
	 * @access public
	 * @param  string  $tags 值
	 * @param 	mixed 	$content
	 * @return string
	 */
	public function tagWeeklist($tags, $content)
	{
		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);

		$html = <<<EOD
		<?php
			\$_WEEK_LIST = explode(',',saenv('play_week'));
			foreach (\$_WEEK_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 获取语言
	 * @access public
	 * @param  string  $tags 值
	 * @param 	mixed 	$content
	 * @return string
	 */
	public function taglanguage($tags, $content)
	{
		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);

		$html = <<<EOD
		<?php
			\$_LANG_LIST = explode(',',saenv('play_language'));
			foreach (\$_LANG_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 获取播放器
	 * @access public
	 * @param  string  $tags 值
	 * @param 	mixed 	$content
	 * @return string
	 */
	public function tagPlaylist($tags, $content)
	{
		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);

		$html = <<<EOD
		<?php
			\$_PLAY_LIST = config('player');
			foreach (\$_PLAY_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 获取服务器
	 * @access public
	 * @param  string  $tags 值
	 * @param 	mixed 	$content
	 * @return string
	 */
	public function tagServerlist($tags, $content)
	{
		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);

		$html = <<<EOD
		<?php
			\$_SERVER_LIST = config('Server');
			foreach (\$_SERVER_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 获取自定义模板
	 * @access public
	 * @param  string  $tags 值
	 * @param 	mixed 	$content
	 * @return string
	 */
	public function tagCustomtpl($tags, $content)
	{
		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);

		$html = <<<EOD
		<?php
			\$path = root_path().'app/index/view/custom/';
			\$_TPL_LIST = glob(\$path.'*.html');
			\$_TPL_LIST = str_replace(array(\$path,'.html'),'',\$_TPL_LIST);
			foreach (\$_TPL_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 获取模型数据
	 * @access public
	 * @param  string  $tags 值
	 * @param 	mixed 	$content
	 * @return string
	 */
	public function tagChannel($tags, $content)
	{

		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);
		$html = <<<EOD
		<?php
			\$_CHANNEL_LIST = \app\common\model\system\Channel::select()->toArray();
			foreach (\$_CHANNEL_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 获取用户组
	 * @access public
	 * @param  string  $tags 值
	 * @return string
	 */
	public function tagUsergroup($tags, $content)
	{
		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);
		$html = <<<EOD
		<?php
			\$_USER_LIST = \app\common\model\system\UserGroup::select()->toArray();
			foreach (\$_USER_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 自定义变量标签
	 * @access public
	 * @param  string  $tags 值或变量
	 * @return string
	 */
	public function tagVariable($tags)
	{
		if (!isset($tags['name']) || !$tags['name']) {
			return false;
		}

		// 获取变量
		$variable = saenv('variable');
		if (isset($variable[$tags['name']])) {
			return $variable[$tags['name']];
		}
	}

	/**
	 * 获取公司变量
	 * @access public
	 * @param  string  $tags 值或变量
	 * @return string
	 */
	public function tagCompany($tags)
	{
		$where = [];
		if (isset($tags['alias']) && $tags['alias']) {
			$where[] = ['alias', '=', $tags['alias']];
		} else { // 默认查询
			$where[] = ['id', '=', '1'];
		}

		$data = Db::name('company')->where($where)->find();
		if (!empty($data) && isset($data[$tags['name']])) {
			return $data[$tags['name']];
		}
	}

	/**
	 * 获取友情链接
	 * @access public
	 * @param  string  $tags 值或变量
	 * @param  string  $content 自定义元素
	 * @return string
	 */
	public function tagFriendlink($tags, $content)
	{

		$tags['id'] = $tags['id'] ?? 'vo';
		$tags['id'] = $this->autoBuildVar($tags['id']);
		$tags['type'] = isset($tags['type']) ? (!empty($tags['type']) ? $tags['type'] : 'null') : 'null';
		$html = <<<EOD
		<?php
			\$where = [];
			if ('{$tags['type']}' != 'null') {
				\$where[] = ['type','=','{$tags['type']}'];
			} 
			\$where[] = ['status','=',1];
			\$_FRIEND_LIST = \app\common\model\system\Friendlink::where(\$where)->select()->toArray();
			foreach (\$_FRIEND_LIST as \$key => {$tags['id']}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}

	/**
	 * 获取字典标签
	 * @access public
	 * @param  string  $tags 值或变量
	 * @param  string  $content 自定义元素
	 * @return string
	 */
	public function tagDictionary($tags, $content)
	{
		$tags['id'] = isset($tags['id']) ? $tags['id'] : 'vo';
		$id = $this->autoBuildVar($tags['id']);
		$value = isset($tags['value']) ? $tags['value'] : '';

		$html = <<<EOD
		<?php
			\$where = [];
			if ('{$value}' !== '') {
				\$params['pid'] = 0;
				\$params['value'] = '{$value}';
				\$_DIC_DATA = \app\common\model\system\Dictionary::queryDiction(\$params,'id',false);
				\$where['pid'] = \$_DIC_DATA['id'];
			}
			\$_DIC_LIST = \app\common\model\system\Dictionary::queryDiction(\$where);
			foreach (\$_DIC_LIST as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
EOD;
		return $html;
	}
}
