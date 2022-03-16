## submitIframe
::: warning
data-reload 参数为是否重载父页面

form表单的action=""可以不写，留空的情况下，默认会投递到当前控制器，

我们建议 lay-filter="submitIframe" 增加 type="button"  避免敲击回车提交
:::
``` html
<include file="/public/header" />
<div class="layui-fluid" >
    <form class="layui-form layui-form-fixed" >
        <div class="layui-card-body" >
            <gt name="$data.id" value="0"><input type="text" name="id" value="{$data.id}" hidden=""></gt>
            <div class="layui-form-item">
                <label class="layui-form-label">应用名称</label>
                <div class="layui-input-block">
                    <input type="text" name="name" value="{$data.name}" class="layui-input" lay-verify="required">
                </div>
            </div> 
            <!-- ...省略代码 -->
        </div>

        <div class="layui-footer" style="text-align: center;">
            <button class="layui-btn layui-btn-primary" type="button"  sa-event="closeDialog" >取消</button>
            <button class="layui-btn layui-btn-normal" type="button" lay-filter="submitIframe" lay-submit>提交</button>
        </div>
    </form>
</div>
<include file="/public/footer" />
```

## lay-ajax

全局ajax函数是利用率最多的一个，swiftadmin极速开发框架已经为大家封装好了，可以十分方便的用来开发，任何元素只要增加lay-ajax属性既可以使用
> 基本用法
``` html
<a href="javascript:;" lay-ajax="" data-url="{:url('/index/edit/')}id/1" >访问控制器</a> 
```
::: tip 必读
先看下这个HTML标签，熟悉一下，接下来我们先看ajax的参数配置！！！！！
:::

| 参数 | 选项 | 说明 |
| --- | --- | --- |
| **lay-ajax** | **必填** | **全局的监听过滤器值** |
| **data-url** | **必填** | **路由地址，可以是一个带参数的地址** |
| data-type | 选填 | 访问模式，默认POST！ |
| data-packet | 选填 | 一个JSON对象，用来补充数据用的 |
| data-object | 选填 | 一组类数据，用来查找input class用的[参考Redis测试] |
| data-confirm | 选填 | 当前AJAX操作需要用户确认才可以执行 |
| data-table | 选填 | 在table工具栏里执行AJAX操作后是否刷新表格 |
| callback | 选填 | 回调函数，如果服务器返回的消息和后置操作需要自己去执行，可以利用这个！比如你要做自定义表格的操作 |

> 下面这个是JS的一段配置，他会获取你填写的属性后面使用！

``` js
// 可以很清楚的看到，这里是获取你上面HTML填写的属性值的
var config = {
    url : clickthis.data('url')|| "undefined",
    type :  clickthis.data('type') || 'post',
    dataType :  clickthis.data('dataType') || 'json',
    timeout :  clickthis.data('timeout') || '6000',
    confirm :  clickthis.data('confirm'), // 是否确认执行
    tableId :  clickthis.data('table') || clickthis.attr('batch'),
};

```
现在来说下使用lay-ajax的几种情况！

1、点击链接进行投递，最基本的写法！

``` html
<a href="javascript:;" lay-ajax="" data-url="{:url('/index/edit')}?id=1&status=1" >执行操作</a> 
```

足够简单吧！点击这个链接，会自动访问的后台控制器，传递的参数1 状态为1， 这个需要你自己再后台写代码，但是近期有朋友反馈说使用这个报错！

::: danger 注意
首先，如果报Access methods failure错误，而且明明HTTP是200啊，那是因为你的Accept: application/json,  设置错误了，<br>
使用lay-ajax属性，默认需要返回json格式的数据！如果你的后端控制，直接echo一下输出信息，那肯定出错了！！！<br>
还有一个需要注意的地方，那就是如果你使用a标签，那么需要将href属性自己屏蔽下，或者改为#、或者删掉那个属性

::: 
2、参数太多，该咋办？？？别着急，安排！
``` html
<a href="javascript:;" lay-ajax=""  data-url="{:url('/index/edit')}?id=1&status=1" data-packet={ids:2,pid:6} >执行操作</a> 
``` 
只需要增加一个data-packet属性，并且里面填写对应的JSON对象字符串就行了， 其实我个人一直不太喜欢在后台HTML代码里面写对象属性，

因为感觉太乱，没有在js里面看着舒心，这个属性，基本上会很少用到，只有特殊情况下会使用！


3、我只需要获取到数据， 然后我要自己去处理数据，那么写法就是

``` html
<a href="javascript:;" lay-ajax=""  data-url="{:url('/index/edit')}?id=1&status=1" data-packet={ids:2,pid:6}  callback="myfun" >执行操作</a> 
<script>

    admin._callback.myfun = function(obj, data, config) {
        // TODO....
        console.log(obj) 		// 当前click对象，在这里是a标签
        console.log(data) 	    // 拼装组合的数据对象
        console.log(config)     // 就是上面你设置的那些属性，默认会返回到config里面
    }

</script>
```

4、在某些form表单中，有时候我需要测试下数据发送，例如配置项的测试，代码配置如下
``` html
<button type="button" class="layui-btn layui-btn-primary" lay-ajax="" data-url="{:url('/index/testFtp')}" 
    data-object="host:ftp_host,port:ftp_port,user:ftp_user,pass:ftp_pass">测试连接
</button>
```

::: warning
    data-object 填写键值对，注意这个可不是对象，不要搞混了，具体的可以参考swiftadmin里面基础配置的HTML代码页面，简单易用！
:::

## lay-open
::: tip
 这个属性是SAPHP框架使用率最高的一个组件，这个一定要好好看一下
:::

| 属性 | 选项 | 说明 |
| --- | --- | --- |
| lay-open | 必填 | jquery的筛选器，只要有这个属性，不管是什么元素都可以打开窗体 |
| data-url | 必填 | 为打开的控制器，或者页面元素#id或者类名，或者外部网址，<br>外部网址需要http://www.baidu.com这样的格式，会自动识别type的选项，必填参数 |
| lay-type | 选填 | 自动识别，非必要的话，不需要写。默认2 |
| data-disabled | 选填 | input表单和select选择器 当使用了这个元素后，在编辑状态下 不可用|
| lay-area | 选填 | 宽度和高度，默认格式为lay-area="360px,360px",会自动识别成数组参数，默认auto |
| lay-offset | 选填 | 打开的位置，默认为auto,建议设置这个参数，这样展现出来的位置更适合一些 |
| data-title | 选填 | 如果不填的话，则title属性为false，默认false |
| lay-maxmin | 选填 | 是否最大化，默认true lay-maxmin="false" 关闭最大化 |
| lay-auto | 选填 | 自动调整窗体大小，默认是自动调整的，如果不需要则lay-auto="false" |

下面是一些示例代码

``` html
<div class="layui-form-item ">
    <label class="layui-form-label">信息模板</label>
     <div class="layui-input-inline" >
         <div class="layui-form-mid layui-word-aux">
             <a href="javascript:void(0)" class="layui-color-blue"
             lay-open=""
             data-url="{:url('/index/showTpl')}" 
             data-title="邮件模板" 
             lay-area="500px,260px" 
             lay-offset="30%"
             >[点击编辑]</a>
         </div>
     </div> 
</div>
```
``` html
<tbody><volist name="$list" id="vo">
    <tr>
        <td>{$key}</td>
        <td>{$vo.name}</td>
        <td>{$vo.path}</td>
        <td><a href="javascript:void(0)" class="editTpl"
         lay-open=""
         data-url="{:url('/index/editTpl/p/')}{$vo.param}" 
         data-title="{$vo.name}" 
         lay-area="60%,85%" 
        >编辑</a></td>
    </tr></volist>
</tbody>
```

::: tip 提示
 因为你的打开窗体的是，有时候参数是多种多样的，所以open组件只支持拼接URL格式进行GET方式获取数据！<br>
理论上lay-open属性支持任何元素打开窗口的操作，你只需要在data-url里面填写值就行了，这个值可以是一个控制器，<br>
可以是一个类元素或者ID元素,或者是外部地址 下面再来一些示例，其实这些示例你都可以在模板页面找到，在这里是为了减少你的学习时间成本！
:::
``` html
<!-- // 打开一个iframe窗口 -->
<button class="layui-btn icon-btn" lay-open=""  data-title="添加管理员" data-url="{:url('/admin/add')}" >添加管理员</button>

<!-- // 打开外部百度页面 -->
<button lay-open="" data-url="http://www.baidu.com" data-title="打开窗口"  >打开外部百度</button></div>

<!-- // 采用页面元素打开窗口，注意这个是页面层的 -->
<button lay-open="" data-url="#editform" data-title="编辑管理员"  >编辑管理员</button></div>

```

基本上就是这么多，需要注意的是，如果你是在layui 表格的tool监听工具栏里面使用，请不要使用lay-open属性，请使用lay-evevt搭配data-url属性进行操作！ 需要注意的是，如果你打开的页面层只用到的layui原始的组件渲染功能，则不用但是，他会自动帮你渲染好！！
## lay-batch

::: danger 警告
注意 删除操作分为列表的删除 和 全部删除操作，其中列表的删除需要在lay-event事件中进行定义
::: 

| 参数 | 选项 | 说明 |
| --- | --- | --- |
| lay-batch | 必填 | 表的ID值，用来查找和重载用的 |
| data-url | 必填 | 填写的需要访问的后台控制器方法 |
| data-type | 选填 | 访问模式，自动识别，可以不写！ |
| data-data | 选填 | 用来增加其他的数据，为对象格式数组格式 |

> 这里是批量删除按钮的代码
``` html
<button class="layui-btn icon-btn" lay-batch="lay-tableList"  data-url="{:url('/admin/del')}" >
  <i class="layui-icon layui-icon-del"></i>删除所有
</button>  <!-- 一般只需要两个参数，一个是lay-batch里面填写表格的ID，另外一个是data-url路由地址  -->
```
在你点击这个按钮的时候，后端会从当前对象中读取到配置信息，然后进行AJAX操作，根据状态码进行是否数据表删除操作！

## lay-event
其实看到这个属性，你可能会很不解？这不是layui的表格参数吗，为什么也写！！<br>
那是因为封装了表格的操作，所以这里需要讲解一下这个地方的东西！<br>
> 我们先来看最普通最简单的执行代码！<br>
``` js
<script type="text/html" id="tableBar">  
    <a class="layui-btn layui-btn-primary layui-btn-xs"  
    data-title="编辑 {{d.name}}" data-area="800px,497px" data-url="{:url('/system.category/edit/')}id/{{d.id}}" lay-event="edit" >编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs"  data-url="{:url('/system.category/del/')}id/{{d.id}}" lay-event="del" >删除</a>
</script>
```
这个是删除的代码，因为使用table组件来渲染的，所以写起来好像是JavaScript的东西，<br>
其实他还是HTML代码而已，相信熟悉layui的你不用我多说啥了，基本上单例删除需要写的属性就这么多！<br>
其实对于日常的后台操作，基本的属性不需要多写，只要会用就行了，后面无外乎还是执行的layui或者jQuery的那一套操作。<br>
现在的编辑是打开一个窗口，注意他是iframe类型的窗口，然后删除直接访问的ajax操作！<br>
> 那么接下来，就是为什么要使用这个属性的时候了！lay-event这里默认监听 edit编辑、del删除、以及ajax操作，因为比如你需要在表格里面执行一个操作，<br>
但是并不希望他弹出提示，如果你写del的话，他肯定会弹出你是要删除的操作！所以当event等于ajax的时候，则只会进行操作而不会弹出友好提示。<br>
当然了，后端返回的资源信息提示还是会显示的！<br>

``` js
<!-- // 列表编辑框 -->
<script type="text/html" id="tableBar"> 
    <a class="icon-btn" data-url="{:url('/system.category/restore/')}id/{{d.id}}" lay-event="ajax" ><i class="layui-icon layui-icon-edit"></i>还原</a>
    <a class="icon-btn" data-url="{:url('/system.category/destroy/')}id/{{d.id}}" lay-event="del" ><i class="layui-icon layui-icon-close"></i>销毁</a>
</script>
```

以上的这段代码是回收站窗口的代码，你可以看到里面存在一个lay-event="ajax"的操作，如果你写成del的话他会销毁，<br>
如果你使用lay-ajax属性的方式去访问，操作肯定是没有问题，但是无法自动刷新表格，然后最后说明一下，默认如果你在tool里面的event没有写，<br>
他默认是会变成编辑操作的，也就是会打开一个窗口并自动填充form表单。<br>
以下说明是table表单的tool(lay-tableList)监听事件，请仔细阅读，会非常提高开发效率<br>

- 默认监听事件lay-event 遵循官方准则！<br>

- 默认监听edit和del，也就是编辑和删除操作，代码也已经写好了，常规的东西不用你重复写代码。<br>

- 在列表工具栏中，如果你需要点击后打开一个窗口，支持两种方式，<br>

3.1、lay-open的方式，适用于iframe的方式，直接URL传递参数

3.1.1、如果你需要传参，那么请遵循iframe传递参数的做法

3.1.2、如果你需要在工具栏使用诸如查看，发布，等操作，则可以直接使用a标签或者使用lay-ajax进行操作

3.2、lay-event的方式，比如你创建了一个lay-event="add"的事件，那么你需要执行以下两种操作

3.2.1、为lay-event创建一个回调函数，不然任何事件（除删除以外），都会默认成编辑操作，【但不会执行第三方组件的渲染】

3.2.2、为lay-event事件再添加一个data-disable的属性，值为true，也就是打开窗口以后默认不调用form.val填充表单

3.2.3、剩下的事情就交给你了

::: warning 
swiftadmin的迭代离不开您的支持，如果你使用本框架，请不要吝啬您的星星，感谢您，好人一生平安！

另外：form.val默认只有页面层的时候才会赋值，如果你需要使用自定义事件然后打开iframe窗口，一定要自己写回调函数，

现在如果你的data-url参数不是页面元素，则不需要设置data-disable属性了
:::


注意注意：回调函数一般是在使用第三方组件的时候用到的，那是不是我每个event都要写一个回调函数，你会发现回调函数里面会重复很多代码

这时候你可以把里面的代码块分开写，然后调用，或者都使用同一个回调函数，然后在里面写代码逻辑即可！

如果你要做的事情，不是很复杂，比如在编辑和添加以外你需要增加一个文章查看和其他诸如在某个栏目下点击添加打开窗口自动填写父类数据的时候，

你可以和edit使用同一个回调函数，但需要写data-disable属性，然后就是代码逻辑的问题了。

看完上面我小学三年级毕业写的文档你可能会很懵逼，那我们再重新来梳理下逻辑

1、依照layui的原则，列表工具栏只有编写lay-event属性的时候才会被识别

2、swiftAdmin列表工具栏监听，默认监听edit和del，编辑和删除操作！

3、我需要点击工具栏可以查看到我发布的文章，在工具栏模版里面使用a标签就行

4、我需要点击工具栏某个按钮打开一个iframe窗口，可以直接使用lay-open属性，参数在data-url里面设置

5、我需要点击工具栏某个按钮打开一个iframe窗口，但是需要获取到table表格对象，data-url参数直接设置为后端控制器地址，

6、我有这样一个需求场景，就是我栏目很多，我为了方便添加栏目，需要点击列表工具栏我自己设置的添加按钮以后，在编辑框里面自动展现父类的数据

::: tip
【可以参考swiftadmin菜单管理，因为需要渲染第三方组件，当页面层的时候，是不会刷新加载JS的】，

那么可以将渲染和监听的东西写成一个回调函数，然后在回调函数里面  写代码逻辑就行了！
:::

其实纵观swiftAdmin极速开发框架的定位，你会发现，如果只是简单的想做一个流量站，那么基本的代码操作无需你的关心，

你只需要配置好里面的各种lay-xx参数就可以了！因为其他的layui自带的渲染组件都是默认全局监听渲染的，很方便你使用！

## lay-upload

::: tip 提示
上传接口的使用十分的方便，只要记住swiftadmin框架的根本，一切皆是元素，全局监听一起渲染！<br/>
但是由于上传的场景可能有所区别，所以有时候你需要编写回调函数来处理返回的数据信息或者进行插入操作，<br/>
一般返回的数据信息为JSON格式，当然你也可以自己去设置所需要的格式。这取决于你后端返回的数据格式！<br/>
::: 

| 参数 | 选项 | 说明 |
| --- | --- | --- |
| lay-upload | 必填 | 过滤器属性，值为class类名 |
| data-url | 选填 | 上传的文件接口，默认为前端upload/file |
| data-type | 选填 | 上传组件分类，值为file/images/multiple 默认为file |
| data-size | 选填 | 上传文件的大小,默认 102400 |
| data-accept | 选填 | 上传文件的类型 默认file |
| callback | 选填 | 回调函数，返回当前this对象以及服务器资源 |

下面来是最简单的上传input表单的示例代码
``` html
    <!-- // 这里是因为我写了一个上传LOGO的方法 -->
    <!-- // 默认情况下，这个可以不写，除非你使用自己的上传接口 -->
<button type="button" class="layui-btn layui-btn-normal" lay-upload="logo" data-url="{:url('/upload/logo')}" >
    <i class="layui-icon layui-icon-upload"></i>上传图片
</button>

<label class="layui-form-label">站点LOGO</label>
    <div class="layui-input-inline">
    <input type="text" name="site[site_logo]" value="{$config.site.site_logo}" 
    placeholder="请上传站点LOGO图" class="layui-input logo">
</div>

<div class="layui-form-item">
    <div class="layui-input-block">
        <div class="layui-upload-logo">
            <dl><dt> 
                <!-- // 当前版本会连这个IMG标签一起渲染 -->
                <img class="logo" src="{$config.site.site_logo}" alt="站点LOGO" >
            </dt>
            <dd class="layui-badge" >删除</dd>
            </dl>
        </div>
    </div>
</div>
```

::: tip
这里是批量上传的代码模板
:::
``` html

<div class="layui-imagesbox">

    <!-- // 循环输出代码 -->
    <notempty name="$data['{%field%}']" >
    <volist name="$data['{%field%}']" id="vo">
        <div class="layui-input-inline layui-uplpad-image">
            <img src="{$vo.src}" lay-image-hover >
            <input type="text" name="{%field%}[{$key}][src]" hidden value="{$vo.src}" >
            <input type="text" name="{%field%}[{$key}][title]" class="layui-input" value="{$vo.title}" placeholder="图片简介">
            <span class="layui-badge layui-badge-red" onclick="layui.$(this).parent().remove();">删除</span>
        </div>
    </volist>
    </notempty>
    <div class="layui-input-inline layui-uplpad-image">
        <div class="layui-upload-drag" lay-upload="{%field%}" data-type="multiple" data-accept="{%accept%}" data-size="{%size%}">
            <i class="layui-icon layui-icon-upload"></i>
            <p>点击上传，或将文件拖拽到此处</p>
            <div class="layui-hide"></div>
        </div>
        <button type="button" class="layui-btn layui-btn-xs layui-btn-fluid"><i class="layui-icon layui-icon-windows"></i> 选择</button>
    </div>
</div>

```

> 监听全局上传函数，仅仅传入 data-type="multiple"，说明是多文件上传， 并且返回的数据会append到值类名下，需要确保HTML值（类名的存在）<br/>
> 如果你需要返回的数据执行回调函数，则上传的回调函数需要自己编写，传入 lay-callback="myfunction" 然后在html页面编写以下代码

``` js
<script>
layui.use(['admin'],function(){
    var admin = layui.admin;

    // 回调函数 大多数情况下，回调是为应付不同的应用场景
    // 而且需要你自己去实现layer.msg，也就是弹出一个消息用来覆盖！
    admin._callback.myfunction = function(clickthis,colletction) {
        // 回调返回2个参数，
      	console.log(clickthis); 		// 当前点击对象
      	console.log(colletction); 	    // 数据信息，包含index和upload
    }
})
</script>
```

如果对于上传你有什么问题可以在这里提出来！！！
## lay-image-hover
这个组件的应用场景是，比如你的后台LIST列表中包含图片，那么当鼠标移动到元素上的时候， 就自动展示出了这个图片。感觉说了一些废话，有点绕。。。

| 属性 | 选项 | 说明 |
| --- | --- | --- |
| lay-image-hover | 必填 | 过滤器参数，图片地址参数，为空则调用img标签的src属性 |
| data-size | 选填 | 建议设置data-size="宽度,高度" 这样后台整体的体验度要好一些，当然如果你的图片都是规格一致的，可以忽略 |

还是直接上代码看比较清楚。
``` html
<img  src="/upload/images/2020-11-21/5fb8cf7ed838a.jpg" lay-image-hover="https://img.swiftadmin.net/lang.jpg" alt="lang" > 
``` 
不管元素是什么，只要有lay-image-hover这个属性就可以， 比如你后台文章列表 ，可以在有图的标题a标签里面设置这个属性，当鼠标移动上面的时候，就自动展示文章的封面图片了这个样子,

## lay-image-click
这个组件的跟lay-image-hover有点像

| 属性 | 选项 | 说明 |
| --- | --- | --- |
| lay-image-click | 必填 | 过滤器参数，图片地址参数，为空则调用img标签的src属性 |
| data-size | 选填 | 建议设置data-size="宽度,高度" 这样后台整体的体验度要好一些，当然如果你的图片都是规格一致的，可以忽略 |
| data-title | 选填 | 支持设置标题 默认false，如果想做一些对比业务报表图片的操作，可以设置title，只有设置了才可以移动 |

> [warning] 当data-title属性存在并且不为空的时候，才不会启用点击遮罩层关闭！如果想做一些对比业务报表图片的操作，可以设置title，只有设置了才可以移动
``` html
<img  src="/upload/images/2020-11-21/5fb8cf7ed838a.jpg" lay-image-click="https://img.swiftadmin.net/lang.jpg" alt="lang" data-title="我是标题" > 
```
设置了data-title属性后，当前打开的窗体需要自己点击X才会关闭！不怎么常用的属性！！
