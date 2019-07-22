<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><#include "head.ftl" parse=true encoding="utf-8">
<script type="text/javascript" src="/${urlPath}/${webStaticPath}/js/laypage/laypage.min.js"></script>
<script>
	function initDOC(){
		laypage({
	    cont: 'pager',
	    pages: ${pageCount}, //可以叫服务端把总页数放在某一个隐藏域，再获取。假设我们获取到的是18
	    curr: function(){ //通过url获取当前页，也可以同上（pages）方式获取
	        var page = ${pageIndex};
	        return page;
	    }(), 
	    jump: function(e, first){ //触发分页后的回调
	        if(!first){ //一定要加此判断，否则初始时会无限刷新
	        		if(e.curr==1)
	        		{
	        			location.href = "index.html";
	        		}
	        		else{
	        				location.href = "index_"+e.curr+".html";
	        		}
	        }
	    }
		});
	}
</script>
</head>
<body onload="initDOC()">
	<#include "header.ftl" parse=true encoding="utf-8">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="scroll">
		<tr>
			<td align="center" class="scroll_img1" valign="bottom"><img
				src="../images/cp_05.jpg" width="1012" height="223" /></td>
		</tr>
	</table>
	<!------scroll------>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		bgcolor="#f4f4f4">
		<tr>
			<td>
				<div class="dqwzbg">
					<div class="dqwz">
						<span class="c_nav_wz">当前位置： <a href="../index.html">首页</a>
							> 产品及方案
						</span>
					</div>
				</div>
				<div class="content dxal_img">
					<h1>
						产品及方案<span>Products and Solutions</span>
					</h1>
					<span class="eeq">
						<div class="clear"></div>
					</span>
					<div class="ser_box">
						<#list newslist as news>
						<dl class="new_list2">
							<dt>
								<a href="info_${news.id}.html"><img
									src="/${urlPath}/${news.img}" width="149" height="104" /></a></span>
							</dt>
							<dd>
								<h2>
									<strong><a href="info_${news.id}.html">${news.title}</a></strong>
								</h2>
								<p>${news.summary}</p>
							</dd>
						</dl>
						</#list>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td height="50">
				<div id="pager" style="text-align: center; margin-top: 5px;"></div>
			</td>
		</tr>
	</table>
	<#include "footer.ftl" parse=true encoding="utf-8">
</body>
</html>
