## 表单提交
> 表单提交是一个经常用到的操作属性，这里需要介绍一下表单提交的配置

| 参数 | 选项 | 说明 |
| --- | --- | --- |
| submitIframe | 选填 | 主要用于iFrame窗口的提交 |
| submitIPage | 选填 | 主要用于页面层窗口的提交 |

> 这个是iframe页面层下对form表单的提交操作！

``` html
<div class="layui-form-item layui-layout-admin">
    <div class="layui-input-block">
        <div class="layui-footer" id="layui-footer-btn">
            <button class="layui-btn layui-btn-normal" lay-submit="" lay-filter="submitIframe">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</div>
```
> 这个是对页面层下对form表单的提交操作！

``` html
<!-- // 编辑权限列表 -->
<script type="text/html" id="authForms">
<div class="layui-fluid layui-bg-white" >
    <!-- // 注意这里一定要加上权限地址，否则无法判断 -->
    <form class="layui-form" >
    <div class="layui-authtree"><div id="authTree"></div></div>
    <div class="layui-footer layui-form-item layui-center "  >
        <button class="layui-btn layui-btn-primary" type="button" sa-event="closePageDialog" >{:__('Cancel')}</button>
        <button class="layui-btn" lay-filter="submitPage" lay-submit>{:__('Submit')}</button>
    </div>
    </form>
</div>
</script>
```
这里的说明你可能会看不太明白，其实说白了就是框架自身替你去处理表单的提交的操作！

- 如果你是页面层，当然如果你需要处理的数据量很小，并且也不涉及第三方的组件渲染，那么强烈建议你使用页面层的渲染进行操作
- 具体可以参考本框架的管理员组的操作，基本上修改后直接自动修改了表的列显示。
- 对于打开页面层的东西是自动监听的，如果你要使用iframe来渲染，则请使用submitIframe进行监听处理！
- 具体的还是看swiftadmin框架的代码示例，让你能更方面的使用这个框架进行个人二次开发使用！！！

::: danger 提示
以下是比较重要的部分
::: 
form表单提交默认获取的地址有三个地方，同时也是鉴权所需要的，但基本上你需要按照自己的要求进行填写就行了，

- 1、action 默认的获取的地方，通过这个地方可以进行表单提交
- 2、按钮的lay-add 或者lay-edit属性值，如果你使用页面层的话，则使用这两个属性。
- 3、或者自动识别后端控制器，当使用iframe层的时候用的比较多，默认action不填，具体请参考system.category/add.html模板！
## 时间组件
时间组件的使用十分的方便只有一个参数

| 参数 | 选项 | 说明 |
| --- | --- | --- |
| lay-datetime | 必填 | 时间控件的过滤器。 |

> 以下是示例代码

``` html
<div class="layui-form-item ">
   <label class="layui-form-label">评论间隔</label>
    <div class="layui-input-inline" >
        <input type="text" 
        name="user[user_form_second]" 
        autocomplete="off" 
        lay-datetime="" 
        class="layui-input" > 
    </div>
</div>
``` 
因为layui的时间组件自身的机制是自动绑定到元素的，所以不需要填写元素的CLASS，
点击日期他会将时间数据自动写入到input标签中，所以在HTML标签中设置上述代码的时候
lay-datetime=的值可以是空的，这里留空为了给下一个版本如果有其他需要做传值使用！
WARNING
另外请注意，封装的所有组件使用的时候，iframe层会自动渲染组件，如果是页面层组件未成功渲染，则需要自己去实现第三方组件的渲染
如果你不需要使用组件或者其他的东西，为了方便快速开发，推荐你使用而不是HTML页面层，而不是iframe层！
## 滑块组件
> 滑块组件一般常用于方便调节数据，最后都需要有一个input标签来承载数据用于投递

| 参数 | 选项 | 说明 |
| :---: | :---: | :--- |
| lay-slider | 必填 | 传入类名，用于回调将数据填入 |
| data-value | 必填 | 渲染时使用的原始数值 |
| data-theme | 选填 | 颜色,传入#十六进制颜色代码 |

``` html
<div class="layui-form-item">
    <label class="layui-form-label">透明度</label>
    <div class="layui-input-inline">
        <div lay-slider="upload_water_pct" data-value="{$config['upload']['upload_water_pct']}" data-theme="#1E9FFF"
             style="margin-top: 15px; margin-left: 3px;">
      	</div>
        <input type="hidden" name="upload[upload_water_pct]" value="{$config['upload']['upload_water_pct']}" class="layui-input upload_water_pct">
    </div>
</div>
```
从这里慢慢开始熟悉属性值，可以很好的简化代码的编写效率，对于这样只是页面化调节数据的组件，其实很多代码没必要重复写！我更倾向于将最简单的东西一起做了， 剩下的复杂的再去写逻辑，不然。。。一大堆整容后的代码，都是一个样子，很臃肿，也不易维护！！！！
## 评分组件
> 评分组件可以适用于列表展示和内容页编辑使用  星星组件 / 默认访问参数 为GET

| 参数 | 选项 | 说明 |
| :---: | :---: | :--- |
| lay-rate | 必填 | list,ones 列表还是单个 |
| data-url | 必填 | 点击进行GET的地址 |
| lay-object | 必填 | 进行修改的对象ID |
| data-value | 必填 | 渲染时使用的原始数值 |
| data-theme | 选填 | 颜色,传入#十六进制颜色代码 |
| data-readonly | 选填 | 是否只是展示，不可以点击，默认false， |
| lay-class | 选填 | 当lay-rate为ones的时候 回显的class名称 |

``` html
<div lay-rate="ones" data-url="路由地址"  data-value="2" lay-object="2" ></div>
<div lay-rate="list" data-url="路由地址"  data-value="3" lay-object="3" data-readonly="true" ></div>
<div lay-rate="list" data-url="路由地址"  data-value="1" lay-object="2" data-theme="#000"></div>
```
只需要你传入需要操作的路由地址就行了，所有的全局需要操作的东西，都是通过后端ajax函数进行异步调用的！
## 开关组件
> switch组件一般是用来解决列表或者编辑框中点选/更改状态使用的

| 属性 | 选项 | 说明 |
| :---: | :---: | :---: |
| lay-filter | 必选 | lay-filter="switchStatus" 需设置过滤器 |
| data-url | 必选 | 需要GET或者POST的地址，必填 |
| value | 必填 | 当前需要操作的对象id，比如他应该是文章id |

> 如果设置lay-callback="test" 则需要在操作页面增加回调函数，增加回调函数后，所有的动作。需要自己实现，他最后调用的还是ajax操作，所以ajax操作里面的所有属性都可以在这里进行填写，就不一一写出来了，具体的请看后面的lay-ajax属性！！！

``` js
<input type="checkbox" name="status" value="1" lay-skin="switch"  lay-text="启用|锁定"  />
```
```
admin.callback.test = function(res){ 或者 function(res，obj) 看自己的需求
    console.log(res);
｝
```
> 以下是一个状态栏的操作示例！

``` js
<!-- // 列表状态栏 -->
<script type="text/html" id="userStatus">
    <input type="checkbox" lay-filter="switchStatus" data-url="{:url('/system.admin/status')}" value="{{d.id}}" lay-skin="switch"
    lay-text="{:__('Normal')}|{:__('Close')}" {{d.status==1?'checked':''}}  />
</script>
```
> **需要注意的是，如果回调函数过多，请自行设置避免重复，重复会导致其他问题！**

## 单选组件
> RADIO 单选组件是为了方便做显示隐藏用的，如果你需要操作ajax数据的话，请不要使用这个属性！后续swiftadmin框架会增加对于单选情况下进行ajax交互的功能！

属性很少，一共就俩！！！！！，以至于我都想凑点字写点啥！！！！

| 属性 | 选项 | 说明 |
| :---: | :---: | :---: |
| lay-filter | 必填 | 填写radioStatus，过滤器值 |
| data-display | 必填 | 当radio的值为1的时候用来显示的那个元素的类 |

``` html
<div class="layui-input-inline">
    <input type="radio" name="sphinx[sphinx_status]"
      data-display="sphinx" lay-filter="radioStatus"
    value="1" title="开启"  checked >
    <input type="radio" name="sphinx[sphinx_status]"  
    data-display="sphinx" lay-filter="radioStatus"
    value="0" title="关闭"  >
</div>  
<!--  在点击radio为开启状态的时候，我会显示 -->
<div class="sphinx" style="display:none;">
    # TODO.....
</div>
```
> 你可以直接按照这样的方式进行书写，可以省去编写js代码繁琐的步骤，具体的可以看SwiftAdmin框架HTML代码！

## 下拉框组件
> select组件在这里也是为了方便做显示隐藏用的

| 属性 | 选项 | 说明 |
| :---: | :---: | :---: |
| lay-filter | 必选 | lay-filter="selectStatus" 需设置过滤器 |
| data-display | 必选 | 只存在这个数值，option值等于1则显示/否则隐藏 |
| data-disable | 可选 | data-display  data-disable 则说明等于data-disable则关闭否则都显示 |
| data-selector | 可选 | 如果仅仅存在属性data-selector，则会将里面的class格式化为数组，等于自己则显示/否则隐藏 |

## 编辑器组件

> 系统默认集成了tinymce编辑器，如有其他编辑器插件需求，请自行构建

为大家封装了更方便的编辑器组件调用，基本上不用你写太多的东西，默认的返回图片会自动插入到里面
但是默认上传的，只写了图片的接口，如果是附件的话，请自行扩充第三方组件。

调用很简单

``` html
<!-- // 编辑器模式也可以写在这里，写在属性优先调用，还有上传的接口，可以写 -->
 <textarea id="content" name="content" />{$data.content}</textarea>
```

```js
<script>
    layui.use(['content'],function () {
        
        var content = layui.content;
        // 常规元素渲染
        content.tinymce('content');
        content.xmselect('access',grouplist,[{$data.access}]);
        content.xmselect('pid',categorylist,[{$data.pid}],false);
    });
</script>
```
## 颜色选择器
> 经过封装后的colorpicker组件使用特别的方便

| 参数 | 选项 | 说明 |
| --- | --- | --- |
| lay-colorpicker | 必填 | 颜色过滤器的标志。 |
| data-value | 必填 | 初始化渲染颜色选择器所用到的颜色值 |

> 以下是示例代码

``` html
<div class="layui-form-item ">
    <div class="layui-input-inline" >
    <input type="text" name="user[user_replace]"  class="red layui-input">
    </div> 
    <div lay-colorpicker="red" data-value="#6C6C6C" ></div>
</div>
<div class="layui-form-item ">
    <div class="layui-input-inline" >
    <input type="text" name="user[user_replace]" class="blue layui-input">
    </div> 
    <div lay-colorpicker="blue" data-value="#189fff" ></div>
 </div>
```
由于colorpicker组件我已经帮你封装好了，所以在使用的时候你需要提供两个属性 分别是lay-colorpicker 和 data-value，其中lay-colorpicker里面填写选择颜色后，将颜色值写到input标签的CLASS类名。
## 组件示例代码
以下页面会展示一些常用的HTML元素，方便你使用
``` html
<!-- 页面select例子，当使用页面层而且没有第三方组件渲染需求的时候，可以直接写代码 -->
<select name="group_id" lay-verify="" >
  <option value="">请选择组别</option>
  <volist name="group" id="vo">
    <option value="{$vo.id}" >{$vo.title}</option>
  </volist>
</select>
```
``` html
<input name="status" type="radio" value="0" title="锁定" checked/>
<input name="status" type="radio" value="1" title="正常"/>
```
``` js
<!-- // 列表分组 -->
<script type="text/html" id="userGroup">
    {{# layui.each(d.group, function(index, item){ }}
        <span class="layui-badge {{ item.color }}" >{{ item.title }}</span>
    {{# }); }}
</script> 
      {
        field: 'type',title: '类型', width: 80, templet: function (d) {
          var strs = ['<span class="layui-badge layui-bg-blue">菜单</span>', 
                      '<span class="layui-badge layui-bg-gray">按钮</span>',
                      '<span class="layui-badge layui-bg-cyan">接口</span>'
                     ];
          return strs[d.type];
        }, align: 'center'
      },
```
``` html
<div class="layui-form-item">
    <label class="layui-form-label">微缩图</label>
    <div class="layui-input-inline">
        <select name="upload[upload_thumb]" data-display="upload_thumb" lay-filter="selectStatus" >
        <option value="1"  >开启</option>
        <option value="0"  >关闭</option>
        </select>
    </div>                     
    <div class="layui-form-mid layui-word-aux">* 上传图片是否自动生成微缩图</div>
</div>
```
``` html
<div class="layui-form-item">
    <label class="layui-form-label">缓存方式</label>
    <div class="layui-input-inline" > 
       <select name="cache[cache_type]" data-display="cache_type" data-disable="file" lay-filter="selectStatus" >                
         <option value="file" <if condition="$config['cache']['cache_type'] eq 'file'">selected</if>  >file</option>
         <option value="redis" <if condition="$config['cache']['cache_type'] eq 'redis'">selected</if>   >redis</option>
         <option value="memcached" <if condition="$config['cache']['cache_type'] eq 'memcached'">selected</if> >memcached</option>
       </select>
    </div>
    <div class="layui-form-mid layui-word-aux">
    <i class="layui-icon layui-icon-about" lay-tips="使用Redis缓存方式,出错会抛出Connection refused！"></i></div>
</div>
```
> 如果使用data-selector属性的话，只填写一个就可以了，他的格式为 data-selector="class,class1,class2"
> 你可以直接按照这样的方式进行书写，可以省去编写js代码繁琐的步骤！
