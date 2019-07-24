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
		/* This sets the color for "TK" nodes to a light blue green. */

		g.type-suss>rect {
			fill: #ddefd3;
		}

		.node text {
			font-weight: 300;
			font-family: "Helvetica Neue", Helvetica, Arial, sans-serf;
			font-size: 12px;
			pointer-events: none;
			text-anchor: middle;
			fill: white;
		}

		.label g text tspan:last-child {
			font-size: 10px;
			margin-top: 5px;
			dy: 1.5em;
		}

		.label g {
			transform: translate(0, -13px);
		}

		.node rect {
			fill: white;
			stroke-width: 0px;
			color: white;
		}

		.edgePath path {
			stroke: rgb(78, 78, 78);
			stroke-width: 1px;
		}

		g.type-init>rect {
			fill: rgba(0, 91, 252, 0.4);
		}

		g.type-ready>rect {
			fill: rgba(0, 91, 252, 0.6);
		}

		g.type-queue>rect {
			fill: rgba(0, 91, 252, 0.8);
		}

		g.type-run>rect {
			fill: rgba(0, 91, 252, 1);
		}

		g.type-suss>rect {
			fill: #3EBB44;
		}

		g.type-fail>rect {
			fill: #E93A3A;

		}

		g.type-freeze>rect {
			fill: #f2f3f7;
		}

		.type-freeze text {
			fill: #999999;
		}
		#myMenu{
			position: absolute;
			display: none;
			width: 160px;
			height: 100px;
			background: #999999;
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

	function addDuOrg(){

		var title = "添加督办节点";
    	    layer.open ({
    	        type : 2,
    	        title : title,
    	        shadeClose : true,
    	        shade : 0.8,
    	        area : [
    	                '90%', '90%'
    	        ],
    	        content : "duban/addDuOrg?docId=${o.id}&parentId=" + parentId
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
<style>
html,body{ margin:0; padding:0;}
.tit{ font:18px 微软雅黑; color:#000;}
.tab_text{ width:98%; height:38px; border:0; margin-left:1%; font:14px 宋体;}
.tab_textarea{ width:98%; height:38px;  border:0; margin-left:1%; font:14px/25px 宋体;}
</style>
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
			<svg id="svgCanvas" width=100% height=100%></svg>
			<ul id="myMenu">
				<li><a href="javascript:addDuOrg()">添加督办节点</a></li>
			</ul>
		</div>
		
	</div>


	<script id="js">
		var statePoint = 0;
		var state = new Array();
		var edg = new Array();
       
var map = {};
	<c:forEach items="${insList}" var="ins" varStatus="status">
		if(statePoint == 0){
		    statePoint = "${ins.id}";
		}
       var entity = new Object();
		entity.id = "${ins.id}";
        entity.stepName = "${ins.stepName}";
        entity.stepId = "${ins.stepId}";
        entity.nextStepId = "${ins.nextStepId}";
        entity.refNum = "${ins.refNum}";
        map["${ins.id}"] = entity;
		var t = new Object();
		t.id = "${ins.id}";
		t.label = "${ins.stepName}";
		var className = "type-run"
        if("${ins.yesNo}" != "yes"){
            className = "type-suss"
        }else{
            className = "type-fail"
		}


		t.class = className;
		state.push(t);
		if("${ins.forward}" != ""){
		    var forward = "${ins.forward}".split(",");
		    for (var i = 0;i < forward.length;i ++){
                var tl = new Object();
                tl.start =  "${ins.id}";
                tl.end = forward[i];
                tl.option = "{}";
                edg.push(tl);
			}

        }

	</c:forEach>
        diagGraph.init(statePoint, state, edg); //创建关系图
        var myMenu = document.getElementById("myMenu"); //鼠标右键
        var svgCanvas = document.getElementById('svgCanvas'); //绑定事件鼠标点击
        svgCanvas.addEventListener('click', function (e) {
            e.preventDefault();
            if (e.target.tagName === 'rect') {
                var id = e.target.parentNode.id;
                diagGraph.changePoint(id);
                //alert(map[id].stepName)
                var wi = map[id];
                if(wi.stepId == 1){
                    onShow("${o.fileUrl}","${o.fileExt}");
                } else if(wi.stepId == 2){
                    onShowPi();
                }else if(wi.stepId == 3){
					/*parentId = e.target.parentNode.id;
                    myMenu.style.top = e.clientY + "px";
                    myMenu.style.left = e.clientX + "px";
                    myMenu.style.display = 'block'*/
                }else if(wi.stepId > 3){
                    var pid = e.target.parentNode.id;
                    onShowFlow(pid);
				}
            }else{
                myMenu.style.display = 'none'
			}
        })



      svgCanvas.addEventListener("contextmenu", (event) => { //鼠标右击事件
            event.preventDefault();
        if (event.target.tagName === 'rect') {
            //alert(event.target.parentNode.id)
            var id = event.target.parentNode.id;
            var wi = map[id];
            if(wi.stepId > 2){
                parentId = id;
                myMenu.style.top = event.clientY + "px";
                myMenu.style.left = event.clientX + "px";
                myMenu.style.display = 'block'
			}

            // this.myMenuShow = true
        }
        });


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
        function onShow (url, fileExt) {
            url = _BasePath + "/" + url;
            if (".jpg;.gif;.bmp;.png".indexOf (fileExt) >= 0){
                showPhoto (url)
            }
            else{
                window.open (url, "att", "")
            }
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
