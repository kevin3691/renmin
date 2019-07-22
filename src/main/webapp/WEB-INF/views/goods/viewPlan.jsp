<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>固定资产-编辑</title>
<script type="text/javascript">
    var lastFlag ;

	function loadGrid2(){
        $ ("#cash").jqGrid (
            {
                url : "goods/listGPList",
                postData:{
                    refNum:${o.id}
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
                sortorder : "asc"

            });

	}
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
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
							   onclick=""></i>
						</div>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="sqrq">申请日期</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="sqrq" name="sqrq" value="${o.sqrq}"
							   type="text" readonly/>
						<div class="input-group-addon">
							<i class="fa fa-calendar"
							   onclick=""></i>
						</div>
					</div>
				</div>
			</div>

            <div class="form-group">
                <label class="col-sm-2 control-label" for="descr">备注</label>
                <div class="col-sm-10">
                    <textarea class="form-control" id="descr" name="descr" rows=3 readonly>${o.descr}</textarea>
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

                                <div class="col-sm-12" id="sel">
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
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>

	</div>
</body>
</html>
