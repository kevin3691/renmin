<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib
	uri="http://www.owasp.org/index.php/Category:OWASP_CSRFGuard_Project/Owasp.CsrfGuard.tld"
	prefix="csrf"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>${WorkplateTitle}</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<base id="basePath" href="">
<script type="text/javascript">
	//获取站点根域名（含虚拟目录）
    function getWebPath () {
	    var strFullPath = window.document.location.href;
	    var strPath = window.document.location.pathname;
	    var pos = strFullPath.indexOf (strPath);
	    var prePath = strFullPath.substring (0, pos);
	    var postPath = strPath.substring (0, strPath.substr (1).indexOf ('/') + 1);
	    return (prePath + postPath);
        //return (prePath);
    }

    var _BasePath = getWebPath ()+"/";
    document.getElementById("basePath").href = _BasePath;
 </script>
 <script type="text/javascript" charset="utf-8" src="jslib/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	var l = document.location.href;
	if(l.indexOf(".arc")>=0||l.indexOf(".old")>=0||l.indexOf(".bak")>=0)
	{
		document.location.href = _BasePath + "error/404";
	}
	$ (function () {
	    if ("${srcUrl}" != ""){
		    var action = _BasePath + "${srcUrl}"
		    $('#mainForm').attr('action', action);
		    $("#OWASP_CSRFTOKEN").val("${t}");
		    $ ("form").submit ();
	    }
    })
</script>
</head>
<body class="hold-transition skin-blue-light sidebar-mini">
	<form id="mainForm" action="">
		<input type=hidden id="OWASP_CSRFTOKEN" name="OWASP_CSRFTOKEN"
			value="">
	</form>
</body>
</html>
