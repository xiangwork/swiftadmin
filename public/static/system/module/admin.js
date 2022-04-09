// +----------------------------------------------------------------------
// | swiftadmin极速开发框架后台模板 [基于layui开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | git://github.com/meystack/swiftadmin.git 616550110
// +----------------------------------------------------------------------
// | Author: meystack <coolsec@foxmail.com> Apache 2.0 License Code
// +----------------------------------------------------------------------
layui.define(['jquery', 'i18n', 'element', 'layer', 'form', 'rate', 'table', 'slider', 'upload', 'laydate', 'dropdown', 'colorpicker', 'cascader', 'content', 'tags'], function (exports) {

    "use strict";
    var $ = layui.jquery;
    var i18n = layui.i18n;
    var layer = layui.layer;
    var form = layui.form;
    var rate = layui.rate;
    var table = layui.table;
    var slider = layui.slider;
    var element = layui.element;
    var laydate = layui.laydate;
    var cascader = layui.cascader;
    var content = layui.content;
    var element = layui.element;
    var colorpicker = layui.colorpicker;

    // 系统常量
    var TABFILTER = 'swiftadmin-tabs', BODY = '.layui-body', LAYOUTBODY = ".layui-layout-body", LAYOUTADMIN = ".layui-layout-admin"
        , TABS = BODY + ">.layui-tab", FLEXIBLEID = "flexible", MENUFILTER = "lay-side-menu", LAYTOPMENU = "lay-top-menu", LAYSIDESHRINK = "layadmin-side-shrink"
        , LAYSIDESPREAD = "layadmin-side-spread-sm", ICONSHRINKRIGHT = "layui-icon-shrink-right", ICONSPREADLEFT = "layui-icon-spread-left", STR_EMPTY = ''
        , BODYSHADE = "<div class=\"layadmin-body-shade\" sa-event=\"shade\"><\/div>", BODYSHADECLASS = ".layadmin-body-shade", LAYERCONTENT = ".layui-layer-content";

    // 对象初始化
    var admin = {
        options: {
            tplName: 'swiftadmin',      // 数据标识
            version: '1.1.0',           // 版本
            moreLabel: true,            // 是否开启多标签
            cacheTab: true,             // 缓存多标签
            maxTabNum: 20,              // 最大打开标签
            TabLists: [],               // 标签缓存
            style: 'dark',              // 样式
            theme: 'blue',              // 皮肤
            layout: 'left',             // 布局操作 // top // 混合模式这三种就行了 // 然后还需要判断，当前是否需要左侧菜单
            fluid: true,                // 是否内容铺满
            openHeader: true,
            openFooter: true,

        },
        getSpinningHtml: function () {
            return ['<div id="loading">',
                '<div class="loader">',
                '<div class="ant-spin ant-spin-spinning" >',
                '<span class="ant-spin-dot ant-spin-dot-spin">',
                '<i class="ant-spin-dot-item"></i>',
                '<i class="ant-spin-dot-item"></i>',
                '<i class="ant-spin-dot-item"></i>',
                '<i class="ant-spin-dot-item"></i>',
                ' </span></div></div></div>'].join('');
        },
        // 展现动画
        showLoading: function (obj) {
            /**
             * 动态增加查询动画
             */
            var html = admin.getSpinningHtml();
            var exist = $(obj).children('#loading');
            if (exist.length <= 0) {
                $(obj).append(html);
            } else {
                exist.show();
            }

        },
        // 移除动画
        removeLoading: function (obj) {
            (typeof (obj) === undefined) && (obj = "body");
            if (obj == 'master') {

                var master = $(LAYOUTBODY).children("#loading");
                master && master.fadeOut(800);

                // 兼容IE
                master && master.remove();
                $(LAYOUTADMIN).show(300);

            } else {
                $(obj).next("#loading").fadeOut(800);
            }
        },
        setConfig: function (key, value) {
            var tplName = admin.options.tplName + '_session';
            if (value != null && value !== "undefined") {
                layui.sessionData(tplName, {
                    key: key,
                    value: value
                })
            } else {
                layui.sessionData(tplName, {
                    key: key,
                    remove: true
                })
            }
        },
        getConfig: function (key) {
            var tplName = admin.options.tplName + '_session';
            var array = layui.sessionData(tplName);
            if (array) {
                return array[key]
            } else {
                return false
            }
        }
        , setStorage: function (key, value) {
            var tplName = admin.options.tplName + '_system';
            if (value != null && value !== "undefined") {
                layui.data(tplName, {
                    key: key,
                    value: value
                })
            } else {
                layui.data(tplName, {
                    key: key,
                    remove: true
                })
            }
        },
        getStorage: function (key) {
            var tplName = admin.options.tplName + '_system';
            var array = layui.data(tplName);
            if (array) {
                return array[key]
            } else {
                return false
            }
        }
        , setBreadHtml: function () {

            // 设置面包屑导航
            var b = '<div class="layui-breadcrumb-header layui-breadcrumb" lay-separator="/">';
            b += '      <a lay-href="#">' + '主页' + '</a>';
            b += '      <span class="breadcrumb">';
            b += '          <a lay-href="#">Dashboard</a>';
            b += '      </span>';
            b += "   </div>";

            // 加入节点
            if ($('.layui-breadcrumb-header').length <= 0) {
                $('.layui-nav-head').before(b);
                $('.layui-nav-head').hide();
            }

            if (admin.screen() < 2) {
                $('.layui-breadcrumb-header').hide();
            }
        }
        , setBreadcrumb: function (urls, title) {

            var text = STR_EMPTY,
                current = $('.layui-nav-tree li [lay-href="' + urls + '"]');
            var bread = $(current).parents().find('.layui-nav-item');
            for (var i = 0; i < bread.length; i++) {

                var elem = $(bread[i]).find('[lay-href="' + urls + '"]');
                if (elem.length) {
                    var name = $(bread[i]).find('a:first').text();
                    text += '<a lay-href="#" >' + name + '</a><span lay-separator="">/</span>';
                }
            }
            // 自身的标题
            text += '<a lay-href="' + urls + '">' + title + '</a>';
            $('.breadcrumb').html(text);

        },
        fullScreen: function () { //全屏
            var ele = document.documentElement
                , reqFullScreen = ele.requestFullScreen || ele.webkitRequestFullScreen || ele.mozRequestFullScreen || ele.msRequestFullscreen;
            if (typeof reqFullScreen !== 'undefined' && reqFullScreen) {
                reqFullScreen.call(ele);
            };
        },
        exitScreen: function () { //退出全屏
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
        /**
         * 窗口移动设置 偏移量
         */
        , rollPage: function (type, index) {
            var o = $(TABS + ">.layui-tab-title");
            var p = o.scrollLeft();
            if ("left" === type) {
                o.animate({
                    "scrollLeft": p - 120
                }, 100)
            } else {
                if ("auto" === type) {
                    var n = 0;
                    o.children("li").each(function () {
                        if ($(this).hasClass("layui-this")) {
                            return false
                        } else {
                            n += $(this).outerWidth()
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
        , refresh: function (id) {
            if (id == null || id == undefined) {
                return false
            }

            // 单页面形式
            if (!admin.options.moreLabel) {
                var iframe = $('iframe[lay-id="' + id + '"]');
                $('#loading').show();
                return iframe[0].contentWindow.location.reload(true);
            }

            var iframe = $(TABS + " .layui-tab-item").find("iframe");
            for (let i = 0; i < iframe.length; i++) {
                var layid = $(iframe[i]).attr('lay-id');
                if (layid == id) {
                    iframe[i].contentWindow.location.reload(true);
                    $(iframe[i]).next("#loading").css({ 'overflow': 'hidden', 'display': "block" });
                }
            }

        }
        , globalStyleCss: function () {
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
        , setTheme: function () { // 设置皮肤函数
            var theme = admin.getStorage('theme') || admin.options.theme;
            if (admin.getStorage('moreLabel')) {
                var iframe = top.layui.$(TABS + " .layui-tab-item").find("iframe");
                for (let i = 0; i < iframe.length; i++) {
                    $(iframe[i]).contents().find('body').attr('id', theme);
                }
            }
            else {
                top.layui.$('iframe').contents().find('body').attr('id', theme);
            }

            // 给自身样式
            top.layui.$('body').attr('id', theme);
        }
        , setlayFluid: function () {

            var fluid = admin.getStorage('fluid'),
                fixedStyle = '<style id="lay-fluid">.layui-fluid{max-width:1200px;}</style>';

            if (typeof fluid == 'undefined') {
                fluid = admin.options.fluid;
            }

            // 多标签
            if (admin.options.moreLabel) {
                var iframe = top.layui.$(TABS + " .layui-tab-item").find("iframe");
                for (let i = 0; i < iframe.length; i++) {

                    if (fluid !== false) {
                        $(iframe[i]).contents().find('#lay-fluid').remove();
                    } else {
                        if ($(iframe[i]).contents().find('head').find('#lay-fluid').length <= 0) {
                            $(iframe[i]).contents().find('head').append(fixedStyle);
                        }
                    }
                }
            }
            else {

                if (fluid !== false) {
                    top.layui.$('iframe').contents().find('#lay-fluid').remove();
                } else {
                    if ($(iframe[i]).contents().find('head').find('#lay-fluid').length <= 0) {
                        top.layui.$('iframe').contents().find('head').append(fixedStyle);
                    }
                }
            }

        }
        , setDropStyle: function () {
            var dropstyle = admin.getStorage('dropstyle');
            if (typeof dropstyle !== "undefined") {
                top.layui.$(".layui-nav-tree").removeClass('arrow1 arrow2 arrow3');
                top.layui.$(".layui-nav-tree").addClass(dropstyle);
            }
        }
        , setPageHeaderFooter: function (type = 'header') {

            if (type == 'header') {
                console.log(type);
                var openHeader = admin.getStorage('openHeader');
                if (openHeader === false) { // 移除
                    top.layui.$('.layui-header,.layui-logo').hide();
                    top.layui.$('.layui-nav-tree,.layui-body').css({
                        "top": "0px",
                        "margin-top": "0px"
                    });
                } else if (openHeader === true) { // 还原回来
                    top.layui.$('.layui-header,.layui-logo').show();
                    top.layui.$('.layui-nav-tree').css("margin-top", "60px");
                    top.layui.$('.layui-body').css("top", "50px");
                }

            } else {
                var openFooter = admin.getStorage('openFooter');
                if (openFooter === false) { // 移除
                    top.layui.$('.layui-footer').hide();
                } else if (openFooter === true) { // 显示
                    top.layui.$('.layui-footer').show();
                }
            }
        }
        , changeI18n: function (type) {
            i18n.render(type);
        }
        , screen: function () {
            var width = $(window).width()
            if (width > 1200) {
                return 3; //大屏幕
            } else if (width > 992) {
                return 2; //中屏幕
            } else if (width > 768) {
                return 1; //小屏幕
            } else {
                return 0; //超小屏幕
            }
        },
        flexible: function (status) {

            var app = $(LAYOUTBODY),
                iconElem = $('#' + FLEXIBLEID);
            var screen = admin.screen();
            if (status) {
                iconElem.removeClass(ICONSPREADLEFT).addClass(ICONSHRINKRIGHT);
                if (screen < 2) {
                    app.addClass(LAYSIDESPREAD);
                } else {
                    app.removeClass(LAYSIDESPREAD);
                }
                app.removeClass(LAYSIDESHRINK);
                // 增加移动端遮罩层
                if ($(BODYSHADECLASS).length <= 0) {
                    $(LAYOUTADMIN).append(BODYSHADE);
                }
            }
            // 关闭侧边栏
            else {
                iconElem.removeClass(ICONSHRINKRIGHT).addClass(ICONSPREADLEFT);
                if (screen < 2) { // 手机版默认移除
                    app.removeClass(LAYSIDESHRINK);
                } else { // 电脑版添加这个CLASS 向左width 60px;
                    app.addClass(LAYSIDESHRINK);
                }
                // 移除多余的
                app.removeClass(LAYSIDESPREAD) // layadmin-side-shrink layadmin-side-spread-sm
                $(LAYOUTADMIN).removeClass(BODYSHADE);
            }
        }

    };

    // 工具函数
    admin.utils = {
        // 获取文件图标
        filesuffix: function (url, leng = 6) {
            if (typeof url != 'undefined') {

                var suffix = url.substring(url.lastIndexOf('.') + 1, url.length);
                if (suffix.length >= length) {
                    suffix.substring(0, length);
                }

                var char = [];
                for (const i in suffix) {
                    if (i >= 3) {
                        char[i - 3] += suffix[i].charCodeAt();
                    } else {
                        char[i] = suffix[i].charCodeAt();
                    }
                }
                var svg = [
                    '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">',
                    '<path style="fill:#E2E5E7;" d="M128,0c-17.6,0-32,14.4-32,32v448c0,17.6,14.4,32,32,32h320c17.6,0,32-14.4,32-32V128L352,0H128z"/>',
                    '<path style="fill:#B0B7BD;" d="M384,128h96L352,0v96C352,113.6,366.4,128,384,128z"/>',
                    '<polygon style="fill:#CAD1D8;" points="480,224 384,128 480,128 "/>',
                    '<path style="fill:rgb(' + char.join(',') + ');" d="M416,416c0,8.8-7.2,16-16,16H48c-8.8,0-16-7.2-16-16V256c0-8.8,7.2-16,16-16h352c8.8,0,16,7.2,16,16 V416z"/>',
                    '<path style="fill:#CAD1D8;" d="M400,432H96v16h304c8.8,0,16-7.2,16-16v-16C416,424.8,408.8,432,400,432z"/>',
                    '<g><text><tspan x="220" y="380" font-size="124" font-family="Verdana, Helvetica, Arial, sans-serif" fill="white" text-anchor="middle">' + suffix + '</tspan></text></g>',
                    '</svg>',
                ].join('');

                return 'data:image/svg+xml;base64,' + window.btoa(svg);
            }
        }
        , escape: function (html) {
            return String(html || '').replace(/&(?!#?[a-zA-Z0-9]+;)/g, '&amp;')
                .replace(/</g, '&lt;').replace(/>/g, '&gt;')
                .replace(/'/g, '&#39;').replace(/"/g, '&quot;');
        }
        , getPath: function () {
            var jsPath = document.currentScript ? document.currentScript.src : function () {
                var js = document.scripts
                    , last = js.length - 1
                    , src;
                for (var i = last; i > 0; i--) {
                    if (js[i].readyState === 'interactive') {
                        src = js[i].src;
                        break;
                    }
                }
                return src || js[last].src;
            }();
            return jsPath.substring(0, jsPath.lastIndexOf('/') + 1);
        }
    }

    // 定义全局事件
    admin.event = {
        flexible: function () {
            var iconElem = $('#' + FLEXIBLEID);
            var spread = iconElem.hasClass(ICONSPREADLEFT);
            admin.flexible(spread ? 'open' : null);
        },
        shade: function () { // 移动端遮罩层点击
            admin.flexible();
        },
        refresh: function () {
            admin.refresh(admin.getConfig("activeTab"));
        },
        back: function () { // 后退的函数

        },
        theme: function () {
            var n = $(this).data("url");
            admin.event.popupRight({
                id: "layer-theme",
                type: 2,
                content: n
            })
        },
        message: function () {
            var that = $(this),
                n = that.data("url");
            admin.event.flowOpen({
                id: "layer-msg",
                type: 2,
                // title: "🔔  消息提醒",
                area: ["336px", "390px"],
                content: n
            }, that)
        },
        pwd: function () {
            var n = $(this).data("url");
            admin.event.pupupOpen({
                id: "layer-pwd",
                type: 2,
                shade: 0,
                title: "🔑  修改密码",
                area: ["385px", "295px"],
                content: n
            })
        },
        clear: function () {
        }
        , logout: function (res) {
            var href = $(this).data("url");
            layui.layer.confirm("确定要退出登录吗？", {
                title: '提示',
            }, function () {
                location.replace(href)
            })
        }
        , flowOpen: function (n, that) {

            if (typeof that === "undefined") {
                return layer.msg(i18n.prop('this undefined'), 'info');
            }

            var elemWidth = 0, client = that[0].getBoundingClientRect();

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
            } else {
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
                n.offset = [top, left];
            }

            return layer.open(n);
        }
        , pupupOpen: function (n) {

            if (n.title == undefined) {
                n.title = false;
                n.closeBtn = false
            }
            if (!n.offset) {
                if ($(window).width() < 768) {
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
        , pupupTop: function (n) {
            n = admin.event.popupAnim(n);
            n.offset = n.offset || (n.offset = "t");
            return admin.event.pupupOpen(n)
        }
        , pupupDown: function (n) {
            n = admin.event.popupAnim(n);
            n.offset = n.offset || (n.offset = "d");
            return admin.event.pupupOpen(n)
        }
        , pupupLeft: function (n) {
            n = admin.event.popupAnim(n);
            n.offset = n.offset || (n.offset = "l");
            return admin.event.pupupOpen(n)
        }
        , popupRight: function (n) {
            n = admin.event.popupAnim(n);
            n.offset = n.offset || (n.offset = "r");
            return admin.event.pupupOpen(n)
        }
        , popupAnim: function (n) {
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
        , fullscreen: function (res) {
            var SCREEN_FULL = 'layui-icon-screen-full'
                , SCREEN_REST = 'layui-icon-screen-restore'
                , iconElem = res.children("i");
            if (iconElem.hasClass(SCREEN_FULL)) {
                iconElem.addClass(SCREEN_REST).removeClass(SCREEN_FULL);
                admin.fullScreen();
            } else {
                admin.exitScreen();
                iconElem.addClass(SCREEN_FULL).removeClass(SCREEN_REST);
            }
        }
        , leftPage: function () {
            admin.rollPage('left');
        }
        , rightPage: function () {
            admin.rollPage();
        }
        , tabs: function () {

            var url = $(this).data("url");
            var title = $(this).data("title");
            title || (title = $(this).text());
            if (top.layui && top.layui.admin) {
                top.layui.admin.createElementTabs({
                    id: url,
                    title: title ? title : "",
                    url: url
                })
            } else {
                location.href = url
            }
        }
        , closeThisTabs: function (id) { // 关闭当前，关闭的是当前活动的选项卡

            if (id != null && typeof (id) == 'object') {
                id = admin.getConfig('activeTab');
            }

            if (admin.options.TabLists[0].id == id) {
                layer.msg(i18n.prop('Plase Close HomePage', 'info'));
                return false;
            }

            element.tabDelete(TABFILTER, id);
        },
        closeOtherTabs: function (id) {

            if (id != null && typeof (id) == 'object') {
                id = admin.getConfig('activeTab')
            }
            // 倒序删除
            var TabLists = admin.options.TabLists;
            var length = TabLists.length - 1;
            for (; length >= 1; length--) {
                if (TabLists[length].id != id) {
                    element.tabDelete(TABFILTER, TabLists[length].id);
                }
            }

            admin.setConfig("activeTab", id);
        },
        closeAllTabs: function () {
            var TabLists = admin.options.TabLists;
            var length = TabLists.length - 1;
            for (; length >= 1; length--) {
                element.tabDelete(TABFILTER, TabLists[length].id);
            }
        },
        closeDialog: function (that) {
            var _type = $(that).parents(".layui-layer").attr("type");

            if (typeof _type === "undefined") {
                parent.layer.close(parent.layer.getFrameIndex(window.name));
            } else {
                var o = $(that).parents(".layui-layer").attr("id").substring(11);
                layer.close(o);
            }
        }
        , closePageDialog: function () {
            admin.event.closeDialog(this);
        }
        , ajax: function (url, data, async = false) { 
            var result = [];
            $.ajax({
                url: url,   
                type: "post",
                data: data,
                async: async, 
                success: function (res) {
                    result = res;
                }
            });

            try {
                return typeof (result) !== "object" ? JSON.parse(result) : result;
            } catch (error) {
                console.error('result not JSON');
            }
        }

        // 打开面板
        , open: function (clickObj, tableThis, mergeOptions) {

            // 初始化数据
            var options = {
                url: admin._validauthURL(clickObj),
                type: clickObj.data('type') || 2,
                area: clickObj.data('area') || "auto",
                offset: clickObj.data('offset') || false,
                title: clickObj.data('title') || false,
                maxmin: clickObj.data('maxmin') || false,
                auto: clickObj.data('auto') || undefined,
                scrollbar: clickObj.data('scrollbar') || undefined,
                disableform: clickObj.data('disable') || false,
                callback: clickObj.attr('callback') || undefined,
            };


            // 获取地址
            options.id = options.url.replace(/[^0-9|a-z|A-Z]/i, '');
            options.url = options.url.replace(/\s+/g, '');

            // 截取首个字符串
            var firstURL = options.url.substring(0, 1);
            if (firstURL && firstURL == '#') {
                options.type = 1;
                options.url = $(options.url).html();
                if (typeof tableThis !== 'undefined') {
                    var htmls = $(options.url);
                    $(htmls).find('*[data-disabled]').addClass('layui-disabled').attr('disabled', '');
                    options.url = htmls.prop("outerHTML");
                }
            } else {
                // options.url = [options.url, 'no'];
                options.url = options.url
            }

            // 计算窗口偏移
            if (options.offset == false && options.area !== "auto") {

                var height = options.area.split(',');
                if (typeof height[1] != 'undefined') {
                    height = height[1];
                    var offsetHeight = document.documentElement.clientHeight;
                    if (height.indexOf('px') !== -1) {
                        height = parseInt(height);
                    } else {
                        height = parseInt(height);
                        height = offsetHeight * (height / 100);
                    }

                    if (height >= offsetHeight) {
                        options.offset = 0;
                    }
                    else {
                        options.offset = (offsetHeight - height) / 3;
                    }
                }

            } else {
                options.offset = options.offset || '15%';
            }

            // 当前窗口大小
            (options.area !== "auto") && (options.area = options.area.split(','));
            if (options.area !== "auto" && options.area[0] == '100%') {
                options.offset = 0;
                if (typeof options.url == 'object') {
                    options.url = options.url[0];
                }
            }


            // mergeOptions用于覆盖
            (typeof (mergeOptions) !== "undefined") && (options = $.extend(options, mergeOptions));

            layer.open({
                type: options.type,
                area: options.area,
                title: options.title,
                offset: options.offset,
                maxmin: options.maxmin,
                shadeClose: false,
                scrollbar: false,
                content: options.url,
                success: function (layero, index) {

                    if (options.type <= 1) {

                        options.area == 'auto' && layer.iframeAuto(index);
                        $(layero).children(LAYERCONTENT).css("overflow", "visible");
                        if (typeof tableThis !== 'undefined') {
                            form.val(options.id, tableThis.data);
                        }

                        // 渲染其他组件
                        const components = admin.components;
                        for (const key in components) {
                            if (options.url.match('lay-' + key)) {
                                eval(components[key])();
                            }
                        }

                        form.render();

                        // 是否存在回调函数
                        if (typeof options.callback != 'undefined') {
                            return admin.callbackfunc(clickObj, { tableThis: tableThis, layero: layero, index: index });
                        }

                        // 开始执行监听
                        form.on("submit(submitPage)", function (post) {

                            var othat = $(this),
                                postUrl = $(othat).parents('form').attr('action');

                            var action = !tableThis ? 'add' : 'edit';
                            if (!postUrl) {
                                postUrl = othat.attr('lay-' + action);
                            }

                            // 默认为添加编辑方法
                            if (typeof postUrl == 'undefined') {
                                postUrl = _fr4mework.app + '/' + _fr4mework.controller + '/' + action;
                            }



                            // 防止快速点击
                            othat.attr("disabled",true);

                            // 开始POST提交数据
                            $.post(postUrl,
                                post.field, function (res) {

                                    for (var elem in post.field) {
                                        var lay = $(clickObj).parents("tr").find('*[data-field=' + elem + ']').find('*[lay-skin]');
                                        if (lay.length !== 0) {
                                            delete post.field[elem];
                                        }
                                    }

                                    if (res.code == 200) {
                                        tableThis ?
                                            tableThis.update(JSON.parse(JSON.stringify(post.field))) :
                                            table.reload("lay-tableList");
                                        layer.msg(res.msg);
                                        admin.event.closeDialog(othat);
                                    }
                                    else {

                                        layer.error(res.msg)
                                        othat.attr("disabled", false);
                                    }

                                }, 'json');


                            return false;
                        })

                    }

                }
            })
        }
        , request: function (clickObj, reqData, callback, merge) {

            // 当前选项
            var options = {
                url: admin._validauthURL(clickObj),
                type: clickObj.data('type') || 'post',
                dataType: clickObj.data('dataType') || 'json',
                timeout: clickObj.data('timeout') || '6000',
                confirm: clickObj.data('confirm'),
                tableId: clickObj.data('table') || clickObj.attr('batch'),
                async: clickObj.data('async') || true // 默认异步调用
            }

            // 发送实体函数
            var reqSend = function (options) {

                // 合并数据
                if (typeof merge !== 'undefiend') {
                    options = $.extend({}, options, merge);
                }

                $.ajax({
                    url: options.url,
                    type: options.type,
                    dataType: options.dataType,
                    timeout: options.timeout,
                    data: reqData,
                    async: options.async,
                    success: function (res) {

                        if (res.code == 200) {

                            // 如果存在 - 回调函数成功
                            if (typeof callback !== 'undefined'
                                && typeof callback.success === 'function') {
                                return callback.success(res);
                            }

                            if (typeof (options.tableId) !== "undefined") {
                                table.reload(options.tableId);
                            }

                            layer.msg(res.msg);
                        }
                        else {

                            // 如果存在 - 回调函数错误
                            if (typeof callback !== 'undefined'
                                && typeof callback.error === 'function') {
                                return callback.error(res);
                            }

                            layer.error(res.msg);
                        }
                    },
                    error: function (res) {
                        layer.msg(i18n.prop('Access methods failure'), 'error');
                    }
                })

                return options;
            }

            // 是否执行确认操作
            if (options.confirm !== undefined) {

                options.confirm = options.confirm || '确定执行此操作吗?';
                layer.confirm(options.confirm, function (index) {

                    layer.close(index);
                    return reqSend(options);

                }, function (index) {
                    layer.close(index);
                    return false;
                })

            } else {
                return reqSend(options);
            }
        }
    }

    /**
     * 全局回调函数
     * @param {*} clickThis 
     * @param {*} collection 
     * @param {*} before 
     * @returns 
     */
    admin.callback = {};
    admin.callbackfunc = function (clickThis, collection, before) {
        let funcObj = before ? clickThis.attr('callbefore') : clickThis.attr('callback');
        if (typeof funcObj != 'undefined') {
            funcObj = 'admin.callback.' + funcObj;
            if (typeof eval(funcObj) === "function") {
                return eval(funcObj)(clickThis, collection);
            } else {
                layer.msg(i18n.prop('callback error'), 'error');
                return false;
            }
        }
    }

    /**
     * 鉴权函数
     * @param {*} othis 
     */
    admin._validauthURL = function (othis, make) {

        var curl = $(othis).attr('data-url');
        if (typeof curl == 'undefined') {
            layer.msg(i18n.prop('url undefined'), 'error');
            throw 'lay-ajax url undefined';
        }

        // 在当前APP里才执行鉴权
        if (curl.indexOf(_fr4mework.app) !== -1) {

            var route = curl.replace('.html', '');
            route = route.substring(1);
            var main = route.substring(0, route.indexOf('/'));
            if (route.indexOf('.php') != -1) {
                main = route.replace(main, '').substring(1);
                main = main.substring(0, main.indexOf('/'));
            }

            // 查找方法
            var action = route.substring(route.indexOf(main) + main.length + 1);
            if (action.indexOf('/') !== -1) {
                action = action.substring(0, action.indexOf('/'))
            } else if (action.indexOf('?') !== -1) {
                action = action.substring(0, action.indexOf('?'))
            }

            // 拼接路由节点
            route = main + ':' + action;

            // 递归查询权限节点
            var status, recursive = function (elem) {
                for (let i in elem) {
                    var n = elem[i];
                    if (route == n.alias) {
                        status = true;
                    }

                    if (typeof n.children !== undefined) {
                        recursive(n.children);
                    }
                }

                return status ? status : false;
            }

            var router = admin.getConfig('router');
            if (!router.supersadmin  // 非超级管理员
                && curl.indexOf('://') === -1 && !recursive(router._admin_auth_menus_)) {
                layer.msg(i18n.prop('无权操作'), 'error');
                throw '没有权限';
            }
        }

        return curl;
    }

    /**
     * 全局渲染组件
     */
    admin.components = {
        datetime: function (params) {
            /**
             * 时间控件
             * 1、lay-datetime 参数 默认留空即可，layui自动绑定到了元素 自动赋值
             */
            var datetime = $('*[lay-datetime]');
            datetime.each(function (key, obj) {
                var t = $(obj).data('datetype') || 'datetime',
                f = $(obj).data('dateformat') || 'yyyy-MM-dd HH:mm:ss',//格式需要按照laydate的格式
                    val = $(obj).val() || '',//获取value值
                    r = $(obj).data('range') || false,
                    max = $(obj).data('maxvalue') || '2222-12-31',
                    min = $(obj).data('minvalue') || '1930-01-01';

                laydate.render({
                    elem: this
                    , type: t
                    , range: r
                    , max: max
                    , min: min
                    , value:val
                    , format: f
                    , done: function (value, date, end_date) {
                        console.log(value, date, end_date);
                    }
                });
            })
        },
        slider: function (params) {
            /**
             * 滑块组件
             */
            layui.each($("*[lay-slider]"), function (key, elem) {

                var that = $(this),
                    type = that.data('type') || 'default',
                    min = that.data('min') || 0,
                    max = that.data('max') || 100,
                    theme = that.data('theme') || '#1890ff',
                    step = that.data('step') || 1,
                    input = that.data('input') || false,
                    showstep = that.data('showstep') || false;

                // 获取滑块默认值
                var name = $(elem).attr("lay-slider");
                var value = $('input[name=' + name + ']').val() || that.data('default');

                slider.render({
                    elem: elem
                    , type: type
                    , min: min
                    , max: max
                    , step: step
                    , showstep: showstep
                    , theme: theme
                    , input: input
                    , value: value
                    , change: function (value) {

                        if (value <= min || isNaN(value)) {
                            value = min;
                        }

                        $('input[name=' + name + ']').val(value);
                    }
                })
            })
        },
        rate: function (params) {
            /**
             * 星星组件 / 默认访问参数 为GET
             * 1、lay-rate 必填参数 list|ones 列表还是单个
             * 2、data-url  必填参数 点击进行GET的地址
             * 3、data-object  必填参数 进行修改的对象ID
             * 4、data-value 必填参数 渲染时使用的原始星星
             * 5、data-theme  颜色
             * 6、data-readonly 是否只是展示，
             */
            layui.each($("*[lay-rate]"), function (index, elem) {
                var that = $(this),
                    url = that.data("url") || undefined,
                    ids = that.data('ids') || undefined,
                    theme = that.data('theme') || '#1890ff',
                    length = that.data('length') || 5,
                    half = that.data('half') || false,
                    readonly = that.data('readonly') || false;

                // 这种的初始值应该有两个地方，
                // 一个是当前星星的值用来去获取，一个是另外的
                // 
                var name = $(elem).attr("lay-rate");
                var el = $('.' + name);
                var value = el.val() || that.data('value');

                rate.render({
                    elem: elem
                    , half: half
                    , length: length
                    , theme: theme
                    , readonly: readonly
                    , value: value
                    , choose: function (value) {

                        // 如果当前存在URL则进行AJAX处理
                        if (typeof url != 'undefined') {

                            // 执行AJAX的操作
                            // id: ids,
                            // stars: value
                            // 后续再加

                        } else {
                            el.val(value);
                        }
                    }
                })
            })
        },
        tips: function (params) {
            /**
             * 监听消息提示事件
             */
            $(document).on("mouseenter", "*[lay-tips]", function () {
                var remind = $(this).attr("lay-tips");
                var tips = $(this).data("offset") || 1;
                var color = $(this).data("color") || '#000';
                layer.tips(remind, this, {
                    time: -1,
                    tips: [tips, color],
                    area: ['auto', 'auto'],
                });
            }).on("mouseleave", "*[lay-tips]", function () {
                layer.closeAll("tips");
            });
        },
        colorpicker: function (params) {
            /**
             * 颜色选择器控件
             * lay-colorpicker 填写的数据为是哪一个类
             * data-value 初始化的颜色，自己从数据库获取，必填参数
             */
            var picker = $('*[lay-colorpicker]');
            picker.each(function (index, elem) {
                var name = $(elem).attr("lay-colorpicker");
                var color = $('.' + name).val() || $(name).data('value');
                colorpicker.render({
                    elem: this
                    , color: color
                    , predefine: true
                    , alpha: true
                    , done: function (e) {
                        $('.' + name).val(e);
                    }
                });
            })
        },
        upload: function (params) {

            layui.each($('*[lay-upload]'), function (index, elem) {

                var that = $(this),
                    name = $(elem).attr('lay-upload') || undefined,
                    url = $(elem).data('url') || _fr4mework.app + '/upload/file',
                    type = $(elem).data('type') || 'normal',
                    size = $(elem).data('size') || 102400,
                    accept = $(elem).data('accept') || 'file',
                    callback = $(elem).attr('callback') || undefined;

                // 文件上传函数
                var uploadFiles = {
                    normal: function (res, name) {
                        $('input.' + name).prop('value', res.url);
                        $('img.' + name).prop('src', res.url);
                        // $('input[name="'+name+'"]').next('img').prop('src',res.url);
                    },
                    images: function (res, name) {
                        var o = $('img.' + name);
                        o.prop('src', res.url);
                        o.parent('div').removeClass('layui-hide');
                        $('input.' + name).val(res.url);
                        console.log($('input.' + name).val());
                        // $('input.'+name).remove();
                        $(elem).find('p,i,hr').addClass('layui-hide');
                    },
                    multiple: function (res, name) {

                        var index = $('.layui-imagesbox .layui-input-inline');
                        index = index.length ? index.length - 1 : 0;
                        console.log(index);
                        var html = '<div class="layui-input-inline">';
                        html += '<img src="' + res.url + '" >';
                        html += '<input type="text" name="' + name + '[' + index + '][src]" class="layui-hide" value="' + res.url + '">';
                        html += '<input type="text" name="' + name + '[' + index + '][title]" class="layui-input" placeholder="图片简介">';
                        html += '<span class="layui-badge layui-badge-red" onclick="layui.$(this).parent().remove();">删除</span></div>';
                        $(elem).parent().before(html);

                    }
                }

                // 执行上传操作
                layui.upload.render({
                    elem: elem
                    , url: url
                    , method: 'post'
                    , size: size
                    , accept: accept
                    , before: function (res) {
                        // 关闭按钮点击
                        that.prop("disabled", true);

                    }, done: function (res, index, upload) {

                        that.prop("disabled", false);

                        // 是否存在回调
                        if (typeof callback != 'undefined') {
                            return admin.callbackfunc(this.item, { res: res, index: index, upload: upload });
                        }

                        if (res.code == 200) {
                            uploadFiles[type](res, name);
                        }
                        else {
                            // 错误消息
                            layer.error(res.msg);
                        }
                    }
                })

            })
        },
        cascader: function (el) {
            var elObj = [];
            el = el || "input[lay-cascader]";
            layui.each($(el), function (index, elem) {

                var value = $(elem).val();
                var name = $(elem).attr('name');
                var propsValue = $(elem).data('value') || 'value';
                var parents = $(elem).data('parents') || false;

                if (typeof value != 'undefined' && value) {
                    value = value.split('/');
                    value = value[value.length - 1];
                    value = $.trim(value);
                }

                elObj[index] = cascader({
                    elem: elem,
                    value: value,
                    clearable: true,
                    filterable: true,
                    showAllLevels: parents,
                    props: {
                        value: propsValue
                    },
                    options: cascader_data
                });

                elObj[index].changeEvent(function (value, node) {

                    if (node != null) {
                        if (parents) {
                            var arrpath = [];

                            for (const key in node.path) {
                                var path = node.path[key].data;
                                arrpath.push($.trim(path[propsValue]));
                            }
                            $('#' + name).val(arrpath.join('/'));
                        } else {

                            $(elem).val(node.data[propsValue]);

                        }
                    }
                    else {
                        $(elem).val('');
                    }
                });
            })
        },
        content: function (params) {
            layui.each($("textarea[lay-editor]"), function (index, elem) {

                var id = $(elem).attr('id');
                if (typeof id == 'undefined' || !id) {
                    // 插入一个ID
                    id = 'Matheditor_' + Math.round(Math.random() * 36);
                    $(elem).prop('id', id);
                }
                content.tinymce(id);
            })
        },
        tags: function (params) {
            layui.each($('.layui-tags'), function (i, e) {
                $(e).remove();
            })

            layui.each($('*[lay-tags]'), function (index, elem) {
                var isTags = layui.tags.render({
                    elem: elem,
                    url: '/ajax/getTags',
                    done: function (key, all) { }
                });
            })
        },
    }

    // 国际化
    i18n.render(admin.getStorage('language') || 'zh-CN');

    // 执行组件渲染
    for (const key in admin.components) {
        eval(admin.components[key])();
    }

    // 初始化皮肤
    admin.setTheme();

    // 内嵌风格
    admin.getStorage('style') === 'light' && $('head').append(admin.globalStyleCss());

    // 清除拖拽上传
    $(document).on('click', function () {
        $('span.layui-upload-clear').on('click', function (event) {
            event = event || window.event;
            event.stopPropagation();
            event.preventDefault();
            $(this).parents('.layui-upload-drag').find('i,p,hr').removeClass('layui-hide');
            $(this).parents('.layui-upload-drag').find('div').addClass('layui-hide');
            $(this).parents('.layui-upload-drag').find('input').prop('value', '');
        })
    })

    // JSON组件点击
    $('body').on('click', '.layui-jsonvar-add', function (e) {
        e.stopPropagation();
        e.preventDefault();
        var html = '<tr>';
        html += '<td><input type="text" class="layui-input" name="' + $(this).data('name') + '[key][]"></td>';
        html += '<td><input type="text" class="layui-input" name="' + $(this).data('name') + '[value][]"></td>';
        html += '<td><i class="layui-icon fa-times" onclick="layui.$(this).parents(\'tr\').remove();" ></i></td>';
        html += '</tr>';
        $(this).prev('table').find('tbody').append(html);
    })

    /*
     * 监听全局radio选择器
     */
    form.on('radio(radioStatus)', function (data) {
        var display = $(this).data('display');
        if (display != null && display !== 'undefined') {
            (data.value == 1) ? $('.' + display).show() : $('.' + display).hide();
        }
    })

    /**
     * 监听select过滤器
     */
    form.on('select(selectStatus)', function (data) {

        var select = $(this).parents().prev('select'),
            display = select.data('display'),
            disable = select.data('disable'),
            selector = select.data('selector');

        if (typeof (selector) == 'undefined' || selector == null) {

            // 第一种情况
            if (typeof (display) != 'undefined' && typeof (disable) == 'undefined') {
                (data.value == 1) ? $('.' + display).show() : $('.' + display).hide();
            }

            // 第二种情况
            if (typeof (display) != 'undefined' && typeof (disable) != 'undefined') {
                (data.value == disable) ? $('.' + display).hide() : $('.' + display).show();
            }
        }
        else { // 第三种情况 * demo file,class,oss
            selector = selector.replace('，', ',').split(',');
            for (let i in selector) {
                (data.value !== selector[i]) ? $('.' + selector[i]).hide() : $('.' + selector[i]).show();
            }
        }
    })

    /**
     * 监听switch点击状态
     */
    form.on('switch(switchStatus)', function (obj) {

        var that = $(this)
            , callback = {
                // 远程回调
                error: function (res) {
                    $(obj.elem).prop('checked', !obj.elem.checked);
                    layer.error(res.msg);
                    form.render('checkbox');
                }
            }
            , data = {
                id: $(this).attr('value'),
                status: obj.elem.checked ? 1 : 0
            };

        if ($('.bubble').length) {
            $('.bubble').removeClass('bubble');
            return false;
        }

        admin.event.request(that, data, callback);
    });

    /**
     * 监听form表单提交
     */
    form.on('submit(submitIframe)', function (data) {

        /**
         * 默认从action查找，没找到则说明是增删改查，
         * 则从控制器进行数据控制
         */
        var that = $(this), _form = that.parents('form'),
            _url = _form.attr("action") || false;

        if (_url === false || _url === '') {
            try {
                var app = _fr4mework.app;
                var action = _fr4mework.action;
                var controller = _fr4mework.controller;
                _url = app + '/' + controller + '/' + action;
            } catch (error) {
                console.warn(error);
            }
        }

        if (typeof _url === 'undefined') {
            layer.msg(i18n.prop('remote url undefined!'), 'error');
            return false;
        }

        // 默认是否重载父页面
        var _parent = that.data('reload') || false;

        // 禁用按钮
        that.attr("disabled", true);

        // 进行表单提交！
        $.post(_url, data.field, function (res) {

            if (res.code == 200) {

                top.layer.msg(res.msg);
                admin.event.closeDialog(that);

                // 默认重载父页面
                if (_parent !== false && parent.window != top) {
                    parent.location.reload();
                } else {
                    if (parent.layui.table.cache['lay-tableList']) {
                        parent.layui.table.reload('lay-tableList');
                    }
                }

            } else {
                top.layer.error(res.msg);
            }

        }, 'json');

        // 延时释放点击
        setTimeout(function (e) {
            that.attr("disabled", false);
        }, 2000);

        return false;
    });

    /**
     * 监听form表单搜索  
     */
    form.on('submit(formSearch)', function (data) {

        var field = data.field;
        for (const key in field) {
            if (!field[key]) {
                delete field[key];
            }
        }

        table.reload('lay-tableList', {
            page: { curr: 1 },
            where: field
        });
    })

    /**
     * 监听表格事件
     */
    table.on("tool(lay-tableList)", function (obj) {

        var data = obj.data
            , reqData = {}
            , selector = $(this).parents('table').find('tbody tr')
            , callback = {
                success: function (res) {

                    obj.del(); // 删除tr元素

                    if ((selector.length - 1) == 0 ||
                        typeof selector.length === 'undefined') {
                        table.reload("lay-tableList");
                    }

                    layer.msg(res.msg);
                },
                error: function (res) {
                    layer.error(res.msg);
                }
            }
            , othis = $(this)
            , title = othis.data("title") || undefined

            // 拼接字段数据
            , field = $(this).data('field');
        if (typeof (field) === "undefined") {
            reqData = {
                id: data.id
            }
        } else {
            var array = field.split(",");
            for (let d in array) {
                reqData[d] = data[d];
            }
        }

        // 表格编辑状态
        if (obj.event === "edit") {

            admin.event.open(othis, obj);
        }
        else if (obj.event === "del") {

            var tips = i18n.prop('Sure you want to delete');
            if (typeof title !== "undefined") {
                tips += ' ' + title + ' ';
            }

            tips += '？';
            layer.confirm(tips, function (index) {
                admin.event.request(othis, reqData, callback);
                layer.close(index);
            })

        }
        // 如果event为ajax，则发送请求
        else if (obj.event === "ajax") {
            admin.event.request(othis, reqData, callback);
        }
        else {

            // 打开窗口
            admin.event.open(othis, obj);
        }
    })

    /**
     * 鼠标click状态下，OPEN图片
     */
    $(document).on("click", "*[lay-image-click]", function () {

        var that = $(this)
            , images = that.attr("lay-image-click")
            , size = that.data("size") || undefined;

        /**
         * IMG标签使用SRC属性，适用于展现微缩图的情况
         */
        if (images.length == 0 && that[0].localName == "img") {
            images = that.prop("src");
        }

        var event = window.event || event;
        var width = that.width(), height = that.height();

        // 计算宽度*高度
        if (typeof (size) !== 'undefined') {
            size = size.split(",");
            if (size.length >= 1) {
                width = size[0],
                    height = size[1];
            }

            layer.open(that, undefined, {
                type: 1
                , area: 'auto'
                , offset: '15%'
                , shadeClose: true
                , url: '<img class="lay-images-address" src="' + images + '" width="' + width + '" height="' + height + '" >'
            })

        } else {

            $('<img/>').attr("src", images).load(function () {
                width = this.width;
                height = this.height;
                layer.open(that, undefined, {
                    type: 1
                    , area: 'auto'
                    , offset: '15%'
                    , shadeClose: true
                    , url: '<img class="lay-images-address" src="' + images + '" width="' + width + '" height="' + height + '" >'
                })

            })
        }

    });

    /**
     * 鼠标hover状态下，显示图片
     */
    $(document).on("mouseenter", "*[lay-image-hover]", function () {
        var that = $(this)
            , images = that.attr("lay-image-hover")
            , size = that.data("size") || undefined;

        /**
         * IMG标签使用SRC属性，适用于展现微缩图的情况
         */
        if (images.length == 0 && that[0].localName == "img") {
            images = that.prop("src");
        } else if (that[0].localName == "input") {
            images = that.prop("value");
        }

        if (!images) return;
        var event = window.event || event;
        var width = that.width;
        var height = that.height;
        var left = event.clientX + document.body.scrollLeft + 20;
        var top = event.clientY + document.body.scrollTop + 20;

        // 计算宽度*高度
        if (typeof (size) !== 'undefined') {
            size = size.split(",");
            if (size.length >= 2) {
                width = size[0],
                    height = size[1];
            }
        } else if (height <= 50) {
            $("<img/>").attr("src", images).load(function () { })
        }

        // 获取可视高度
        height = Number(height);
        var sightHeight = $(window).height();

        if (height > sightHeight) {
            height = sightHeight;
        }

        // 偏移50像素
        if (sightHeight <= (top + height)) {
            top = sightHeight - height - 50;
        }

        // 获取html元素
        var showbox = '<div class="lay-images-show" style="display:none;">';
        showbox += '<img class="lay-images-address" src="' + images + '" width="' + width + '" height="' + height + '" ></div>';
        $('body').append(showbox);
        $(".lay-images-show").css({ left: left, top: top, display: "inline-block" });

    }).on("mouseleave", "*[lay-image-hover]", function () {
        $(".lay-images-show").remove();
    });

    /**
     * 列表全部删除操作
     * 默认传入表的参数，进行POST投递
     */
    $(document).on("click", "*[lay-batch]", function (obj) {

        var othis = $(this)
            , tableId = othis.attr("lay-batch") || null
            , data = othis.data("field") || undefined
            , selector = $(this).parents("body").find('.layui-table-main tbody *[data-field=id]')
            , list = table.checkStatus(tableId)
            , tips = 'sure you want to batch operation?';

        // 当前是否传递表id
        if (tableId === null || tableId === undefined) {
            layer.msg(i18n.prop('lay-table undefined!'), 'error');
            return false;
        }

        var field = ['id'];
        if (typeof data !== 'undefined') {
            field = field.concat(data.split(','));
        }

        if (list.data.length === 0) {
            console.log(i18n.prop('lay-table undefined!'));
            layer.msg(i18n.prop('Plase check data'), 'error');
            return false;
        }

        var data = {};
        for (var n in field) {
            var e = field[n];
            field[e] = [];
            for (var i in list.data) {
                field[e].push(list.data[i][e]);
            }
            data[e] = field[e];
        }

        layer.confirm(tips, function (index) {
            admin.event.request(othis, data);
            layer.close(index);
        })
    })

    /**
     * 监听全局layui.open事件并解决鉴权问题
     */
    $(document).on('click', "*[lay-open]", function () {
        admin.event.open($(this), undefined, {});
    })

    /**
     * 监听全局属性鉴权
     */
    $(document).on('click', "*[lay-noauth]", function () {
        var event = $(this).attr('lay-event');

        // 过滤掉工具栏鉴权事件
        var status = admin.getConfig('authnodes');
        if (!status.supersadmin && event === undefined) {
            // 没有权限
        }
    })

    /**
     * 监听ajax属性操作
     */
    $(document).on("click", "*[lay-ajax]", function (obj) {

        var data = {}

            // 获取拼接参数
            , packet = $(this).data("packet") || null
            , object = $(this).data("object") || undefined;

        // 传递类数据
        if (typeof object !== "undefined") {
            object = object.split(',');
            for (var i = 0; i < object.length; i++) {
                let ele = object[i].split(":");
                var val = $('.' + ele[1]).val();
                data[ele[0]] = val;
            }
        }

        // 传递对象数据
        if (packet !== 'null') {
            packet = new Function("return " + packet)();
            data = $.extend({}, data, packet);
        }

        admin.event.request($(this), data, {});
    })

    /**
     * 监听模板打开函数 SHIFT + P
     */
    $(document).keyup(function (event) {
        if (event.shiftKey && event.keyCode == 80) {
            $('[sa-event="theme"]').click();
        }
    });

    // 清理系统缓存
    layui.dropdown.render({
        elem: '#clearCache'
        , data: [{
            title: '一键清理缓存'
            , event: 'all'
        }, {
            title: '清理内容缓存'
            , event: 'content'
        }, {
            title: '清理模板缓存'
            , event: 'template'
        }, {
            title: '清理插件缓存'
            , event: 'plugin'
        }], click: function (data, othis) {

            var index = layui.layer.confirm("确定要清理缓存吗？", {
                title: '提示',
            }, function () {
                admin.event.request($('#clearCache'), { type: data.event });
                layui.layer.close(index);
            })

        }
    });

    /**
      * 监听小屏幕后hover菜单栏事件
      */
    var layuiside = "." + LAYSIDESHRINK + " .layui-side .layui-nav .layui-nav-item";
    $(document).on("mouseenter", layuiside + "," + layuiside + " .layui-nav-child>dd", function () {
        if (admin.screen() >= 2) {
            var self = $(this),
                child = self.find(">.layui-nav-child");
            if (child.length > 0) {
                self.addClass("layadmin-nav-hover");
                child.css({ "width": "30px", "top": self.offset().top, "left": self.offset().left + self.outerWidth() });
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
                        html += '"><a lay-href="' + href + '">' + title + '</a></dd>';
                        html += '</dl>';
                        $(self).append(html);
                        element.render("nav");
                        self.addClass("layadmin-nav-hover");
                        child = self.find(">.layui-nav-child");
                        child.css({ "width": "30px", "top": self.offset().top, "left": self.offset().left + self.outerWidth() });
                    }
                }
                else { // 混合布局菜单，顶层布局不选这个，因为元素已经被隐藏了
                    var n = self.text();
                    layer.tips(n, self, {
                        tips: [2, "#303133"],
                        time: -1,
                        success: function (r, s) {
                            $(r).css("margin-top", "12px")
                        }
                    })
                }
            }
        }

    }).on("mouseleave", layuiside + "," + layuiside + " .layui-nav-child>dd", function () {
        layer.closeAll("tips");
        var self = $(this);
        self.removeClass("layadmin-nav-hover");
        $("#layui-nav-child").remove();
        var child = self.find("dl");
        // ie下bug不能为unset
        child.css({
            "left": 0,
            "top": 0,
        });
    });

    /**
     * 获取左侧布局
     * @param {*} object 
     * @param {*} child 
     * @returns 
     */
    admin.getNavHtml = function (object, child, icon = true) {

        var othis = this, navHtml = STR_EMPTY;

        for (var i = 0; i < object.length; i++) {

            var element = object[i];

            if (element.children && element.router == '#') {

                if (element.pid != 0
                    && element.router == '#'
                    && othis.options.layout == 'hybrid') {
                    navHtml += '<li class="layui-nav-item ">';
                }

                if (element.pid != 0 && element.router == '#') {
                    navHtml += '<dd class="layui-nav-itemed hybrid-item">';
                } else {
                    navHtml += '<li class="layui-nav-item">';
                }

                navHtml += '<a href="javascript:;">';
                if (element.icons && icon) {
                    navHtml += '<i class="layui-icon ' + element.icons + '"></i>';
                }

                navHtml += '<cite>' + element.title + '</cite>';
                navHtml += '<i class="layui-icon layui-icon-down layui-nav-more"></i>';
                navHtml += '</a>';


                navHtml += '<dl class="layui-nav-child">';
                navHtml += admin.getNavHtml(element.children);
                navHtml += '</dl>';

                if (element.pid !== 0 && element.router == '#') {
                    navHtml += '</dd>';

                    if (othis.options.layout == 'hybrid') {
                        navHtml += '</li>';
                    }
                } else {
                    navHtml += '</li>';
                }
            }
            else {

                if ((element.pid == 0 && element.router != '#') || othis.options.layout == 'hybrid') {
                    navHtml += '<li class="layui-nav-item">';
                    navHtml += '<a lay-href="' + element.router + '" class="layui-nav-noChild" >';

                    if (element.icons && icon) {
                        navHtml += '<i class="layui-icon ' + element.icons + '"></i>';
                    }

                    navHtml += '<cite>' + element.title + '</cite>';
                    navHtml += '</a></li>';
                }
                else {
                    navHtml += '<dd><a lay-href="' + element.router + '">';
                    if (element.icons) {
                        navHtml += '<i class="layui-icon ' + element.icons + '"></i>';
                    }
                    navHtml += element.title + '</a></dd>';
                }
            }
        }

        return navHtml;
    }

    /**
     * 混合菜单布局
     * @param {*} route 
     * @param {*} child 
     * @param {*} icon 
     */
    admin.getNavhybrid = function (route, child, icon = true) {

        var header = STR_EMPTY, navHtml = STR_EMPTY;
        for (let index = 0; index < route.length; index++) {
            const element = route[index], nav = 'swift-admin-' + (index + 1);
            if (element.pid == 0) {
                header += '<li class="layui-nav-item layui-hide-xs ';
                if (index === 0) {
                    header += 'layui-this';
                }
                header += '">';
                if (!element.children) {
                    header += '<a href="javascript:;" data-bind="' + nav + '" sa-event="tabs" data-url="' + element.router;
                    header += '" lay-title="' + element.title + '" >' + element.title + '</a>';
                }
                else {
                    header += '<a href="javascript:;" class="lay-nav-bind" lay-nav-bind="' + nav + '" >' + element.title + '</a>';
                }
                header += '</li>';
                route[index]['nav'] = nav;
            }

            if (element.children && element.router === '#') {

                navHtml += '<div class="' + element.nav + '"';

                if (index === 0) {
                    navHtml += 'style="display:block;"';
                }
                navHtml += '>';
                navHtml += admin.getNavHtml(element.children);
                navHtml += '</div>';
            }
        }

        return { header: header, navHtml: navHtml };

    }


    /**
     * 创建多标签
     * @param {*} res 
     * @returns 
     */
    admin.createElementTabs = function (res, bool = false) {

        var options = this.options;

        if (!res.url) {
            layer.msg(i18n.prop('Menu addr not empty!'));
            return;
        }

        var id = res.id || res.url;
        var url = res.url;
        var title = res.title;

        // 判断选项卡
        if (options.moreLabel) {

            // 最大TAB标签
            if ((options.TabLists.length + 1) >= options.maxTabNum) {
                layer.msg(i18n.prop('max 20 tabs'));
                return false
            }

            // 防止重复
            if ($(TABS + '>.layui-tab-title [lay-id="' + id + '"]').length >= 1) {
                element.tabChange(TABFILTER, id);
                return false;
            }

            // 获取标题
            title = '<em class="circle"></em><span class="title">' + (title ? title : "") + "</span>";
            element.tabAdd(TABFILTER, {
                id: id,
                title: title,
                content: '<iframe lay-id="' + url + '" src="' + url + '" frameborder="0" onload="layui.admin.removeLoading(this)" class="swiftadmin-iframe"></iframe>'
            });

            // 开启面包屑
            var layout = admin.getStorage('layout') || options.layout;
            if (layout == 'left') {
                admin.setBreadHtml();
            }

            // 左侧布局面包屑
            if (options.TabLists.length >= 2 && layout === "left") {
                admin.setBreadcrumb(url, title);
            }

            // 增加动画
            admin.showLoading($('iframe[lay-id="' + url + '"]').parent());
            element.render("breadcrumb");
            element.tabChange(TABFILTER, id);
        }
        else {

            var iframe = $('.swiftadmin-iframe');
            if (typeof (iframe) === "undefined" || iframe.length <= 0) {

                var html = ['<div id="swiftadmin-iframe">',];
                html += ' <iframe lay-id="' + url + '" src="' + url + '"';
                html += 'frameborder="0" onload="layui.admin.removeLoading(this)" class="swiftadmin-iframe"></iframe></div>';

                $(LAYOUTADMIN + '>' + BODY).html(html);
            }
            else {

                iframe.attr("lay-id", url);
                iframe.attr("src", url);
                admin.setBreadcrumb(url, title);
            }

            admin.setBreadHtml();
            element.render("breadcrumb");
            admin.showLoading($('#swiftadmin-iframe'));
        }

        // 添加到选项卡
        options.TabLists.push(res);

        if (options.cacheTab) {
            admin.setConfig('TabLists', options.TabLists);
        }

        // 切换到活动页
        admin.setConfig('activeTab', url);
    }

    // 监听菜单点击
    element.on("nav(" + MENUFILTER + ")", function (res) {

        var othis = $(this), id = othis.attr("lay-id");
        var href = othis.attr("lay-href");

        if (!id) {
            id = href;
        }

        if (href && href != "javascript:;") {
            var title = othis.attr("sa-title");
            title || (title = othis.text().replace(/(^\s*)|(\s*$)/g, ""));

            // 开始创建选项卡
            admin.createElementTabs({
                id: id,
                url: href,
                title: title
            }, true);
        }

        // 小屏幕点击关闭
        if (admin.screen() < 2
            && othis.children('.layui-nav-more').length == 0) {
            admin.flexible();
        }

    })

    /**
     * 活动的菜单样式
     * @param {} Id 
     */
    admin.activityTabElem = function (Id) {

        var layout = admin.getStorage('layout') || admin.options.layout;
        $(".layui-nav li").removeClass("layui-this").removeClass("layui-nav-itemed");
        $(".layui-nav li dd").removeClass("layui-this").removeClass("layui-nav-itemed");
        switch (layout) {
            case 'top':
                break;
            case 'hybrid':
                var othis = $('.layui-nav li [lay-href="' + Id + '"]');
                var navBind = $('.layui-nav-tree [lay-href="' + Id + '"]').parents('div').attr('class');
                if (typeof (navBind) !== "undefined") {
                    $(othis).parent('li').addClass('layui-this');
                    $(othis).parents('dd.hybrid-item').addClass('layui-nav-itemed');
                }

                $("div[class^='swift-admin']").hide();
                $("." + navBind).show();
                othis.parent("dd,li").addClass('layui-this');
                break;
            default:
                var othis = $('.layui-nav li [lay-href="' + Id + '"]');
                othis.parent("dd,li").addClass('layui-this');
                othis.parent("dd").parents("dd,li").addClass("layui-nav-itemed");
                break;
        }
    }

    /**
     * 监听TAB点击
     * 需要切换状态
     */
    element.on("tab(" + TABFILTER + ")", function (v) {

        var id = $(this).attr("lay-id");

        // 活动的元素
        admin.activityTabElem(id);

        // 先切换菜单 再去查找
        var layout = admin.getStorage('layout') || "left";
        if (layout === "left" || typeof (layout) === "undefined") {
            var title = $(this).children('.title').text();
            if (admin.options.TabLists.length >= 2 && layout === "left") {
                admin.setBreadcrumb(id, title);
            }
        }

        admin.rollPage("auto");
        admin.setConfig("activeTab", id);
    });

    // 监听选项卡删除
    element.on("tabDelete(" + TABFILTER + ")", function (res) {
        var id = admin.options.TabLists[res.index];
        if (id && typeof id === 'object') {

            // 删除当前对象
            admin.options.TabLists.splice(res.index, 1);
            if (admin.options.cacheTab) {
                admin.setConfig("TabLists", admin.options.TabLists);
            }
            // 修正活动选项卡
            id = admin.options.TabLists[res.index - 1];
            if (id && typeof id === 'object') {
                admin.setConfig("activeTab", id.id || id.url);
            }
        }
    })

    // 监听右键菜单
    $('body').off("contextmenu").on("contextmenu", TABS + " li", function (v) {
        var that = $(this);
        var id = $(this).attr("lay-id");

        layui.dropdown.render({
            elem: that
            , trigger: 'contextmenu'
            , style: 'width: 110px;text-align:center;'
            , id: id
            , show: true
            , data: [
                {
                    title: '刷新当前'
                    , id: 'refresh'
                }
                , {
                    title: '关闭当前'
                    , id: 'closeThisTabs'
                }
                , {
                    title: '关闭其他'
                    , id: 'closeOtherTabs'
                }
                , {
                    title: '关闭全部'
                    , id: 'closeAllTabs'
                }]
            , click: function (obj, othis) {
                if (obj.id === 'refresh') {
                    admin.refresh(id);
                    element.tabChange(TABFILTER, id);
                } else if (obj.id === 'closeThisTabs') {
                    admin.event.closeThisTabs(id)
                } else if (obj.id === 'closeOtherTabs') {
                    admin.event.closeOtherTabs(id)
                } else if (obj.id === 'closeAllTabs') {
                    admin.event.closeAllTabs(id)
                }
            }
        });
        return false;
    })

    // 监听全局sa-event事件
    $(window).on('resize', layui.data.resizeSystem);
    $(document).on("click", "*[sa-event]", function () {
        var name = $(this).attr("sa-event");
        var obj = admin.event[name];
        obj && obj.call(this, $(this));
    });

    // 窗口resize事件
    var resizeSystem = layui.data.resizeSystem = function () {
        var layout = admin.getStorage('layout') || "left";
        var width = $(window).width() - 550;
        if (!resizeSystem.lock) {
            setTimeout(function () {
                if (admin.screen() < 2) {
                    admin.flexible();
                    $('.layui-breadcrumb-header').hide();
                    if ($(BODYSHADECLASS).length <= 0) {
                        $(LAYOUTADMIN).append(BODYSHADE);
                    }
                } else {
                    admin.flexible('open');
                    $('.layui-breadcrumb-header').show();
                    $(BODYSHADECLASS).remove();
                }

                if (layout === "top" || layout === "hybrid") {
                    $('.layui-nav-head').css({
                        "overflow": "hidden"
                        , "width": width
                    })
                    if (width >= 900) {
                        $('.layui-nav-head').css({ "overflow": "unset" })
                    }
                }
                delete resizeSystem.lock;
            }, 50);
        }

        resizeSystem.lock = true;
    }

    /**
     * 基础布局函数
     * @param {*} res 
     * @param {*} router 
     * @param {*} bool 
     */
    admin.BasicLayout = function (res, router = null, bool = false) {

        var othis = this,
            options = othis.options;
        options.TabLists = [];

        // 获取路由
        router = router || othis.getConfig('router');

        // 获取菜单布局
        options.layout = othis.getStorage('layout') || options.layout;

        // 是否开启多标签
        options.moreLabel = othis.getStorage('moreLabel');
        if (typeof options.moreLabel == 'undefined') {
            options.moreLabel = true;
        }


        // 初始化菜单布局
        $('.layui-nav-head').hide();
        $(".layui-side-menu,.layui-breadcrumb").show();
        $('.layui-nav-top,.layui-nav-tree').html(STR_EMPTY);

        // 分类布局函数
        var BodyLayout = {
            left: function (route) {

                // 左侧布局
                $('.layui-nav-tree').html(othis.getNavHtml(route));
                $('.layui-layout-left,.layui-footer,' + LAYOUTADMIN + '>' + BODY).removeAttr('style');
            },
            top: function (route) {

                // 顶部菜单布局
                $(".layui-side-menu").hide();
                $('.layui-breadcrumb').hide();
                $('.layui-nav-head').show();
                $('.layui-nav-top').html(othis.getNavHtml(route, {}, false));
                $('.layui-layout-left,.layui-footer,' + LAYOUTADMIN + '>' + BODY).css('left', '0');

            },
            hybrid: function (route) {

                // 混合菜单布局
                $('.layui-breadcrumb').hide();
                $('.layui-nav-head').show();
                var obj = admin.getNavhybrid(route);
                $('.layui-nav-top').html(obj.header);
                $('.layui-nav-tree').html(obj.navHtml);

                $('.layui-layout-left,.layui-footer,' + LAYOUTADMIN + '>' + BODY).removeAttr('style');
                // 切换选项卡
                $('a.lay-nav-bind').on("click", function (res) {
                    var that = $(this),
                        navBind = that.attr('lay-nav-bind');
                    if (typeof (navBind) !== "undefined") {
                        $("div[class^='swift-admin']").hide();
                        $("." + navBind).show();
                    }
                })
            },
        };

        // 开始执行布局操作
        // options.layout = 'hybrid';
        BodyLayout[options.layout](router._admin_auth_menus_);

        // 顶部TAB选项卡
        var allowclose = '<div class="layui-tab" lay-allowClose="true" lay-filter="swiftadmin-tabs">';
        allowclose += '       <ul class="layui-tab-title"></ul>';
        allowclose += '          <div class="layui-tab-content"></div>';
        allowclose += "   </div>";
        allowclose += ' <div id="tabs-control">';
        allowclose += '   <div class="layui-icon swiftadmin-tabs-control layui-icon-left" sa-event="leftPage"></div>';
        allowclose += '   <div class="layui-icon swiftadmin-tabs-control layui-icon-right" sa-event="rightPage"></div>';
        allowclose += '   <div class="layui-icon swiftadmin-tabs-control layui-icon-down">';
        allowclose += '      <ul class="layui-nav swiftadmin-tabs-select " lay-filter="swiftadmin-nav">';
        allowclose += '         <li class="layui-nav-item" lay-unselect>';
        allowclose += "            <a></a>";
        allowclose += '            <dl class="layui-nav-child layui-anim-fadein">';
        allowclose += '               <dd sa-event="closeThisTabs" lay-unselect><a>关闭当前标签页</a></dd>';
        allowclose += '               <dd sa-event="closeOtherTabs" lay-unselect><a>关闭其它标签页</a></dd>';
        allowclose += '               <dd sa-event="closeAllTabs" lay-unselect><a>关闭全部标签页</a></dd>';
        allowclose += "            </dl>";
        allowclose += "         </li>";
        allowclose += "      </ul>";
        allowclose += "   </div>";
        allowclose += " </div>";

        // 是否多标签
        if (options.moreLabel) {
            $(BODY).html(allowclose);
        }

        var TabLists = admin.getConfig("TabLists");
        if (typeof TabLists == 'undefined') {
            TabLists = options.TabLists;
        }

        var activeTab = admin.getConfig("activeTab");

        // 初始化标签
        if (!TabLists.length) {
            if (typeof res.id == 'undefined') {
                res.id = res.url;
            }

            admin.createElementTabs({
                id: res.id,
                title: res.title,
                url: res.url
            })

        } else {

            for (var i in TabLists) {
                admin.createElementTabs({
                    id: TabLists[i].id,
                    url: TabLists[i].url,
                    title: TabLists[i].title
                })
            }
        }

        // 切换活动页
        element.render("nav");
        element.tabChange(TABFILTER, activeTab);
    }

    /**
     * 入口函数，渲染界面
     * @param {*} res 
     * @param {*} options 
     */
    admin.render = function (res, options) {

        var othis = this;
        this.options = $.extend(this.options, options);
        this.options.layout = this.getStorage('layout') || this.options.layout;

        // 初始化Load效果
        if (!$(LAYOUTBODY).children('#loading').length) {
            $(LAYOUTBODY).append(admin.getSpinningHtml());
        }

        // 可自行修改
        var authorizeUrl = $('#authorize').data('url');

        $.ajax({
            type: 'get',
            url: authorizeUrl,
            success: function (result) {

                try {
                    result = typeof (result) !== "object" ? JSON.parse(result) : result;
                } catch (error) {
                    console.error('result not JSON');
                }

                othis.setConfig('router', result);
                othis.BasicLayout(res, result);
                admin.removeLoading('master');
            },
            error: function (res) {
                // 执行异常
                admin.removeLoading('master');
                $(LAYOUTADMIN).html(res.responseText);
            }
        })
    }

    exports('admin', admin);
});
