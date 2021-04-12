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
		'variable'  => ['attr'=>'name','close' => 0], 			// 自定义变量	
		'company'   => ['attr'=>'name,alias','close' => 0], 	// 公司信息	
		'plugin'    => ['attr'=>'name,field','close' => 0], 	// 插件配置信息	
		'friendlink'=> ['attr'=>'id'],
    ];


	/**
	 * 自定义变量标签
     * @access public
     * @param  string  $tags 值或变量
     * @return string
     */
	public function tagVariable($tags)
	{
		if (!isset($tags['alias']) || !$tags['alias']) {
			return false;
		}

		// 获取变量
		$variable = config('system.variable');
		if (isset($variable[$tags['alias']])) {
			return $variable[$tags['alias']];
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
	 * 获取插件配置信息
     * @access public
     * @param  string  $tags 值或变量
     * @return string
	 */
	public function tagPlugin($tags)
	{	

		if (!isset($tags['name']) || !$tags['name']) {
			return false;
		}

		if (!isset($tags['field']) || !$tags['field']) {
			return false;
		}

		$pluginInfo = get_plugin_infos($tags['name'],true);
		if (!empty($pluginInfo)) {

			$pluginInfo = $pluginInfo['extends'] ?? [];
			if (isset($tags['field']) && $tags['field']) {
				return $pluginInfo[$tags['field']] ?? '';
			}
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
		
		$tags['id'] = $tags['id'] ?: 'vo';
		$tags['id'] = $this->autoBuildVar($tags['id']);
		$html = <<<Eof
		<?php
			\$list = \app\common\model\system\Friendlink::select()->toArray();
			foreach (\$list as \$key => {$tags['id']}):
		?>
		$content
		<?php endforeach;?>
		Eof;
		return $html;
	}
}