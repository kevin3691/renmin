// JavaScript Document
	var oBox=document.getElementById("picbox");
	var oPic=oBox.getElementsByClassName("pic")[0];
	var oPage=oBox.getElementsByClassName("page")[0];
	var oLi=oPage.getElementsByTagName("li");
	var Previous=document.getElementById("Previous");
	var next=document.getElementById("next");
	var liLength=oLi.length;
	var zdnum=0;
	var pwidht=oPage.offsetWidth/2;
	oPage.style.marginLeft=-pwidht+"px";
	oLi[0].className="selected";
	//自动轮翻
	var zdpic=window.setInterval(autoFn,3000);	
	function autoFn(){
		zdnum++;
		if(zdnum==liLength){
			zdnum=0;
		}
		effect(zdnum);
	}
	//鼠标单击轮翻
	for(i=0;i<liLength;i++){
		oLi[i].index=i;		
		oLi[i].onclick=function(){
			zdnum=this.index;
			effect(zdnum);
			window.clearInterval(zdpic);
			zdpic=window.setInterval(autoFn,3000);
		}
		
	}
	var transparent;
	//轮翻方法
	function effect(zdnum){
		window.clearInterval(transparent);
		for(j=0;j<liLength;j++){
			oLi[j].className="";
		}
		var tNum=0;
		transparent=window.setInterval(function(){
			oPic.style.marginLeft=zdnum*(-oBox.offsetWidth)+"px";
			oLi[zdnum].className="selected";
			tNum++;
			oPic.style.opacity= tNum/10;
			if(tNum==10){
				window.clearInterval(transparent);
			}
		},50);
	}
	//上一页，下一页
	Previous.onclick=function(){
			zdnum--;
			if(zdnum==-1){
				zdnum=liLength-1;
			}
			effect(zdnum);
			window.clearInterval(zdpic);
			zdpic=window.setInterval(autoFn,3000);
		}
		next.onclick=function(){
			if(zdnum==liLength-1){
				zdnum=-1;
			}
			zdnum++;
			effect(zdnum);
			window.clearInterval(zdpic);
			zdpic=window.setInterval(autoFn,3000);
		}