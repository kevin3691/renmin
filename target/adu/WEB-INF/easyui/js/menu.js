var SystemMenu = [{
    title: '首页',
    icon: '&#xe63f;',
    isCurrent: true,
    menu: [{
        title: '首&nbsp;&nbsp;页',
        icon: '&#xe620;',
        isCurrent: true,
        children: [{
            title: '待办工作',
            href: 'home/dashboard',
            isCurrent: true
        }]
    }]
},{
    title: '文档管理',
    icon: '&#xe63f;',
    menu: [{
        title: '文档管理',
        icon: '&#xe620;',
        isCurrent: true,
        children: [{
            title: '文档管理',
            href: 'document/index',
            isCurrent: true
        },{
            title: '文档查询',
            href: 'document/index5'
        }]
    }]
},{
    title: '公文流转',
    icon: '&#xe63f;',
    menu: [{
        title: '公文流转',
        icon: '&#xe620;',
        isCurrent: true,
        children: [{
            title: '新建公文',
            href: 'document/dsel',
        },{
            title: '待处理',
            href: 'document/dindex',
            isCurrent: true
        },
        //     {
        //     title: '待归档',
        //     href: 'document/dindex2',
        // },{
        //     title: '已归档',
        //     href: 'document/dindex3',
        // },
            {
            title: '已新建',
            href: 'document/dindex4',
        },{
            title: '已处理',
            href: 'document/dindex5',
        }]
    }]
},{
	title: '工作督办',
	icon: '&#xe60d;',
	menu: [{
		title: '工作督办',
		icon: '&#xe647;',
        isCurrent: true,
		children: [
            {
                title: '工作督办',
                href: 'duban/index',
                isCurrent: true,
                children: []
            }
            ,{
                title: '主要工作任务分解督办',
                href:'duban/index2',
                children: []
            },{
                title: '专项督办',
                href:'duban/index3',
                children: []
            }
        ]
	},]
}
,{
	title: '财务管理',
	icon: '&#xe61e;',
	menu: [{
        title: '报销管理',
        icon: '&#xe647;',
        isCurrent: true,
        children: [{
            title: '报销申请',
            href: 'cash/index',
            isCurrent: true
        }
        ,{
            title: '所有报销',
            href: 'cash/index2'
        }
        ]
    }

        ]
}
    ,{
        title: '办公用品',
        icon: '&#xe61e;',
        menu: [{
            title: '办公用品管理',
            icon: '&#xe647;',
            isCurrent: true,
            children: [
                {
                    title: '待审批采购申请',
                    href: 'goods/plan2',
                    isCurrent: true
                },
                {
                    title: '所有采购申请',
                    href: 'goods/plan'
                }
                ,
                {
                    title: '待执行采购计划',
                    href: 'goods/planlist',
                }
                ,
                {
                    title: '执行中采购计划',
                    href: 'goods/planlist2',
                }

                ,
                {
                    title: '所有采购计划',
                    href: 'goods/planlistall',
                }
            ]},{
            title: '办公用品管理',
            icon: '&#xe647;',
            children: [{
                title: '办公用品',
                href: 'goods/index4'

            },
              {
                    title: '入库记录',
                    href: 'goods/suplist/index',
                },
                {
                    title: '领用记录',
                    href: 'goods/suplist/index4',
                }

            ]
        }


        ]
    } ,{
        title: '固定资产管理',
        icon: '&#xe61e;',
        menu: [{
            title: '固定资产管理',
            icon: '&#xe647;',
            isCurrent: true,
            children: [{
                title: '固定资产',
                href: 'goods/index',
                isCurrent: true
            }

            ]
        }


        ]
    }
    ,{
        title: '公章管理',
        icon: '&#xe61e;',
        menu: [{
            title: '公章管理',
            icon: '&#xe647;',
            isCurrent: true,
            children: [{
                title: '用章申请',
                href: 'seal/index',
                isCurrent: true
            },
                {
                    title: '待审批申请',
                    href: 'sealtype/index2',
                },{
                    title: '已批准申请',
                    href: 'sealtype/index3',
                },{
                    title: '未批准申请',
                    href: 'sealtype/index4',
                },
                {
                    title: '公章类型',
                    href: 'sealtype/index',
                }

            ]
        }


        ]
    },{
        title: '文印费用',
        icon: '&#xe61e;',
        menu: [{
            title: '文印费用',
            icon: '&#xe647;',
            isCurrent: true,
            children: [{
                title: '文印费用申请',
                href: 'docprint/index',
                isCurrent: true
            },
                {
                    title: '待审批申请',
                    href: 'docprint/index2',
                },{
                    title: '已批准申请',
                    href: 'docprint/index3',
                }
                ,{
                    title: '未批准申请',
                    href: 'docprint/index4',
                }

            ]
        }


        ]
    }
    ,{
        title: '会议管理',
        icon: '&#xe61e;',
        menu: [{
                title: '会议管理',
                icon: '&#xe611;',
            isCurrent: true,
                children: [

                    {
                        title: '所有会议',
                        href: 'meet/index',
                        isCurrent: true
                    }]
            }
        ]
    }
    ,{
        title: '接待管理',
        icon: '&#xe61e;',
        menu: [{
            title: '接待管理',
            icon: '&#xe611;',
            isCurrent: true,
            children: [

                {
                    title: '接待管理',
                    href: 'meet/index2',
                    isCurrent: true
                }]
        }
        ]
    }
,{
	title: '车辆管理',
	icon: '&#xe620;',
	menu: [{
        title: '车辆管理',
        icon: '&#xe620;',
        isCurrent: true,
        children: [
			{
				title:'车辆状态',
				href:'car/index',
                isCurrent: true,
				children:[]
			},{
                title: '车辆使用信息',
                icon: '&#xe611;',
                href: 'car/index4',
                children: []
            },{
                title: '车辆运行费用信息',
                icon: '&#xe611;',
                href: 'car/index2',
                children: []
            },{
                title: '车辆维修保养信息',
                icon: '&#xe611;',
                href: 'car/index3',
                children: []
            }
		]
	}]
}
// ,{
// 	title: '值班管理',
// 	icon: '&#xe625;',
// 	menu: [{
// 		title: '值班管理',
// 		icon: '&#xe647;',
// 		children: []
// 	},{
// 		title: '排班计划',
// 		icon: '&#xe611;',
// 		href: 'basic_info.html',
// 		children: []
// 	}]
// },{
// 	title: '信访管理',
// 	icon: '&#xe64b;',
// 	menu: [{
// 		title: '信访管理',
// 		icon: '&#xe647;',
// 		isCurrent: true,
// 		children: []
// 	}]
// },{
// 	title: '老干部管理',
// 	icon: '&#xe64c;',
// 	menu: [{
// 		title: '老干部信息',
// 		icon: '&#xe647;',
// 		isCurrent: true,
// 		children: []
// 	}]
// },{
// 	title: '机要管理',
// 	icon: '&#xe646;',
// 	menu: [{
// 		title: '机要管理',
// 		icon: '&#xe647;',
// 		isCurrent: true,
// 		children: []
// 	}]
// },{
// 	title: '日志管理',
// 	icon: '&#xe646;',
// 	menu: [{
// 		title: '工作日志',
// 		icon: '&#xe647;',
// 		isCurrent: true,
// 		children: [{
// 			title: '日志管理',
// 			href: 'workbench.html',
// 			isCurrent: true
// 		},{
// 			title: '日志状态',
// 			href: 'index.html'
// 		}]
// 	}]
// }
,{
	title: '领导工作管理',
	icon: '&#xe646;',
	menu: [
	 //    {
    //     title: '日程安排',
    //     icon: '&#xe611;',
    //     href: 'basic_info.html',
    //     isCurrent: true,
    //     children: []
    // },
        {
		title: '工作计划',
		icon: '&#xe647;',
            isCurrent: true,
		children: [{
			title: '周计划',
			href: 'workPlan/index',
			isCurrent: true
		},{
			title: '工作完成情况',
			href: 'workPlan/index2'
		}]
	}]
}

    ,{
	title: '系统设置',
	icon: '&#xe646;',
	menu: [{
		title: '系统管理',
		icon: '&#xe647;',
        isCurrent: true,
		children: [{
			title: '组织机构',
			href: 'base/org/index',
			isCurrent: true
		},{
            title: '人员管理',
            href: 'base/person/index'
        },{
            title: '用户管理',
            href: 'base/user/index'
        }]
	}]
}
];