<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<title>车辆费用登记</title>
	<script type="text/javascript">
        //保存
        function onSave () {
            //表单验证
            if (!$ ('#mainForm').validate ().form ()){
                return false;
            }
            var para = $ ("#mainForm").serialize ();
            $.post ('car/saveInfo', $ ("#mainForm").serialize (), function (result, status) {
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
        function onSelPerson () {
            layer.open ({
                type : 2,
                title : "选择申请人",
                shadeClose : true,
                shade : 0.8,
                area : [
                    '800', '500'
                ],
                content : 'base/person/sel' //iframe的url
            });
        }
        //选择部门回调方法
        function onPersonSelOk (node) {
            $ ("#sqrId").val (node.id)
            $ ("#sqr").val (node.name)
            $ ("#orgId").val (node.baseOrgId)
            $ ("#org").val (node.baseOrgName)
            layer.closeAll ()
        }


        //选择部门
        function onSelCar () {
            layer.open ({
                type : 2,
                title : "选择车辆",
                shadeClose : true,
                shade : 0.8,
                area : [
                    '800', '500'
                ],
                content : 'car/sel' //iframe的url
            });
        }
        //选择部门回调方法
        function onCarSelOk (node) {
            $ ("#carId").val (node.id)
            $ ("#cardNo").val (node.cardNo)

            layer.closeAll ()
        }


        $ (function () {
            //加载select特效
            $ (".select2").select2 ();
            //为日期设置格式输入
            $ ("#starttime").inputmask ("yyyy-mm-dd", {
                "placeholder" : "yyyy-mm-dd"
            });
            //加载日期控件
            $ ('#starttime').datetimepicker ({
                minView : 3
                //时间，默认为日期时间
            });
            //设置掩码
            $ ('#starttime').inputmask ("yyyy-mm-dd");


            $ ("#finishtime").inputmask ("yyyy-mm-dd", {
                "placeholder" : "yyyy-mm-dd"
            });
            //加载日期控件
            $ ('#finishtime').datetimepicker ({
                minView : 3
                //时间，默认为日期时间
            });
            //设置掩码
            $ ('#finishtime').inputmask ("yyyy-mm-dd");

            //赋值
            if ("${o.id}" > 0){
                $("#type").select2("val","${o.type}")

            }else{
                $("#carId").val("${car.id}")
                $("#cardNo").val("${car.cardNo}")

            }
        })
	</script>
</head>

<body>
<div class="container-fluid">
	<div>&nbsp;</div>
	<form id="mainForm" class="form-horizontal">
		<input type="hidden" id="id" name="id" value="${o.id}" />
		<input type="hidden" id="sqrId" name="sqrId" value="${o.sqrId}" />

		<input type="hidden" id="carId" name="carId" value="${o.carId}" />


		<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />

		<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />

		<div class="form-group">
			<label class="col-sm-2 control-label" for="cardNo">车辆车号</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="cardNo" name="cardNo"
						   value="${o.cardNo}" type="text" readOnly/>
					<div class="input-group-addon">
						<i class="fa fa-search"
						   onclick="onSelCar()"></i>
					</div>
				</div>
			</div>
			<label class="col-sm-2 control-label" for="sqr">送保人</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="sqr" name="sqr"
						   value="${o.sqr}" type="text" readOnly/>
					<div class="input-group-addon">
						<i class="fa fa-search"
						   onclick="onSelPerson()"></i>
					</div>
				</div>
			</div>
		</div>



		<div class="form-group">
			<label class="col-sm-2 control-label" for="baoyangfeiyong">保养/修理费用</label>
			<div class="col-sm-4">
				<input class="form-control" id="baoyangfeiyong" name="baoyangfeiyong" value="${o.baoyangfeiyong}"
					   type="text" />
			</div>
			<label class="col-sm-2 control-label" for="qitafeiyong">其他费用</label>
			<div class="col-sm-4">
				<input class="form-control" id="qitafeiyong" name="qitafeiyong" value="${o.qitafeiyong}"
					   type="text" />
			</div>
		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label" for="starttime">送保/送修时间</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="starttime" name="starttime" value="${o.starttime}"
						   type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar"
						   onclick="$('#starttime').datetimepicker('show');"></i>
					</div>
				</div>
			</div>
			<label class="col-sm-2 control-label" for="finishtime">完成时间</label>
			<div class="col-sm-4">
				<div class="input-group">
					<input class="form-control" id="finishtime" name="finishtime" value="${o.finishtime}"
						   type="text" />
					<div class="input-group-addon">
						<i class="fa fa-calendar"
						   onclick="$('#finishtime').datetimepicker('show');"></i>
					</div>
				</div>
			</div>

		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label" for="baoyangchangjia">保养/维修厂家</label>
			<div class="col-sm-4">
				<input class="form-control" id="baoyangchangjia" name="baoyangchangjia" value="${o.baoyangchangjia}"
					   type="text" />
			</div>
			<label class="col-sm-2 control-label" for="type">类型</label>
			<div class="col-sm-4">
				<select class="select2">
					<option value="保养">保养</option>
					<option value="维修">维修</option>
				</select>
				<input class="form-control" id="type" name="type" value="${o.type}"
					   type="text" />
			</div>

		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label" for="changjiadizhi">维修/保养厂家地址</label>
			<div class="col-sm-10">
				<input class="form-control" id="changjiadizhi" name="changjiadizhi" value="${o.changjiadizhi}"
					   type="text" />
			</div>

		</div>

		<div class="form-group">
			<label class="col-sm-2 control-label" for="total">总费用</label>
			<div class="col-sm-10">
				<input class="form-control" id="total" name="total" value="${o.total}"
					   type="text" />
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
