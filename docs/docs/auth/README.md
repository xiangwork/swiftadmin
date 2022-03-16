## 权限配置
::: tip 
  权限部署
:::

* 理论上，菜单配置就是权限配置，新生成的控制器继承一键CURD的 index add edit del status 这几个方法！
* 需要注意的地方！在你创建控制器菜单的时候，如果他有子类的情况下，一定要将父类路由地址设置成#号，
* 其次你的菜单的地址例如：`/system.category/index` 他的类型为菜单形式
## 前端鉴权
SwiftAdmin 前端使用JS判断路由节点进行鉴权，一般会从form表单的action 或者属性值的data-url lay-add lay-edit去查找地址
如果没有到则会提示没有权限！但是这样有一个不好的地方，是会暴露后端的控制器地址，所以在前端提供了一个函数进行数据调用！
``` php
if (!function_exists('check_auth')) {
  /**
   * 权限判断
   */
  function check_auth($urls, $action = '', $attr = 'data-url') {

    $judge = false;
    $urls = (string)url($urls);
    $urls = str_replace('.html','',$urls);
    if (preg_match('/\/\w+.php(\/.*?\/.*?\w+[^\/\?]+)/',$urls, $macth)) {
      $judge = app\common\library\auth::instance()->checkAuth($macth[1]);
    }
    echo !$judge ? 'lay-noauth' : $attr .'="'.$urls.'"' . $action;
  }
}
```
在前端的调用示例
``` html
<a href="javascript:;" {:check_auth('/system.admin/add','lay-open')} >用来鉴权</a>
```
也就是说，在前端页面，如果你不期望用户看到后端的访问地址，则可以使用这样的方式来对前端的按钮进行鉴权操作。
如果对方没有权限的情况下，则会输出lay-noauth属性，JS会监听这个属性的点击，如果有权限的话则会输出 data-url="/admin.php/system.admin/add" lay-open

## 后端鉴权
swiftadmin 框架后端鉴权采用经典的auth权限鉴定方案`二次开发`，之所以选择这个方案是因为这个方案足以应付大多数情况下的基本鉴权操作！<br/>
如果你需要更详细的鉴权操作，则需要自己进行代码的部分逻辑重构！后端鉴权默认会在基础控制器进行权限鉴定操作，如果没有权限则会返回<br/>JSON格式信息或抛出一个403权限异常页面！