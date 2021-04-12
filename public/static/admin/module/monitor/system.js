// CPU使用率
var CpuElem = {
    tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b}: {c} ({d}%)" // 定义工具栏
    },
    color:['#FF5722', '#ccc'], // 定义颜色
    series: [  // 系列数据 如果是圆图的话，则使用一个系列就行了。。可以这么理解，每一个数据类型不同的情况下，需要进行不同的配置，而不简单的是设置一些公用的东西。
        {
            name:'CPU使用率',
            type: 'pie',
            center: ['50%', '50%'],
            radius: ['70%', '80%'],
            avoidLabelOverlap: false,
            hoverAnimation: false,
            label: { 
                normal: {
                    show: true,
                    position: 'center',
                    color: '#666',
                    fontSize: 14,
                    fontWeight: 'bold',
                    formatter: '{d}%\n{b}'
                }
            },
            labelLine: {
                normal: {
                    show: false
                }
            },
            data:[{
                    value: 40,
                    name: "CPU使用率",
                    label: {
                        normal: {
                            show: true
                        }
                    }
                },
                {
                    value: 60,
                    name: 'CPU未使用',
                    label: {
                        normal: {
                            show: false
                        }
                    }
                }
            ]
        }
    ]
};

// 定义内存使用率
var memElem = {
    tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b}: {c} ({d}%)"
    },
    color:['#1890FF', '#ccc'],
    series: [
        {
            name:'内存使用率',
            type: 'pie',
            center: ['50%', '50%'],
            radius: ['70%', '80%'],
            avoidLabelOverlap: false,
            hoverAnimation: false,
            label: { 
                normal: {
                    show: true,
                    position: 'center',
                    color: '#666',
                    fontSize: 14,
                    fontWeight: 'bold',
                    formatter: '{d}%\n{b}'
                }
            },
            labelLine: {
                normal: {
                    show: false
                }
            },
            data:[{
                    value: 20,
                    name: "内存使用率",
                    label: {
                        normal: {
                            show: true
                        }
                    }
                },
                {
                    value: 80,
                    name: '剩余内存',
                    label: {
                        normal: {
                            show: false
                        }
                    }
                }
            ]
        }
    ]
};

// 定义数据库使用率
var MySQLElem = {
    tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b}: {c} ({d}%)"
    },
    color:['#FFB800', '#ccc'],
    series: [
        {
            name:'数据库使用率',
            type: 'pie',
            center: ['50%', '50%'],
            radius: ['70%', '80%'],
            avoidLabelOverlap: false,
            hoverAnimation: false,
            label: { 
                normal: {
                    show: true,
                    position: 'center',
                    color: '#666',
                    fontSize: 14,
                    fontWeight: 'bold',
                    formatter: '{d}%\n{b}'
                }
            },
            labelLine: {
                normal: {
                    show: false
                }
            },
            data:[{
                    value: 20,
                    name: "MySQL使用率",
                    label: {
                        normal: {
                            show: true
                        }
                    }
                },
                {
                    value: 80,
                    name: 'MySQL数据库',
                    label: {
                        normal: {
                            show: false
                        }
                    }
                }
            ]
        }
    ]
};
