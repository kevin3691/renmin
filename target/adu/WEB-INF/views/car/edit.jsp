<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<title>车辆-编辑</title>
<script type="text/javascript">
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('car/save', $ ("#mainForm").serialize (), function (result, status) {
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


    $ (function () {
	    //加载select特效
	    $ (".select2").select2 ();
	    //为日期设置格式输入
	    $ ("#goumairiqi").inputmask ("yyyy-mm-dd", {
		    "placeholder" : "yyyy-mm-dd"
	    });
	    //加载日期控件
	    $ ('#goumairiqi').datetimepicker ({
		    minView : 3
	    //时间，默认为日期时间
	    });
	    //设置掩码
	    $ ('#goumairiqi').inputmask ("yyyy-mm-dd");

	    //赋值
	    if ("${o.id}" > 0){
		    $ ("#type").select2 ("val", "${o.type}");

	    }else{
	        $("#status").val('空闲')
		}
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">
			<input type="hidden" id="id" name="id" value="${o.id}" />
			<input type="hidden" id="shiyongxingzhi" name="shiyongxingzhi" value="${o.shiyongxingzhi}" />
			<input type="hidden" id="cheliangjibie" name="cheliangjibie" value="${o.cheliangjibie}" />
			<input type="hidden" id="zhuyaoshiyongdanwei" name="zhuyaoshiyongdanwei" value="${o.zhuyaoshiyongdanwei}" />
			<input type="hidden" id="zhuyaoshiyongren" name="zhuyaoshiyongren" value="${o.zhuyaoshiyongren}" />

			<input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
			<input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />

			<jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
			<div class="form-group">
				<label class="col-sm-2 control-label" for="cardNo">车牌号</label>
				<div class="col-sm-4">
					<input class="form-control" id="cardNo" name="cardNo" value="${o.cardNo}"
						   type="text" required />
				</div>
				<label class="col-sm-2 control-label" for="status">车辆状态</label>
				<div class="col-sm-4">
					<input class="form-control" id="status" name="status"
						   value="${o.status}" type="text" readOnly/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label" for="pinpai">品牌</label>
				<div class="col-sm-4">
					<input class="form-control" id="pinpai" name="pinpai" value="${o.pinpai}"
						   type="text"  />
				</div>
				<label class="col-sm-2 control-label" for="xinghao">型号</label>
				<div class="col-sm-4">
					<input class="form-control" id="xinghao" name="xinghao"
						   value="${o.xinghao}" type="text"/>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="type">类型</label>
				<div class="col-sm-4">
					<select id="type" name="type" class="form-control select2">
						<option value="轿车">轿车</option>
						<option value="SUV">SUV</option>
						<option value="商务车">商务车</option>
						<option value="面包车">面包车</option>
						<option value="皮卡">皮卡</option>
						<option value="货车">货车</option>

					</select>
				</div>
				<label class="col-sm-2 control-label" for="fadongji">发动机号</label>
				<div class="col-sm-4">
					<input class="form-control" id="fadongji" name="fadongji"
						   value="${o.fadongji}" type="text"/>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label" for="goumairiqi">购买日期</label>
				<div class="col-sm-4">
					<div class="input-group">
						<input class="form-control" id="goumairiqi" name="goumairiqi" value="${o.goumairiqi}"
							   type="text" />
						<div class="input-group-addon">
							<i class="fa fa-calendar"
							   onclick="$('#goumairiqi').datetimepicker('show');"></i>
						</div>
					</div>
				</div>
				<label class="col-sm-2 control-label" for="source">车辆来源</label>
				<div class="col-sm-4">
					<input class="form-control" id="source" name="source"
						   value="${o.source}" type="text" />
				</div>

			</div>


			<div class="form-group">
				<label class="col-sm-2 control-label" for="yiyonglicheng">已用里程</label>
				<div class="col-sm-4">
					<input class="form-control" id="yiyonglicheng" name="yiyonglicheng" value="${o.yiyonglicheng}"
						   type="text"  />
				</div>
				<label class="col-sm-2 control-label" for="xianzairenshu">限载人数</label>
				<div class="col-sm-4">
					<input class="form-control" id="xianzairenshu" name="xianzairenshu"
						   value="${o.xianzairenshu}" type="text"/>
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
