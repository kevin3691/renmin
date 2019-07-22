<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<title>流程信息</title>
<script type="text/javascript">
    
    //返回
    function onCancel () {
	    /* var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭    */
    	document.location = 'document/index'
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
   
    
  
    $ (function () {
    	
	    
    })
</script>
</head>

<body>
	<div class="container-fluid">
		
		<ul class="nav nav-tabs" style="padding-top:10px;">
			<li><a href="document/act?id=${id}">正文</a></li>
			<li class="active"><a href="document/flow?id=${id}">流程信息</a></li>
			<li style="float:right;">
				<div>
					&nbsp;&nbsp;
				</div>
			</li>
		</ul>
		<div>&nbsp;</div>
		<c:forEach items="${insList}" var="ins">
			<div class="row">
        		<div class="col-md-6">
          			<div class="box box-success box-solid">
            			<div class="box-header with-border">
              				<h3 class="box-title">环节${ins.stepId }---办理人：${ins.actorName }</h3>

              				<div class="box-tools pull-right">
                				
              				</div>
			              <!-- /.box-tools -->
			            </div>
	            <!-- /.box-header -->
	            <div class="box-body">
	            	接收时间：<fmt:formatDate value="${ins.recordInfo.createdAt }" pattern="yyyy-MM-dd HH:mm"/>
	            	<br/>
	            	办理时间：<fmt:formatDate value="${ins.actAt }" pattern="yyyy-MM-dd HH:mm"/>
	            	<br/>
	            	<c:choose>
	            		<c:when test="${ins.yesNo eq 'yes'}">
	            			办理意见：${ins.descr }
	            		</c:when>
	            		<c:otherwise>
	            			办理意见：${ins.descr }
	            			<!-- <div class="form-group">
								<label class="col-sm-2 control-label" for="title">办理意见</label>
								<div class="col-sm-10">
									<input class="form-control" id="descr" name="descr" value=""
										type="text" required />
								</div>
								
							</div>
							<div style="align:center">
								<button type="button" class="btn btn-info" onclick="onSave()">保存</button>
							</div> -->
	            		</c:otherwise>
	            	</c:choose>
	            	
	            	
            	</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        </div>
			<br/>
		</c:forEach>
		
	</div>
</body>
</html>
