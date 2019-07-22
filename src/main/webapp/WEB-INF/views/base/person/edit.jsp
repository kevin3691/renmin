<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<title>人员-编辑</title>
	<script type="text/javascript">
        //保存
        function onSave () {
            //表单验证
            if (!$ ('#mainForm').validate ().form ()){
                return false;
            }
            var para = $ ("#mainForm").serialize ();
            $.post ('base/person/save', $ ("#mainForm").serialize (), function (result, status) {
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
                title : "选择单位",
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
            $ ("#baseOrgId").val (node.id)
            $ ("#baseOrgName").val (node.name)
            layer.closeAll ()
        }
        //数据字典回调函数,初始化后为其赋值
        function dictCallBack (container) {
            if (container == "title"){
                $ ("#title").select2 ("val", "${o.title}");
            }
            else if (container == "education"){
                $ ("#education").select2 ("val", "${o.education}");
            }
            else if (container == "gender"){
                $ ("#gender").select2 ("val", "${o.gender}");
            }
        }
        $ (function () {
            //加载select特效
            $ (".select2").select2 ();
            //为日期设置格式输入
            $ ("#DOB").inputmask ("yyyy-mm-dd", {
                "placeholder" : "yyyy-mm-dd"
            });
            //加载日期控件
            $ ('#DOB').datetimepicker ({
                minView : 3
                //时间，默认为日期时间
            });
            //设置掩码
            $ ('#DOB').inputmask ("yyyy-mm-dd");
            //加载数据字典--性别
            bindDictSelect ("GENDER", "gender");
            //加载数据字典--职务
            bindDictSelect ("TITLE", "title");
            //加载数据字典--教育程度
            bindDictSelect ("EDUCATION", "education");
            //赋值
            if ("${o.id}" > 0){
                $ ("#isActive").select2 ("val", "${o.isActive}");
            }
        })
	</script>
</head>

<body>
<div class="container-fluid">
	<div>&nbsp;</div>
	<form id="mainForm" class="form-horizontal">
		<input type="hidden" id="id" name="id" value="${o.id}" />
		<input type="hidden" id="baseOrgId" name="baseOrgId" value="${o.baseOrgId}" />
		<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
		<div class="form-group">
			<label class="col-sm-2 control-label" for="name">姓名</label>
			<div class="col-sm-4">
				<input class="form-control" id="name" name="name" value="${o.name}"
					   type="text" required />
			</div>
			<label class="col-sm-2 control-label" for="baseOrgName">单位</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="baseOrgName" name="baseOrgName"
						   value="${o.baseOrgName}" type="text" readOnly/>
					<div class="input-group-addon">
						<i class="fa fa-search"
						   onclick="onSelOrg()"></i>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="gender">性别</label>
			<div class="col-sm-4">
				<select id="gender" name="gender" class="form-control select2">
				</select>
			</div>
			<label class="col-sm-2 control-label" for="DOB">出生日期</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="DOB" name="DOB" value="${o.DOB}"
						   type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar"
						   onclick="$('#DOB').datetimepicker('show');"></i>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="title">职务</label>
			<div class="col-sm-4">
				<select id="title" name="title" class="form-control select2">
				</select>
			</div>
			<label class="col-sm-2 control-label" for="education">教育程度</label>
			<div class="col-sm-4">
				<select id="education" name="education"
						class="form-control select2">
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="phone">联系电话</label>
			<div class="col-sm-4">
				<input class="form-control" id="phone" name="phone"
					   value="${o.phone}" type="text" phone=true />
			</div>
			<label class="col-sm-2 control-label" for="mobile">移动电话</label>
			<div class="col-sm-4">
				<input class="form-control" id="mobile" name="mobile"
					   value="${o.mobile}" type="text" mobile=true />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="email">邮箱</label>
			<div class="col-sm-4">
				<input class="form-control" id="email" name="email"
					   value="${o.email}" type="text" email=true />
			</div>
			<label class="col-sm-2 control-label" for="isActive">状态</label>
			<div class="col-sm-4">
				<select id="isActive" name="isActive" class="form-control select2">
					<option value=1>启用</option>
					<option value=0>停用</option>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label" for="address">地址</label>
			<div class="col-sm-10">
				<input class="form-control" id="address" name="address"
					   value="${o.address}" type="text" />
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
