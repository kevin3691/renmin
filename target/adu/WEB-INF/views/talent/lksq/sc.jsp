<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head.jsp" />
<script type="text/javascript" charset="utf-8" src="u000e/config.min.js"></script>
<script type="text/javascript" charset="utf-8" src="u000e/all.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>
<title>人员-编辑</title>
<script type="text/javascript">
var _BTN;
//获取站点根域名（含虚拟目录）
function getWebPath () {
	var strFullPath = window.document.location.href;
	var strPath = window.document.location.pathname;
	var pos = strFullPath.indexOf (strPath);
	var prePath = strFullPath.substring (0, pos);
	var postPath = strPath.substring (0, strPath.substr (1).indexOf ('/') + 1);
	return (prePath + postPath);
}
	function loadGrid () {
	    $ ("#grid").jqGrid (
	            {
	                url : "talent/lksq/listFile",
	                height : document.body.clientHeight - 130,
	                postData : {
	                	refNum : "${o.id}"
	                },
	                rownumbers : true,
	                colModel : [
	                        
	                        {
	                            label : '材料名称',
	                            name : 'title',
	                            index : 'title',
	                            width : 120
	                        },
	                        {
	                            label : '材料形式',
	                            name : 'type',
	                            index : 'type',
	                            width : 90
	                        },
	                        {
	                            label : '文件',
	                            name : 'descr',
	                            width : 140,
	                            align : 'center',
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            var btn = "";
		                            $.post('talent/lksq/listAtt', {refNum:row.id}, function(result,status) {
		                            	if (result == null)
		                					return;
		                            	var b ="";
		                				for(var i = 0; i < result.length; i++)
		                				{
		                					var item = result[i];
		                					btn += "<div fileId='"+item.id+"'><a href='"+item.fileUrl+"' title=''  target= '_blank'>" + (i + 1) + ".&nbsp;" +item.title+"</a>"
		                					btn += "<a href='javascript:;' onclick='Remove(this)'><i class='glyphicon glyphicon-remove' style='color:red'></i></a>";
		                					btn += "</div>";
		                					
		                				}
		                				joinBtn(btn)
		                			});
		                            return _BTN;
	                            }
	                        },
	                        {
	                            label : '操作',
	                            name : 'id',
	                            width : 140,
	                            align : 'center',
	                            sortable : false,
	                            formatter : function (value, options, row) {
		                            var btn = "";
		                            btn += '&nbsp;<a href="javascript:onUpload('+value+')" title="">上传</a>'
		                            
		                            return btn;
	                            }
	                        }
	                ],
	                rowNum : 20,
	                rowList : [
	                        20, 50, 100
	                ],
	                pager : '#pager',
	                sortname : 'id',
	                sortorder : "asc",
	            });
	    jQuery ("#grid").jqGrid ('bindKeys', {
	        "onEnter" : function (rowid) {
		        //alert ("你enter了一行， id为:" + rowid)
	        },
	        "onRightKey" : function (rowid) {
		        onDown (rowid)
	        },
	        "onLeftKey" : function (rowid) {
		        onDel (rowid)
	        },
	        "onSpace" : function (rowid) {
		        onShow (rowid)
	        }
	    });
    }
	
	function Remove(obj) {
		var id = $(obj).parent().attr('fileId');
		$(obj).parent().remove();
		onDel (id);
	}
	function joinBtn(btn){
		_BTN = btn;
	}
	function onDel (id) {
	    layer.confirm ('确定要删除该文件？', {
		    btn : [
		            '确定', '取消'
		    ]
	    //按钮
	    }, function () {
		    $.post ("comm/attachment/del", {
			    id : id
		    }, function () {
			    $ ("#grid").trigger ("reloadGrid");
		    });
		    layer.closeAll ();
	    });
    }
	var _ID;
	function onUpload(id){
		_ID = id;
		$ ("input[name='file']").click ();
	}
	
	function onQ () {
	    var para = {
	       
	    };
	    $ ("#grid").jqGrid ("setGridParam", {
		    postData : para
	    }).trigger ("reloadGrid");
    }
	
	function onUploadSucess (file, res) {
		$.post("comm/uploader/updateRefNum",{id:res.entity.id,refNum:_ID},function(result,stts){
    		//alert(result+"\n\r"+stts)
    	})
	    onQ();
    }
	//保存
    function onSave () {
	    //表单验证
	    if (!$ ('#mainForm').validate ().form ()){
		    return false;
	    }
	    var ue = UE.getEditor ('editor');
	    $ ("#experience").val (ue.getContent ());
	    
	    var ue2 = UE.getEditor ('editor2');
	    $ ("#achievements").val (ue.getContent ());
	    
	    var para = $ ("#mainForm").serialize ();
	    $.post ('talent/lksq/save', $ ("#mainForm").serialize (), function (result, status) {
		    alert("保存成功!")
		    document.location.reload;
	    });
    }
    //返回
    function onCancel () {
	    var index = parent.layer.getFrameIndex (window.name); //先得到当前iframe层的索引
	    parent.layer.close (index); //再执行关闭   
    }
    
    
  
  //ueditor 上传完成后回调
    function ueSimpleUploadCallback(json){
    	/* $.post("comm/uploader/saveAs",{url:json.url},function(result,stts){
                        		//alert(result+"\n\r"+stts)
                        	}) */
    }
  
    function onChange(flag){
  	  var url = "talent/lksq/sq?id=${o.id}";
  	  if(flag == 2)
  	  {
  		  if("${o.id}" == 0)
  		{
  			  alert("请先保存信息，再上传材料！");
  			  return false;
  		}
  		  url = "talent/lksq/sc?id=${o.id}";
  	  }
  	  document.location.href = url;
  		  
    }
   
    $ (function () {
    	UPLOADER.formData = {
    		    applyTo : 'TALENT'
    	    }
    	    UPLOADER.init ();
    	loadGrid ();
    })
</script>
</head>

<body>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<ul class="nav nav-tabs">
								<li style="cursor:pointer;"><a
									href="javascript:onChange(1)">基本信息
								</a></li>
								<li class="active" style="cursor:pointer;"><a
									href="javascript:onChange(2)">上传材料
								</a></li>
		</ul>
		<table id="grid" style="height:35px;"></table>
		<div id="pager" style="height:35px;"></div>
	</div>
</body>
</html>
