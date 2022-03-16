module.exports = {
    title: "SAPHP极速开发文档",
    description: "swiftadmin",
    base: "/help/",
    dest: "dist",
    head: [
        ['link', { rel: 'icon', href: '/images/logo.png' }],
        [
            "script",
            {},
            `
            var _hmt = _hmt || [];
            (function() {
              var hm = document.createElement("script");
              hm.src = "https://hm.baidu.com/hm.js?6dab9d5b223a13d5c80b1ccf4df58f9d";
              var s = document.getElementsByTagName("script")[0]; 
              s.parentNode.insertBefore(hm, s);
            })();
              `
        ]
    ],
    markdown: {
        lineNumbers: true,
        toc: {
            includeLevel: [1, 2, 3],
        },
    },
    themeConfig: {
        logo: '/images/logo.png',
        nav: [
            {
                text: "指南",
                link: "/",
            },
            {
                text: "插件",
                link: "/plugin/",
            },
            {
                text: "工具",
                items: [{ text: "自动配置", link: "/" }],
            },
        ],
        sidebar: [
            {
                title:'序言',
                path: '/',
                
            },
            {
                title:'基础',
                path: '/base/',
            },
            {
                title:'数据库',
                path: '/database/',
            },
            {
                title:'全局组件',
                path: '/component/',
            },
            {
                title:'快捷属性',
                path: '/attribute/',
            },
            {
                title:'权限管理',
                path: '/auth/',
            },
            {
                title:'全文检索',
                path: '/fulltext/',
            },
            {
                title:'代码生成',
                path: '/curd/',
            },
            {
                title:'插件开发',
                path: '/plugin/',
            },
            {
                title:'微信登录',
                path: '/weixin/',
            },
            {
                title:'前端标签',
                path: '/index/',
            },
            {
                title:'更新日志',
                path: '/update/',
            },
            {
                title:'常见问题',
                path: '/question/',
            }
        ],
		
        sidebarDepth: 3
    }
}