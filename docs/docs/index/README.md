## 模板标签



### 栏目标签

``` html

salibs:catrgory

<salibs:category pid='0' id="vo">
<li class="layui-nav-item {:check_menu_active($vo,$detail??'')}"><a href="{$vo.readurl}"> <img src="{$vo.image}">{$vo.alias}</a></li>
</salibs:category>

<salibs:category id="vo" pid="0" type="son" >     
    <li class="layui-nav-item"><a href="{$vo.readurl}">{$vo.title}</a></li>
    <notempty name="$vo['son']" >
        <volist name="$vo['son']" id="child">
            <p>{$child.title}</p>
        </volist>
    </notempty>
</salibs:category>

```

### 内容标签

* 内容标签为通用型标签，请看示例
``` html
<salibs::content id="vo" table="article" limit="10">

// 自定义的一些内容，具体更多的请参考源代码
</salibs::content>

<ul class="layui-hot-replylist">
    <salibs:content table="article" id="vo" limit="1" page="true" paging="/dd/page=page">
        <li class="item">
        <div class="item-img"> 
        <a class="item-img-inner" href="{$vo.readurl}" title="{$vo.title}"> 
            <img width="480" height="300" src="{$vo.image}" alt="{$vo.title}">  
        </a></div>
        <div class="item-content">
            <p class="item-title">
                <a href="{$vo.readurl}" title="{$vo.title}">{$vo.title}</a></p>
                <p class="item-date">{$vo.createtime}</p>
            </div> 
        </li> 
    </salibs:content>
</ul>

<!-- 如果存在分页 则使用 $_CONTENT_LIST -->
<div calss="page">{$_CONTENT_LIST['pages']}</div>
```

其他的标签就不一一说明了，如果你不想使用标签的话，可以使用mysql_content函数调用，都是一样的