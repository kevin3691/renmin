<ul id="ulscroll" style="list-style-type: none; margin-left: 15px">
	<#list products as product>
		<li>
			<table width="252" border="0" cellspacing="0" cellpadding="0"
				height="326" class="box_a">
				<tr>
					<td height="140" valign="top"><span class="box_img"><a
							href="/${urlPath}/${webStaticPath}/product/${product.id}.html"> <img src="/${urlPath}/${product.img}"
								width="173" height="103" /></a></span></td>
				</tr>
				<tr>
					<td valign="top"><a href="/${urlPath}/${webStaticPath}/cpjfw/info_${product.id}.html" class="box_title">${product.title}</a>
						<a href="/${urlPath}/${webStaticPath}/cpjfw/info_${product.id}.html" class="box_txt"> <#if
							product.summary?length lt 48> ${product.content} <#else>
							${product.summary[0..47]} </#if> </a></td>
				</tr>
			</table>
		</li> 
	</#list>
</ul>