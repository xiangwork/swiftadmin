/* admin菜单模块 */
layui.define(["contextMenu","iziToast"], function (exports) {
    "use strict";
    var jquery = layui.jquery;
    var form = layui.form;
    var rate = layui.rate;
    var table = layui.table;
    var slider = layui.slider;
    var upload = layui.upload;
    var element = layui.element;
    var laydate = layui.laydate;
    var iziToast = layui.iziToast;

    // 定义系统变量
    var colorpicker = layui.colorpicker;
    var contextMenu = layui.contextMenu;
    var tabfilter = 'swiftadmin-tabs';
    var body = '.layui-body';    
    var layoutbody = ".layui-layout-body";
    var layoutadmin = ".layui-layout-admin";   
    var tabs = body + ">.layui-tab"; // 主体里的TAB
    var flexibleid = "flexible";
    var menufilter = "lay-side-menu";
    var menutopfilter = "lay-top-menu";
    var sideshrink = "layadmin-side-shrink";
    var sidespread = "layadmin-side-spread-sm";
    var iconshrink = "layui-icon-shrink-right";
    var iconspread = "layui-icon-spread-left";    
    var bodyshade = "<div class=\"layadmin-body-shade\" sa-event=\"shade\"><\/div>";
    var shadeclass = ".layadmin-body-shade";
    var layercontent =".layui-layer-content";

    /*
     * 获取上传地址
    */
    var baseUrl = window.location.href.split("://")[1],
        _begin = baseUrl.indexOf('/'),
        _end   = baseUrl.indexOf('.php')+4,
        _header = baseUrl.substring(_begin,_end),
        uploadUrl = _header + '/upload/upload';


    // 功能函数对象
    var admin = {
        init: undefined,
        name: 'admin.js',
        table:"swiftadmin",
        version:"1.0 beta",
        getMenu: _header + '/system.admin/_get_auth_func',
        pageTabs: true, // 默认开启TAB
        cacheTab: true, // 缓存TAB标签
        maxTabNum: 20, // 最大数量
        TabLists: [], // TAB本地列表
        callback: {}, // 函数对象
        callstatus: false, // 回调函数状态
        callString: 'admin.callback.',
        activeTab: undefined, // 当前TAB标签位置
        loading:function(res){ // 初始化函数

            var TabLists = admin.getConfig("TabLists");
            var activeTab = admin.getConfig("activeTab");

            // 初始化首页 / 初始化等于空
            if (TabLists == null || activeTab == null) {
                admin.render({
                    id: res.urls,
                    title: res.title,
                    urls: res.urls
                })
            }

            // 是否初始化
            var init = (res.inits == undefined ? true : res.inits);
            if (init && typeof (TabLists) === 'object') { // 在这里循环创建
                
                if (admin.pageTabs === true) {
                    for (var i in TabLists) {
                        admin.render({
                            id: TabLists[i].id, 
                            urls: TabLists[i].urls,
                            title: TabLists[i].title                   
                        })
                    }

                }else { 

                    // 进行单页面操作
                    admin.render({
                        id: TabLists.id, 
                        urls: TabLists.urls,
                        title: TabLists.title                   
                    })

                    admin.activeTab = TabLists.id;
                    admin.setConfig('activeTab',TabLists.urls)
                    admin.activeMenu(TabLists.id);
                    // 初始化单页面的时候改变面包屑
                    admin.setBreadcrumb(TabLists.urls,TabLists.title);
                }

                element.tabChange(tabfilter,activeTab);
            }
        },
        render:function(res){ // 准备函数

            if (!res.urls) {
                iziToast.info({
                    message: admin.lang('Menu addr not empty!'),
                });
                return;
            }
            
            var id = res.id || res.urls;
            var urls = res.urls;    
            var title = res.title;

            // 启用多标签模式
            if (admin.pageTabs) {

                // 最大TAB标签
                if ((admin.TabLists.length + 1) >= admin.maxTabNum) {
                    iziToast.info({
                        message: admin.lang('Max Open') + admin.maxTabNum + admin.lang('TAB'),
                    });
                    return false
                } 
                
                // 防止重复打开
                var isexist = jquery(tabs + '>.layui-tab-title [lay-id="'+ id +'"]');
                if (isexist && isexist.length >= 1) {
                    element.tabChange(tabfilter, id);
                    return false;
                }
                
                // 过滤TAB图标 layui-icon-circle-dot
                if (title.indexOf('layui-icon') != -1) {
                    title = '<span class="title">' + (title ? title : "") + "</span>";
                }else {
                    title = '<em class="circle"></em><span class="title">' + (title ? title : "") + "</span>";
                }

                // 添加选项卡
                element.tabAdd(tabfilter, {
                    id: id, 
                    title: title,
                    content: '<iframe lay-id="' + urls + '" src="' + urls + '" frameborder="0" onload="layui.admin.removeLoading(this)"  class="swiftadmin-iframe"></iframe>'
                });

                // 资源PUSH到列表
                admin.TabLists.push(res);
                if (admin.cacheTab) {
                    admin.setConfig('TabLists',admin.TabLists);
                }

                // 只有左侧布局才使用面包屑
                var nav = admin.getStorage('nav');
                if (nav === "left" || typeof (nav) === 'undefined') {
                    admin.setBreadHtml();
                }

                // 判断当前表里面的数量
                if (admin.TabLists.length >= 2 && nav === "left") {
                    admin.setBreadcrumb(urls, title);
                }
                
                // 增加动画
                admin.showLoading(jquery('iframe[lay-id="' + urls + '"]').parent());
                element.render("breadcrumb");
                element.tabChange(tabfilter, id);
            }
            else { // 单页面形式
                
                var iframe = jquery('.swiftadmin-iframe');
                if (typeof(iframe) === "undefined" ||  iframe.length <= 0) {
                    // 面包屑
                    admin.setBreadHtml();
                    // 主题区域
                    var c = '<div id="swiftadmin-iframe">';
                    c += ' <iframe lay-id="' + urls + '" src="' + urls + '" frameborder="0" onload="layui.admin.removeLoading(this)" class="swiftadmin-iframe"></iframe>';
                    c += "</div>";
                    
                    jquery(layoutadmin+'>'+body).html(c);
                }
                else { // 存在数据

                    iframe.attr("lay-id", urls);
                    iframe.attr("src", urls);
                    // 设置面包屑
                    admin.setBreadcrumb(urls, title);
                }

                admin.showLoading(jquery('#swiftadmin-iframe'));
                // 缓存数据
                if (admin.cacheTab) {
                    admin.setConfig('TabLists',res);
                }

                admin.setConfig('activeTab',urls);
                admin.activeTab = urls;
                element.render("breadcrumb");
            }
        }
        ,saPHPInit: function(elem = false) {

            // 获取权限菜单数据
            var authnodes = admin.getConfig('authnodes');

            // 重新请求菜单
            if (typeof(authnodes) === "undefined" || elem) {
                authnodes = admin.event.getAjaxData(admin.getMenu);
                admin.setConfig('authnodes',authnodes);
            }

            // 判断类型进行数据插入
            const authMenu = admin.getNavHtml(authnodes._admin_auth_menus_);
            
            if (admin.getStorage('nav') === 'hybrid') {
                admin.getNavhybrid(authnodes._admin_auth_menus_);
            }else if (admin.getStorage('nav') === 'top'){
                parent.layui.jquery('.layui-nav-top').html(authMenu);
            }else {
                parent.layui.jquery('.layui-nav-tree').html(authMenu);
            }

            // 重新渲染页面，解决layui下拉失效的BUG
            jquery('.layui-nav-top').find('span.layui-nav-bar').remove(); 
            
    
            // 顶部菜单布局点击
            if (admin.getStorage('nav') === 'top') {
    
                // 监听顶部点击
                element.on("nav("+ menutopfilter +")", function (res) {
                    var that = jquery(this); // 混合菜单布局隐藏
                    that.parent('dd').siblings().children('.layui-nav-third').hide();
                    that.parent('dd').siblings().children('dl').children('dl').hide();
                    admin.clickRender(res);
                })
    
                // 顶部菜单布局需要处理的样式
                jquery(".layui-side-menu" ).hide();
                jquery('.layui-layout-left').css('left','0');
                jquery('.layui-footer').css('left','0');
                jquery(layoutadmin + '>' + body).css('left','0');
                jquery('[sa-event="flexible"]').removeAttr('sa-event'); // 因为左侧已经没有了，所以这里需要设置为0
                jquery(".layui-third-class").on('click',function (obj) {   // hover的菜单点击事件，无限极菜单
                    var third = jquery(this);
                    third = third.parent('dd').siblings();
                    third.children('.layui-nav-third').hide();
                    jquery(this).next().show();
                    var self = jquery(this),child = self.parent().find(">.layui-nav-third");
                    child.css({"top": "0px", "left":self.outerWidth() + 2});
                });
            }
    
            // 混合菜单布局
            if (admin.getStorage('nav') === 'hybrid') {
    
                // 当上面的顶级栏目标签点击的时候，开始切换选项卡！
                jquery('.layui-nav-head .layui-nav-item a').on("click",function(res) {
                    var that = jquery(this),
                    navBind = that.attr('lay-nav-bind');
                    if (typeof (navBind) !== "undefined") {
                        jquery("div[class^='swift-admin']").hide();
                        jquery("." + navBind).show();
                    }
                })
            }

            parent.layui.element.render('nav');
            if (elem !== false) {
                parent.layui.admin.activeMenu(admin.getConfig("activeTab"));
            }
        }
        ,clickRender: function (res) { // 不同菜单布局下的选项卡创建
            var self = jquery(res);
            var id = self.attr("lay-id"); 
            var href = self.attr("lay-href");
            if (!id) {
                id = href;
            }
            if (href && href != "javascript:;") {
                var title = self.attr("sa-title"); 
                title || (title = self.text().replace(/(^\s*)|(\s*$)/g, ""));
                admin.render({
                    id: id,
                    urls: href,
                    title: title
                })
            }
            // 点击菜单关闭侧边栏
            if (admin.screen() < 2 && self.children('.layui-nav-more').length == 0) {
                admin.flexible();
            }            
        }
        ,escape: function(html){
            return String(html || '').replace(/&(?!#?[a-zA-Z0-9]+;)/g, '&amp;')
            .replace(/</g, '&lt;').replace(/>/g, '&gt;')
            .replace(/'/g, '&#39;').replace(/"/g, '&quot;');
        }
       ,getPath: function(){
            var jsPath = document.currentScript ? document.currentScript.src : function(){
              var js = document.scripts
              ,last = js.length - 1
              ,src;
              for(var i = last; i > 0; i--){
                if(js[i].readyState === 'interactive'){
                  src = js[i].src;
                  break;
                }
              }
              return src || js[last].src;
            }();
            return jsPath.substring(0, jsPath.lastIndexOf('/') + 1);
        }
        ,setBreadHtml: function() { 

            // 设置面包屑导航
            var b = '<div class="layui-breadcrumb-header layui-breadcrumb" lay-separator="/">';
            b += '      <a lay-href="#">'+ admin.lang('Home') +'</a>';
            b += '      <span class="breadcrumb">';
            b += '          <a lay-href="#">Dashboard</a>';
            b += '      </span>';
            b += "   </div>";

            // 加入节点
            if (jquery('.layui-breadcrumb-header').length <= 0) {
                jquery('.layui-nav-head').before(b);
                jquery('.layui-nav-head').hide();   
            }

            if (admin.screen() < 2) {
                jquery('.layui-breadcrumb-header').hide();
            }
        }
        ,setBreadcrumb: function(urls, title) { // 更新面包屑导航

            var text = '',current = jquery('.layui-nav-tree li [lay-href="'+ urls +'"]'); 
            var bread = jquery(current).parents().find('.layui-nav-itemed');
            for (var i = 0; i < bread.length; i++) {

                var elem = jquery(bread[i]).find('[lay-href="'+ urls +'"]');
                if (elem.length >= 1) {
                    var name = jquery(bread[i]).find('a:first').text();
                    text += '<a lay-href="#" >'+ name +'</a><span lay-separator="">/</span>';
                }
            }

            // 加上自身的
            text += '<a lay-href="' + urls +'">'+ title +'</a>';
            jquery('.breadcrumb').html(text);

        }
        // 侧边栏缩放
        ,flexible: function(status){
            var app = jquery(layoutbody),
            iconElem = jquery('#' + flexibleid);
            var screen = admin.screen();
            if (status) {
                iconElem.removeClass(iconspread).addClass(iconshrink);
                if (screen < 2) {
                    app.addClass(sidespread);
                }else {
                    app.removeClass(sidespread);
                }
                app.removeClass(sideshrink);
                // 增加移动端遮罩层
                if (jquery(shadeclass).length <= 0) {
                    jquery(layoutadmin).append(bodyshade);
                }
            }
             // 关闭侧边栏
            else {
                iconElem.removeClass(iconshrink).addClass(iconspread);
                if(screen < 2){ // 手机版默认移除
                    app.removeClass(sideshrink);
                  } else { // 电脑版添加这个CLASS 向左width 60px;
                    app.addClass(sideshrink);
                }
                // 移除多余的
                app.removeClass(sidespread) // layadmin-side-shrink layadmin-side-spread-sm
                jquery(layoutadmin).removeClass(bodyshade);
            }
        },
        screen: function(){
            var width =jquery(window).width()
            if(width > 1200){
              return 3; //大屏幕
            } else if(width > 992){
              return 2; //中屏幕
            } else if(width > 768){
              return 1; //小屏幕
            } else {
              return 0; //超小屏幕
            }
        },
        fullScreen: function(){ //全屏
          var ele = document.documentElement
          ,reqFullScreen = ele.requestFullScreen || ele.webkitRequestFullScreen || ele.mozRequestFullScreen || ele.msRequestFullscreen;      
          if(typeof reqFullScreen !== 'undefined' && reqFullScreen) {
                reqFullScreen.call(ele);
          };
        },
        exitScreen: function(){ //退出全屏
          var ele = document.documentElement
          if (document.exitFullscreen) {  
            document.exitFullscreen();  
          } else if (document.mozCancelFullScreen) {  
            document.mozCancelFullScreen();  
          } else if (document.webkitCancelFullScreen) {  
            document.webkitCancelFullScreen();  
          } else if (document.msExitFullscreen) {  
            document.msExitFullscreen();  
          }
        }
        ,lang: function(str) { 
            var langtype = admin.getStorage('language');
            var language = {
                'zh-cn': {
                    'this undefined'        :'对象未定义',
                    'Plase Close HomePage'  :'请不要关闭主页！',
                    'lay-url NoSeting'      :'未设置',
                    'NO Permissions!'       :'没有权限！',
                    'File Upload...'        :'文件上传中',
                    'The lack of DIV elements':'请添加包含多图上传的DIV元素！',
                    'Menu addr not empty!'  :'菜单地址不能为空',
                    'Max Open'              :'最多打开',
                    'TAB'                   :'选项卡',
                    'Tips'                  :'提示',
                    'Home'                  :'首页',
                    'not lay-url attr'      :'按钮缺少 url 属性',
                    'Plase check data'      :'请选择数据',
                    'sure you want to batch operation?': '确定要批量操作吗？',
                    'Sure you want to delete':'确定要删除',
                    'controller or action undefined!':'控制器或方法JS未定义！',
                }
            }

            // 英文默认返回
            if (langtype === 'en-us') {
                return str;
            }

            // 默认等于中文
            if (typeof language[langtype] === "undefined") { 
                langtype = 'zh-cn'; 
            }

            return language[langtype][str] ? language[langtype][str] : str;
        }
        /**
         * 窗口移动设置 偏移量
         */
        ,rollPage: function(type, index){
            var o = jquery(tabs + ">.layui-tab-title");
            var p = o.scrollLeft();
            if ("left" === type) {
                o.animate({
                    "scrollLeft": p - 120
                }, 100)
            } else {
                if ("auto" === type) {
                    var n = 0;
                    o.children("li").each(function () {
                        if (jquery(this).hasClass("layui-this")) {
                            return false
                        } else {
                            n += jquery(this).outerWidth()
                        }
                    });
                    o.animate({
                        "scrollLeft": n - 120
                    }, 100)
                } else {
                    o.animate({
                        "scrollLeft": p + 120
                    }, 100)
                }
            }    
        }
        /**
         * 活动的窗口设置
         */
        ,activeMenu: function(Id) { // 传过来的lay-id

            var nav = admin.getStorage('nav') || "left";
            jquery(".layui-nav li").removeClass("layui-this");
            jquery(".layui-nav li").removeClass("layui-nav-itemed");
            jquery(".layui-nav li dd").removeClass("layui-this");
            jquery(".layui-nav li dd").removeClass("layui-nav-itemed");
            var current = jquery('.layui-nav li dd [lay-href="'+ Id +'"]'); 
            if (nav === 'hybrid') { // 混合菜单布局下的样式修改
                var navBind = jquery('.layui-nav-tree [lay-href="'+ Id +'"]').parents('div').attr('class');
                if (typeof(navBind) !== "undefined") {
                    jquery('[lay-nav-bind="'+navBind).parent('li').addClass('layui-this');
                }
                jquery("div[class^='swift-admin']").hide();
                jquery("." + navBind).show();
            }

            // 不等于顶部菜单才设置，因为顶部菜单会扰乱左侧菜单布局代码，会一直显示
            if (current && current.length > 0 && nav !== 'top') { 
                current.parent("dd").addClass('layui-this'); 
                current.parent("dd").parents("dd").addClass("layui-nav-itemed"); 
                current.parent("dd").parents("li").addClass("layui-nav-itemed"); 
            }else {
                // 顶级栏目
                jquery('ul li [lay-href="'+ Id +'"]').parent().addClass("layui-this");
            }

        }
        ,checkAuth: function(routerUrl) { // 校验权限

            // 格式化字符串
            if (!routerUrl) {
                return true;
            }

            if (routerUrl.indexOf('http://') === -1) {
                routerUrl = routerUrl.replace(_header,'').replace('.html','');

                // 转换成规则
                routerUrl = routerUrl.substring(1);
                var controller = routerUrl.substring(0,routerUrl.indexOf('/'));
                var action = routerUrl.substring(routerUrl.indexOf('/')+1); // 查找后面的方法
               
                // 检测最后的字符串
                if (action.indexOf('/') !== -1) {
                    action = action.substring(0,action.indexOf('/'))
                }else if (action.indexOf('?') !== -1) {
                    action = action.substring(0,action.indexOf('?'))
                }
                // 拼接路由节点
                routerUrl = controller + ':' + action;
            }
            
            var status, recursive = function(elem) {
                for (let i in elem) {
                    var n = elem[i];
                    if (routerUrl == n.alias) {
                        status = true;
                    }

                    if (typeof n.children !== undefined) {
                        recursive(n.children);
                    }
                }
                
                return status ? status : false;
            }

            var authnodes = admin.getConfig('authnodes');
            if (!authnodes.supersadmin && routerUrl.indexOf('http://') === -1 
                && !recursive(authnodes._admin_auth_menus_)) {
                return false;
            }

            return true;
        }
        ,setConfig: function(key,value) {
            var table = admin.table + '_template';
            if (value != null && value !== "undefined") {
                layui.sessionData(table,{
                    key: key,
                    value:value
                })
            }else {
                layui.sessionData(table,{
                    key: key,
                    remove:true
                })                
            }
        },
        getConfig: function(key) {
            var table = admin.table + '_template';
            var array = layui.sessionData(table);
            if (array) {
                return array[key]
            } else {
                return false
            }
        }
        ,setStorage: function(key,value) {
            var table = admin.table + '_system';
            if (value != null && value !== "undefined") {
                layui.data(table,{
                    key: key,
                    value:value
                })
            }else {
                layui.data(table,{
                    key: key,
                    remove:true
                })                
            }
        },
        getStorage: function(key) {
            var table = admin.table + '_system';
            var array = layui.data(table);
            if (array) {
                return array[key]
            } else {
                return false
            }
        }
        ,refresh: function(id) {
            if (id == null || id == undefined) {
                return false
            }

            // 单页面形式
            if (!admin.pageTabs) {
                var iframe = jquery('iframe[lay-id="'+ id +'"]');
                jquery('#loading').show();
                return iframe[0].contentWindow.location.reload(true);
            }

            var iframe = jquery(tabs + " .layui-tab-item").find("iframe");
            for (let i = 0; i < iframe.length; i++) {
                var layid = jquery(iframe[i]).attr('lay-id');
                if (layid == id) {
                    iframe[i].contentWindow.location.reload(true);
                    jquery(iframe[i]).next("#loading").css({'overflow':'hidden','display':"block"});
                }
            }
        }
        // 展现动画
        ,showLoading: function(obj) {
            /**
             * 动态增加查询动画
             */
            var html = this.getloadingHtml()
                ,isexist = jquery(obj).children('#loading');
            if (isexist.length <= 0) {
                jquery(obj).append(html);
            }else {
                isexist.show();
            }

        }, // 移除动画
        removeLoading: function(obj) {
            (typeof(obj) === undefined ) && (obj = "body");
            var isexist = jquery(obj).next("#loading");
            isexist && isexist.fadeOut(500);
        }
        ,getloadingHtml: function() { // 插入loading元素
            var html = '<div id="loading">';
            html += '<div class="loader">';
            html += '<div class="ant-spin ant-spin-spinning" >';
            html += '<span class="ant-spin-dot ant-spin-dot-spin">';
            html += '<i class="ant-spin-dot-item"></i>';
            html += '<i class="ant-spin-dot-item"></i>';
            html += '<i class="ant-spin-dot-item"></i>';
            html += '<i class="ant-spin-dot-item"></i>';
            html += ' </span></div></div></div>';
            return html;
        }
        , getNavHtml: function(obj, child) {

            // 直接在这里进行判断
            var html = '', nav = admin.getStorage('nav') || "left";
            for (var i = 0; i < obj.length; i++) {

                var main = obj[i];

                // 判断子类
                if (main.children && main.router === '#') {

                    if (main.pid === 0 || (nav === "hybrid" && child !== "parent")) { // 这个地方不变
                        html += '<li class="layui-nav-item">';
                    }else {
                        html += '<dd>';
                        main.fixed = true;
                    }

                    // 左侧和混合菜单选项
                    if ('left' === nav || nav === "hybrid") {
                        html += '<a href="javascript:;">';
                    }
                    else {
                        if (main.pid === 0 ) { 
                            // 左侧类型全部等于这个，现在这个是TOP类型的数据
                            html += '<a href="javascript:;">';
                        }else {
                            html += '<a href="javascript:;" class="layui-third-class" >';
                        }
                    }

                    // 左侧展现图标
                    if (main.icons && (nav === 'left' || nav === "hybrid")) {
                        
                        // 图标必须要左侧菜单设置才可以。加一个等于混合就可以了
                        html += '<i class="layui-icon ' + main.icons +'"></i>';
                    }

                    // 左侧pid等于0展现图标
                    if (main.pid === 0 && nav === 'left') { // 这里需要增加 或者等于混合菜单的时候
                        html += '<cite>'+main.title+'</cite>';
                    } else if (child !== "parent") {
                        html += main.title;
                    } else {
                        html += main.title;
                    }

                    if ('left' === nav || nav === "hybrid") { // 这里需要增加 等于混合菜单
                        html += '</a><dl class="layui-nav-child">';
                    }
                    else {
                        if (main.pid === 0 || nav === "hybrid" || nav === "left") {
                            html += '</a><dl class="layui-nav-child">';
                        }else {
                            html += '<i class="layui-icon layui-icon-right"></i></a><dl class="layui-nav-third">';
                        }
                    }

                    if (nav === "hybrid") {
                        html += this.getNavHtml(main.children,  "parent");
                    }else {
                        html += this.getNavHtml(main.children,  child + i);
                    }
                    
                    html += '</dl>';
                }
                else {

                    // 顶级菜单
                    if (main.pid === 0 || (nav === 'hybrid' && child !== "parent")) { 
                        html += '<li class="layui-nav-item" >';

                        // 需要增加判断地址是否等于#号
                        if (main.router == '#') {
                            html += '<a href="javascript:;" >';

                        }else {
                            html += '<a href="javascript:;" target="_self" lay-href="' + baseUrl.substring(_begin,_end) + main.router + '">';
                        }
                        

                        if (main.icons && (nav === "left" || nav === "hybrid")) {
                            html += '<i class="layui-icon ' + main.icons +'"></i>';
                        }

                        html += '<cite>' + main.title + '</cite>';
                        html += '</a></li>';

                    } else {
                        // 子类菜单
                        if (main.type == 0) {

                            if (main.router == '#') { 
                                // 过滤当赋予权限失败的时候，则不使用lay-href
                                html += '<dd><a href="javascript:;">';
    
                            } else if (main.type == 0){
    
                                html += '<dd><a lay-href="'+ baseUrl.substring(_begin,_end) + main.router +'">';
                            }                        
                           
                            if (main.icons  && (nav === "left" || nav === "hybrid")) {
                                html += '<i class="layui-icon ' + main.icons +'"></i>';
                            }
                            
                            html +=  main.title +'</a></dd>';
                        }
                        
                    }                 
                }

                if (typeof main.fixed !== "undefined") {
                    html += '</dd>';
                }

                if (main.pid === 0 || (nav === 'hybrid' && child !== "parent")) {
                    html += '</li>';
                }
      
                if (main.id == 24 && "left" === nav) {
                    html += '<div class="layui-other-set">设置</div>  ';
                }                
            }

            return html;
        }
        ,getNavhybrid: function(obj, child) {
            var header = '', navHtml = '';
            for (let index = 0; index < obj.length; index++) {
                /**
                 * 混合型菜单，当顶级菜单为一个的时候，会出现错误
                 */
                const element = obj[index], nav = 'swift-admin-' + (index+1);

                if (element.pid === 0) { 
                    
                    header += '<li class="layui-nav-item layui-hide-xs '; 
                    if (index === 0) {
                        header += 'layui-this'; 
                    }
                    header += '">'; 

                    try {

                        if (!element.children) {
                            header += '<a href="javascript:;" lay-nav-bind="'+ nav +'" sa-event="tabs" lay-url="'+_header+ element.router;
                            header += '" lay-title="'+ element.title +'" >' + element.title +'</a>';
                        }
                        else {
                            header += '<a href="javascript:;" lay-nav-bind="'+ nav +'" >' + element.title +'</a>';
                        }

                        header += '</li>';

                    } catch (error) {
                        console.log(error);
                    }

                    // 子类生成的类名 用来切换
                    obj[index]['nav'] = nav;
                }

                // 应该在这里设置传递下面的东西
                if (element.children && element.router === '#') {

                    navHtml += '<div class="' + element.nav + '"';
                    
                    if (index === 0) {
                        navHtml += 'style="display:block;"'; 
                    }

                    navHtml += '>';
                    navHtml += admin.getNavHtml(element.children); // 这里只传递子菜单的区块，返回的子菜单其实就是当做顶级菜单在左侧使用
                    navHtml += '</div>';
                }
            }

            // 插入到顶层
            jquery('.layui-nav-top').html(header);
            jquery('.layui-nav-tree').html(navHtml);
        }
        ,getStyleCss: function() {
            var css = '<style id="style-light">';
            css += '.layadmin-setTheme-side, .layui-side-menu,.layui-layout-admin .layui-logo,.layui-nav-itemed>.layui-nav-child{';
            css += 'background-color: #fff!important;';
            css += 'color: #000;}';
            css += '.layui-side-menu .layui-nav .layui-nav-item>a,';
            css += '.layui-nav-tree .layui-nav-child,';
            css += '.layui-nav-itemed>a, .layui-nav-tree .layui-nav-title a, .layui-nav-tree .layui-nav-title a:hover,';
            css += '.layui-side .layui-logo h1,';
            css += '.layui-side-menu .layui-nav .layui-nav-item>a, .layui-nav-tree .layui-nav-child a,';
            css += '.layui-layout-admin .layui-side .layui-nav .layui-other-set {';
            css += 'color: #000!important;}';
            css += '.layui-nav-tree .layui-nav-child, .layui-nav-tree .layui-nav-child a:hover {color: #1890ff!important;}';
            css += '.layui-nav-tree .layui-nav-child .layui-this a { color: #fff!important;}';
            css += '.layui-nav .layui-nav-more { border-top-color: rgba(0,0,0,.7);}';
            css += '.layui-nav .layui-nav-mored, .layui-nav-itemed>a .layui-nav-more {border-color: transparent transparent #000;}';
            css += '.layadmin-side-shrink .layui-side .layui-nav .layadmin-nav-hover>.layui-nav-child:before{background-color: #fff; }';
            css += '.layadmin-side-shrink .layui-side-menu .layui-nav>.layui-nav-itemed>a{background: #f2f2f2;}';
            css += '</style>';
            return css;
        }
        ,setTheme: function() { // 设置皮肤函数
            var theme = admin.getStorage('theme');
            theme = (theme === 'blue') ? '' : theme; 
            if (admin.getStorage('pageTabs')) {
                var iframe = top.layui.$(tabs + " .layui-tab-item").find("iframe");
                for (let i = 0; i < iframe.length; i++) {
                    jquery(iframe[i]).contents().find('body').attr('id',theme);
                }
            }
            else {
                top.layui.$('iframe').contents().find('body').attr('id',theme);
            }
            // 给自身样式
            top.layui.$('body').attr('id',theme);
        }
        ,setDropStyle: function() {
            var dropstyle =  admin.getStorage('dropstyle');
            if (typeof dropstyle !== "undefined") {
                top.layui.$(".layui-nav-tree").removeClass('arrow1 arrow2 arrow3');
                top.layui.$(".layui-nav-tree").addClass(dropstyle);
            }
        }
        ,setlayFluid: function() {

            var layout =  admin.getStorage('layout');
            var laycss = '<style id="lay-fluid">.layui-fluid{padding: 50px;}</style>';
            if (admin.getStorage('pageTabs') && typeof(layout) !== "undefined") {

                var iframe = top.layui.$(tabs + " .layui-tab-item").find("iframe");
                for (let i = 0; i < iframe.length; i++) {
                    if (layout === "fixed") {
                        if (jquery(iframe[i]).contents().find('head').find('#lay-fluid').length <= 0) {
                            jquery(iframe[i]).contents().find('head').append(laycss);
                        }
                        
                    }else {
                        jquery(iframe[i]).contents().find('#lay-fluid').remove();
                    }
                } 
            }
            else if (typeof(layout) !== "undefined") {
                if (layout === "fixed") { // 单页面模式
                    if (top.layui.$('iframe').contents().find('#lay-fluid').length <= 0) {
                        top.layui.$('iframe').contents().find('head').append(laycss);
                    }
                }else {
                    top.layui.$('iframe').contents().find('#lay-fluid').remove();
                }
            }
        }
        ,setOpenHeader: function() {  // 设置头部
            var openHeader = admin.getStorage('openheader');
            if (openHeader === false) { // 移除
                top.layui.$('.layui-header,.layui-logo').hide(); 
                top.layui.$('.layui-nav-tree,.layui-body').css({
                    "top":"0px",
                    "margin-top":"0px"
                }); 
            }else if (openHeader === true) { // 还原回来
                top.layui.$('.layui-header,.layui-logo').show();
                top.layui.$('.layui-nav-tree').css("margin-top","60px"); 
                top.layui.$('.layui-body').css("top","50px"); 
            }

        }
        ,setOpenFooter: function() {
            var openfooter = admin.getStorage('openfooter');
            if (openfooter === false) { // 移除
                top.layui.$('.layui-footer').hide(); 
            }else if (openfooter === true) { // 显示
                top.layui.$('.layui-footer').show();
            }
        }
        ,renderUpload: function() { // 渲染上传组件
            layui.upload.render({
                elem: '*[lay-upload]'
                ,url: uploadUrl // 默认的上传地址
                ,method: 'post'
                ,accept: 'file'
                ,before: function(res) {
                    iziToast.info({
                        message: admin.lang('File Upload...'),
                        timeout: 30000,
                    });   
                },done: function(res, index, upload) {    

                    // 销毁消息
                    layui.iziToast.destroy({
                        time: 500
                    });

                    // 加载配置数据
                    var input = jquery(this.item).attr('lay-input'),
                        images = jquery(this.item).attr('lay-images'),
                        imglist = jquery(this.item).attr('lay-imglist'),
                        options = {
                            input: input,
                            images: images,
                            imglist: imglist
                        };
    
                    // 回调函数
                    if (admin.event.callfunc(this.item,{ res:res, index:index, upload:upload } , options) || admin.callstatus === true ) {
                        return admin.callstatus = false;
                    }
                   
                    // 上传成功
                    if (res.code == 200) {

                        iziToast.success({
                            message: res.msg,
                        });
                
                        if (typeof(imglist) !== 'undefined') {
                            if (jquery('.' + imglist).length > 0) {
                                var html = '<div class="layui-imglist-images" >';
                                    html += '<a href="'+ res.url +'" class="layui-upload-imglist" target="_blank >';
                                    html += '<img src="'+ res.url +'" alt="" class="layui-upload-images">';
                                    html += '</a>';
                                    html += '</div>';
                                    jquery('.' + imglist).append(html);
                            }else {
                                iziToast.error({
                                    message: admin.lang('The lack of DIV elements'),
                                });
                            }
                        }
    
                        else {
                            if (typeof input !== "undefined") {
                                jquery('.'+ input).prop('value',res.url)
                                // jquery('.'+ input).val(res.url)
                            }
                            if (typeof images !== "undefined") {
                                jquery('.'+ images).prop('src',res.url)
                            }
                        }
                        
                    }else{
                        
                        iziToast.error({
                            message: res.msg,
                        });
                    }
                }
            })
        }
        ,renderDate: function() {
            /**
             * 时间控件
             * 1、lay-datetime 参数 默认留空即可，layui自动绑定到了元素 自动赋值
             */
            var datetime = jquery('*[lay-datetime]');
            datetime.each(function(obj){
                laydate.render({
                    elem: this
                    ,type: 'datetime'
                    ,format :'yyyy-MM-dd HH:mm:ss'
                });
            })
        }
        ,renderPicker: function() {
            /**
             * 颜色选择器控件
             * lay-colorpicker 填写的数据为是哪一个类
             * lay-value 初始化的颜色，自己从数据库获取，必填参数
             */
            var picker = jquery('*[lay-colorpicker]');
            picker.each(function(obj,elem){
                colorpicker.render({
                    elem: this
                    ,color: jquery(elem).attr("lay-value")
                    ,done: function(color){
                        jquery('.' + jquery(elem).attr("lay-colorpicker")).val(color);
                    }
                });
            }) 
        }
        ,renderStars: function() {
            /**
             * 星星组件 / 默认访问参数 为GET
             * 1、lay-stars 必填参数 list|ones 列表还是单个
             * 2、lay-url  必填参数 点击进行GET的地址
             * 3、lay-object  必填参数 进行修改的对象ID
             * 4、lay-value 必填参数 渲染时使用的原始星星
             * 5、lay-theme  颜色
             * 6、lay-readonly 是否只是展示，
             */
            layui.each(jquery("*[lay-stars]"),function(obj,elem){
                // 
                var that = jquery(this),
                stars = that.attr("lay-stars"),
                url = that.attr("lay-url") || undefined,
                ids =  that.attr('lay-object') || undefined,
                theme = that.attr('lay-theme') || '#fadb14',
                classd = that.attr('lay-class') || undefined,
                readonly = that.attr('lay-readonly') || false;

                rate.render({
                    elem: elem
                    ,theme: theme
                    ,readonly: readonly
                    ,value: that.attr('lay-value') //初始值
                    ,choose: function(value) {

                        if (stars == 'ones') {
                            jquery('.'+classd).attr('value',value);
                            return false;
                        }

                        jquery.get(url, {
                            id: ids,
                            stars: value
                        }, function (res) {
                            if (res.code == 200) {
                                iziToast.success({
                                    message: res.msg,
                                });
                            } else {
                                iziToast.error({
                                    message: res.msg,
                                });
                            }
                        }, 'json');

                    }
                })
            })
        }
        ,renderSlider: function() {
            /**
             * 滑块组件
             */
            layui.each(jquery("*[lay-slider]"),function(obj,elem){
                var that = jquery(this),
                ids = that.attr("lay-slider"),
                theme = that.attr('lay-theme') || '#1E9FFF';

                slider.render({
                    elem: elem
                    ,theme: theme
                    ,value: jquery(elem).attr("lay-value")
                    ,change: function(value) {
                        jquery('.' + ids).val(value);
                    }
                })
            })
        }
        ,renderTips: function() {
            /**
             * 监听消息提示事件
             */
            jquery(document).on("mouseenter","*[lay-tips]" , function () {
                var remind = jquery(this).attr("lay-tips");
                var tips = jquery(this).attr("lay-offset") || 4 ;
                var color = jquery(this).attr("lay-color") || '#000';
                layer.tips(remind,this,{
                    time: -1,
                    tips: [tips, color]
                });
            }).on("mouseleave", "*[lay-tips]", function () {
                layer.closeAll("tips");
            });            
        }
    };

    // 定义全局事件
    admin.event = {
        flexible: function () {
            var iconElem = jquery('#'+flexibleid);
            var spread = iconElem.hasClass(iconspread);
            admin.flexible(spread ? 'open' : null);
        },
        shade: function() { // 移动端遮罩层点击
            admin.flexible(); 
        },
        refresh: function () {
            admin.refresh(admin.getConfig("activeTab"));
        },
        back: function () { // 后退的函数
            
        },
        theme: function () {
            var n = jquery(this).attr("lay-url");
            admin.event.popupRight({
                id: "layer-theme",
                type: 2,
                content: n ? n : baseUrl.substring(_begin,_end) + '/system.admin/theme'
            })         
        },
        message: function () {
            var that = jquery(this),
                n = that.attr("lay-url");
            admin.event.flowOpen({
                id: "layer-msg",
                type: 2,
                // title: "🔔  消息提醒",
                area: ["336px", "390px"],
                content: n ? n : baseUrl.substring(_begin,_end) + '/system.admin/message'
            }, that)      
        },
        pwd: function () {
            var n = jquery(this).attr("lay-url");
            admin.event.pupupOpen({
                id: "layer-pwd",
                type: 2,
                shade: 0,
                title: "🔑  修改密码",
                area: ["385px", "295px"],
                content: n ? n : baseUrl.substring(_begin,_end) + '/system.admin/pwd'
            })   
        },
        clear: function() {
        }
        ,logout: function (res) {
            var href = jquery(this).attr("lay-url");
            layui.layer.confirm("确定要退出登录吗？", {
                title: admin.lang("Tips"),
            }, function () {
                location.replace(href ? href : baseUrl.substring(_begin,_end) + '/login/logout')
            })        
        }
        ,flowOpen: function (n, that) {
            
            if (typeof that === "undefined") {
                return iziToast.info({
                    message: admin.lang('this undefined'),
                });
            }

            var elemWidth = 0,client = that[0].getBoundingClientRect();

            // 标题
            if (n.title == undefined) {
                n.title = false;
                n.closeBtn = false
            }

            // 弹窗关闭
            n.shadeClose = true;
            n.area || (n.area = "336px");

            if (n.area instanceof Array) {
                elemWidth = n.area[0]
            }else {
                elemWidth = n.area;
            }
            elemWidth = parseInt(elemWidth); 

            // 动画效果
            n.anim || (n.anim = 5);
            n.resize = n.resize != undefined ? n.resize : false;
            n.shade = n.shade != undefined ? n.shade : 0.1;

            // 计算偏移量
            var top = client.height,
                padding = (that.innerWidth() - that.width()) / 2, // 不用计算 padding
                left = client.left + (client.width / 2) - (elemWidth / 2);
            if (!n.offset) {
                n.offset = [top,left];
            }

            return layer.open(n);
        }
        ,pupupOpen : function (n) {

            if (n.title == undefined) {
                n.title = false;
                n.closeBtn = false
            }
            if (!n.offset) {
                if (jquery(window).width() < 768) { 
                    n.offset = "15px"
                } else {
                    if (window == top) {  
                        n.offset = "25%"
                    } else {
                        n.offset = "20%"
                    }
                }
            }
            n.resize = n.resize != undefined ? n.resize : false;
            n.shade = n.shade != undefined ? n.shade : 0.1;
            return layer.open(n)
        }
        ,pupupTop: function(n) { 
            n = admin.event.popupAnim(n);
            n.offset = n.offset || (n.offset = "t");
            return admin.event.pupupOpen(n)
        }
        ,pupupDown: function(n) { 
            n = admin.event.popupAnim(n);
            n.offset = n.offset || (n.offset = "d");
            return admin.event.pupupOpen(n)
        }
        ,pupupLeft: function(n) { 
            n = admin.event.popupAnim(n);
            n.offset = n.offset || (n.offset = "l");
            return admin.event.pupupOpen(n)
        }
        ,popupRight: function(n) {
            n = admin.event.popupAnim(n);
            n.offset = n.offset || (n.offset = "r");
            return admin.event.pupupOpen(n)
        }
        ,popupAnim: function(n) {
            n.anim = -1;
            n.shadeClose = true;
            n.area || (n.area = "336px");
            n.skin || (n.skin = "layui-anim layui-anim-rl layui-layer-adminRight");
            n.move = false;
            if (n.fixed == undefined) {
                n.fixed = true
            }

            return n;
        }
        ,fullscreen: function (res) {
            var SCREEN_FULL = 'layui-icon-screen-full'
            ,SCREEN_REST = 'layui-icon-screen-restore'
            ,iconElem = res.children("i");
            if(iconElem.hasClass(SCREEN_FULL)){ // 添加图标元素并执行操作
                iconElem.addClass(SCREEN_REST).removeClass(SCREEN_FULL);
                admin.fullScreen();
            } else {
                admin.exitScreen();
                iconElem.addClass(SCREEN_FULL).removeClass(SCREEN_REST);
            }
        }
        ,leftPage: function () {
            admin.rollPage('left');
        }
        ,rightPage: function () {
            admin.rollPage();
        }
        ,tabs: function() { // 打开一个面板
 
            var urls = jquery(this).attr("lay-url");
            var title = jquery(this).attr("lay-title");
            title || (title = jquery(this).text());
            if (top.layui && top.layui.admin) {
                top.layui.admin.render({
                    id: urls,
                    title: title ? title : "",
                    urls: urls
                })
            } else {
                location.href = urls
            }
        }
        ,closeThisTabs: function (id) { // 关闭当前，关闭的是当前活动的选项卡
            if (id != null && typeof(id) == 'object') {
                id = admin.getConfig('activeTab');
            }

            if (admin.TabLists[0].id == id) {
                iziToast.info({
                    message: admin.lang('Plase Close HomePage'),
                });
                return false;
            }

            element.tabDelete(tabfilter,id);
        },
        closeOtherTabs: function (id) {

            if (id != null && typeof(id) == 'object') {
                id = admin.getConfig('activeTab')
            }
            // 倒序删除
            var TabLists = admin.TabLists;
            var length = TabLists.length - 1;
            for (;length >= 1; length--) {
                if (TabLists[length].id != id) {
                    element.tabDelete(tabfilter,TabLists[length].id);
                }
            }
            // 修复当前为自身活动选项卡
            admin.setConfig("activeTab",id);
        },
        closeAllTabs: function () {
            var TabLists = admin.TabLists;
            var length = TabLists.length - 1;
            for (;length >= 1; length--) {
                element.tabDelete(tabfilter,TabLists[length].id);
            }            
        },
        closeDialog: function (that) {  // 关闭弹出层
           var _type = jquery(that).parents(".layui-layer").attr("type");

           // 如果这里不是页面层，则说明是iframe层
           if (typeof _type === "undefined") {
                parent.layer.close(parent.layer.getFrameIndex(window.name));
           }else {
                var o = jquery(that).parents(".layui-layer").attr("id").substring(11);
                layer.close(o);
                top.layer.close(o);
           }
        }
        ,closePageDialog: function() {           
            admin.event.closeDialog(this);
        }
        ,getAjaxData: function(url, data, async) { // 同步获取数据
            var result = [],
                async = async || false;
            jquery.ajax({
                url: url,    // 后台数据请求地址
                type: "post",
                data: data,
                async: async, // 同步操作
                success: function(res){
                    result = res;
                }
            });

            try {
                return typeof (result) !== "object" ? JSON.parse(result) : result;
            } catch (error) {
                console.error('result not JSON');
            }
        }
        /**
         * 回调函数
         * 1、obj           被点击的元素本身
         * 2、collection    数据对象集合，ajax,open,upload返回不同的对象，
         * 3、config        从clickthi或自己传递过来的参数配置
         * 4、before        是否执行前置回调函数 / 需要开启支持 / 因为有些情况下，只需要点击之后获取某些参数，剩下的操作由自己完成！
         */
        ,callfunc: function (clickthis, collection, config, before) {
            var callback = before ? clickthis.attr('lay-callbefore') : clickthis.attr('lay-callback');
            if (typeof(callback) !== "undefined") {
                 callback = admin.callString + callback;
                if (typeof eval(callback) === "function") {
                    admin.callstatus = true; // 函数状态
                    return eval(callback)(clickthis, collection, config);
                }
            }
         }
        // 打开面板
        ,open: function(clickthis, tableThis , options) {

            var config = {
                
                // 配置窗口
                url: clickthis.attr('lay-url') || undefined,
                type: clickthis.attr('lay-type') || 2,
                area: clickthis.attr('lay-area') || "auto",
                offset: clickthis.attr('lay-offset') || "15%",
                title: clickthis.attr('lay-title') || false,
                maxmin: clickthis.attr('lay-maxmin') || false,
                auto: clickthis.attr('lay-auto') || "undefined",
                scrollbar:clickthis.attr('lay-scrollbar') || "undefined",

                // 系统配置
                disableform: clickthis.attr('lay-disable') || false
            }

            // 标题遮罩层
            var closeBtn = 1, shade = 0.3, routerUrl;
            // config.title !== false && (closeBtn = 1);
        
            // 解析URL地址
            if (typeof(config.url) !== "undefined") {
                
                // 获取ID，用来填充form表单
                config.id = config.url.replace(/[^0-9|a-z|A-Z]/i,'');

                // 判断是否为页面元素 // 过滤锚文本或者外部链接
                if (config.url.indexOf('#') !== -1 || config.url.indexOf('.') !== -1) {

                    // 页面层地址
                    if (config.url.indexOf('http://') === -1 && config.url.indexOf('.php') === -1) {
                        config.type = 1;

                        // 这里已经将URL变成HTML文本了
                        config.url = jquery(config.url).html(); 
                    }
                }
            }
            else {
                // URL地址不允许留空
                if (typeof (config.url) === 'undefined' && typeof(options) === "undefined") {
                    iziToast.error({
                        message: 'lay-url NoSeting！',
                    });
                    return false;
                }
            }
        
            // 判断宽度x高度
            // 默认百分之百为0
            (config.area !== "auto") && (config.area = config.area.split(','));
            if (config.area !== "auto" && config.area[0] == '100%') {
                config.offset = 0;
            }
            
            // options用于覆盖
            (typeof(options) !== "undefined") && (config = jquery.extend(config,options));


            // 如果是页面元素
            if (config.type === 1 && config.url) {
                
                // 当前是表右工具栏编辑
                if (typeof tableThis !== "undefined" ) {
                    if (tableThis.event == 'edit') {
                        routerUrl = config.url.match(/lay-edit=\"(.*?)\"/);
                    }else { // 其他默认为添加状态
                        routerUrl = config.url.match(/lay-add=\"(.*?)\"/);
                    }

                }else {
                    // 不存在也为添加状态
                    routerUrl = config.url.match(/lay-add=\"(.*?)\"/);
                }

                // 如果还没有找到则直接从FORM表单中查找
                if (!routerUrl) {
                    routerUrl = config.url.match(/\<form.*?action=\"(.*?)\"/);
                }
                
                // 找到地址则直接使用！
                routerUrl && (routerUrl = routerUrl[1]);
            }

            // 全局鉴权操作
            if (typeof(config.url) !== 'object' && config.type === 2) {
                routerUrl = config.url;
                if (typeof config.scrollbar === 'undefined') {
                    config.url = [config.url, 'no'];
                }
            }

            if (!admin.checkAuth(routerUrl)) {
                iziToast.error({
                    message: admin.lang('NO Permissions!'),
                });

                return false;
            }

            
            // 打开窗口
            layer.open({
                type: config.type,
                area: config.area,
                title: config.title,
                offset: config.offset,
                maxmin: config.maxmin, 
                shade: shade,
                shadeClose: false,
                scrollbar: false,
                closeBtn: closeBtn,
                content:  config.url , // 这里的URL会变成内容
                success:function(layero,index){
                  
                    // 弹窗类型
                    var pageType = (config.type === 1) ? true : false;
                    // 编辑状态
                    var tableEdit = typeof tableThis !== "undefined";

                    // 获取赋值状态
                    var disableForm = config.disableform;

                    // 自动调整大小
                    config.auto !== "undefined" && layer.iframeAuto(index);

                    // 渲染表单 / 默认页面层
                    pageType && form.render();

                    // 重载页面层控件 / 正则匹配
                    if (pageType) {
                        if (config.url.match(/lay-upload/i)) {
                            admin.renderUpload();
                        }
                        if (config.url.match(/lay-datetime/i)) {
                            admin.renderDate();
                        }
                        if (config.url.match(/lay-colorpicker/i)) {
                            admin.renderPicker();
                        }
                        if (config.url.match(/lay-stars/i)) {
                            admin.renderStars();
                        }
                        if (config.url.match(/lay-slider/i)) {
                            admin.renderSlider();
                        }
                        if (config.url.match(/lay-tips/i)) {
                            admin.renderTips();
                        }
                    }

                    // 调整overflow属性
                    var overvisi = jquery(layero).children(layercontent);
                    pageType && overvisi.css("overflow", "visible");
                    
                    // 默认编辑TABLE表
                    (!disableForm && pageType && tableEdit) && (form.val(config.id,tableThis.data));

                    // 如果是iframe Window对象
                    var iframeWindow = config.type === 2 ? layero.find('iframe')[0].contentWindow : null;
                    
                    /**
                     * 回调函数，后续需要自己处理！！！
                     */
                    if (admin.event.callfunc(clickthis, {tableThis:tableThis, layero:layero, index:index}, config ) || admin.callstatus === true ) {
                        return admin.callstatus = false;
                    }

                    // 页面层使用submitPage监听
                    form.on("submit(submitPage)",function(post) {

                        var pageThat = jquery(this), // 获取提交地址
                            _pageUrl = !tableEdit ? pageThat.attr('lay-add') : pageThat.attr('lay-edit');

                        if (typeof(_pageUrl) === 'undefined') {
                            _pageUrl = pageThat.parents('form').attr('action');
                        }

                        if (typeof(_pageUrl) === 'undefined') {
                            iziToast.error({
                                message: admin.lang('not lay-url attr'),
                            });
                            return false;
                        }
                        
                        // 禁止按钮防止重复点击
                        pageThat.attr("disabled",true);
                        
                        // 开始POST提交数据
                        jquery.post(_pageUrl, 
                            post.field, function(res){

                                // 本地更新的bug!
                                // 第三方空间无法更新数据
                                for (var elem in post.field) {
                                    var layskin = jquery(clickthis).parents("tr").find('*[data-field=' + elem+']').find('*[lay-skin]');
                                    if (layskin.length !== 0) {
                                        delete post.field[elem];
                                    }
                                }

                                if (res.code == 200) {

                                    iziToast.success({
                                        message: res.msg,
                                    });

                                    // 更新列数据
                                    (pageType && tableEdit ) ?
                                    tableThis.update(JSON.parse(JSON.stringify(post.field))) : 
                                    table.reload("lay-tableList");
                                    // 关闭当前窗口
                                    admin.event.closeDialog(pageThat);
                                }
                                else {
                                    iziToast.error({
                                        message: res.msg,
                                    });
                                    pageThat.attr("disabled",false);
                                }

                        }, 'json');

                        return false;                        
                    })
                }
            })
        }
        /*
        * 全局ajax函数
        * 接受一个对象，然后去查找配置参数
        * clickthis,     当前对象，传递过来的jquery this
        * data,          数据，由调用函数负责拼装，
        * options,       其他选项，用来给失败或者成功函数做一些本地的东西。
        */
        ,ajax: function(clickthis, data, options, custom) {

            // 配置数据
            var config = {
                url : clickthis.attr('lay-url')|| "undefined",
                type :  clickthis.attr('lay-type') || 'post',
                dataType :  clickthis.attr('lay-dataType') || 'json',
                timeout :  clickthis.attr('lay-timeout') || '6000',
                tableId :  clickthis.attr('lay-table') || clickthis.attr('lay-batch'),
                async: true
            }, defer = jquery.Deferred();
            
            // Ajax鉴权
            if (!admin.checkAuth(clickthis.attr('lay-url'))) {
                iziToast.error({
                    message: admin.lang('NO Permissions!'),
                });
                return false;
            }

            // 存在则合并数据
            if (typeof(custom) !== "undefined") {
                config = jquery.extend({},config,custom);
            }

            // 地址不能为空
            if (typeof(config.url) === 'undefined') {
                iziToast.error({
                    message: 'lay-url undefined！',
                });
                return false;
            }
    
            // 前置回调
            if (admin.event.callfunc(clickthis, data, config, true) || admin.callstatus === true ) {
                return admin.callstatus = false;
            }
        
            // 执行AJAX操作
            jquery.ajax({
                url: config.url,
                type: config.type,
                dataType: config.dataType,
                timeout: config.timeout,
                data: data, 
                async: config.async,
                success: function(res) {

                    // 执行后置回调函数
                    if (admin.event.callfunc(clickthis, res, config) || admin.callstatus === true ) {
                        return admin.callstatus = false;
                    }
                    
                    if (res.code == 200) { // 当传递TAB表ID的是刷新表

                        // 回调函数，批量操作默认不写，直接删除数据
                        if (typeof options !== "undefined" && typeof options.success === "function") {
                            return options.success(res);
                        }

                        if (typeof(config.tableId) !==  "undefined") {
                            table.reload(config.tableId);
                        }

                        // 自身弹出提示
                        iziToast.success({
                            message: res.msg,
                        });


                    } else {

                        if (typeof options !== "undefined" && typeof options.error === "function") {
                            return options.error(res);
                        }

                        iziToast.error({
                            message: res.msg,
                        });
                    }
                },
                error: function(res) {
                    // 访问控制器失效
                    iziToast.error({
                        message: 'Access methods failure',
                    });
                }
            })
              
            return config;
        }
    };
    

    // 初始化全局操作
    admin.init = jquery(layoutbody), admin.setTheme(),admin.setlayFluid();
    admin.renderTips();admin.renderDate();admin.renderStars();
    admin.renderPicker();admin.renderSlider();admin.renderUpload();
    if (admin.init.length >= 1 && typeof(admin.init) !== "undefined") {

        // 初始化标签
        var tabPage = admin.getStorage('pageTabs');
        tabPage === false && (admin.pageTabs = tabPage);

        // 初始化风格
        admin.getStorage('style') === 'light' && jquery('head').append(admin.getStyleCss());
                
        // 初始化页头和页脚
        admin.setOpenFooter() || admin.setOpenHeader();

        // 初始化箭头风格
        admin.setDropStyle() || admin.saPHPInit();

        // 初始化侧边栏
        if (admin.screen() <= 1) {
            jquery('#'+flexibleid).removeClass(iconshrink).addClass(iconspread);
        }

        // 全局的loading载入操作，
        if (jquery(layoutbody).children('#loading').length <= 0) {    
            jquery(layoutbody).append(admin.getloadingHtml());

            setTimeout(function() { // 兼容IE浏览器
                jquery(layoutbody).children('#loading').remove();
                jquery(layoutadmin).show(300);
            }, 1200);
        }
    }
    
    // 监听左侧菜单布局点击
    element.on("nav("+ menufilter +")", function (res) {
        admin.clickRender(res);
    })
    
    // 监听左侧菜单布局选项卡切换
    element.on("tab(" + tabfilter + ")", function (v) {
        var id = jquery(this).attr("lay-id");
        if (id != "undefined") {
            admin.activeTab = id; // 赋值当前ID
        }else {
            admin.activeTab = undefined;
        }

        // 活动的菜单
        admin.activeMenu(id);

        // 一定要先改变样式再去查找
        var nav = admin.getStorage('nav') || "left";
        if (nav === "left" || typeof (nav) === "undefined") {
            var title = jquery(this).children('.title').text();
            if (admin.TabLists.length >= 2 && nav === "left") { 
                admin.setBreadcrumb(id, title);
            }
        }

        admin.rollPage("auto");
        admin.setConfig("activeTab",id);
    });

    // 监听选项卡删除
    element.on("tabDelete("+tabfilter+")",function(res) {
        var id = admin.TabLists[res.index];
        if (id && typeof id === 'object') {

            // 删除当前对象
            admin.TabLists.splice(res.index,1);
            if (admin.cacheTab) {
                admin.setConfig("TabLists",admin.TabLists);
            }
            // 修正活动选项卡
            id = admin.TabLists[res.index-1];
            if (id && typeof id === 'object') {
                admin.setConfig("activeTab",id.id||id.urls);
            }
        }
    })

    // 窗口resize事件
    var resizeSystem = layui.data.resizeSystem = function(){
        var nav = admin.getStorage('nav') || "left";
        var width =jquery(window).width() - 550;
        if(!resizeSystem.lock){
            setTimeout(function(){
                if (admin.screen() < 2) {
                    admin.flexible();
                    jquery('.layui-breadcrumb-header').hide();
                    if (jquery(shadeclass).length <= 0) {
                        jquery(layoutadmin).append(bodyshade);
                    }
                }else {
                    admin.flexible('open');
                    jquery('.layui-breadcrumb-header').show();
                    jquery(shadeclass).remove();
                }

                // 修正顶部或者混合菜单布局菜单长度自动隐藏问题
                if (nav === "top" || nav === "hybrid") {
                    jquery('.layui-nav-head').css({
                        "overflow":"hidden"
                        ,"width": width
                    })
                    if (width >= 900) {
                        jquery('.layui-nav-head').css({"overflow":"unset"})
                    }
                }
                delete resizeSystem.lock;
            }, 50);
        }
        
        resizeSystem.lock = true;
    }
  
    // 监听全局sa-event事件
    jquery(window).on('resize', layui.data.resizeSystem);  
    jquery(document).on("click", "*[sa-event]", function () {
        var name = jquery(this).attr("sa-event");
        var obj = admin.event[name];
        obj && obj.call(this, jquery(this));
    });    

    /*
     * 监听全局radio选择器
     */
    form.on('radio(radioStatus)',function(data){
        var display = jquery(this).attr('lay-display');
        if (display != null && display !== 'undefined') {
            (data.value == 1) ? jquery('.'+display).show() : jquery('.'+display).hide();
        }
    })

    /**
     * 监听全局select过滤器
     */
    form.on('select(selectStatus)',function(data) {
        var select = jquery(this).parents().prev('select'),
        display = select.attr('lay-display'),
        disable = select.attr('lay-disable'),
        selector = select.attr('lay-selector');

        if (typeof(selector) == 'undefined' || selector == null) {

            // 第一种情况
            if (typeof(display) != 'undefined' && typeof(disable) == 'undefined') {
                (data.value == 1) ? jquery('.'+ display).show() : jquery('.'+ display).hide();
            }

            // 第二种情况
            if (typeof(display) != 'undefined' && typeof(disable) != 'undefined') {
                (data.value == disable) ? jquery('.'+ display).hide() : jquery('.'+ display).show();
            }
        }
        else { // 第三种情况 * demo file,class,oss
            selector = selector.replace('，',',').split(',');
            for (let i in selector) {
                (data.value !== selector[i]) ? jquery('.'+ selector[i]).hide() : jquery('.'+ selector[i]).show();
            }
        }
    })

    /**
     * 监听全局switch点击状态
     */
    form.on('switch(switchStatus)', function (obj) {
        
        var that = jquery(this)
        ,options = {
            error: function (res) {
                jquery(obj.elem).prop('checked', !obj.elem.checked);
                form.render('checkbox');
                iziToast.error({
                    message: res.msg,
                });
            }
        }
        ,data = {
            id: jquery(this).attr('value'),
            status: obj.elem.checked ? 1 : 0
        };

        if (jquery('.bubble').length) {
            jquery('.bubble').removeClass('bubble');
            return false;
        }

        admin.event.ajax(that,data,options);
    });

    /**
     * 监听form表单提交
     */
    form.on('submit(submitIframe)', function(data){

        /**
         * 默认从action查找，没找到则说明是增删改查，
         * 则从控制器进行数据控制
         */
        var that = jquery(this), _form = that.parents('form'),
            _url = _form.attr("action") || false;

        if (typeof controller === "undefined" || typeof action === "undefined") {
            iziToast.error({
                message: admin.lang('controller or action undefined!'),
            });

            return false;
        }

        if (_url === false || _url === '') {
            _url = _header + '/'+ controller+ '/' + action;
        }

        // 默认是否重载父页面
        var _parent = that.attr('lay-reload') || false;
        if (typeof(_url) === 'undefined') {
            console.warn('lay-url undefined!');
            return false;
        }

        // 禁用按钮
        that.attr("disabled",true);

        // 进行表单提交！
        jquery.post(_url,
            data.field,function(res){
                if (res.code == 200) {
                    // 顶层打开
                    top.layui.iziToast.success({
                        message: res.msg,
                    });

                    admin.event.closeDialog(that);
                    // 默认重载父页面
                    if (_parent === false && parent.window != top) { 
                        parent.location.reload();
                    }else {
                        if (parent.layui.table.cache['lay-tableList']) {
                            parent.layui.table.reload('lay-tableList');
                        }
                    }
                    
                } else {
                    top.layui.iziToast.error({
                        message: res.msg,
                    });
                }
                
                that.attr("disabled",false);
        }, 'json');

        return false;
    });

    /**
     * 监听form表单搜索  
     */ 
    form.on('submit(formSearch)',function(data) {
        var field = data.field;
        table.reload('lay-tableList', {
            where: field
        });
    })

    /**
     * 监听table里面右侧工具栏点击事件
     */
    table.on("tool(lay-tableList)", function(obj){

        var data = obj.data
        ,ajaxData = {}
        ,selector = jquery(this).parents('table').find('tbody tr')
        ,options = {
            success: function(res) {

                obj.del(); // 删除后重载
                iziToast.success({
                    message: res.msg,
                });

                if ((selector.length - 1) == 0 ||
                    typeof selector.length === 'undefined') {
                    table.reload("lay-tableList");
                }
            },
            error: function (res) {  
                iziToast.error({
                    message: res.msg,
                });
            }
        }
        ,clickthis = jquery(this)
        ,title = clickthis.attr("lay-title") || undefined
        
        // 拼接字段数据
        ,field = jquery(this).attr('lay-field');
        if (typeof (field) === "undefined") {
            ajaxData = {
                id: data.id
            }
        }else {
            var array = field.split(",");
            for (let d in array) {
                ajaxData[d] = data[d];
            }
        }

        // 编辑TABLE状态
        if (obj.event === "edit" ) { 
            // 需要table传递对象
            admin.event.open(clickthis,obj);
        }
        else if (obj.event === "del") {

            var tips = admin.lang('Sure you want to delete');
            if (typeof title !== "undefined") {
                tips += ' '+ title +' ';
            }
            tips +='？';

            // 删除鉴权
            if (!admin.checkAuth(clickthis.attr('lay-url'))) {
                iziToast.error({
                    message: (admin.lang('NO Permissions!')),
                });
                return false;
            }
            // 如果全部在ajax里面写，这样的话其实就可以不走后端鉴权了，
            // 但是这样的话，删除会弹出提示，所以删除前也需要鉴权下，
            // 那么剩下的地方就可以不写了
            layer.confirm(tips, function(index) {
                admin.event.ajax(clickthis,ajaxData,options); // 一样需要传递table对象
                layer.close(index);
            })
        }else if (obj.event === "ajax") {
            admin.event.ajax(clickthis,ajaxData,options); 
        }
        else {
            // 默认的自定义事件
            admin.event.open(clickthis,obj);
        }
    })

    /**
     * 鼠标click状态下，OPEN图片
     */
    jquery(document).on("click", "*[lay-image-click]", function () {

        var  that = jquery(this)
        ,images = that.attr("lay-image-click")
        ,size  = that.attr("lay-size") || undefined;

        /**
         * IMG标签使用SRC属性，适用于展现微缩图的情况
         */
        if (images.length == 0 && that[0].localName == "img") {
            images = that.prop("src");
        }

        var event = window.event || event;
        var width = that.width(),height = that.height();

        // 计算宽度*高度
        if (typeof(size) !== 'undefined') {
            size = size.split(",");
            if (size.length >= 2) {
                width = size[0],height=size[1];
            }
        }

        admin.event.open(that,undefined,{
            type: 1
            ,area: 'auto'
            ,url:'<img class="lay-images-address" src="' + images + '" width="'+ width +'" height="'+ height +'" >'
        })

    });

    /**
     * 鼠标hover状态下，显示图片
     */
    jquery(document).on("mouseenter","*[lay-image-hover]",function(){
        var that = jquery(this)
        ,images = that.attr("lay-image-hover")
        ,size  = that.attr("lay-size") || undefined
        ,remove = that.attr("lay-remove") || undefined;

        /**
         * IMG标签使用SRC属性，适用于展现微缩图的情况
         */
        if (images.length == 0 && that[0].localName == "img") {
            images = that.prop("src");
        } else if (that[0].localName == "input") {
            images = that.prop("value");
        }

        var event = window.event || event;
        var width = that.width(),height = that.height();
        var left = event.clientX + document.body.scrollLeft + 20;
        var top = event.clientY + document.body.scrollTop + 20;     

        // 计算宽度*高度
        if (typeof(size) !== 'undefined') {
            size = size.split(",");
            if (size.length >= 2) {
                width = size[0],
                height = size[1];
            }
        }
        else {
            width = "150"
            height = "180";
        }

        if (typeof images == 'undefined' || !images) {
            return false;
        }

        // 获取html元素
        var showbox = '<div class="lay-images-show" style="display:none;">';
        showbox += '<img class="lay-images-address" src="' + images + '" width="'+ width +'" height="'+ height +'" ></div>';
        jquery('body').append(showbox);
        jquery(".lay-images-show").css({left: left,top: top,display: "block"});
        
    }).on("mouseleave", "*[lay-image-hover]", function () {
        jquery(".lay-images-show").remove(); 
    });

    /**
     * 列表全部删除操作
     * 默认传入表的参数，进行POST投递
     */
    jquery(document).on("click","*[lay-batch]",function(obj){

        var clickthis = jquery(this)
            ,tableId = clickthis.attr("lay-batch") || null
            ,data = clickthis.attr("lay-field") || undefined
            ,selector = jquery(this).parents("body").find('.layui-table-main tbody *[data-field=id]')
            ,checkStatus = table.checkStatus(tableId)
            ,tips = admin.lang('sure you want to batch operation?');

        // 当前是否传递表id
        if (tableId === null || tableId === undefined) {
            iziToast.info({
                message: 'lay-table undefined!',
            });
            return false;
        }

        var field = ['id'];
        if (typeof data !== 'undefined') {
            field = field.concat(data.split(','));
        }

        if (checkStatus.data.length === 0) {
            iziToast.info({
                message: admin.lang('Plase check data'),
            });
            return false;
        }

        var data = {};
        for (var n in field) {
            var e = field[n];
            field[e] = [];
            for (var i in checkStatus.data) {
                field[e].push(checkStatus.data[i][e]);
            }
            data[e] = field[e];
        }

        layer.confirm(tips, function(index) {
            admin.event.ajax(clickthis,data);
            layer.close(index);
            iziToast.destroy({
                time: 500
            });
        })
    })


    /**
     * 监听全局layui.open事件并解决鉴权问题
     */
    jquery(document).on('click',"*[lay-open]",function(){
        admin.event.open(jquery(this),undefined,{});
    })

    /**
     * 监听全局属性鉴权
     */
    jquery(document).on('click',"*[lay-noauth]",function(){
        var event = jquery(this).attr('lay-event'); // 过滤掉工具栏鉴权事件
        var status = admin.getConfig('authnodes');
        if (!status.supersadmin && event === undefined) {
            iziToast.error({
                message: admin.lang('NO Permissions!'),
            });
        }
    })

    /**
     * 监听全局点击GET|POST事件,在使用的时候，请参考AJAX手册
     * 使用方式，任何元素都可以定义这个属性
     * 1、定义lay-ajax属性，值为空！
     * 2、定义lay-url属性，可以是一个带参数的地址，用来POST
     * 3、定义lay-type属性，默认为POST，如果你不需要修改，可以不写
     * 4、定义lay-data属性，里面是一个对象，适合参数多的情况下使用
     * 还可以传递对象类，
     */
    jquery(document).on("click","*[lay-ajax]",function(obj) {

        // 定义初始化对象
        var data = {}

        // 获取拼接参数
        ,packet =  jquery(this).attr("lay-data") || null
        ,object =  jquery(this).attr("lay-object") || undefined;

        // 传递类数据
        if (typeof object !== "undefined") {
            object = object.split(',');
            for (var i = 0; i < object.length; i++) {
                let ele = object[i].split(":");
                var val = jquery('.'+ele[1]).val();
                data[ele[0]] = val;
            }
        }

        // 传递对象数据
        if (packet !== 'null') {
            packet = new Function("return "+packet)();
            data = jquery.extend({},data,packet);
        }

        admin.event.ajax(jquery(this),data,{});
    })

    /**
     * 监听模板打开函数 SHIFT + P
     */
    jquery(document).keyup(function(event){
    　　if(event.shiftKey && event.keyCode == 80){
            jquery('[sa-event="theme"]').click();
    　　}
    });

    // 清理系统缓存
    layui.dropdown.render({
        elem: '.layui-system-clear'
        ,data: [{
            title: '一键清理缓存'
            ,event: 'all'
        },{
            title: '清理内容缓存'
            ,event: 'content'
        },{
            title: '清理模板缓存'
            ,event: 'template'
        },{
            title: '清理插件缓存'
            ,event: 'plugin'
        }] ,click: function(data, othis){
            var index = layui.layer.confirm("确定要清理缓存吗？", {
                title: admin.lang("Tips"),
            }, function () {
                admin.event.ajax(jquery(this),{},{},{url: _header + '/system.admin/clear/type/' + data.event});
                layui.layer.close(index);
            })
        }
    }); 

    // 监听右键菜单
    jquery(layoutadmin).off("contextmenu").on("contextmenu", tabs + " li", function (v) {
        var id = jquery(this).attr("lay-id");
        contextMenu.render([{
            name: "刷新当前",
            click: function () {
                admin.refresh(id);
                element.tabChange(tabfilter,id);
            }
        }, {
            name: "关闭当前",
            click: function () {
                admin.event.closeThisTabs(id) // 关闭当前的ID
            }
        }, {
            name: "关闭其他",
            click: function () {
                admin.event.closeOtherTabs(id)
            }
        }, {
            name: "关闭全部",
            click: function () {
                admin.event.closeAllTabs(id)
            }
        }
        ], v.clientX, v.clientY); 
        return false
    })

    /**
     * 监听小屏幕后hover菜单栏事件
     */
    var layuiside = "." + sideshrink + " .layui-side .layui-nav .layui-nav-item";
    jquery(document).on("mouseenter",layuiside + "," + layuiside + " .layui-nav-child>dd",function(){
        if (admin.screen() >= 2) {
            var self = jquery(this),
            child = self.find(">.layui-nav-child");
            if (child.length > 0) {
                self.addClass("layadmin-nav-hover");
                child.css({"width": "30px","top": self.offset().top, "left":self.offset().left + self.outerWidth()});
            }
            else {
                // 不存在子类则创建父类当作子类
                if (admin.getStorage('nav') === 'left') { // 当左侧菜单布局的时候
                    if (self.hasClass("layui-nav-item")) {
                        var title = self.find("cite").text(),
                        href = self.find("a").attr("lay-href");
                        
                        var html = '<dl id="layui-nav-child" class="layui-nav-child" >';
                        html += '<dd class="';
                        if (self.hasClass("layui-this")) {
                            html += 'layui-this';
                        }
                        html += '"><a lay-href="'+ href +'">'+ title +'</a></dd>';
                        html += '</dl>';
                        jquery(self).append(html);
                        element.render("nav");
                        self.addClass("layadmin-nav-hover");
                        child = self.find(">.layui-nav-child");
                        child.css({"width": "30px","top": self.offset().top, "left":self.offset().left + self.outerWidth()});
                    }
                }
                else { // 混合布局菜单，顶层布局不选这个，因为元素已经被隐藏了
                    var n = self.text();
                    layer.tips(n, self, {
                        tips: [2, "#303133"],
                        time: -1,
                        success: function (r, s) {
                            jquery(r).css("margin-top", "12px")
                        }
                    })
                }
            }
        }
        
    }).on("mouseleave", layuiside + "," + layuiside + " .layui-nav-child>dd", function () {
        layer.closeAll("tips");
        var self = jquery(this);
        self.removeClass("layadmin-nav-hover");
        jquery("#layui-nav-child").remove();
        var child = self.find("dl");
        // ie下bug不能为unset
        child.css({ 
            "left": 0,
            "top": 0,
        });
    });

    //  初始化的时候设置
    if (admin.pageTabs && jquery(tabs).length <= 0) {
        var e = '<div class="layui-tab" lay-allowClose="true" lay-filter="swiftadmin-tabs">';
        e += '       <ul class="layui-tab-title"></ul>';
        e += '          <div class="layui-tab-content"></div>';
        e += "   </div>";
        e += '   <div class="layui-icon swiftadmin-tabs-control layui-icon-left" sa-event="leftPage"></div>';
        e += '   <div class="layui-icon swiftadmin-tabs-control layui-icon-right" sa-event="rightPage"></div>';
        e += '   <div class="layui-icon swiftadmin-tabs-control layui-icon-down">';

        e += '      <ul class="layui-nav swiftadmin-tabs-select " lay-filter="swiftadmin-nav">';
        e += '         <li class="layui-nav-item" lay-unselect>';
        e += "            <a></a>";
        e += '            <dl class="layui-nav-child layui-anim-fadein">';
        e += '               <dd sa-event="closeThisTabs" lay-unselect><a>关闭当前标签页</a></dd>';
        e += '               <dd sa-event="closeOtherTabs" lay-unselect><a>关闭其它标签页</a></dd>';
        e += '               <dd sa-event="closeAllTabs" lay-unselect><a>关闭全部标签页</a></dd>';
        e += "            </dl>";
        e += "         </li>";
        e += "      </ul>";
        e += "   </div>";
        jquery(body).html(e);
        element.render("nav");
    }

    exports('admin', admin);
});