<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<title>办公用品-编辑</title>
	<script type="text/javascript">
        //保存
        function onSave () {
            //表单验证
            if (!$ ('#mainForm').validate ().form ()){
                return false;
            }
            var para = $ ("#mainForm").serialize ();
            $.post ('goods/suplist/save', $ ("#mainForm").serialize (), function (result, status) {
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
                title : "选择领用部门",
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
            layer.close(_index);
        }

        $ (function () {
            //加载select特效
            $ (".select2").select2 ();
            //为日期设置格式输入
            $ ("#supdate").inputmask ("yyyy-mm-dd", {
                "placeholder" : "yyyy-mm-dd"
            });
            //加载日期控件
            $ ('#supdate').datetimepicker ({
                minView : 3
                //时间，默认为日期时间
            });
            //设置掩码
            $ ('#supdate').inputmask ("yyyy-mm-dd");

            //赋值
            if ("${o.id}" > 0){

            }

        })
	</script>
</head>

<body>
<div class="container-fluid">
	<div>&nbsp;</div>

	<form id="mainForm" class="form-horizontal">
		<input type="hidden" id="id" name="id" value="${o.id}" />
		<input type="hidden" id="type" name="type" value="${o.type}" />
		<input type="hidden" id="sym" name="sym" value="${o.sym}" />

		<input type="hidden" id="price" name="price" value="${o.price}" />
		<input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />


		<input type="hidden" id="personId" name="personId" value="${o.personId}" />
		<input type="hidden" id="person" name="person" value="${o.person}" />
		<input type="hidden" id="refNum" name="refNum" value="${o.refNum}" />



		<div class="form-group">
			<label class="col-sm-2 control-label" for="name">名称</label>
			<div class="col-sm-4">
				<input class="form-control" value="${goods.name}"
					   type="text"  readonly/>
			</div>
			<label class="col-sm-2 control-label" for="spec">规格型号</label>
			<div class="col-sm-4">
				<input class="form-control"  value="${goods.spec}"
					   type="text"  readonly/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="num">领用数量</label>
			<div class="col-sm-4">
				<input class="form-control" id="num" name="num" value="${o.num}"
					   type="text" readonly />
			</div>
			<label class="col-sm-2 control-label" for="price">领用部门</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="org" name="org"
						   value="${o.org}" readonly type="text" />
					<div class="input-group-addon">
						<i class="fa fa-search"
						   ></i>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="supdate">领用日期</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="supdate" name="supdate" value="${o.supdate}"
						   type="text" readonly/>
					<div class="input-group-addon">
						<i class="fa fa-calendar"
						   ></i>
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
		<div class="form-group controls" style="text-align:center">
			<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
		</div>
	</form>
</div>
</body>
</html>
