<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
<title>公文-编辑</title>
<script type="text/javascript">
    var lastFlag ;
function loadGrid () {
    $ ("#grid").jqGrid (
        {
            url : "comm/attachment/list5",
            postData:{
                refNum: "${o.id}"
            },
            height : 150,
            rownumbers : true,
            colModel : [
                {
                    label : '标题',
                    name : 'title',
                    index : 'title',
                    width : 200
                },
                {
                    label : '文件大小',
                    name : 'fileSize',
                    index : 'fileSize',
                    width : 80,
                    formatter : function (value, options, row) {
                        var s = commafy (value / 1024);
                        s = s != "0" ? s : "<1";
                        return s + "KB";
                    }
                },
                {
                    label : ' ',
                    name : 'id',
                    width : 140,
                    align : 'center',
                    sortable : false,
                    formatter : function (value, options, row) {
                        var btn = "";

                        btn += '&nbsp;<a href="javascript:onShow(\'' + row.fileUrl + '\',\'' + row.fileExt
                            + '\')" title="">查看</a>'
                        btn += '&nbsp;<a href="comm/attachment/download?filePath=' + row.filePath
                            + '" title="">下载</a>'
                        btn += '&nbsp;<a href="javascript:onDel(' + value + ')" title="">删除</a>'
                        return btn;
                    }
                }
            ],
            sortname : 'id',
            sortorder : "asc",
        });

$ ("#cash").jqGrid (
    {
        url : "cash/details/list",
        postData:{
            refNum:"${o.id}",
			applyTo:"CASH"
        },
        height : 150,
        rownumbers : true,
        colModel : [
            {
                label : '科目',
                name : 'kemu',
                index : 'kemu',
                width : 200,
                editable:true,edittype:'text',editrules:{required:true}
            },{
                label : '金额',
                name : 'jine',
                index : 'jine',
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
                    btn += '&nbsp;<a href="javascript:delRow(' + value + ')" title="">删除</a>'
                    return btn;
                }
            }
        ],


        sortname : 'id',
        sortorder : "asc",
        onSelectRow : function(id){
            if(id && id!=lastFlag){
                $('#cash').jqGrid('saveRow',lastFlag);
                lastFlag=id;
            }
            $('#cash').jqGrid('editRow',id,true);

        }
    });
    // $("#t_cash").append("<input type='button' value='Click Me' style='height:20px;font-size:-3'/>");

}

    function addRow()
    {
        $('#cash').jqGrid('saveRow',lastFlag);
        var selectedId = $("#cash").jqGrid("getGridParam", "selrow");
        var dataRow = {
            id: 0,
            kemu: "",
            jine:"",
            descr:"",
            lineNo:0,
            applyTo:"",
            refNum:0
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

    function delRow(id,lineNo) {
        $('#cash').jqGrid('saveRow',lastFlag);
        var selectedId = $("#cash").jqGrid("getGridParam","selrow");
        if(!selectedId){
            alert("请选择要删除的行");
            return;
        }else{
            $("#cash").jqGrid("delRowData", selectedId);
            if(id > 0){
                $.post ("cash/details/del", {
                    id : lineNo
                }, function () {

                });
            }
        }
    }

    //选择人员
function onSelPerson () {
    var title = "选择人员"
    layer.open ({
        type : 2,
        title : title,
        shadeClose : true,
        shade : 0.8,
        area : [
            '90%', '90%'
        ],
        content : 'base/person/sel'
    });
}
//选择人员回调方法
function onPersonSelOk (row) {
    $ ("#sqrId").val (row.id)
    $ ("#sqr").val (row.name)
    $ ("#orgId").val (row.baseOrgId)
    $ ("#org").val (row.baseOrgName)
    layer.closeAll ();
}
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }

        $("#payment").val($("input[name='rd']:checked").val());
        $('#cash').jqGrid('saveRow',lastFlag);


	    var para = $ ("#mainForm").serialize ();
	    $.post ('cash/save', $ ("#mainForm").serialize (), function (result, status) {
                // if(top.onCancel()){
                //     top.onCancel();
                // }
            var id = result.entity.id;
            var total = $("#cash").jqGrid('getRowData')
            for(var i = 0 ;i < total.length;i++){
                var entity = new Object();
                entity.id = total[i].lineNo
                entity.kemu = total[i].kemu
                entity.jine = total[i].jine
                entity.descr = total[i].descr
                entity.refNum = id
                entity.applyTo = "CASH"
                entity.lineNo = total[i].lineNo
                var json = JSON.stringify(entity)
                $.ajax({
                    headers : {
                        'Accept' : 'application/json',
                        'Content-Type' : 'application/json'
                    },
                    type : "POST",
                    url : "cash/details/save",
                    data :json,
                    success : function(result) {

                    },
                    error : function(result) {
                        //alert("保存失败！");
                    }
                });
            }

            window.top.OBJ.onQ()
            document.location.href = "cash/edit?id=" + id;
		    }

	    );
    }
function onDel(id) {
    $.post ("comm/attachment/del", {
        id : id
    }, function () {
        $ ("#grid").trigger ("reloadGrid");
    });
}

    //返回
    function onCancel () {

        window.top.onCancel();
    }

    function onUpload (flag) {
	    flag = flag || "";
	    var title = "上传附件";
	    var url = 'comm/attachment/upload';
	    if (flag == "preview"){
		    url = 'comm/attachment/preUpload';
	    }
	    else if (flag == "corpper"){
		    url = 'comm/attachment/cropUpload';
	    }
	    layer.open ({
	        type : 2,
	        title : title,
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '800', '450'
	        ],
	        content : url
	    //iframe的url
	    });
    }
    function onSelfUpload () {
    	if("${o.id}" == 0)
    	{
    		alert("请先保存再上传附件！");
    		return;
    	}
	    $ ("input[name='file']").click ();
    }
    //上传完附件后执行
    function onUploadSucess () {
	    onQ ();
    }
    //查询
    function onQ () {
	    var para = {

	    };
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }


function onFinish(){
		/* if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    } */
	    if("${o.id}" == 0)
		{
			alert("请先保存再提交！");
			return false;
		}
		layer.confirm ('确定不批转？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
	    	$.post('document/finish', {"descr":$("#descr").val(),"insId":"${ins.id}"}, function(result,
    				status) {
    			document.location = 'document/ins'
    		});
		    layer.closeAll ();
	    });

	}
    $ (function () {
    	UPLOADER.formData = {
    		    applyTo : "CASH",
    		    refNum : "${o.id}"
    	    }
    	UPLOADER.init ();
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

        if("${o.id}" >0){
            $("#type").select2("val","${o.type}")
		}
	    loadGrid();

    })
</script>

<body style="background-color: #e9e1f1">
<div class="breadcrumb content-header form-inline"
	 style="padding:8px;">

	<button class="btn btn-info" id="btnAdd" type="button"
			onclick="onSave()">保存</button>
</div>
<!-- Custom Tabs -->
<div id="uploader" class="wu-example">
	<!--用来存放文件信息-->
	<div id="thelist" class="uploader-list"></div>
	<div class="btns" style="display:none;">
		<div id="picker">选择文件</div>
		<button id="ctlBtn" class="btn btn-default">开始上传</button>
	</div>
</div>
<div class="container-fluid">
	<div>&nbsp;&nbsp;</div>
	<div class="nav-tabs-custom">
		<ul class="nav nav-tabs">
			<li class="active"><a href="#tab_1" data-toggle="tab">基本信息</a></li>
			<li><a href="#tab_2" data-toggle="tab"></a></li>
			<li><a href="#tab_3" data-toggle="tab"></a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active" id="tab_1">
				<div  style="background-color: #e9e1f1">
					<form id="mainForm" class="form-horizontal" >
						<input type="hidden" id="id" name="id" value="${o.id}" />
						<input type="hidden" id="sqrId" name="sqrId" value="${o.sqrId}" />
						<input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />
						<input type="hidden" id="minus" name="minus" value="${o.minus}" />
						<input type="hidden" id="title" name="title" value="${o.title}" />
						<input type="hidden" id="status" name="status" value="${o.status}" />

						<%--<input type="hidden" id="sqr" name="sqr" value="${o.sqr}" />--%>
						<%--<input type="hidden" id="org" name="org" value="${o.org}" />--%>

						<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />

						<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
						<div>&nbsp;</div>
						<div class="form-group">
							<label class="col-sm-1 control-label" for="sqr">申请人</label>
							<div class="col-sm-5">
								<div class="input-group">
									<input class="form-control" id="sqr" name="sqr"
										   value="${o.sqr}" type="text" readOnly/>
									<div class="input-group-addon">
										<i class="fa fa-search"
										   onclick="onSelPerson()"></i>
									</div>
								</div>
							</div>
							<label class="col-sm-1 control-label" for="sqrq">申请日期</label>
							<div class="col-sm-5">
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
							<label class="col-sm-1 control-label" for="org">部门</label>
							<div class="col-sm-5">
								<input class="form-control" id="org" name="org"
									   value="${o.org}" type="text" readonly />
							</div>
							<label class="col-sm-1 control-label" for="type">类型</label>
							<div class="col-sm-5">
								<select id="type" name="type" class="form-control select2" style="width: 320px">
									<option value="普通费用报销">普通费用报销</option>
									<option value="差旅报销">差旅报销</option>
									<option value="其它">其它</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-1 control-label" for="org">支付方式</label>
							<div class="col-sm-5">
								<div class="radio">
									<label>
										<input type="radio" name="pay" id="pay1" value="现金" checked>
										现金
									</label>
									<label>
										<input type="radio" name="pay" id="pay2" value="转账 ">
										转账
									</label>
									<label>
										<input type="radio" name="pay" id="pay3" value="支票 ">
										支票
									</label>
								</div>
							</div>
							<label class="col-sm-1 control-label" for="reason">报销原因</label>
							<div class="col-sm-5">
								<input class="form-control" id="reason" name="reason"
									   value="${o.reason}" type="text" />
							</div>
						</div>
					<div>&nbsp;</div>
						<div class="form-group">
							<div class="container-fluid">
							<div class="box box-default box-solid">
								<div class="box-header with-border">
									<h3 class="box-title">单据明细</h3>

									<div class="box-tools pull-right">
										<button type="button" onclick="addRow()" class="btn btn-box-tool"><i class="fa fa-plus"></i>
										</button>
									</div>
									<!-- /.box-tools -->
								</div>
								<!-- /.box-header -->
								<div class="box-body">
									<table id="cash"></table>
								</div>
								<!-- /.box-body -->
							</div>
							<!-- /.box -->
							</div>
						</div>

						<div class="form-group">
							<div class="container-fluid">
							<label class="col-sm-1 control-label" for="org">报销金额</label>
							<div class="col-sm-5">
								<input class="form-control" id="total" name="total"
									   value="${o.total}" type="text" />
							</div>
							<label class="col-sm-1 control-label" for="paper">单据总数</label>
							<div class="col-sm-5">
								<input class="form-control" id="paper" name="paper"
									   value="${o.paper}" type="text" />
							</div>
							</div>
						</div>

						<div class="form-group">
							<div class="container-fluid">
							<div class="box box-default box-solid">
								<div class="box-header with-border">
									<h3 class="box-title">备注</h3>

									<div class="box-tools pull-right">
										<%--<button type="button" class="btn btn-box-tool"><i class="fa fa-plus"></i>--%>
										<%--</button>--%>
									</div>
									<!-- /.box-tools -->
								</div>
								<!-- /.box-header -->
								<div class="box-body">
									<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
								</div>
								<!-- /.box-body -->
							</div>
							<!-- /.box -->
							</div>
						</div>

						<div class="form-group">
							<div class="container-fluid">
							<div class="box box-default box-solid">
								<div class="box-header with-border">
									<h3 class="box-title">单据附件</h3>

									<div class="box-tools pull-right">
										<button type="button" onclick="onSelfUpload()" class="btn btn-box-tool"><i class="fa fa-plus"></i>
										</button>
									</div>
									<!-- /.box-tools -->
								</div>
								<!-- /.box-header -->
								<div class="box-body">
									<table id="grid"></table>
								</div>
								<!-- /.box-body -->
							</div>
							<!-- /.box -->
							</div>
						</div>


					</form>
				</div>
				<div>&nbsp;</div>
			</div>
			<!-- /.tab-pane -->
			<div class="tab-pane" id="tab_2">
				222
			</div>
			<!-- /.tab-pane -->
			<div class="tab-pane" id="tab_3">
				333
			</div>
			<!-- /.tab-pane -->
		</div>
		<!-- /.tab-content -->
	</div>
	<!-- nav-tabs-custom -->
</div>



</body>
</html>
