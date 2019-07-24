<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>用户管理统计</title>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<link rel="stylesheet" href="jslib/amcharts/css/style.css"
	type="text/css">
<link href='jslib/amcharts/css/googleapis.css' rel='stylesheet'
	type='text/css'>
<script src="jslib/amcharts/amcharts.js" type="text/javascript"></script>
<script src="jslib/amcharts/radar.js" type="text/javascript"></script>
<script src="jslib/amcharts/serial.js" type="text/javascript"></script>
<script src="jslib/amcharts/pie.js" type="text/javascript"></script>
<script src="jslib/amcharts/themes/light.js" type="text/javascript"></script>
<script src="jslib/amcharts/themes/dark.js" type="text/javascript"></script>
<script src="jslib/amcharts/themes/black.js" type="text/javascript"></script>
<script src="jslib/amcharts/themes/chalk.js" type="text/javascript"></script>
<script src="jslib/amcharts/themes/patterns.js" type="text/javascript"></script>
<script>
	//初始化
	$(function() {
		loadGrid();
		genChart();
	});
	//生成表格
	function loadGrid() {
		$("#grid")
				.jqGrid(
						{
							url : "cms/webUser/list",
							height : (document.body.clientHeight - 130) / 2,
							fitColumns : true,
							rownumbers : true,
							colModel : [
									{
										label : '用户名',
										name : 'userName',
										index : 'userName',
										width : 100
									},
									{
										label : '手机号码',
										name : 'mobile',
										index : 'mobile',
										width : 100
									},
									{
										label : '邮箱地址',
										name : 'email',
										index : 'email',
										width : 70
									},
									{
										label : '性别',
										name : 'gender',
										index : 'gender',
										width : 70
									},
									{
										label : '是否启用',
										name : 'isActive',
										index : 'isActive',
										width : 50,
										formatter : function(value, options,
												row) {
											return value == 1 ? '使用中'
													: '<span style="color:gray;">已停用</span>'
										}

									} ],
							rowNum : 15,
							rowList : [ 15, 50, 100 ],
							pager : '#pager'
						});
	}
	//窗口变化时自适应宽度
	window.onresize = function() {
		$("#grid").setGridWidth(document.body.clientWidth - 12);
	}
	//取消
	function onCancel() {
		$("#grid").trigger("reloadGrid");
		layer.closeAll();
	}
	//查询
	function onQ(para) {
		var para = para || getPara();
		$("#grid").jqGrid("setGridParam", {
			postData : para
		}).trigger("reloadGrid");
		genChart1();
	}
	//显示全部
	function showAll() {
		$("#userName").val("");
		var para = {
			userName : $("#userName").val()
		}
		onQ(para);
	}

	var chart;
	function genChart(chartData) {
		var para = getPara();
		$.post("cms/webStatistic/webuserCount", para, function(rslt) {
			
			var data = [];
			
			$.each(rslt, function(idx, obj) {
			var d=[];
			if(rslt[idx][0].indexOf(',')>0){
				d=rslt[idx][0].split(',')
				for(var i=0;i<d.length;i++){
					if(d[i]==""||d[i]==null||d[i]==undefined){
							continue;
						}
						var yflag=false;
					for(var j=0;j<data.length;j++){
								
						if(d[i]==data[j].key){
							data[j].value=data[j].value+1;
							yflag=true;
							continue;
						}
				   		 
				     }
				     if(!yflag){
				   
				     data[data.length] = {
						key : d[i],
						value : rslt[idx][1],
						url : "javascript:var para=getPara();para['productNames']='"
							+ rslt[idx][0] +  "';onQ(para,1);"
				}
				     }
			    }
			}else{
				data[data.length] = {
					key : rslt[idx][0],
					value : rslt[idx][1],
					url : "javascript:var para=getPara();para['productNames']='"
							+ rslt[idx][0] +  "';onQ(para,1);"
				}
			}
			
		
			})


 			// SERIAL CHART
		    chart = new AmCharts.AmSerialChart ();
		    chart.dataProvider = data;
		    chart.categoryField = "key";
		    chart.startDuration = 1;
		    // AXES
		    // category
		    var categoryAxis = chart.categoryAxis;
		    categoryAxis.labelRotation = 45; // this line makes category values to be rotated
		    categoryAxis.gridAlpha = 0;
		    categoryAxis.fillAlpha = 1;
		    categoryAxis.fillColor = "#FAFAFA";
		    categoryAxis.gridPosition = "start";
		    // value
		    var valueAxis = new AmCharts.ValueAxis ();
		    valueAxis.dashLength = 5;
		    valueAxis.title = "用户管理分析统计";
		    valueAxis.axisAlpha = 0;
		    chart.addValueAxis (valueAxis);
		    // GRAPH
		    var graph = new AmCharts.AmGraph ();
		    graph.valueField = "value";
		    graph.colorField = "color";
		   graph.balloonText = "[[key]]:数量 [[value]]";
		    graph.type = "column";
		    graph.lineAlpha = 0;
		    graph.fillAlphas = 1;
		    graph.urlField = "url";
		    graph.urlTarget = "_self";
		    chart.addGraph (graph);
		    // CURSOR
		    var chartCursor = new AmCharts.ChartCursor ();
		    chartCursor.cursorAlpha = 0;
		    chartCursor.zoomable = false;
		    chartCursor.categoryBalloonEnabled = false;
		    chart.addChartCursor (chartCursor);
		    chart.creditsPosition = "top-right";
		    // WRITE
		    chart.write ("chartdiv");

		})
	}

	function getPara() {
		var para = {
			userName : $("#userName").val()
		}
		return para;
	}

	$(function() {
		$("#chartdiv").height((document.body.clientHeight - 130) / 2)
	})
</script>
</head>

<body>
		<div class="container-fluid">
		<div class="breadcrumb content-header form-inline"
			style="padding:8px;">
			<div class="form-group">
				<label for="userName">用户名</label> <input
					class="form-control input-sm" id="userName" value="" type="text" />
				<label for="gender">性别</label> <input
					class="form-control input-sm" id="gender" value="" type="text" />
			</div>

			<div class="form-group">
				<button class="btn btn-info" id="btnAdd" type="button"
					onclick="onQ()">查询</button>
			</div>
			<div class="form-group">
				<button class="btn btn-info" id="btnShowAll" type="button"
					onclick="showAll()">显示全部</button>
			</div>


		</div>
		<div class="row">
			<div class="col-sm-12">
				<div id="chartdiv" style="width: 100%;">&nbsp;</div>
			</div>
		</div>
		<table id="grid"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>