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
class SaLibs extends TagLib
{

    /**
     * 定义标签列表
     */
    protected $tags = [
        // 标签定义： attr 属性列表 close 是否闭合（0 或者1 默认1） alias 标签别名 level 嵌套层次
        'variable'   => ['attr' => 'name', 'close' => 0],                    // 自定义变量
        'company'    => ['attr' => 'name,alias', 'close' => 0],              // 公司信息
        'archivetpl' => ['attr' => 'id'],                                    // 自定义模板
        'dictionary' => ['attr' => 'id,value'],                              // 获取字典列表
    ];

    /**
     * 获取自定义模板
     * @param array $tags
     * @param string $content
     * @return string
     */
    public function tagArchivetpl(array $tags, string $content): string
    {
        $tags['id'] = $tags['id'] ?? 'vo';
        $id = $this->autoBuildVar($tags['id']);

        $_var = Random::alpha();
        $parse = '<?php ';
        $parse .= '$path = root_path()."app/index/view/custom";';
        $parse .= '$_TPL_LIST = glob($path.\'*.html\');';
        $parse .= '$_' . $_var . ' = str_replace(array($path,\'.html\'),\'\',$_TPL_LIST);';
        $parse .= ' ?>';
        $parse .= '<?php foreach($_' . $_var . ' as $key=>' . $id . '):?>';
        $parse .= $content;
        $parse .= '<?php endforeach; ?>';
        return $parse;
    }

    /**
     * 自定义变量标签
     * @access public
     * @param string $tags 值或变量
     * @return string
     */
    public function tagVariable($tags)
    {
        if (!isset($tags['name'])
            || !$tags['name']) {
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
     * @param string $tags 值或变量
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
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
     * 获取字典标签
     * @access public
     * @param array $tags
     * @param string $content 自定义元素
     * @return string
     */
    public function tagDictionary(array $tags, string $content): string
    {
        $tags['id'] = $tags['id'] ?? 'vo';
        $id = $this->autoBuildVar($tags['id']);
        $value = $tags['value'] ?? '';
        $_var = Random::alpha();
        $parse = '<?php ';
        $parse .= '$_' . $_var . ' = \app\common\model\system\Dictionary::getValueList("' . $value . '");';
        $parse .= ' ?>';
        $parse .= '<?php foreach($_' . $_var . ' as $key=>' . $id . '):?>';
        $parse .= $content;
        $parse .= '<?php endforeach; ?>';
        return $parse;
    }
}
