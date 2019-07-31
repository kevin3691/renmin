<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>${WorkplateTitle}</title>


	<jsp:include page="/WEB-INF/views/include/ltehead.jsp" />
	<link rel="stylesheet" href="jslib/layui/css/layui.css">
	<script type="text/javascript" charset="utf-8"
			src="jslib/layui/layui.js"></script>
	<script type="text/javascript" charset="utf-8"
			src="jslib/layer/layer.min.js"></script>
	<script type="text/javascript" charset="utf-8"
			src="jslib/layer/extend/layer.ext.min.js"></script>

	<script>
		var OBJ;
        function onModify(){
            var title = "修改密码"
            var url = 'home/modifyPwd?id=${baseUser}'
            window.top.document.getElementById("ifrmDtl").src = url;
            window.top.$('#winDtl').dialog({
                width:300,
                height:300,
                closed: false,
                cache: false,
                modal:true,
                title:title
            });
            window.top.$('#winDtl').dialog("open");
        }

        function closeWin(){
            window.top.$('#winDtl').dialog("close");
		}
			function onCancel(){
                window.top.$('#winDtl').dialog("close");
			}
            $ (function () {
                $ ("#ifrmMain").height ($ (document).height () - 202)
                //设置默认打开菜单 如果为一个则默认打开
                // var m = $ (".sidebar-menu>.treeview")
                // if (m.length == 1){
                //     m.addClass ("active")
                // }
                //菜单选择时高亮显示
                // $ (".treeview-menu li").click (function () {
                //     $ (".treeview-menu li").removeClass ("active");
                //     $ (this).addClass ("active");
                // })
                //initMenu (0);
            })
		function showWs() {
        	$("#newIcon i").remove();
			$("#showWS").animate({right:10});
		}
		function closeWs() {
        	var w = $("#showWS").width();
        	console.log(w)
			$("#showWS").animate({right:-1000});
		}

	</script>
	<%--LayIM--%>
	<script>
		var ws;
		layui.use('layim', function(layim){

			var wsUrl = "ws://192.168.10.119:8000${pageContext.request.contextPath}/ws/chat?${sessionScope.baseUser.id}";

			function createWebSocket() {
				try {
					ws = new WebSocket(wsUrl);
				} catch(e) {
					console.log('catch');
					reconnect(wsUrl);
				}
			}
			createWebSocket();
			//连接成功时触发
			ws.onopen = function(){
				appendHtm("连接成功！");
				$.post ("chat/list2", {sendToId:${sessionScope.baseUser.id},state:0}, function (data) {
					$.each(data,function(i,t){
						layim.getMessage(t);
					});
				});
			}
			ws.onerror = function(){
				appendHtm("连接失败！");
			}
			ws.onclose = function(){
				appendHtm("连接关闭！");
			}
			function appendHtm(htm){
				console.log(htm);
			}
			//基础配置
			layim.config({

				//获取主面板列表信息
				init: {
					url: 'chat/chatInfoList' //接口地址（返回的数据格式见下文）
					,type: 'get' //默认get，一般可不填
					,data: {} //额外参数
				}


				/*//上传图片接口（返回的数据格式见下文）
				,uploadImage: {
					url: '' //接口地址（返回的数据格式见下文）
					,type: 'post' //默认post
				}

				//上传文件接口（返回的数据格式见下文）
				,uploadFile: {
					url: '' //接口地址（返回的数据格式见下文）
					,type: 'post' //默认post
				}*/

				//增加皮肤选择，如果不想增加，可以剔除该项
				,skin: [
					'http://xxx.com/skin.jpg',

		]

		,brief: false //是否简约模式（默认false，如果只用到在线客服，且不想显示主面板，可以设置 true）
					,title: '消息' //主面板最小化后显示的名称
					,min: false //用于设定主面板是否在页面打开时，始终最小化展现。默认false，即记录上次展开状态。
					,minRight: null //【默认不开启】用户控制聊天面板最小化时、及新消息提示层的相对right的px坐标，如：minRight: '200px'
					,maxLength: 3000 //最长发送的字符长度，默认3000
					,isfriend: true //是否开启好友（默认true，即开启）
					,isgroup: false //是否开启群组（默认true，即开启）
					,right: '0px' //默认0px，用于设定主面板右偏移量。该参数可避免遮盖你页面右下角已经的bar。
					,chatLog: 'chat/index' //聊天记录地址（如果未填则不显示）
					,find: '' //查找好友/群的地址（如果未填则不显示）
					,copyright: false //是否授权，如果通过官网捐赠获得LayIM，此处可填true
		});

			ws.onmessage = function(res){
			    console.log(res.data);
				var data = JSON.parse(res.data);
				if(data.type == "Status"){
					layim.setFriendStatus(data.id, data.status); //在线状态
				}else if(data.type == "friend"){
					layim.getMessage(data); //res.data即你发送消息传递的数据（阅读：监听发送的消息）
				}

			};

			layim.on('sendMessage', function(res){

				var str = {sendToId:res.to.id,sendToName:sendToName,sendDoId:${sessionScope.baseUser.id},sendDoName:"${sessionScope.baseUser.basePersonName}",
					sendDoPrName:"${sessionScope.baseUser.baseRoleName}",content:res.mine.content,sendTime:res.to.timestamp};
				$.post("chat/save",str,function (data) {
					console.info(data);
					console.info("发送成功");
				});
				ws.send(JSON.stringify({
                    type: 'chatMessage' //随便定义，用于在服务端区分消息类型
                    ,data: res
                }));

			});

			//每次窗口打开或切换，即更新对方的状态
			layim.on('chatChange', function(res){
				var type = res.data.type;
				if(type === 'friend'){
					var data = {sendToId:${sessionScope.baseUser.id},sendDoId:res.data.id};
					$.post("chat/upState",data,function(data){
						console.log("已读消息");
					});
					//layim.setChatStatus('<span style="color:#FF5722;">在线</span>'); //模拟标注好友在线状态
				} else if(type === 'group'){
					//模拟系统消息
					layim.getMessage({
						system: true //系统消息
						,id: 111111111
						,type: "group"
						,content: '贤心加入群聊'
					});
				}
			});

		});




	</script>
</head>
<body>
<div class="">
	<div id="pf-hd">
		<div class="pf-logo">
			<img src="images/logo.png" alt="logo">
		</div>

		<div class="pf-nav-wrap">
			<!--<div class="pf-nav-ww">-->
			<div class="pf-nav-ww">

				<ul class="pf-nav">

				</ul>
			</div>
			<!-- </div> -->


			<a href="javascript:;" class="pf-nav-prev disabled iconfont">&#xe606;</a>
			<a href="javascript:;" class="pf-nav-next iconfont">&#xe607;</a>
		</div>



		<div class="pf-user">
			<div class="pf-user-photo">
				<img src="easyui/images/main/user.png" alt="">
			</div>
			<h4 class="pf-user-name ellipsis">${baseUser.basePersonName}</h4>
			<i class="iconfont xiala">&#xe607;</i>
			<div class="pf-user-panel">
				<ul class="pf-user-opt">
					<li class="pf-modify-pwd">
						<a href="javascript:onModify()">
							<i class="iconfont">&#xe634;</i>
							<span class="pf-opt-name">修改密码</span>
						</a>
					</li>
					<li class="pf-logout">
						<a href="javascript:;">
							<i class="iconfont">&#xe60e;</i>
							<span class="pf-opt-name">退出</span>
						</a>
					</li>
				</ul>
			</div>
		</div>

	</div>

	<div id="pf-bd">
		<div class="pf-sider-wrap">

		</div>


		<div id="pf-page">

		</div>
	</div>

	<div id="pf-ft">
		<div class="system-name">
			<i class="iconfont">&#xe6fe;</i>
			<span></span>
		</div>
		<div class="copyright-name">
			<span>CopyRight&nbsp;2018</span>
			<i class="iconfont" >&#xe6ff;</i>
		</div>
	</div>
</div>
<div style="width: 45px ; height: 45px;position: absolute;right: 30px;top:150px;z-index:999;">
	<button  type="button" onclick="showWs();"  style=" display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;color: #333;
    background-color: #fff;
    border-color: #ccc;position: relative;">&nbsp;&nbsp;消息
		<b id="newIcon" style="position:absolute;top: 0px ;left: -0px">

		</b>
	</button>

</div>
<style>
	.xiaoXi{position: fixed;right: -50%; top: 10%;height: 80%;width: 40%;
		background-color: #fff;
		border: 1px solid transparent;
		border-radius: 4px;
		-webkit-box-shadow: 0 1px 1px rgba(0,0,0,.05);
		box-shadow: 0 1px 1px rgba(0,0,0,.05);border-color: #ddd;z-index: 999;}
	.xiaoXi_Top{
		width: 100%;
		border-radius: 4px 4px 0 0 ;
		border-bottom:1px solid transparent;
		background-color: #fff;
		box-shadow: 0 1px 1px rgba(0,0,0,.05);
		height: 40px;
		line-height: 40px;
		text-indent: 1em;
		overflow: hidden;
	}
	.show_close{
		-webkit-appearance: none;
		padding: 0;
		cursor: pointer;
		background: 0 0;
		border: 0;
		margin-top: 5px;
		margin-right: 5px;
		font-size: 18px;
	}
</style>

<style>
	#user{
		margin: 0px;
		list-style: none;
		height: 100%;
		overflow-scrolling: auto;
	}
	.myIcon{
		border: 1px solid red;
		border-radius: 50%;
		width: 15px;
		height: 15px;
		text-align: center;
		line-height: 15px;
		display: inline-block;
		background: red;
		color: #fff;
		text-indent: 0;
		float: right;
		margin-top: 7px;
		margin-right: 20px;
		overflow: hidden;
		font-size: 12px;
	}
	#user li{
		background: #fff;
		height: 31px;
		border: 1px solid #00000054;
		border-radius: 3px;
		margin-bottom: 1px;
		line-height: 31px;
		position:relative;
	}
	#user li button{
		display: none;
		position: absolute;
		top: 1px;
		right: 0px;
	}
	#user li:hover button{
		display: block;
	}
	#user li:hover{
		background: #f5f4f485;
		cursor: pointer ;
	}
	#liaoTianInfo {
		display: -webkit-flex;
		display: flex;
		-webkit-flex-wrap: wrap;
		flex-wrap: wrap;
	}

	 section label {
		background: #eee;
		border: 1px solid #ddd;
		padding: .7em 1em;
		cursor: pointer;
		z-index: 1;
		margin-left: -1px;
	}
	 section label:first-of-type {
		margin-left: 0;
	}
	 #liaoTianInfo>div {
		width: 100%;height: 83%;
		 max-height: 621px;
		margin-top: -1px;
		padding: 1em;
		border-top: 1px solid #ddd;
		 border-bottom: none;
		-webkit-order: 1;
		order: 1;
		 overflow-y:scroll
	}
	section input[type=radio]{
		display: none;
	}
	 .divHide{
		 display: none;
	 }
	 section input[type=radio]:checked + label {
		background: #fff;
		border-bottom: 1px solid #fff;
	}
	 section input[type=radio]:checked + label + div {
		display: block;
	}
	.divShow{
		display: block;
	}
	.inputClass{
		color: #555;
		background-color: #fff;
		background-image: none;
		border: 1px solid #ccc;
		height: 30px;
		padding: 5px 10px;
		font-size: 12px;
		line-height: 1.5;
		border-radius: 0;
		box-shadow: none;
		display: inline-block;
		width: auto;
		vertical-align: middle;
	}
	.userName{
		text-indent: 1em;
		width: 100px;
		display: inline-block;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.fasong{
		display: inline-block;
		height: 38px;
		line-height: 38px;
		padding: 0 18px;
		background-color: #009688;
		color: #fff;
		white-space: nowrap;
		text-align: center;
		font-size: 14px;
		border: none;
		border-radius: 2px;
		cursor: pointer;
		border: 1px solid #e9e9e9;

		background-color: #fff;
		color: #555;
	}
	.mes{
		width: 100%;
		box-sizing: border-box;
		padding: 10px 10px;
		list-style: none;
		height: 84%;
		min-height:420px;
		max-height:420px;
		overflow-y: scroll;
	}
	.mes li{
		width: 100%;
		margin-bottom: 5px;
		padding-top: 10px;
	}
	.sendToName{
		display:inline-block;
		margin: 10px 0px;
		float:left;
	}
	.myName{
		display:inline-block;
		margin: 10px 0px;
		float:right;
	}
	.send {
		clear:both;
		margin:0px 20px;
		position: relative;
		word-break: break-all;
		word-wrap: break-word;
		max-width: 300px;
		vertical-align: middle;
		background: #F8C301;
		border-radius: 5px;
		line-height: 32px;
		min-height: 32px;
		display: inline-block;
	}
	.send p{
		padding:5px 10px;
		display:inline-block;
		margin:0px;
	}
	.send .arrow{
		position:absolute;
		top:10px;
		font-size:0;
		border:solid 8px;
		transform:rotate(45deg);
		border-color:#F8C301;
	}
	.msgRight{
		right:-8px; /* 圆角的位置需要细心调试哦 */
		width:0;
		height:0;
	}
	.msgLeft{
		left:-8px; /* 圆角的位置需要细心调试哦 */
		width:0;
		height:0;
	}
	.mesInfo{
		word-break: break-all;
		white-space: pre-wrap;
		line-height: 30px;
		margin-top: 5px;
		text-indent: 2em;
	}
</style>
<script>
	$(function(){
		$("#liaoTianInfo input[type=radio]").bind("change",function(){
			$("#liaoTianInfo label:eq(1) i").remove();
			var infoTest =  $("#liaoTianInfo :input:eq(1)").prop("checked");
			console.log(infoTest);
			if(infoTest){
				var displayState = $(".mes:not(:eq(0))");//信息界面
				$.each(displayState,function(i,t){
					var dpState = $(t).css("display");
					if(dpState == "block"){
						var sendDoId = $(t).attr("data-id");
						var data = {sendDoId:sendDoId,sendToId:${sessionScope.baseUser.id}}
						$.post("chat/upState",data,function(data){
							console.log(data);
						});
					}
				});
			}
			var $div = $("#liaoTianInfo").children("div");
			console.log($div);
			$div.css("display","none");
			$div = $("#liaoTianInfo input[type=radio]:checked").next().next();
			console.log($div);
			$div.css("display","block");
		})
	})
	function closeUserMes(ele) {
		var id = $(ele).attr("data-id");
		$(".mes[data-id="+id+"]").remove();
		$(ele).parents("li").remove();
		$("#userTitle").text("选择联系人");

	}
	function toSendMes(id,name,prName) {
		var userLi = $("#user li[data-id="+id+"]");
		if(userLi.length<1){
			userLi = "<li onclick='toLiaoTian(this);' data-id="+id+" data-name='"+name+"' data-prName='"+prName+"'><span class=\"userName\">"+name+"</span>\n" +
					"<button type=\"button\" class=\"show_close\" onclick=\"closeUserMes(this);\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button>\n" +
					"</li>"
			$("#user").append(userLi);
		}
		var $userLi = $(userLi);
		toLiaoTian($userLi)
		$("#liaoTianInfo>input:eq(0)").prop("checked",false);
		$("#liaoTianInfo>div").css("display","none");
		var inputEle = $("#liaoTianInfo>input").eq(1);
		inputEle.prop("checked",true);
		var $div = inputEle.next().next();
		console.log($div);
		$div.css("display","block");
	}
	var sendToId = 0;
	var sendToName = "暂无";
	var sendToPrName = "暂无";
	function toLiaoTian(ele) {
		$(ele).find("i").remove();
		var $this = $(ele);
		sendToId = $this.attr("data-id");
		sendToName = $this.attr("data-name");
		sendToPrName = $this.attr("data-prName");
		var liaoTianWin = $(".mes[data-id="+sendToId+"]");
		$(".mes").css("display","none");
		if(liaoTianWin.length<1){
			var eleUl = "<ul class=\"mes\" data-id="+sendToId+" ></ul>";
			$("#xiaoXi_right div:first-child").append(eleUl);
			$(eleUl).css("display","block");

		}else{
			liaoTianWin.css("display","block");
		}
		$("#xiaoXi_right div:first-child h1").text(sendToName);
		$(".fasong").val("");
		var data = {sendToId:${sessionScope.baseUser.id},sendDoId:sendToId,state:0};
		$.post("chat/upState",data,function(data){
			console.log(data);
		});
	}

	function toSendMes1(id,name,prName) {
		var userLi = $("#user li[data-id="+id+"]");
		if(userLi.length<1){
			userLi = "<li onclick='toLiaoTian(this);' data-id="+id+" data-name='"+name+"' data-prName='"+prName+"'><span class=\"userName\">"+name+"</span>\n" +
					"<button type=\"button\" class=\"show_close\" onclick=\"closeUserMes(this);\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button>\n" +
					"</li>"
			$("#user").append(userLi);
		}
		var $userLi = $(userLi);
		toLiaoTian1($userLi)
	}
	function toLiaoTian1(ele) {
		var $this = $(ele);
		sendToId = $this.attr("data-id");
		sendToName = $this.attr("data-name");
		sendToPrName = $this.attr("data-prName");
		var liaoTianWin = $(".mes[data-id="+sendToId+"]");
		if(liaoTianWin.length<1){
			$(".mes").css("display","none");
			var eleUl = "<ul class=\"mes\" data-id="+sendToId+" ></ul>";
			$("#xiaoXi_right div:first-child").append(eleUl);
			$(eleUl).css("display","block");

		}else{

		}
		$("#xiaoXi_right div:first-child h1").text(sendToName);
		$(".fasong").val("");
	}
	//消息记录
	function chatList(){
		if(sendToId.isNaN){
			return;
		}
		if(sendToId<1){
			return;
		}
		layer.open ({
			type : 2,
			title : '消息记录',
			shadeClose : true,
			shade : 0.8,
			area : [
				'50%', '70%'
			],
			content : 'chat/index?sendToId=' + sendToId+'&sendDoId=${sessionScope.baseUser.id}' //iframe的url
		});
	}
</script>

<div id="showWS" class="container xiaoXi" >
 <div class="xiaoXi_Top">
	 <span style="float: left">消息</span>
	 <span style="float: right">
		 <button type="button" class="show_close" onclick="closeWs();" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	 </span>
 </div>
	<div style="width: 100%;height:100%" class="container-fluid">
		<section id="liaoTianInfo" >

			<input id="tab-one" type="radio" name="grp" checked="checked">
			<label for="tab-one">列表</label>
			<div style="display: block" >
				<iframe scrolling="no" id="ifrmOrg"
						style="width: 100%; height: 1224px"scrolling="yes" frameborder="0"
						src="base/user/index2"></iframe>
			</div>

			<input id="tab-two" type="radio" name="grp">
			<label for="tab-two">消息</label>
			<div class="divHide">
				<div style="width: 100%;height: 100%;">
					<div id="xiaoXi_left"style="width:20%;height: 100%;float: left">
						<ul id="user">
							<%-- <li><span class="userName">哈哈哈</span><i class="myIcon">1</i>
								<button type="button" class="show_close" onclick="closeUserMes(this);" aria-label="Close"><span aria-hidden="true">×</span></button>
							</li>--%>
						</ul>
					</div>
					<div id="xiaoXi_right" style="width:80%;height: 100%;float: right;padding-left: 10px;box-sizing: border-box;">
						<div style="width: 100%;height: 70%;border: 1px solid #e9e9e9;border-bottom: none;">
							<h1 id="userTitle" style="width: 100%;background-color:#fff;float: left;height: 60px;line-height:60px;font-size:24px;border-bottom: 1px solid #e9e9e9;margin: 0 0 10px 0;text-align: center">
								选择联系人</h1>
							<ul class="mes" data-id="-1" style=""></ul>
						</div>
						<div style="width: 100%;height: 30%;min-height:120px;border: 1px solid #e9e9e9;position: relative">
							<textarea id="mesText" style="width: 100%;height: 100%;min-height:120px;border:none"></textarea>
							<div style="width: 100%;position:absolute;right: 0px;bottom: 0px;">
								<button	style="float: right;" onclick="chatList();" class="fasong">记录</button><button style="float: right;" onclick="onSend();" class="fasong">发送</button>
							</div>

						</div>
					</div>
				</div>
			</div>

		</section>
	</div>
</div>
<%--
<script type="text/javascript">

	var lockReconnect = false;//避免重复连接
	var wsUrl = "ws://192.168.10.119:8000${pageContext.request.contextPath}/ws/chat?${sessionScope.baseUser.id}";
	var ws;
	var tt;
	function createWebSocket() {
		try {
			ws = new WebSocket(wsUrl);
		} catch(e) {
			console.log('catch');
			reconnect(wsUrl);
		}
	}
	createWebSocket();

	//心跳检测
	var heartCheck = {
		timeout: 3000,
		timeoutObj: null,
		serverTimeoutObj: null,
		start: function(){
			console.log('start');
			var self = this;
			this.timeoutObj && clearTimeout(this.timeoutObj);
			this.serverTimeoutObj && clearTimeout(this.serverTimeoutObj);
			this.timeoutObj = setTimeout(function(){
				//这里发送一个心跳，后端收到后，返回一个心跳消息，
				console.log('心跳检测');
				ws.send("心跳检测");
				self.serverTimeoutObj = setTimeout(function() {
					console.log("心跳检测");
					console.log(ws);
					// createWebSocket();
				}, self.timeout);

			}, this.timeout)
		}
	}

	function reconnect(url) {
		if(lockReconnect) {
			return;
		};
		lockReconnect = true;
		//没连接上会一直重连，设置延迟避免请求过多
		tt && clearTimeout(tt);
		tt = setTimeout(function () {
			createWebSocket(url);
			lockReconnect = false;
		}, 4000);
	}

	function onSend(){
		var htm = $("#mesText").val();
		if(htm.length<1 || htm == ""){
			return;
		}
		if(sendToId<1){
			return;
		}
		doSend(htm);
	}
	ws.onopen = function(){
		appendHtm("连接成功！");
	}

	// 从服务端接收到消息，将消息回显到聊天记录区
	ws.onmessage = function(evt){
		if(evt.data=="心跳检测"){
			console.log("心跳");
		}else{
			var mydata = $.parseJSON(evt.data);
			console.log(typeof(mydata))
			toSendMes1(mydata.sendDoId,mydata.sendDoName,mydata.sendDoPrName);
			addIcon(mydata);
			/*var ele = "<li>"+mydata.sendDoName+":<br/><p class=\"mesInfo\">"+mydata.content+"</p></li>";*/

			var ele = "<li><p class=\"sendToName\">"+mydata.sendDoName+"</p><div class=\"send\"><p>"+mydata.content+"</p>" +
					"<div class=\"arrow msgLeft\"></div></div></li>";
			$(".mes[data-id="+mydata.sendDoId+"]").append(ele);
			var box=document.getElementsByClassName("mes")[0];
			box.scrollTop=box.scrollHeight;
		}
		appendHtm(evt.data);
		heartCheck.start();
	}

	ws.onerror = function(){
		appendHtm("连接失败！");
	}

	ws.onclose = function(){
		appendHtm("连接关闭！");
	}
	//添加新消息ICON
	function addIcon(data){
		var newIcon = "<i class=\"myIcon\">新</i>";
		var displayState = $(".mes[data-id="+data.sendDoId+"]").css("display");//信息界面
		var i = 0;
		if(displayState!="block"){
			//如果这个信息界面没有显示就添加
			$("#user li[data-id="+data.sendDoId+"]").append(newIcon);
			i++;
		}
		displayState = $("#liaoTianInfo div:eq(1)").css("display");//聊天界面
		if(displayState!="block"){
			$("#liaoTianInfo label:eq(1) i").remove();
			$("#liaoTianInfo label:eq(1)").append("<i class=\"myIcon\"style='position: absolute;top: 35px;'>新</i>");
			i++;
		}
		var rightNum = $("#showWS").css("right");

		if(rightNum.slice(0,rightNum.length-2)<0){
			$("#newIcon i").remove();
			$("#newIcon").append(newIcon);
			i++;
		}
		if(i==0){
			$.post("chat/upState",data,function(data){
				console.log(data);
			});
		}
	}
	function appendHtm(htm){
		console.log(htm);
	}

	// 注销登录
	function doClose(){
		ws.close();
	}

	// 发送消息
	function doSend(htm){
		// ($("#content")[0]).innerHTML += htm +"<br/>"
		console.log("htm+"+htm);
		var str = {sendToId:sendToId,sendToName:sendToName,sendToPrName:sendToPrName,sendDoId:${sessionScope.baseUser.id},sendDoName:"${sessionScope.baseUser.basePersonName}",
			sendDoPrName:"${sessionScope.baseUser.baseRoleName}",content:htm};
		$.post("chat/save",str,function (data) {
			console.info(data);
			console.info("发送成功");
		});
		str = JSON.stringify(str);
		console.log(str);
		ws.send(str);
		/*var ele = "<li style='text-align: right'>我:<br/><p class=\"mesInfo\">"+htm+"</p></li>";*/
		var ele = "<li style=\"text-align:right;\"><div class=\"send\"><p style=\"text-align:left\">"+htm+"</p>" +
				"<div class=\"arrow msgRight\"></div></div><p class=\"myName\">我</p></li>";

		$(".mes[data-id="+sendToId+"]").append(ele);
		var box=document.getElementsByClassName("mes")[0];
		box.scrollTop=box.scrollHeight;
		$("#mesText").val("")

	}

	function doClear(){
		$("#content").empty();
	}

	$(function(){
		$.post ("chat/list", {sendToId:${sessionScope.baseUser.id},state:0}, function (rslt) {
			$("#list ul").empty();
			var rows = rslt.rows;
			console.log(rows);
			$.each(rows,function (i,t) {

				if(t.sendToId == ${sessionScope.baseUser.id}){
					/*var ele = "<li>"+t.sendDoName+"&nbsp;"+time+":<br/><p class=\"mesInfo\">"+t.content+"</p></li>";
					$("#list ul").append(ele);*/
					toSendMes1(t.sendDoId,t.sendDoName,t.sendDoPrName);
					addIcon(t);
					/*var ele = "<li>"+mydata.sendDoName+":<br/><p class=\"mesInfo\">"+mydata.content+"</p></li>";*/

					var ele = "<li><p class=\"sendToName\">"+t.sendDoName+"</p><div class=\"send\"><p>"+t.content+"</p>" +
							"<div class=\"arrow msgLeft\"></div></div></li>";
					$(".mes[data-id="+t.sendDoId+"]").append(ele);
					var box=document.getElementsByClassName("mes")[0];
					box.scrollTop=box.scrollHeight;
				}

			})
			var box=document.getElementsByClassName("mes")[0];
			box.scrollTop=box.scrollHeight;
		})
	})
</script>--%>
<div id="mm" class="easyui-menu tabs-menu" style="width:120px;display:none;">
	<div id="mm-tabclose">关闭</div>
	<div id="mm-tabcloseall">关闭所有</div>
	<div id="mm-tabcloseother">关闭其他</div>
</div>
<div id="dlg" class="easyui-dialog" title="业务日志查看" data-options="closed:true,modal:true" style="width:720px;height:490px;padding:10px;display:none;">
	<link rel="stylesheet" type="text/css" href="static/green/css/process.css">
	<div class="time-line">
		<div class="time-item date">
			<div class="content-left first">
				<span>2016-04-25</span>
				<label><span class="dot"></span><i class="line"></i></label>
			</div>
		</div>
		<div class="time-item time">
			<div class="content-left">
				<span>15:58:34</span>
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
			<div class="content-right">
				<span class="left-arrow"></span>
				<div class="detail-outer">
					<div class="detail">
						<div>
							<span class="name">占立中</span>
							<label>[买方]</label>
							<span class="status">发布</span>
						</div>
						<div>
							<span class="name">占立中</span>
							<label>[买方]</label>
							<span class="status">发布</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="time-item time important">
			<div class="content-left">
				<span>17:00:21</span>
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
			<div class="content-right">
				<span class="left-arrow"></span>
				<div class="detail-outer">
					<div class="detail">
						<div>
							<span class="name">纪相东</span>
							<label>[供方]</label>
							<span class="status">石家庄华能电力有限公司。报价已发布，报价单号：<span class="order">121568215782</span></span>
						</div>
						<div>
							<span class="name">纪相东</span>
							<label>[供方]</label>
							<span class="status">石家庄华能电力有限公司。报价已发布，报价单号：<span class="order">121568215782</span></span>
						</div>
						<div>
							<span class="name">纪相东</span>
							<label>[供方]</label>
							<span class="status">石家庄华能电力有限公司。报价已发布，报价单号：<span class="order">121568215782</span></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="time-item date">
			<div class="content-left">
				<span>2016-04-26</span>
				<label><span class="dot"></span><i class="line"></i></label>
			</div>
		</div>
		<div class="time-item time">
			<div class="content-left">
				<span>09:21:14</span>
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
			<div class="content-right">
				<span class="left-arrow"></span>
				<div class="detail-outer">
					<div class="detail">
						<div>
							<span class="name">占立中</span>
							<label>[买方]</label>
							<span class="status">发布</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="time-item last">
			<div class="content-left">
				<label><i class="line"></i><span class="dot"></span></label>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="easyui/custom/orange/jquery.min.js"></script>
<script type="text/javascript" src="easyui/custom/orange/jquery.easyui.min.js"></script>

<script type="text/javascript">
	var _Menus = ${baseUser.purMenus};
	var topMenu = []
	var index = 0;
    /*$.each (_Menus, function (i, v) {

        if(v.baseTree.parentId == 0){
            index++
            var obj = new Object()
			obj.title = v.title
			obj.icon = v.img
			if(index == 1)
				obj.isCurrent = true
			var menu = []

			if(v.baseTree.isLeaf == 0){
                var in1 = 0
                $.each (_Menus, function (ii, vv) {
                    if(vv.baseTree.parentId == v.id){
                        in1++
                        var t = new Object()
						t.title = vv.title
						t.icon = vv.img
						if(in1 == 1){
                            t.isCurrent = true
						}
						var mm = []
						if(vv.baseTree.isLeaf == 0){
                            var in2 = 0
                            $.each (_Menus, function (iii, vvv) {
                                if(vvv.baseTree.parentId == vv.id){
                                    in2++
									var tt = new Object()
									tt.title = vvv.title
									if(in1 == 1 && in2 == 1){
									    tt.isCurrent = true
									}
									if(vvv.baseTree.isLeaf == 0){

									}else{
									    tt.href = vvv.url
									}
									mm.push(tt)
								}
							})
						}else{
							t.href = vv.url
						}
						t.children = mm
                        menu.push(t)
					}
				})

			}else{
                $.each (_Menus, function (ii, vv) {
                    if(vv.baseTree.parentId == v.id){
                        var t = new Object()
                        t.title = vv.title
                        t.icon = vv.img
						t.href = vv.url
                        if(ii == 0){
                            t.isCurrent = true
                        }
                        menu.push(t)
                    }
                })
			}
			obj.menu = menu
			topMenu .push(obj)
        }
    })*/

    $.each (_Menus, function (i, v) {
        if(v.baseTree.parentId == 0){
            index++
            var obj = new Object()
            obj.title = v.title
            obj.icon = v.img
            if(index == 1)
                obj.isCurrent = true
            var menu = []

            if(v.baseTree.isLeaf == 0){
                var in1 = 0
                $.each (_Menus, function (ii, vv) {
                    if(vv.baseTree.parentId == v.id){
                        in1++
                        var t = new Object()
                        t.title = vv.title
                        t.icon = vv.img
                        if(in1 == 1){
                            t.isCurrent = true
                        }
                        var mm = []
                        if(vv.baseTree.isLeaf == 0){
                            var in2 = 0
                            $.each (_Menus, function (iii, vvv) {
                                if(vvv.baseTree.parentId == vv.id){
                                    in2++
                                    var tt = new Object()
                                    tt.title = vvv.title
                                    if(in1 == 1 && in2 == 1){
                                        tt.isCurrent = true
                                    }
                                    if(vvv.baseTree.isLeaf == 0){

                                    }else{
                                        tt.href = vvv.url
                                    }
                                    mm.push(tt)
                                }
                            })
                        }else{
                            t.href = vv.url
                        }
                        t.children = mm
                        menu.push(t)
                    }
                })

            }else{
                $.each (_Menus, function (ii, vv) {
                    if(vv.baseTree.parentId == v.id){
                        var t = new Object()
                        t.title = vv.title
                        t.icon = vv.img
                        t.href = vv.url
                        if(ii == 0){
                            t.isCurrent = true
                        }
                        menu.push(t)
                    }
                })
            }
            obj.menu = menu
            topMenu .push(obj)
        }
    })
    var SystemMenu = topMenu
</script>






<%--<script type="text/javascript" src="easyui/js/menu.js"></script>--%>
<script type="text/javascript" src="easyui/js/main.js"></script>
<!--[if IE 7]>
<script type="text/javascript">
	$(window).resize(function(){
		$('#pf-bd').height($(window).height()-76);
	}).resize();

</script>
<![endif]-->


<script type="text/javascript">
    // $('.easyui-tabs1').tabs({
    //   tabHeight: 44,
    //   onSelect:function(title,index){
    //     var currentTab = $('.easyui-tabs1').tabs("getSelected");
    //     if(currentTab.find("iframe") && currentTab.find("iframe").size()){
    //         currentTab.find("iframe").attr("src",currentTab.find("iframe").attr("src"));
    //     }
    //   }
    // })
    $(window).resize(function(){
        $('.tabs-panels').height($("#pf-page").height()-46);
        $('.panel-body').not('.messager-body').height($(".easyui-dialog").height)
    }).resize();

    var page = 0,
        pages = ($('.pf-nav').height() / 70) - 1;

    if(pages === 0){
        $('.pf-nav-prev,.pf-nav-next').hide();
    }
    $(document).on('click', '.pf-nav-prev,.pf-nav-next', function(){


        if($(this).hasClass('disabled')) return;
        if($(this).hasClass('pf-nav-next')){
            page++;
            $('.pf-nav').stop().animate({'margin-top': -70*page}, 200);
            if(page == pages){
                $(this).addClass('disabled');
                $('.pf-nav-prev').removeClass('disabled');
            }else{
                $('.pf-nav-prev').removeClass('disabled');
            }

        }else{
            page--;
            $('.pf-nav').stop().animate({'margin-top': -70*page}, 200);
            if(page == 0){
                $(this).addClass('disabled');
                $('.pf-nav-next').removeClass('disabled');
            }else{
                $('.pf-nav-next').removeClass('disabled');
            }

        }
    })

    // setTimeout(function(){
    //    $('.tabs-panels').height($("#pf-page").height()-46);
    //    $('.panel-body').height($("#pf-page").height()-76)
    // }, 200)
    function replace(doc, style) {


        $('link', doc).each(function(index, one) {

            var path = $(one).attr('href').replace(/(static\/)\w+(\/css)/g, '$1' + style + '$2').replace(/(custom\/)\w+(\/)/g, '$1' + style + '$2'),
                sheet;

            if(doc.createStyleSheet) {

                sheet = doc.createStyleSheet(path);
                setTimeout(function() {

                    $(one).remove();

                }, 500)

            } else {

                sheet = $('<link rel="stylesheet" type="text/css" href="' + path + '" />').appendTo($('head', doc));
                sheet = sheet[0];
                sheet.onload = function() {

                    $(one).remove();

                }

            }

        })

        $('img', doc).each(function(index, one) {

            var path = $(one).attr('src').replace(/(static\/)\w+(\/images)/g, '$1' + style + '$2');

            $(one).attr('src', path);

        })

    }
    $('.skin-item').click(function() {

        var color = $(this).data('color');
        replaceAll(color);

    })
    function replaceAll(style) {

        $('iframe').each(function(index, one) {

            try {

                replace(one.contentWindow.document, style)

            } catch(e) {

                console.warn('origin cross');

            }

        })

        replace(document, style)

    }
</script>
</body>
</html>
<div id="winDtl" data-options="title:'待办信息',closed:true,modal:true" class="easyui-window">
	<iframe id="ifrmDtl" style="width: 100%; height: 100%; border: 0;" frameborder="0" src=""></iframe>
</div>

<div id="winDoc" data-options="title:'待办信息',closed:true,modal:true" class="easyui-window">
	<iframe id="ifrmDoc" style="width: 100%; height: 100%; border: 0;" frameborder="0" src="">

	</iframe>
</div>