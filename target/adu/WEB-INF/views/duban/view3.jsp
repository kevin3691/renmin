<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>

	<link rel="stylesheet" href="jslib/d3/demo.css">
	<script src="jslib/d3/d3.min.js" charset="utf-8"></script>
	<script src="jslib/d3/dagre-d3.js"></script>
	<script src="jslib/d3/diag.js"></script>


	<style id="css">
		body {
			position: fixed;
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;
			margin: 0;
			padding: 0;
			color: #000;
			background-color: eee;
		}


		@-webkit-keyframes flash {
			0%, 50%, 100% {
				opacity: 1;
			}

			25%, 75% {
				opacity: 0.2;
			}
		}

		@keyframes flash {
			0%, 50%, 100% {
				opacity: 1;
			}

			25%, 75% {
				opacity: 0.2;
			}
		}

		.warn {
			-webkit-animation-duration: 5s;
			animation-duration: 5s;
			-webkit-animation-fill-mode: both;
			animation-fill-mode: both;
			-webkit-animation-iteration-count: 1;
			animation-iteration-count: 1;
		}

		.live.map {
			width: 100%;
			height: 100%;
		}

		svg {
			width: 100%;
			height: 100%;
			overflow: hidden;
		}

		.live.map text {
			font-weight: 300;
			font-size: 16px;
		}

		.live.map .node rect {
			stroke-width: 1.5px;
			stroke: #bbb;
			fill: #666;
		}

		.live.map .status {
			height: 100%;
			width: 15px;
			display: block;
			float: left;
			border-top-left-radius: 5px;
			border-bottom-left-radius: 5px;
			margin-right: 4px;
		}

		.live.map .running .status {
			background-color: #ffed68;
		}

		.live.map .running.warn .status {
			background-color: #f77;
		}

		.live.map .stopped .status {
			background-color: #7f7;
		}

		.live.map .warn .queue {
			color: #f77;
		}

		/*.warn {*/
			/*-webkit-animation-name: flash;*/
			/*animation-name: flash;*/
		/*}*/

		.live.map .consumers {
			margin-right: 2px;
		}

		.live.map .consumers,
		.live.map .name {
			margin-top: 4px;
		}

		.live.map .consumers:after {
			content: "x";
		}

		.live.map .queue {
			display: block;
			float: left;
			width: 130px;
			height: 20px;
			font-size: 14px;
			margin-top: 2px;
		}

		.live.map .node g div {
			width: 200px;
			height: 40px;
			color: #fff;
		}

		.live.map .node g div span.consumers {
			display: inline-block;
			width: 20px;
		}

		.live.map .edgeLabel text {
			width: 50px;
			fill: #fff;
		}

		.live.map .edgePath path {
			stroke: #999;
			stroke-width: 1.5px;
			fill: #999;
		}
	</style>

<title>公文-编辑</title>
<script type="text/javascript">
    var parentId = 0;
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var para = $ ("#mainForm").serialize ();
	    $.post ('document/save', $ ("#mainForm").serialize (), function (result, status) {
		    if (parent.onSaveOk){
			    parent.onSaveOk (result.entity)
		    }
		    document.location = 'document/edit?id=' + result.entity.id + '&stepId=1'
	    });
    }


    //返回
    function onCancel () {

    	window.history.back()
    }


    function onSelPerson () {
	    layer.open ({
	        type : 2,
	        title : "选择受理人",
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
    	$.post ('duban/saveDuOrg', {"personId":node.id,"insId":"${ins.id}"}, function (result, status) {

    		layer.closeAll ();
	    });

    }

    function initInfo(){
    	$.post ('duban/listDuOrg', {"insId":"${ins.id}"}, function (result, status) {

		});
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

		layer.confirm ('确定办结当前文件？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
	    	$.post('duban/finish', {"docId":"${doc.id}","insId":"${ins.id}"}, function(result,
    				status) {
    			document.location = 'duban/index'
    		});
		    layer.closeAll ();
	    });

	}

	function addDuOrg(pid){

		var title = "添加督办节点";
    	    layer.open ({
    	        type : 2,
    	        title : title,
    	        shadeClose : true,
    	        shade : 0.8,
    	        area : [
    	                '90%', '90%'
    	        ],
    	        content : "duban/addDuOrg?docId=${o.id}&parentId=" + pid
    	    });
	}

	function addInfoOk(){

		document.location.reload()
        layer.closeAll();
	}
	
    $ (function () {
    	UPLOADER.formData = {
    		    applyTo : "${o.category}",
    		    refNum : "${o.id}"
    	    }
    	UPLOADER.init ();


    })
</script>
<%--<style>--%>
<%--html,body{ margin:0; padding:0;}--%>
<%--.tit{ font:18px 微软雅黑; color:#000;}--%>
<%--.tab_text{ width:98%; height:38px; border:0; margin-left:1%; font:14px 宋体;}--%>
<%--.tab_textarea{ width:98%; height:38px;  border:0; margin-left:1%; font:14px/25px 宋体;}--%>
<%--</style>--%>
</head>

<body>
	<div class="container-fluid">
		
		<ul class="nav nav-tabs" style="padding-top:10px;">
			<li style="float:right;">
				<div>
					<%--<button type="button" class="btn btn-info" onclick="onFinish()">办结</button>
					&nbsp;&nbsp;--%>
					<button type="button" class="btn btn-danger" onclick="onCancel()">返回</button>
					&nbsp;&nbsp;
					
					
				</div>
			</li>
		</ul>
		<div>&nbsp;</div>
		<div class="col-md-12 col-sm-12">
			<div class="live map">
				<svg><g/></svg>
			</div>

		</div>
		
	</div>


	<script id="js">

        var map = {};
        <c:forEach items="${insList}" var="ins" varStatus="status">

        var entity = new Object();
        entity.id = "${ins.id}";
        entity.stepName = "${ins.stepName}";
        entity.stepId = "${ins.stepId}";
        entity.nextStepId = "${ins.nextStepId}";
        entity.refNum = "${ins.refNum}";
        entity.yesNo = "${ins.yesNo}"
		entity.forward = "${ins.forward}"
		entity.actorName = "${ins.actorName}"
		entity.parentId = "${ins.parentId}"
		map["${ins.id}"] = entity;



        </c:forEach>


        // Set up zoom support
        var svg = d3.select("svg"),
            inner = svg.select("g"),
            zoom = d3.zoom().on("zoom", function() {
                inner.attr("transform", d3.event.transform);
            });
        svg.call(zoom);

        var render = new dagreD3.render();

        // Left-to-right layout
        var g = new dagreD3.graphlib.Graph();
        g.setGraph({
            nodesep: 70,
            ranksep: 50,
            rankdir: "LR",
            marginx: 20,
            marginy: 20
        });

        function draw(isUpdate) {
            for (var id in map) {
                var m = map[id];
                var className =  "running";
                if(m.yesNo == "yes"){
                    className =  " stopped";
                }
                if(m.yesNo == "no"){
                    className +=  " warn";
                }
				var nodeId = m.id;
                var nodeStepId = m.stepId;
                var html = "<div onclick='onEnter("+nodeId+","+nodeStepId+")' style='cursor:hand'>";
                html += "<span class=status></span>";
                //html += "<span class=consumers>"+m.stepName+"</span>";
               // html += "<span class=name>"+id+"</span>"
                html += "<span class=queue><span class=counter>"+m.stepName+"</span></span>";
                html += "</div>";

                g.setNode(id, {
                    labelType: "html",
                    label: html,
                    rx: 5,
                    ry: 5,
                    padding: 0,
                    class: className
                });
                if(m.parentId > 0){
                    g.setEdge(m.parentId,id,{
                        label:"",
						width:40
					});
                }


                // if(m.forward != ""){
                //     var forward = m.forward.split(",");
                //     for (var i = 0;i < forward.length;i ++){
                //         g.setEdge(id, forward[i], {
                //             label: "",
                //             width: 40
                //         });
                //     }
                //
                // }

            }

            inner.call(render, g);

            // Zoom and scale to fit
            // var graphWidth = g.graph().width + 80;
            // var graphHeight = g.graph().height + 40;
            // var width = parseInt(svg.style("width").replace(/px/, ""));
            // var height = parseInt(svg.style("height").replace(/px/, ""));
            // var zoomScale = Math.min(width / graphWidth, height / graphHeight);
            // var translateX = (width / 2) - ((graphWidth * zoomScale) / 2)
            // var translateY = (height / 2) - ((graphHeight * zoomScale) / 2);
            // var svgZoom = isUpdate ? svg.transition().duration(500) : svg;
            // svgZoom.call(zoom.transform, d3.zoomIdentity.translate(translateX, translateY).scale(zoomScale));
        }


        // Initial draw, once the DOM is ready
        document.addEventListener("DOMContentLoaded", draw);


        function onEnter(id,stepId) {
            if(stepId <=2){
                onShow("${o.id}");
            }
            if(stepId > 2){
                onShowFlow(id)
            }

        }
        function onShowFlow(pid){
            layer.open ({
                type : 2,
                title : "流程信息",
                shadeClose : true,
                shade : 0.8,
                area : [
                    '90%','90%'
                ],
                content : 'duban/addDuInfo?id=' + pid //iframe的url
            });
		}

        //查看
        function onShow (id) {
            id = id || 0;
            layer.open ({
                type : 2,
                title : "批转信息",
                shadeClose : true,
                shade : 0.8,
                area : [
                    '830','500'
                ],
                content : 'duban/dtl?id=${o.id}' //iframe的url
            });
        }
        function showPhoto (url) {
            layer.photos ({
                photos : {
                    "title" : "", //相册标题
                    "id" : 0, //相册id
                    "start" : 0, //初始显示的图片序号，默认0
                    "data" : [ //相册包含的图片，数组格式
                        {
                            "alt" : "图片名",
                            "pid" : 0, //图片id
                            "src" : url, //原图地址
                            "thumb" : "" //缩略图地址
                        }
                    ]
                }
            });
        }

        function onShowPi(){
            layer.open ({
                type : 2,
                title : "批转信息",
                shadeClose : true,
                shade : 0.8,
                area : [
                    '830','500'
                ],
                content : 'document/piInfo?id=${o.id}' //iframe的url
            });
		}
	</script>
</body>
</html>
