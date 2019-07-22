<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
  <head>  
    <title>${pagetitle}</title>  
    <meta http-equiv="pragma" content="no-cache">  
    <meta http-equiv="cache-control" content="no-cache">  
    <meta http-equiv="expires" content="0">      
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">  
    <meta http-equiv="description" content="This is my page">  
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />  
  </head>  
    
  <body>  
  <h2>我来做首诗,请大家见证一下</h2>
  <hr/>
  <table width="451" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td  align="left" valign="top"><div align="center">序号</div></td>
    <td valign="top"><div align="center">内容</div></td>
   </tr>
   <#list articles as article>
   <#if article.content!=''>
	  <tr>
	    <td width="33%" align="left" valign="top"><div align="center">${article.title}</div></td>
	    <td width="33%" valign="top"><div align="center">${article.content}</div></td>
	    </tr>
	 </#if>
 </#list>
 </table>
 <hr>
 <table width="451" border="1" cellspacing="0" cellpadding="0">
   <#assign columnCount=2 />

   <#list articles as article>
	   	<#if article_index%columnCount==0>
		  <tr>
	   	</#if>
		    <td align="left" valign="top"><div align="center">${article.title}</div></td>
		    <td valign="top">
		    	<div align="center">
		    	<#if article.content?length lt 7>
					${article.content}
				<#else>
					${article.content[0..6]}
				</#if>
				</div>
			</td>
		<#if article_index%columnCount==1>
		  </tr>
	   	</#if>
 	</#list>
 </table>
 
	<a href='${nextPage}'>NextPage!</a>

	 <#assign x=42>
	${aaa}
	${aaa?string} <#-- the same as ${x} -->
	${aaa?string.number}
	${aaa?string.currency}
	${aaa?string.percent}
	${aaa?string.computer}
<br>
${lc?lower_case}
${uc?upper_case}
  </body>
  </html>