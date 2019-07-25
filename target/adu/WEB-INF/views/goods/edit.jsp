<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>固定资产-编辑</title>
<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('goods/save', $ ("#mainForm").serialize (), function (result, status) {
		    if (parent.onSaveOk){
			    parent.onSaveOk (result.entity)
		    }
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
	        title : "选择类别",
	        shadeClose : true,
	        shade : 0.8,
	        area : [
	                '350', '420'
	        ],
	        content : 'goodstype/sel' //iframe的url
	    });
    }
    //选择部门回调方法 
    function onSelOrgOk (node) {
	    $ ("#typeId").val (node.id)
	    $ ("#type").val (node.name)
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

	function onSelPerson () {
		var title = '选择领用人'

		_index = layer.open ({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [
				'900', '400'
			],
			content : 'base/person/sel' //iframe的url
		});
	}
	//选择部门回调方法
	function onPersonSelOk (node) {
		$("#keeperId").val(node.id)
		$("#keeper").val(node.name)
		$("#status").select2("val","领出")
		$("#org").val(node.baseOrgName)
		$("#orgId").val(node.baseOrgId)
		layer.close(_index);
	}


	function onSelType () {
		var title = '选择类别'

		_index = layer.open ({
			type : 2,
			title : title,
			shadeClose : true,
			shade : 0.8,
			area : [
				'300', '400'
			],
			content : 'goodstype/sel' //iframe的url
		});
	}
	//选择部门回调方法
	function onSelTypeOk (node) {
		$("#typeId").val(node.id)
		$("#type").val(node.name)
		layer.close(_index);
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


		//为日期设置格式输入
		$ ("#invoicedt").inputmask ("yyyy-mm-dd", {
			"placeholder" : "yyyy-mm-dd"
		});
		//加载日期控件
		$ ('#invoicedt').datetimepicker ({
			minView : 3
			//时间，默认为日期时间
		});
		//设置掩码
		$ ('#invoicedt').inputmask ("yyyy-mm-dd");

	    //赋值
	    if ("${o.id}" > 0){
		    $ ("#status").select2 ("val", "${o.status}");
	    }

        $("#authorId").val("${baseUser.id}")
        $("#author").val("${baseUser.basePersonName}")
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="typeId" name="typeId" value="${o.typeId}" />
			<input type="hidden" id="category" name="category" value="${o.category}" />

			<input type="hidden" id="belong" name="belong" value="${o.belong}" />
			<input type="hidden" id="keeperId" name="keeperId" value="${o.keeperId}" />
			<input type="hidden" id="source" name="source" value="${o.source}" />
			<input type="hidden" id="quanity" name="quanity" value="${o.quanity}" />
			<input type="hidden" id="total" name="total" value="${o.total}" />
			<input type="hidden" id="warn" name="warn" value="${o.warn}" />
			<input type="hidden" id="voucherno" name="voucherno" value="${o.voucherno}" />
			<%--<input type="hidden" id="invoicedt" name="invoicedt" value="${o.invoicedt}" />--%>
			<input type="hidden" id="invoiceval" name="invoiceval" value="${o.invoiceval}" />
			<input type="hidden" id="providerId" name="providerId" value="${o.providerId}" />
			<input type="hidden" id="deptype" name="deptype" value="${o.deptype}" />
			<input type="hidden" id="depbdt" name="depbdt" value="${o.depbdt}" />
			<input type="hidden" id="depbase" name="depbase" value="${o.depbase}" />
			<input type="hidden" id="perofcost" name="perofcost" value="${o.perofcost}" />
			<input type="hidden" id="depyears" name="depyears" value="${o.depyears}" />
			<input type="hidden" id="netsalvage" name="netsalvage" value="${o.netsalvage}" />
			<input type="hidden" id="authorId" name="authorId" value="${o.authorId}" />
			<input type="hidden" id="codeimg" name="codeimg" value="${o.codeimg}" />
			<input type="hidden" id="codesrc" name="codesrc" value="${o.codesrc}" />
			<input type="hidden" id="org" name="org" value="${o.org}" />
			<input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />
			<input type="hidden" id="categoryId" name="categoryId" value="${o.categoryId}" />

			<input type="hidden" id="qrcode" name="qrcode" value="${o.qrcode}" />
			<input type="hidden" id="barcode" name="barcode" value="${o.barcode}" />
			<input type="hidden" id="img" name="img" value="${o.img}" />

			<input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />





			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="name">名称</label>
				<div class="col-sm-4">
					<input class="form-control" id="name" name="name" value="${o.name}"
						   type="text" required />
				</div>
				<label class="col-sm-2 control-label" for="name">类别</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="type" name="type"
							   value="${o.type}" readonly type="text" />
						<div class="input-group-addon">
							<i class="fa fa-search"
							   onclick="onSelType()"></i>
						</div>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="sn">编号</label>
				<div class="col-sm-4">
					<input class="form-control" id="sn" name="sn" value="${o.sn}"
						   type="text"  />
				</div>
				<label class="col-sm-2 control-label" for="unit">单位</label>
				<div class="col-sm-4">
					<select class="form-control select2" id="unit" name="unit">
						<option value="台">台</option>
					</select>

				</div>
			</div>
			<div class="form-group">

				<label class="col-sm-2 control-label" for="spec">规格型号</label>
				<div class="col-sm-4">
					<input class="form-control" id="spec" name="spec" value="${o.spec}"
						   type="text" required />
				</div>

				<label class="col-sm-2 control-label" for="startdt">购买日期</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="invoicedt" name="invoicedt" value="${o.invoicedt}"
							   type="text" />
						<div class="input-group-addon">
							<i class="fa fa-calendar"
							   onclick="$('#invoicedt').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="author">登记人</label>
				<div class="col-sm-4">
					<input class="form-control" id="author" name="author" readonly value="${o.author}"
						   type="text"  />
				</div>
				<label class="col-sm-2 control-label" for="startdt">登记日期</label>
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
				<label class="col-sm-2 control-label" for="name">领用人</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="keeper" name="keeper"
							   value="${o.keeper}" readonly type="text" />
						<div class="input-group-addon">
							<i class="fa fa-search"
							   onclick="onSelPerson()"></i>
						</div>
					</div>
				</div>

				<label class="col-sm-2 control-label" for="spec">使用地</label>
				<div class="col-sm-4">
					<input class="form-control" id="location" name="location" value="${o.location}"
						   type="text" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="provider">供应商名称</label>
				<div class="col-sm-4">
					<input class="form-control" id="provider" name="provider" value="${o.provider}"
						   type="text"  />
				</div>
				<label class="col-sm-2 control-label" for="contactperson">联系人</label>
				<div class="col-sm-4">
					<input class="form-control" id="contactperson" name="contactperson" value="${o.contactperson}"
						   type="text"  />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="address">联系地址</label>
				<div class="col-sm-10">
					<input class="form-control" id="address" name="address" value="${o.address}"
						   type="text"  />
				</div>

			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="phone">电话</label>
				<div class="col-sm-4">
					<input class="form-control" id="phone" name="phone" value="${o.phone}"
						   type="text"  />
				</div>
				<label class="col-sm-2 control-label" for="email">邮件</label>
				<div class="col-sm-4">
					<input class="form-control" id="email" name="email" value="${o.email}"
						   type="text"  />
				</div>
			</div>


			<div class="form-group">

				<label class="col-sm-2 control-label" for="status">状态</label>
				<div class="col-sm-4">
					<select id="status" name="status" class="form-control select2">
						<option value="闲置">闲置</option>
						<option value="领出">领出</option>
						<option value="报废">报废</option>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="descr">备注</label>
				<div class="col-sm-10">
					<textarea class="form-control" id="descr" name="descr" rows=3>${o.descr}</textarea>
				</div>
			</div>
			<div class="form-group controls" style="text-align:center">
				<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
				&nbsp;&nbsp;
				<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
			</div>
		</form>
	</div>
	<iframe scrolling="no" src="goods/record"  width="100%" height="500px" style="padding: 20px;padding-bottom: 40px" frameborder="0"  allowtransparency="true"></iframe>
</body>
</html>
