<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2019-2020 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.NET High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>，河北赢图网络科技版权所有
// +----------------------------------------------------------------------

namespace app\common\taglib;

use think\facade\Db;
use think\template\TagLib;

class Salibs extends TagLib {
	
	/**
     * 定义标签列表
     */
    protected $tags   =  [
        // 标签定义： attr 属性列表 close 是否闭合（0 或者1 默认1） alias 标签别名 level 嵌套层次
		'variable'  	=> ['attr'=>'name','close' => 0], 						// 自定义变量	
		'company'   	=> ['attr'=>'name,alias','close' => 0], 				// 公司信息	
		'plugin'    	=> ['attr'=>'name,field','close' => 0], 				// 插件配置信息	
		'category'		=> ['attr'=>'id,cid,pid,field,limit,order,type'],		// 获取栏目
		'navlist'		=> ['attr'=>'id'],										// 导航标签
		'categoryjson'	=> ['attr'=>'cid,pid,field,limit,order','close' => 0], 	// 非闭合标签
		'channel'		=> ['attr'=>'id'],										// 模型标签
		'article'		=> ['attr'=>'pid,field,limit,order,title,thumb'],		// 获取文章标签
		'customtpl'		=> ['attr'=>'id'],										// 自定义模板
		'usergroup'		=> ['attr'=>'id'],										// 用户组		
		'usergroupjson' =>  ['attr'=>'name','close' => 0], 						// 用户组json数据							
		'playlist'		=> ['attr'=>'id'],										// 播放器列表
		'serverlist'	=> ['attr'=>'id'],										// 服务器列表
		'arealist'		=> ['attr'=>'id'],										// 地区列表
		'yearlist'		=> ['attr'=>'id'],										// 年代列表
		'weeklist'		=> ['attr'=>'id'],										// 星期列表
		'language'		=> ['attr'=>'id'],										// 语言列表
		'friendlink'	=> ['attr'=>'id,type'],									// 获取友链
		'friendtype'	=> ['attr'=>'id'],										// 获取友链类型
    ];

	/**
	 * 获取导航标签
     * @access public
     * @param  string  $tags 值
	 * @param 	mixed 	$content
     * @return string
     */
	public function tagnavlist($tags,$content)
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		

		$html = <<<Eof
		<?php
			\$list = \app\common\model\system\Navmenu::getListNav();
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;

		return $html;
	}

	/**
	 * 获取地区
     * @access public
     * @param  string  $tags 值
	 * @param 	mixed 	$content
     * @return string
     */
	public function tagArealist($tags,$content) 
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		
		$html = <<<Eof
		<?php
			\$list = explode(',',saenv('play_area'));
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;	
	}

	/**
	 * 获取年代
     * @access public
     * @param  string  $tags 值
	 * @param 	mixed 	$content
     * @return string
     */
	public function tagYearlist($tags,$content) 
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		
		$html = <<<Eof
		<?php
			\$list = explode(',',saenv('play_year'));
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;	
	}

	/**
	 * 获取星期
     * @access public
     * @param  string  $tags 值
	 * @param 	mixed 	$content
     * @return string
     */
	public function tagWeeklist($tags,$content) 
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		
		$html = <<<Eof
		<?php
			\$list = explode(',',saenv('play_week'));
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;	
	}

	/**
	 * 获取语言
     * @access public
     * @param  string  $tags 值
	 * @param 	mixed 	$content
     * @return string
     */
	public function taglanguage($tags,$content) 
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		
		$html = <<<Eof
		<?php
			\$list = explode(',',saenv('play_language'));
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;	
	}

	/**
	 * 获取播放器
     * @access public
     * @param  string  $tags 值
	 * @param 	mixed 	$content
     * @return string
     */
	public function tagPlaylist($tags,$content) 
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		
		$html = <<<Eof
		<?php
			\$list = config('player');
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;	
	}

	/**
	 * 获取服务器
     * @access public
     * @param  string  $tags 值
	 * @param 	mixed 	$content
     * @return string
     */
	public function tagServerlist($tags,$content) 
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		
		$html = <<<Eof
		<?php
			\$list = config('Server');
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;	
	}

	/**
	 * 获取自定义模板
     * @access public
     * @param  string  $tags 值
	 * @param 	mixed 	$content
     * @return string
     */
	public function tagCustomtpl($tags,$content) 
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);

		$html = <<<Eof
		<?php
			\$path = root_path().'app/index/view/custom/';
			\$list = glob(\$path.'*.html');
			\$list = str_replace(\$path,'',\$list);
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;	
	}

	/**
	 * 获取模型数据
     * @access public
     * @param  string  $tags 值
	 * @param 	mixed 	$content
     * @return string
     */
	public function tagChannel($tags, $content) {

		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		$html = <<<Eof
		<?php
			\$list = \app\common\model\system\Channel::select()->toArray();
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;		
	}

	/**
	 * 获取用户组
     * @access public
     * @param  string  $tags 值
     * @return string
     */
	public function tagUsergroupJson($tags)
	{
		$list = \app\common\model\system\UserGroup::select()->toArray();
		return json_encode($list);
	}

	/**
	 * 获取栏目JSON
     * @access public
     * @param  string  $tags 值
     * @return string
     */
	public function tagCategoryJson($tags)
	{
		$pid 	= isset($tags['pid']) ? (!empty($tags['pid']) ? $tags['pid'] : '0' ): '0';
		$cid 	= isset($tags['cid']) ? (!empty($tags['cid']) ? $tags['cid'] : '0' ): '0';
		$limit 	= isset($tags['limit']) ? (!empty($tags['limit']) ? $tags['limit'] : '10' ): '10';
		$field 	= isset($tags['field']) ? (!empty($tags['field']) ? $tags['field'] : '*' ): '*';
		$order 	= isset($tags['order']) ? (!empty($tags['order']) ? $tags['order'] : 'id asc' ): 'id asc';

		$list = \app\common\model\system\Category::getListCate($pid,$cid,[
			'limit'=>(int)$limit,
			'field'=>$field,
			'order'=>$order,
		]);

		return json_encode(list_to_tree($list));
	}

	/**
	 * 获取用户组
     * @access public
     * @param  string  $tags 值
     * @return string
     */
	public function tagUsergroup($tags, $content) 
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		$html = <<<Eof
		<?php
			\$list = \app\common\model\system\UserGroup::select()->toArray();
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;
	}

	/**
	 * 获取文章数据
     * @access public
     * @param  string  $tags 值
     * @return string
     */
	public function tagArticle($tags, $content) {

		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		$limit 	= isset($tags['limit']) ? (!empty($tags['limit']) ? $tags['limit'] : '10' ): '10';
		$field 	= isset($tags['field']) ? (!empty($tags['field']) ? $tags['field'] : '*' ): '*';
		$order 	= isset($tags['order']) ? (!empty($tags['order']) ? $tags['order'] : 'id asc' ): 'id asc';
		$thumb  = isset($tags['thumb']) ? (!empty($tags['thumb']) ? $tags['thumb'] : 'not' ): 'not';
		$title  = isset($tags['title']) ? (!empty($tags['title']) ? $tags['title'] : 'not' ): 'not';

		$html = <<<Eof
		<?php
			\$where = [];
			if ('{$thumb}' != 'not') {
				\$where[] = ['thumb','<>',''];
			}
			if (isset({$tags['pid']}) && {$tags['pid']}) {
				\$where[] = ['pid','=',{$tags['pid']}];
			}
			if ('{$title}' != 'not') {
				\$where[] = ['title','like','%'.'{$title}'.'%'];
			}
			\$list = \app\common\model\system\Article::where(\$where)->field('{$field}')->order('{$order}')->limit({$limit})->select()->toArray();
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;

	}

	/**
	 * 获取栏目标签
     * @access public
     * @param  string  $tags 值或变量
     * @return string
     */
	public function tagCategory($tags, $content) {

		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		$pid 	= isset($tags['pid']) ? (!empty($tags['pid']) ? $tags['pid'] : '0' ): '0';
		$cid 	= isset($tags['cid']) ? (!empty($tags['cid']) ? $tags['cid'] : '0' ): '0';
		$limit 	= isset($tags['limit']) ? (!empty($tags['limit']) ? $tags['limit'] : '10' ): '10';
		$field 	= isset($tags['field']) ? (!empty($tags['field']) ? $tags['field'] : '*' ): '*';
		$order 	= isset($tags['order']) ? (!empty($tags['order']) ? $tags['order'] : 'id asc' ): 'id asc';

		$html = <<<Eof
		<?php
			\$list = \app\common\model\system\Category::getListCate({$pid},{$cid},['limit'=>{$limit},'field'=>'{$field}','order'=>'{$order}']);
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;

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
			$where[] = ['alias','=',$tags['alias']];
		}else { // 默认查询
			$where[] = ['id','=','1'];
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
	public function tagFriendlink($tags, $content) {
		
		$tags['id'] = $tags['id'] ?? 'vo';
		$tags['id'] = $this->autoBuildVar($tags['id']);
		$tags['type'] = isset($tags['type']) ? (!empty($tags['type']) ? $tags['type'] : 'null' ): 'null';
		$html = <<<Eof
		<?php
			\$where = [];
			if ('{$tags['type']}' != 'null') {
				\$where = ['type'=>'{$tags['type']}'];
			} 
			\$list = \app\common\model\system\Friendlink::where(\$where)->select()->toArray();
			foreach (\$list as \$key => {$tags['id']}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;
	}

	/**
	 * 获取友情标签
     * @access public
     * @param  string  $tags 值或变量
     * @param  string  $content 自定义元素
     * @return string
	 */	
	public function tagfriendtype($tags,$content) 
	{
		$tags['id'] = is_notempty($tags['id']) ?? 'vo';
		$id = $this->autoBuildVar($tags['id']);
		
		$html = <<<Eof
		<?php
			\$list = explode(',','资源,社区,合作伙伴,关于我们');
			foreach (\$list as \$key => {$id}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;	
	}

}