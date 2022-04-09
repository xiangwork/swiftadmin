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


}
