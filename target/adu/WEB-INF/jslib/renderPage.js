/*二级页分页js*/
$(function(){
		renderPage(1);
	})

	//渲染
	function renderPage(page)
	{
		var rows = 6; //一页显示记录数
		var sidx = 'publishAt'; //排序字段
		var sord = 'desc'; //排序方向
		var args = {page:page, rows:rows, sidx:sidx, sord:sord,colSym:'${colSym}',stts:'已发布', date:new Date()};
		var url = "web/list";
		$.ajax({
			url:url,
			type:'POST',
			data:args,
			dataType:'json',
			success:function(res){
				$("#nav").html(res.rows[0].colTitle);
				//分页
				laypage({
					cont : 'page', //容器。值必须是id名、原生dom对象，jquery对象,
					pages : res.total, //总页数
					skin : 'molv', //皮肤
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