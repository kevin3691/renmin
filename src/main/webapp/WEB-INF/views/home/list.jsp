<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>${WorkplateTitle}</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	//String basePath = path + "/";
	
%>
<base id="basePath" href="<%=basePath%>">
<script type="text/javascript">
    var _BasePath = "<%=basePath%>"
   
</script>
    
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<meta http-equiv="X-FRAME-OPTIONS" content="DENY">
<meta http-equiv="X-Content-Type-Options" content="nosniff">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="<%=basePath%>images/favicon.ico">
<!-- <link href="jslib/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
 -->
<script type="text/javascript" charset="utf-8"
	src="jslib/jquery-1.12.4.min.js"></script>

<script type="text/javascript" charset="utf-8"
	src="jslib/jquery.validate.min.js"></script>

<script type="text/javascript" charset="utf-8" src="jslib/form.min.js"></script>
<script type="text/javascript" charset="utf-8" src="JavaScriptServlet"></script>


<link href="css/master.css" rel="stylesheet" type="text/css">
<link href="css/public.css" rel="stylesheet" type="text/css">
<link href="css/index2.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="jslib/koala.min.1.5.js"></script>
	<script src='jslib/layer-v2.0/layer/layer.js'></script>
	<script src='jslib/laytpl-v1.1/laytpl/laytpl.js'></script>
	<link rel="stylesheet"
		href="jslib/laypage-v1.3/laypage/skin/laypage.css" />
	<script src='jslib/laypage-v1.3/laypage/laypage.js'></script>
	<script type="jslib/commonTop.js"></script>
	
	<script type="text/javascript">
	// 0 "yyyy-MM-dd",1 "yyyy-MM-dd HH:mm",2 "yyyy-MM-dd HH:mm:ss"
	function jsonDateTimeFormatter (jsondate, fmt) {
		fmt = fmt || 0
		if (jsondate == null || jsondate == ""){
			return "";
		}
		if (typeof (jsondate) == "string" && jsondate.indexOf ("Date") >= 0){
			jsondate = jsondate.replace ("/Date(", "").replace (")/", "")
		}
		var date = new Date (parseInt (jsondate, 10));
		var sdate = date.getFullYear () + "-"
		        + (date.getMonth () + 1 < 10 ? "0" + (date.getMonth () + 1) : date.getMonth () + 1) + "-"
		        + (date.getDate () < 10 ? "0" + date.getDate () : date.getDate ());
		if (fmt == 1){
			sdate += " " + (date.getHours () < 10 ? "0" + date.getHours () : date.getHours ()) + ":"
			        + (date.getMinutes () < 10 ? "0" + date.getMinutes () : date.getMinutes ());
		}
		else if (fmt == 2){
			sdate += " " + (date.getHours () < 10 ? "0" + date.getHours () : date.getHours ()) + ":"
			        + (date.getMinutes () < 10 ? "0" + date.getMinutes () : date.getMinutes ()) + ":"
			        + (date.getSeconds () < 10 ? "0" + date.getSeconds () : date.getSeconds ());
		}
		return sdate;
	}
	$(function(){				
		renderPage(1);
		
		var title = '${colSym}';
		$("#title").text('通知公告');
	})

	//渲染
	function renderPage(page)
	{
		var rows = 20; //一页显示记录数
		var sidx = 'publishAt'; //排序字段
		var sord = 'desc'; //排序方向
		var args = {page:page, rows:rows, sidx:sidx, sord:sord,colSym:'${colSym}',stts:'已审核', date:new Date()};
		var url = "web/list";
		$.ajax({
			url:url,
			type:'POST',
			data:args,
			dataType:'json',
			success:function(res){
				//var nav = res.rows[0].colTitle;
 				//$("#nav").append('<img src="images/ico11.png" width="24" height="24" style="vertical-align:middle; margin-right:10px;">'+nav);
				//分页
				laypage({
					cont : 'page', //容器。值必须是id名、原生dom对象，jquery对象,
					pages : res.total, //总页数
					skin : '#FF0000', //皮肤
					skip : false, //是否开启跳页
					groups:2,
					curr : page, //当前页
					first: '首页', //将首页显示为数字1,。若不显示，设置false即可
					last: '尾页', //将尾页显示为总页数。若不显示，设置false即可*/
					prev: '<', //若不显示，设置false即可
				    next: '>', //若不显示，设置false即可 
					jump : function(obj, first) { //触发分页后的回调
						if (!first) { //点击跳页触发函数自身，并传递当前页：obj.curr
							renderPage(obj.curr);  //此处传递当前页
						}
					}
				});
				var container = document.getElementById('tableData').innerHTML;
				laytpl(container).render(res.rows, function(html){
				    document.getElementById('dataContainer').innerHTML = html;
				});
			}
		});
	}
	</script>
	<script type="text/html" id="tableData">
		{{# for(var i = 0; i < d.length; i++){ }}
			<li><span class="time">{{# var time = jsonDateTimeFormatter(d[i].recordInfo.createdAt,0);}}{{time}}</span>
	<a title="市新闻出版广电局开展精准扶贫工作" href="web/info?id={{ d[i].id}}" target="_blank">
					{{#
						var title = d[i].title;
						if (title != null)
						{
							title = title.substring(0,30);
							if (d[i].title.length>30)
								title+='...';
						}
						else
							title = '';
					}}
				{{title}}
	</a></li>
		{{# if (i %4 == 0)}}
				
		{{# }}
		{{# } }}
	</script>
  </head>
  
  <body>
 
<!--网站头部-->
<div class="top">
  <div class="logo"></div>
  <div class="rule"></div>
  <div class="logo1"></div>
</div>
<div class="mid1"><span>当前位置：</span><span><a href="#">首页</a></span><span>-</span><span><a href="#">公告信息</a></span></div>
<div class="column"><span>公告信息</span></div>

<!--网站头部结束-->

<!--网站中部开始-->
	<div class="w1226">
		<div class="main">
			<!--新闻列表开始-->
			<DIV class="box">
				<DIV class="dh7" style="text-align: left">
					<SPAN class="more"></SPAN>
					<H2 class="name" id="title"></H2>
				</DIV>
				<DIV class="list">
					<UL id="dataContainer">
					</UL>
					<ul id="page" style="margin: 0 auto; width: 500px;"
						class="list_page">
						<li><a class="currentA">上一页</a></li>
						<li><a>1</a></li>
						<li><a>2</a></li>
						<li><a class="currentA">3</a></li>
						<li><a>4</a></li>
						<li><a>5</a></li>
						<li><a class="currentA">上一页</a></li>
					</ul>
				</DIV>
			</DIV>

			<!--新闻列表结束-->


			<div class="clear"></div>
		</div>
	</div>
	<!--网站中部结束-->

<!-- <!-- 网站中部开始
<div class="clear"></div>
新闻列表开始

<div class="content">

<ul>
    <li class="text0"></li>
    <li class="text"><a href="#">外国投资机构：中国内需走强 经济风险可控。</a></li>
    <li class="text1">[2017-02-08]</li>
  </ul>
</div>
<DIV class="box">

<DIV class="list">
<UL id="dataContainer">
  </UL>
   <ul id="page" style="margin:0 auto;width: 500px;" class="list_page">
       <li><a class="currentA">上一页</a></li>
       <li><a>1</a></li>
       <li><a>2</a></li>
       <li><a class="currentA">3</a></li>
       <li><a>4</a></li>
       <li><a>5</a></li>
       <li><a class="currentA">上一页</a></li>
   </ul>
</DIV></DIV>
新闻列表结束

<div class="clear"></div>

网站中部结束 --> -->
<!--网站底部开始-->
<!--网页底部开始-->
<div class="bot">中国人民银行</div>
<!--网站底部结束-->
</body>
</html>
