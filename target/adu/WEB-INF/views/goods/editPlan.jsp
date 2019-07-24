<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>固定资产-编辑</title>
<script type="text/javascript">
    var lastFlag ;
    var _ORGID = 0;
    var _ORGNAME = "";
    var _ORGNUM = 0;

    //装载表格
    function loadGrid () {
        $ ("#grid").jqGrid ({
            url : "goods/list",
            postData:{
                category:'BGYP'
            },
            height : document.body.clientHeight - 130,
            rownumbers : true,
            colModel : [
                {
                    label : '名称',
                    name : 'name',
                    index : 'name',
                    width : 120
                }, {
                    label : '规格型号',
                    name : 'spec',
                    index : 'spec',
                    width : 120
                },{
                    name:'id',
                    hidden:true
                }
            ],
            rowNum : 20,
            rowList : [
                20, 50, 100
            ],
            pager : '#pager',
            sortname : 'lineNo',
            sortorder : "asc",
            onSelectRow : function(rowid, status) {
                var row = $("#grid").jqGrid("getRowData", rowid);
                addRow(row)
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

	function loadGrid2(){
        $ ("#cash").jqGrid (
            {
                url : "goods/listGPList",
                postData:{
                    refNum:${o.id},
                    applyTo:"plan"
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
                        width : 200,
                        editable:true,edittype:'text',editrules:{required:true}
                    },
                    {
                        label : '说明',
                        name : 'descr',
                        index : 'descr',
                        width : 200,
                        editable:true,edittype:'text'
                    },
                    {
                        label : ' ',
                        name : 'id',
                        width : 140,
                        align : 'center',
                        sortable : false,
                        formatter : function (value, options, row) {
                            var btn = "";
                            btn += '&nbsp;<a href="javascript:delRow(' + row.id + ')" title="">删除</a>'
                            return btn;
                        }
                    },{
                        name : 'goodId',
                        hidden:true
                    },{
                        name : 'lineNo',
                        hidden:true
                    }
                ],
                sortname : 'id',
                sortorder : "asc",
                onSelectRow : function(rowId){
                    if(rowId && rowId!=lastFlag){
                        $('#cash').jqGrid('saveRow',lastFlag);
                        lastFlag=rowId;
                    }
                    $('#cash').jqGrid('editRow',rowId,true);

                }
            });

	}
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('goods/savePlan', $ ("#mainForm").serialize (), function (result, status) {
            var list = new Array()

            $('#cash').jqGrid('saveRow',lastFlag);
            var total = $("#cash").jqGrid('getRowData')
            for(var i = 0 ;i < total.length;i++){
                var entity = new Object();

                entity.id = total[i].lineNo
                entity.goodName = total[i].goodName
                entity.goodId = total[i].goodId
                entity.num = total[i].num
                entity.refNum = result.entity.id
                entity.descr = total[i].descr
                entity.applyTo = "plan"
				entity.price = 0
				entity.lineNo = total[i].lineNo

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
            // $.post('goods/saveGPList',{'plans':plans},function(result,status){
            //
            //     if (parent.onSaveOk){
            //         parent.onSaveOk (result.entity)
            //     }
            // })


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
        $('#cash').jqGrid('saveRow',lastFlag);
        var selectedId = $("#cash").jqGrid("getGridParam", "selrow");
        var dataRow = {
            id: 0,
            goodName: row.name,
            goodId:row.id,
            num:0,
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

    function delRow(id) {
        $('#cash').jqGrid('saveRow',lastFlag);
        var selectedId = $("#cash").jqGrid("getGridParam","selrow");
        if(!selectedId){
            alert("请选择要删除的行");
            return;
        }else{
            $("#cash").jqGrid("delRowData", selectedId);
            if(id > 0){
                $.post ("goods/delGPList", {
                    id : id
                }, function () {

                });
            }
        }
    }


    //Iframe中点击ORG时获取ORGID，查询该机构下的人员
    function onOrgNodeClick (node) {
        _ORGID = node.id;
        _ORGNAME = node.name;
        _ORGNUM = node.docCount;
        onQ (node.id);
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
        $ ('#ifrmOrg').attr ('src', $ ('#ifrmOrg').attr ('src'));
    }

    $ (function () {
	    //加载select特效
	    $ (".select2").select2 ();
	    //为日期设置格式输入
	    $ ("#sqrq").inputmask ("yyyy-mm-dd", {
		    "placeholder" : "yyyy-mm-dd"
	    });
	    //加载日期控件
	    $ ('#sqrq').datetimepicker ({
		    minView : 3
	    //时间，默认为日期时间
	    });
	    //设置掩码
	    $ ('#sqrq').inputmask ("yyyy-mm-dd");

	    //赋值
	    if ("${o.id}" > 0){

	    }
        $ ("#ifrmOrg").height (document.body.clientHeight - 115)
        loadGrid()
        loadGrid2()

    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />
			<input type="hidden" id="personId" name="personId" value="${o.personId}" />
			<input type="hidden" id="person" name="person" value="${o.person}" />
			<input type="hidden" id="status" name="status" value="${o.status}" />


			<input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="org">申请部门</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="org" name="org"
							   value="${o.org}" readonly type="text" />
						<div class="input-group-addon">
							<i class="fa fa-search"
							   onclick="onSelOrg()"></i>
						</div>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="sqrq">申请日期</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="sqrq" name="sqrq" value="${o.sqrq}"
							   type="text" />
						<div class="input-group-addon">
							<i class="fa fa-calendar"
							   onclick="$('#sqrq').datetimepicker('show');"></i>
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
                                    <button type="button" onclick="addRow()" class="btn btn-box-tool"><i class="fa fa-plus"></i>
                                    </button>
                                </div>
                                <!-- /.box-tools -->
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <div class="col-sm-2">
                                    <div class="nav-tabs-custom">
                                        <!-- Tabs within a box -->
                                        <ul class="nav nav-tabs pull-right ui-sortable-handle">
                                            <li class="pull-left header" style="padding-left:20px;font-size:14px;"><i class="fa fa-bank"></i> <b> 类别 <b></li>
                                        </ul>
                                        <div class="tab-content no-padding">
                                            <iframe scrolling="no" id="ifrmOrg"
                                                    style="width: 100%; height: 300px;" frameborder="0"
                                                    src="suptype/list4"></iframe>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                    <table id="grid"></table>
                                    <div id="pager" style="height:35px;"></div>
                                </div>
                                <div class="col-sm-5" id="sel">
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
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>

	</div>
</body>
</html>
