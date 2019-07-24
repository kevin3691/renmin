var UPLOADER
$ (function () {
	UPLOADER = new initUploader ();
})
function initUploader () {
	this.formData = {};
	this.accept = {};
	this.duplicate = true;
	this.fileNumLimit = 50;
	this.fileSizeLimit = 200 * 1024 * 1024;
	this.init = function () {
		setContainer ();
		var uploader = WebUploader.create ({
		    // swf文件路径
		    swf : _BasePath + 'jslib/webuploader/Uploader.swf',
		    // 文件接收服务端。
		    server : 'comm/attachment/uploader',
		    // 选择文件的按钮。可选。
		    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
		    pick : '#picker',
		    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		    resize : false,
		    formData : this.formData,
		    accept : this.accept,
		    fileSizeLimit : this.fileSizeLimit,
		    duplicate:true
		});
		// 当有文件被添加进队列的时候
		uploader.on ('fileQueued', function (file) {
			$ ("#thelist").append (
			        '<div id="' + file.id + '" class="item">' + '<h4 class="info">' + file.name + '</h4>'
			                + '<p class="state">等待上传...</p>' + '</div>');
			uploader.upload ();
		});
		// 文件上传过程中创建进度条实时显示。
		uploader.on ('uploadProgress', function (file, percentage) {
			var $li = $ ('#' + file.id), $percent = $li.find ('.progress .progress-bar');
			// 避免重复创建
			if (!$percent.length){
				$percent = $ (
				        '<div class="progress progress-striped active">'
				                + '<div class="progress-bar" role="progressbar" style="width: 0%">' + '</div>'
				                + '</div>').appendTo ($li).find ('.progress-bar');
			}
			$li.find ('p.state').text ('上传中');
			$percent.css ('width', percentage * 100 + '%');
		});
		uploader.on ('uploadSuccess', function (file, res) {
			$ ('#' + file.id).remove ();
			if (onUploadSucess){
				onUploadSucess (file, res);
			}
		});
		uploader.on ('uploadError', function (file) {
			$ ('#' + file.id).find ('p.state').text ('上传出错');
		});
		uploader.on ('uploadComplete', function (file) {
			$ ('#' + file.id).find ('.progress').fadeOut ();
		});
		$ ("#ctlBtn").on ('click', function () {
			uploader.upload ();
		});
	}
}
function setContainer () {
	var container = '<div id="uploader" class="wu-example">'
	container += '<div id="thelist" class="uploader-list"></div>'
	container += '<div class="btns" style="display:none;">'
	container += '<div id="picker">选择文件</div>'
	container += '<button id="ctlBtn" class="btn btn-default">开始上传</button>'
	container += '</div></div>'
	$ (document.body).before (container);
}
