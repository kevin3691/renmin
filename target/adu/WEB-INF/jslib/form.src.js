/**
 * Copyright 2016 the original author or authors. 
 * 前台表单通用函数js
 * 
 * @author 
 * @createdAt 2016-01-26
 */
// 获取浏览器类型
var _Explorer = "IE"
var explorer = navigator.userAgent;
// ie
if (explorer.indexOf ("MSIE") >= 0){
	_Explorer = "IE"
}
// firefox
else if (explorer.indexOf ("Firefox") >= 0){
	_Explorer = "Firefox"
}
// Chrome
else if (explorer.indexOf ("Chrome") >= 0){
	_Explorer = "Chrome"
}
// Opera
else if (explorer.indexOf ("Opera") >= 0){
	_Explorer = "Opera"
}
// Safari
else if (explorer.indexOf ("Safari") >= 0){
	_Explorer = "Safari"
}
// Netscape
else if (explorer.indexOf ("Netscape") >= 0){
	_Explorer = "Netscape"
}
//获取站点根域名（含虚拟目录）
function getWebPath () {
	var strFullPath = window.document.location.href;
	var strPath = window.document.location.pathname;
	var pos = strFullPath.indexOf (strPath);
	var prePath = strFullPath.substring (0, pos);
	var postPath = strPath.substring (0, strPath.substr (1).indexOf ('/') + 1);
	return (prePath + postPath);
}
// 设置Jquery验证样式
if (typeof jQuery.validator != "undefined"){
	jQuery.extend (jQuery.validator.defaults, {
	    errorElement : 'span',
	    errorClass : 'help-block',
	    focusInvalid : true,
	    highlight : function (element) {
		    $ (element).closest ('div').addClass ('has-error');
	    },
	    success : function (label) {
		    label.closest ('div').removeClass ('has-error');
		    label.remove ();
	    },
	    errorPlacement : function (error, element) {
		    $ (element).closest ('div').append (error);
	    }
	});
	// Jquery验证默认提示
	jQuery.extend (jQuery.validator.messages, {
	    required : "不能为空",
	    remote : "请修正该字段",
	    email : "请输入正确格式的电子邮件",
	    url : "请输入合法的网址",
	    date : "请输入合法的日期",
	    dateISO : "请输入合法的日期 (ISO).",
	    number : "请输入合法的数字",
	    digits : "只能输入整数",
	    creditcard : "请输入合法的信用卡号",
	    equalTo : "请再次输入相同的值",
	    accept : "请输入拥有合法后缀名的字符串",
	    maxlength : jQuery.validator.format ("请输入一个 长度最多是 {0} 的字符串"),
	    minlength : jQuery.validator.format ("请输入一个 长度最少是 {0} 的字符串"),
	    rangelength : jQuery.validator.format ("请输入 一个长度介于 {0} 和 {1} 之间的字符串"),
	    range : jQuery.validator.format ("请输入一个介于 {0} 和 {1} 之间的值"),
	    max : jQuery.validator.format ("请输入一个最大为{0} 的值"),
	    min : jQuery.validator.format ("请输入一个最小为{0} 的值")
	});
	// 扩展验证规则
	// 手机
	$.validator.addMethod ('mobile', function (value, element) {
		// /^1\d{10}$/ 来自支付宝的正则
		return this.optional (element) || /^1\d{10}$/.test (value);
	}, '请输入正确的手机号码');
	// 电话
	jQuery.validator.addMethod ('phone', function (value, element) {
		var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
		return this.optional (element) || (tel.test (value));
	}, "请正确填写您的电话号码");
	// 联系电话(手机/电话皆可)验证
	jQuery.validator.addMethod ("mobilephone", function (value, element) {
		var length = value.length;
		var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
		return this.optional (element) || tel.test (value) || (length == 11 && mobile.test (value));
	}, "请正确填写您的联系方式");
	// 匹配qq
	jQuery.validator.addMethod ("qq", function (value, element) {
		return this.optional (element) || /^[1-9]\d{4,12}$/;
	}, "请正确填写您的QQ");
	// 邮政编码验证
	jQuery.validator.addMethod ("zipcode", function (value, element) {
		var zip = /^[0-9]{6}$/;
		return this.optional (element) || (zip.test (value));
	}, "请正确填写您的邮政编码。");
	// 匹配密码，以字母开头，长度在6-12之间，只能包含字符、数字和下划线。
	jQuery.validator.addMethod ("extPassword", function (value, element) {
		return this.optional (element) || /^[a-zA-Z]\\w{6,12}$/.test (value);
	}, "以字母开头，长度在6-12之间，只能包含字符、数字和下划线。");
	// 身份证号码验证
	jQuery.validator.addMethod ("idCardNo", function (value, element) {
		// var idCard = /^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/;
		return this.optional (element) || isIdCardNo (value);
	}, "请输入正确的身份证号码。");
	// IP地址验证
	jQuery.validator
	        .addMethod (
	                "ip",
	                function (value, element) {
		                return this.optional (element)
		                        || /^(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.)(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.){2}([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))$/
		                                .test (value);
	                }, "请填写正确的IP地址。");
	// 字符验证，只能包含中文、英文、数字、下划线等字符。
	jQuery.validator.addMethod ("string", function (value, element) {
		return this.optional (element) || /^[a-zA-Z0-9\u4e00-\u9fa5-_]+$/.test (value);
	}, "只能包含中文、英文、数字、下划线等字符");
	// 匹配english
	jQuery.validator.addMethod ("english", function (value, element) {
		return this.optional (element) || /^[A-Za-z]+$/.test (value);
	}, "匹配english");
	// 匹配汉字
	jQuery.validator.addMethod ("chinese", function (value, element) {
		return this.optional (element) || /^[\u4e00-\u9fa5]+$/.test (value);
	}, "匹配汉字");
	// 匹配中文(包括汉字和字符)
	jQuery.validator.addMethod ("chineseChar", function (value, element) {
		return this.optional (element) || /^[\u0391-\uFFE5]+$/.test (value);
	}, "匹配中文(包括汉字和字符) ");
	// 判断是否为合法字符(a-zA-Z0-9-_)
	jQuery.validator.addMethod ("rightfulString", function (value, element) {
		return this.optional (element) || /^[A-Za-z0-9_-]+$/.test (value);
	}, "判断是否为合法字符(a-zA-Z0-9-_)");
	// 判断是否包含中英文特殊字符，除英文"-_"字符外
	jQuery.validator
	        .addMethod (
	                "containsSpecialChar",
	                function (value, element) {
		                var reg = RegExp (/[(\ )(\`)(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\*)(\()(\))(\+)(\=)(\|)(\{)(\})(\')(\:)(\;)(\')(',)(\[)(\])(\.)(\<)(\>)(\/)(\?)(\~)(\！)(\@)(\#)(\￥)(\%)(\…)(\&)(\*)(\（)(\）)(\—)(\+)(\|)(\{)(\})(\【)(\】)(\‘)(\；)(\：)(\”)(\“)(\’)(\。)(\，)(\、)(\？)]+/);
		                return this.optional (element) || !reg.test (value);
	                }, "含有中英文特殊字符");
}
// 设置JqGrid默认参数
if ($.jgrid){
	// JqGrid默认值
	$.jgrid.defaults.autowidth = true;
	// $.jgrid.defaults.altRows = true;
	$.jgrid.defaults.datatype = "json";
	$.jgrid.defaults.mtype = "post";
	$.jgrid.defaults.styleUI = 'Bootstrap';
	$.jgrid.defaults.treedatatype = 'json';
	$.jgrid.defaults.treeGridModel = 'adjacency';
	$.jgrid.defaults.treeReader = {
	    "parent_id_field" : "baseTree.parentId",
	    "level_field" : "baseTree.level",
	    "leaf_field" : "baseTree.leaf",
	    "expanded_field" : "expanded",
	    "loaded" : "loaded",
	    "icon_field" : "icon"
	};
	// 窗口变化时自适应宽度
	window.onresize = function () {
		// Chrome下grid在body宽度发生变化时会重新计算列宽导致出现滚动条
		if (_Explorer == "Chrome"){
			$ (".ui-jqgrid-bdiv").css ("overflow-x", "hidden");
		}
		$ ("#grid").setGridWidth (document.body.clientWidth - 32);
	}
}
// JqGrid TreeGrid 展开方法
var treeExpand = function (xhr) {
	var ar = _expandPath.split (".");
	var id = 0;
	while (ar.length > 0){
		if (ar[0] != "" && ar[0] != "0"){
			id = ar[0];
			ar.shift ();
			break;
		}
		ar.shift ();
	}
	var data = $ ("#grid").jqGrid ("getGridParam").data
	// 如果只有一条根记录则展开它
	if (ar.length == 0 && data.length == 1){
		id = data[0].id
	}
	setTimeout (function () {
		var idx = -1;
		var obj = false;
		for (var i = 0; i < data.length; i++){
			if (data[i].id == id){
				obj = data[i]
				break;
			}
		}
		if (obj && !obj.expanded && !obj["baseTree.leaf"]){
			$ ("#grid").jqGrid ("expandRow", obj);
			$ ("#grid").jqGrid ("expandNode", obj);
		}
		if (ar.length > 0){
			_expandPath = ar.join (".");
		}
	}, 100);
};
// 生成数据字典选择项
function bindDictSelect (sym, container, callback) {
	callback = callback || ""
	$.post ("base/dict/listBySym", {
	    parentSym : sym,
	    container : container
	}, function (rslt) {
		var rows = rslt.rows;
		if (rows == null)
			return;
		container = rslt.container
		$ ("#" + container).append ("<option value=''></option>");
		for (var i = 0; i < rows.length; i++){
			$ ("#" + container).append ("<option value='" + rows[i].title + "'>" + rows[i].title + "</option>");
		}
		if (callback){
			callback (container)
		}
		if (typeof (dictCallBack) != "undefined"){
			dictCallBack (container);
		}
	})
}
// 编辑页回车转TAB切换焦点
// 设置第一个input焦点，为input绑定事件
$ (document).ready (function () {
	// 如果是日期则不自动获取焦点
	if ($ (':input:text:first').attr ("ID") && $ (':input:text:first').attr ("ID").indexOf ("At") == -1){
		$ (':input:text:first').focus ();
	}
	$ (':input:enabled').addClass ('enterIndex');
	textboxes = $ ('.enterIndex');
	// 如果第一个是按钮时无法焦点，所以重新设置一次
	if (textboxes.length > 0){
		textboxes[0].focus ();
	}
	if (/msie/.test (navigator.userAgent.toLowerCase ())){
		$ (textboxes).bind ('keydown', checkForEnter);
	}
	else{
		$ (textboxes).bind ('keypress', checkForEnter);
	}
});
// 监听Enter按键
function checkForEnter (event) {
	if (event.keyCode == 13 && $ (this).attr ('type') != 'button' && $ (this).attr ('type') != 'submit'
	        && !$ (this).is ("textarea") && $ (this).attr ('type') != 'textarea' && $ (this).attr ('type') != 'reset'
	        && $ (this).attr ('id').indexOf ("At") == -1){
		var i = $ ('.enterIndex').index ($ (this));
		var n = $ ('.enterIndex').length;
		if (i < n - 1){
			if ($ (this).attr ('type') != 'radio'){
				nextDOM ($ ('.enterIndex'), i);
			}
			else{
				var last_radio = $ ('.enterIndex').index (
				        $ ('.enterIndex[type=radio][name=' + $ (this).attr ('name') + ']:last'));
				nextDOM ($ ('.enterIndex'), last_radio);
			}
		}
		return false;
	}
}
// 切换下一个焦点
function nextDOM (myjQueryObjects, counter) {
	if (myjQueryObjects.eq (counter + 1)[0].disabled){
		nextDOM (myjQueryObjects, counter + 1);
	}
	else{
		myjQueryObjects.eq (counter + 1).trigger ('focus');
	}
}
// 监听document键盘事件
$ (document).keyup (function (event) {
	switch (event.keyCode) {
		// esc 关闭layer
		case 27 || 96:
			// alert ("ESC");
			if (parent.layer){
				parent.layer.closeAll ();
			}
			else{
				layer.closeAll ();
			}
	}
});
// 身份证号码的验证规则
function isIdCardNo (num) {
	var len = num.length, re;
	if (len == 15)
		re = new RegExp (/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{2})(\w)$/);
	else if (len == 18)
		re = new RegExp (/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/);
	else{
		// alert("输入的数字位数不对。");
		return false;
	}
	var a = num.match (re);
	if (a != null){
		if (len == 15){
			var D = new Date ("19" + a[3] + "/" + a[4] + "/" + a[5]);
			var B = D.getYear () == a[3] && (D.getMonth () + 1) == a[4] && D.getDate () == a[5];
		}
		else{
			var D = new Date (a[3] + "/" + a[4] + "/" + a[5]);
			var B = D.getFullYear () == a[3] && (D.getMonth () + 1) == a[4] && D.getDate () == a[5];
		}
		if (!B){
			// alert("输入的身份证号 "+ a[0] +" 里出生日期不对。");
			return false;
		}
	}
	if (!re.test (num)){
		// alert("身份证最后一位只能是数字和字母。");
		return false;
	}
	return true;
}
// 车牌号校验
function isPlateNo (plateNo) {
	var re = /^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/;
	if (re.test (plateNo)){
		return true;
	}
	return false;
}
/**
 * 
 * 数字格式转换成千分位
 * 
 * @param{Object}num
 * 
 */
function commafy (num, dec) {
	dec = dec || 0;
	num = parseFloat (num)
	if (isNaN (num)){
		return "0.00";
	}
	else{
		return (num.toFixed (dec) + '').replace (/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
	}
}
function clearNoNum (obj) {
	// 先把非数字的都替换掉，除了数字和.
	obj.value = obj.value.replace (/[^\d.]/g, "");
	// 必须保证第一个为数字而不是.
	obj.value = obj.value.replace (/^\./g, "");
	// 保证只有出现一个.而没有多个.
	obj.value = obj.value.replace (/\.{2,}/g, ".");
	// 保证.只出现一次，而不能出现两次以上
	obj.value = obj.value.replace (".", "$#$").replace (/\./g, "").replace ("$#$", ".");
}
/**
 * 
 * 去除千分位
 * 
 * @param{Object}num
 * 
 */
function clearCommafy (num) {
	if (!num){
		return 0;
	}
	if ((num + "").trim () == ""){
		return "";
	}
	num = num.replace (/,/gi, '');
	return num;
}
// layer.photo 由于该弹出层无法在parent中弹出，所以写入共用JS供调用
function showAlbum (jdata) {
	if (!jdata)
		return;
	var json = {
	    "title" : jdata.title, // 相册标题
	    "id" : jdata.id, // 相册id
	    "start" : jdata.start, // 初始显示的图片序号，默认0
	    "data" : jdata.data
	// 相册包含的图片，数组格式
	}
	layer.photos ({
		photos : json
	});
}
// 获取图片的真实高宽
function getImgRealWH (src) {
	var img = document.createElement ('img');
	img.src = src;
	return {
	    w : img.width,
	    h : img.height
	};
}
Date.formatdate = function (d, sep, noseconds, notime) {
	var s = sep || '-'
	var yy = d.getFullYear ()
	var mm = d.getMonth () + 1
	mm = mm < 10 ? '0' + mm : mm
	var dd = d.getDate ()
	dd = dd < 10 ? '0' + dd : dd
	var hh = d.getHours ()
	hh = hh < 10 ? '0' + hh : hh
	var MM = d.getMinutes ()
	MM = MM < 10 ? '0' + MM : MM
	var ss = Math.round (d.getSeconds ())
	ss = ss < 10 ? '0' + ss : ss
	if (notime)
		return yy + s + mm + s + dd
	else if (noseconds)
		return yy + s + mm + s + dd + ' ' + hh + ':' + MM
	else
		return yy + s + mm + s + dd + ' ' + hh + ':' + MM + ':' + ss
}
Date.currentDate = function (sep) {
	return Date.formatdate (new Date (), sep, true, true)
}
Date.currentTime = function () {
	return Date.formatdate (new Date (), '-')
}
// 格式化JSON日期格式
// 0 "yyyy-MM-dd",1 "yyyy-MM-dd HH:mm",2 "yyyy-MM-dd HH:mm:ss"
function jsonDateTimeFormatter (jsondate, fmt) {
	fmt = fmt || 0
	if (jsondate == null || jsondate == ""){
		return "";
	}
	if (typeof (jsondate) == "string" && jsondate.indexOf ("Date") >= 0){
		jsondate = jsondate.replace ("/Date(", "").replace (")/", "")
	}
	var date = new Date (parseInt (jsondate, 10));
	var sdate = date.getFullYear () + "-"
	        + (date.getMonth () + 1 < 10 ? "0" + (date.getMonth () + 1) : date.getMonth () + 1) + "-"
	        + (date.getDate () < 10 ? "0" + date.getDate () : date.getDate ());
	if (fmt == 1){
		sdate += " " + (date.getHours () < 10 ? "0" + date.getHours () : date.getHours ()) + ":"
		        + (date.getMinutes () < 10 ? "0" + date.getMinutes () : date.getMinutes ());
	}
	else if (fmt == 2){
		sdate += " " + (date.getHours () < 10 ? "0" + date.getHours () : date.getHours ()) + ":"
		        + (date.getMinutes () < 10 ? "0" + date.getMinutes () : date.getMinutes ()) + ":"
		        + (date.getSeconds () < 10 ? "0" + date.getSeconds () : date.getSeconds ());
	}
	return sdate;
}
// 获取当前时间
function currentDateTime (notime) {
	notime = notime || 0;
	if (notime == 0){
		return Date.currentTime ();
	}
	return Date.currentDate ();
}
// 将date型转换为tring
function dateToStr (datetime, fmt) {
	fmt = fmt || 0
	var year = datetime.getFullYear ();
	var month = datetime.getMonth () + 1;// js从0开始取
	var date = datetime.getDate ();
	var hour = datetime.getHours ();
	var minutes = datetime.getMinutes ();
	var second = datetime.getSeconds ();
	if (month < 10){
		month = "0" + month;
	}
	if (date < 10){
		date = "0" + date;
	}
	if (hour < 10){
		hour = "0" + hour;
	}
	if (minutes < 10){
		minutes = "0" + minutes;
	}
	if (second < 10){
		second = "0" + second;
	}
	var time = "";
	if (fmt == 0){
		time = year + "-" + month + "-" + date;
	}
	if (fmt == 1){
		time = year + "-" + month + "-" + date + " " + hour + ":" + minutes + ":" + second; // 2009-06-12
																							// 17:18:05
	}
	return time;
}
// 除法函数，用来得到精确的除法结果
// 说明：javascript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。
// 调用：accDiv(arg1,arg2)
// 返回值：arg1除以arg2的精确结果
function accDiv (arg1, arg2, arg3) {
	var t1 = 0, t2 = 0, r1, r2;
	try{
		t1 = arg1.toString ().split (".")[1].length
	} catch (e){
	}
	try{
		t2 = arg2.toString ().split (".")[1].length
	} catch (e){
	}
	with (Math){
		r1 = Number (arg1.toString ().replace (".", ""))
		r2 = Number (arg2.toString ().replace (".", ""))
		return toDecimal ((r1 / r2) * pow (10, t2 - t1), arg3);
	}
}
// 给Number类型增加一个div方法，调用起来更加 方便。
Number.prototype.div = function (arg, arg1) {
	return accDiv (this, arg, arg1);
}
// 乘法函数，用来得到精确的乘法结果
// 说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。
// 调用：accMul(arg1,arg2)
// 返回值：arg1乘以 arg2的精确结果
function accMul (arg1, arg2, arg3) {
	var m = 0, s1 = arg1.toString (), s2 = arg2.toString ();
	try{
		m += s1.split (".")[1].length
	} catch (e){
	}
	try{
		m += s2.split (".")[1].length
	} catch (e){
	}
	return toDecimal (Number (s1.replace (".", "")) * Number (s2.replace (".", "")) / Math.pow (10, m), arg3)
}
// 给Number类型增加一个mul方法，调用起来更加方便。
Number.prototype.mul = function (arg, arg1) {
	return accMul (arg, this, arg1);
}
// 保留两位小数 v是小数位
function toDecimal (num, v) {
	var f = parseFloat (v);
	if (isNaN (f)){
		// 默认保存两位
		v = 2;
	}
	var vv = Math.pow (10, v);
	return Math.round (num * vv) / vv;
}
// 字符串 全部替换
String.prototype.replaceAll = function (s1, s2) {
	return this.replace (new RegExp (s1, "gm"), s2);
}
// 截取字符串为指定长度
function limitStr (s, len) {
	if (s != null && s != ""){
		s = removeHTMLTag (s);
		if (s.length > len){
			s = s.substring (0, len - 1) + "...";
		}
	}
	return s;
}
// 去除字符串中的HTML标记
function removeHTMLTag (str) {
	str = str.replace (/<\/?[^>]*>/g, ''); // 去除HTML tag
	str = str.replace (/[ | ]*\n/g, '\n'); // 去除行尾空白
	// str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
	str = str.replace (/&nbsp;/ig, '');// 去掉&nbsp;
	return str;
}
