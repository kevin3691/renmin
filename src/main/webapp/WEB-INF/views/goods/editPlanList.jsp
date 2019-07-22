<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>固定资产-编辑</title>
<script type="text/javascript">
    var _SELEDROWS = [];
    var _INITROWS = [];
    var gpl = {};
    var gpllist = {};
    //装载表格
    function loadGrid () {
        $ ("#grid").jqGrid ({
            url : "goods/listGoodPlan",
            postData:{
				isActive:1,
				isSel:0
			},
            height : document.body.clientHeight - 130,
            rownumbers : true,
            multiselect : true,
            colModel : [
                {
                    label : '处室',
                    name : 'org',
                    index : 'org',
                    width : 120
                }, {
                    label : '申请日期',
                    name : 'sqrq',
                    width : 120,
                    sortable : false,
                    align : 'center',
                    formatter: function (value, options, row) {
                        return jsonDateTimeFormatter(value,1)
                    }
                }, {
                    label : '审批状态',
                    name : 'isActive',
                    width : 120,
                    sortable : false,
                    align : 'center',
                    formatter: function (value, options, row) {
                        var btn = ""
                        if(value == 1){
                            btn += "<span style='color: green'>通过</span>"
                        }
                        if(value == 2){
                            btn += "<span style='color: red'>不通过</span>"
                        }
                        return btn
                    }
                }, {
                    name: 'id',
                    hidden:true
                }, {
                    name: 'status',
                    hidden:true
                }

            ],
            pager : '#pager',
            sortname : 'lineNo',
            sortorder : "asc",
            onSelectAll : function (ids, status) {
                $.each (ids, function (i, v) {
                    var row = $ ("#grid").jqGrid ("getRowData", v);
                    if (status){
                        pushArr (row);
                    }
                    else{
                        spliceArr (row)
                    }
                })
                $ ("#cash").jqGrid ("clearGridData")
                genSeledList ();
            },
            onSelectRow : function (rowid, status) {
                var row = $ ("#grid").jqGrid ("getRowData", rowid);
                //如果是选中，则判断重复后加入数组,撤销选中则从数组中移除
                if (status){
                    pushArr (row);
                }
                else{
                    spliceArr (row)
                }

                genSeledList ();
            },
            loadComplete: function () {
                var alldata = $("#grid").jqGrid("getRowData");
                $.each (alldata, function (i, v) {
                    if(v.status == 2){
                        $("#grid").jqGrid('setSelection', v.id, false);
                        pushArr (v);
                    }
                })
                genSeledList ();
            }
        });
        jQuery ("#grid").jqGrid ('bindKeys', {
            "onEnter" : function (rowid) {
                //alert ("你enter了一行， id为:" + rowid)
            },
            "onRightKey" : function (rowid) {
                onSave (rowid)
            },
            "onLeftKey" : function (rowid) {
                onDel (rowid)
            },
            "onSpace" : function (rowid) {
            }
        });
    }


    //放置入选中数组
    function pushArr (row) {
        var flag = true;
        $.each (_SELEDROWS, function (i, v) {
            if (v.id == row.id){
                flag = false;
                return false;
            }
        })
        if (flag){
            _SELEDROWS.push (row);
        }
    }
    //从选中数组中删除
    function spliceArr (row) {
        $.each (_SELEDROWS, function (i, v) {
            if (v.id == row.id){
                _SELEDROWS.splice (i, 1);
                return false;
            }
        })
    }


    function genSeledList() {
        gpl = {}
		gpllist = {}

        $.each (_SELEDROWS, function (i, v) {
            $.post ('goods/listGPList', {refNum:v.id}, function (result, status) {
                $.each (result.rows, function (ii, vv) {
                    if(gpllist.hasOwnProperty(vv.goodId)) {
                        var count = vv.num + gpllist[vv.goodId]
                        gpllist[vv.goodId] = count
                    }else{
                        gpllist[vv.goodId] = vv.num
                        gpl[vv.goodId] = vv
                    }
                })
                $ ("#cash").jqGrid ("clearGridData")
                $.each (gpllist, function (key, value) {
                    var row = gpl[key]
                    row.id = 0
                    row.num = gpllist[key]
                    addRow(row)
                })
			});
		})



    }

	function loadGrid2(){
        $ ("#cash").jqGrid (
            {
                url : "goods/listGPList",
                postData:{
                    refNum:${o.id},
                    applyTo:"list"
                },
                height : document.body.clientHeight - 130,
                rownumbers : true,
                colModel : [
                    {
                        label : '名称',
                        name : 'goodName',
                        index : 'goodName',
                        width : 200
                    },{
                        label : '数量',
                        name : 'num',
                        index : 'num',
                        width : 200
                    },
                    {
                        label : '说明',
                        name : 'descr',
                        index : 'descr',
                        width : 200

                    },{
                        name : 'id',
                        hidden:true
                    },{
                        name : 'goodId',
                        hidden:true
                    },{
                        name : 'lineNo',
                        hidden:true
                    }
                ],
                sortname : 'id',
                sortorder : "asc"

            });

	}
	//保存
    function onSave () {
        //表单验证
        if (!$ ('#mainForm').validate ().form ()){
            return false;
        }

        var para = $ ("#mainForm").serialize ();

        $.post ('goods/savePlanList', $ ("#mainForm").serialize (), function (result, status) {

            var ids=$("#grid").jqGrid("getGridParam","selarrrow");
            var rows = new Array()
            var rowIds = []
            $.post ('goods/updatePlan', {"ids":ids.toString(),"status":2}, function (result, status) {
                var rows = $("#grid").jqGrid("getRowData");

                $.each (rows, function (i, v) {
                    var flag = true;
                    $.each (ids, function (ii, vv) {
                        if (vv == v.id){
                            flag = false;
                            return false;
                        }
                    })
                    if(flag){
                        rowIds.push(v.id)
                    }
                    $.post ('goods/updatePlan', {"ids":rowIds.toString(),"status":1}, function (result, status) {
						document.location.reload()
                    })
                })
            })

        });
    }


    function onSubmit () {
        //表单验证
        if (!$ ('#mainForm').validate ().form ()){
            return false;
        }

        var para = $ ("#mainForm").serialize ();

        $.post ('goods/savePlanList', $ ("#mainForm").serialize (), function (result, status) {
			var id = result.entity.id;
            var ids=$("#grid").jqGrid("getGridParam","selarrrow");
            var rows = new Array()
            var rowIds = []
            $.post ('goods/updatePlan', {"ids":ids.toString(),"status":2,"refNum":"${o.id}"}, function (result, status) {
                var rows = $("#grid").jqGrid("getRowData");

                $.each (rows, function (i, v) {
                    var flag = true;
                    $.each (ids, function (ii, vv) {
                        if (vv == v.id){
                            flag = false;
                            return false;
                        }
                    })
                    if(flag){
                        rowIds.push(v.id)
                    }

                })

                $.post ('goods/updatePlan', {"ids":rowIds.toString(),"status":1}, function (result, status) {
                    $.post ('goods/submitPlanList', {id:"${o.id}"}, function (result, status) {
                        var list = new Array()

                        var total = $("#cash").jqGrid('getRowData')
                        for(var i = 0 ;i < total.length;i++){
                            var entity = new Object();

                            entity.id = total[i].lineNo
                            entity.goodName = total[i].goodName
                            entity.goodId = total[i].goodId
                            entity.num = total[i].num
                            entity.refNum = id
                            entity.descr = total[i].descr
                            entity.lineNo = total[i].lineNo
                            entity.price = 0
                            entity.applyTo = "list"

                            list.push(entity)
                            // $.post('cash/details',{'cash':entity},function(result,status){
                            //
                            // })
                        }
                        var plans = new Object();
                        plans.plans = list;
                        var json = JSON.stringify(plans)
                        $.ajax({
                            headers : {
                                'Accept' : 'application/json',
                                'Content-Type' : 'application/json'
                            },
                            type : "POST",
                            url : "goods/saveGPList",
                            data :json,
                            success : function(result) {
                                if (parent.onSaveOk){
                                    parent.onSaveOk (result.entity)
                                }
                            },
                            error : function(result) {
                                alert("保存失败！");
                            }
                        });

                    })
                })

            })

        });

    }
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    //选择部门
    function onSelOrg () {
        layer.open ({
            type : 2,
            title : "选择部门",
            shadeClose : true,
            shade : 0.8,
            area : [
                '350', '420'
            ],
            content : 'base/org/sel' //iframe的url
        });
    }
    //选择部门回调方法
    function onSelOrgOk (node) {
        $ ("#orgId").val (node.id)
        $ ("#org").val (node.name)
        layer.closeAll ()
    }
    //数据字典回调函数,初始化后为其赋值
    function dictCallBack (container) {
	    <%--if (container == "title"){--%>
		    <%--$ ("#title").select2 ("val", "${o.title}");--%>
	    <%--}--%>
	    <%--else if (container == "education"){--%>
		    <%--$ ("#education").select2 ("val", "${o.education}");--%>
	    <%--}--%>
	    <%--else if (container == "gender"){--%>
		    <%--$ ("#gender").select2 ("val", "${o.gender}");--%>
	    <%--}--%>
    }
    function addRow(row)
    {
        var selectedId = $("#cash").jqGrid("getGridParam", "selrow");
        var dataRow = {
            id: 0,
            goodName: row.goodName,
            goodId:row.goodId,
            num:row.num,
            lineNo:0,
            descr:""
        };
        var ids = jQuery("#cash").jqGrid('getDataIDs');
        //获得当前最大行号（数据编号）
        var rowid = Math.max.apply(Math,ids);
        rowid =rowid + 1;
        if (selectedId) {
            $("#cash").jqGrid("addRowData", rowid, dataRow, "after", selectedId);
        } else {
            $("#cash").jqGrid("addRowData", rowid, dataRow, "last");
        }
    }


    //查询
    function onQ (orgid) {
        var para = {
            typeId : orgid,
            name : $ ("#name").val (),
            sn : $ ("#sn").val ()
        };
        $ ("#grid").jqGrid ("setGridParam", {
            page : 0,
            postData : para
        }).trigger ("reloadGrid");
    }
    //显示全部
    function showAll () {
        $ ("#name").val ("");
        $ ("#sn").val ("")
        onQ (0);
    }

    $ (function () {
	    //加载select特效
	    $ (".select2").select2 ();
	    //为日期设置格式输入
	    $ ("#startdt").inputmask ("yyyy-mm-dd", {
		    "placeholder" : "yyyy-mm-dd"
	    });
	    //加载日期控件
	    $ ('#startdt').datetimepicker ({
		    minView : 3
	    //时间，默认为日期时间
	    });
	    //设置掩码
	    $ ('#startdt').inputmask ("yyyy-mm-dd");

	    //赋值
	    if ("${o.id}" > 0){

	    }
        loadGrid()
        loadGrid2()
        $.ajaxSetup ({
            cache: false //关闭AJAX缓存
        });
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />
			<input type="hidden" id="org" name="org" value="${o.org}" />
			<input type="hidden" id="personId" name="personId" value="${o.personId}" />
			<input type="hidden" id="person" name="person" value="${o.person}" />
			<input type="hidden" id="status" name="status" value="${o.status}" />
			<input type="hidden" id="finishdt" name="finishdt" value="${o.finishdt}" />


			<input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">采购计划名称</label>
				<div class="col-sm-10">
					<input class="form-control" id="title" name="title"
						   value="${o.title}" type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="startdt">创建日期</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="startdt" name="startdt" value="${o.startdt}"
							   type="text" />
						<div class="input-group-addon">
							<i class="fa fa-calendar"
							   onclick="$('#startdt').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
			</div>

            <div class="form-group">
                <label class="col-sm-2 control-label" for="descr">备注</label>
                <div class="col-sm-10">
                    <textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
                </div>
            </div>

        </form>
			<div class="form-group">
                <%--<div class="col-sm-2"></div>--%>
			    <div class="col-sm-12">
                    <div class="container-fluid">
                        <div class="box box-default box-solid">
                            <div class="box-header with-border">
                                <h3 class="box-title">采购明细</h3>

                                <div class="box-tools pull-right">

                                </div>
                                <!-- /.box-tools -->
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <div class="col-sm-4">
                                    <table id="grid"></table>
                                    <div id="pager" style="height:35px;"></div>
                                </div>
                                <div class="col-sm-8" id="sel">
                                    <table id="cash"></table>
                                </div>

                            </div>
                            <!-- /.box-body -->
                        </div>
                        <!-- /.box -->
                    </div>
                </div>
			</div>



			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-info" onclick="onSubmit()">执行采购计划</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>

	</div>
</body>
</html>
