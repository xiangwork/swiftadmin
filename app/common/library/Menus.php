<?php

namespace app\common\library;

use app\common\model\system\AdminRules;

/**
 * 菜单规则类
 *
 */
class Menus {

    /**
     * 创建菜单
     * @param array  $MenusArr
     * @param string $note
     * @param mixed  $parent 父类的name或pid
     */
    public static function create($MenusArr = [], $note = '' , $parent = 0)
    {
        if (!is_numeric($parent)) {
            $parentRule = AdminRules::getByTitle($parent);
            $pid = $parentRule ? $parentRule['id'] : 0;
        } else {
            $pid = $parent;
        }
       
        $allow = array_flip(['title', 'router', 'alias', 'type', 'icons', 'note', 'status','update']);

        foreach ($MenusArr as $key => $value) {

            // 子分类数据
            $children = isset($value['children']) && $value['children'] ? true : false;
            $data = array_intersect_key($value, $allow);
            $data['pid'] = $pid;
            $data['type'] = $children ? 0 : 1;

            if (!isset($data['status'])) {
                $data['status'] = 'normal';
            }

            if (trim($data['router']) == '#') {
                $data['alias'] = $data['router'];
            }
            else {

                $data['alias'] = substr(str_replace('/',':',$data['router']),1);
            }

            // PLUGIN 标识
            $data['note'] = $note;
            $data['sort'] = AdminRules::count() + 1;
            
            // 查询当前菜单
            $menu = AdminRules::where(['note'=> $data['note'],'router'=>$data['router']])->find();
            
            // 新建当前菜单项
            if (empty($menu)) {
                $menu = AdminRules::create($data);
            }
            else if (isset($data['update']) && $data['update']){
                unset($data['update']);
                $menu->where('id',$menu->id)->update($data);
            }

            if ($children) {
                self::create($value['children'], $note, $menu['id']);
            }
        }
    }

    /**
     * 启用菜单
     * @param string $name
     * @return boolean
     */
    public static function enable($name)
    {
        $ids = self::getAuthRuleIdsByName($name);
        if (!$ids) {
            return false;
        }
        AdminRules::where('id', 'in', $ids)->update(['status' => 'normal']);
        return true;
    }

    /**
     * 禁用菜单
     * @param string $name
     * @return boolean
     */
    public static function disable($name)
    {
        $ids = self::getAuthRuleIdsByName($name);
        if (!$ids) {
            return false;
        }
        AdminRules::where('id', 'in', $ids)->update(['status' => 'hidden']);
        return true;
    }    

   /**
     * 导出指定名称的菜单规则
     * @param string $name
     * @return array
     */
    public static function export($name)
    {
        $menuList = AdminRules::where('note',$name)->select()->toArray();
        return list_to_tree($menuList);
    }

    /**
     * 删除菜单
     * @param string $name 规则name
     * @return boolean
     */
    public static function delete($name)
    {
        $ids = self::getAuthRuleIdsByName($name);
        if (!$ids) {
            return false;
        }

        AdminRules::destroy($ids,true);
        return true;
    }

    /**
     * 根据名称获取规则IDS
     * @param string $name
     * @return array
     */
    public static function getAuthRuleIdsByName($name)
    {
        return AdminRules::where('note',$name)->column('id');
    }

} 