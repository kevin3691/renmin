<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<jsp:include page="/WEB-INF/views/include/head4.jsp" />
	<link href="easyui/css/process.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="jslib/webuploader/webuploader.min.css">
<script type="text/javascript"
	src="jslib/webuploader/webuploader.min.js"></script>
<script type="text/javascript" src="jslib/webuploader/uploader.min.js"></script>

<title>高拍仪</title>
	<script language="javascript" type="text/javascript">

		var img_index = 1;
        var DeviceMain;//主头
        var DeviceAssist;//副头
        var Video;//视频
		var imglist;
		var uploader;

        function plugin()
        {
            return document.getElementById('view1');
        }

        function view()
        {
            return document.getElementById('view1');
        }

        function thumb()
        {
            return document.getElementById('thumb1');
        }

        function addEvent(obj, name, func)
        {
            if (obj.attachEvent) {
                obj.attachEvent("on"+name, func);
            } else {
                obj.addEventListener(name, func, false);
            }
        }
        function OpenVideo()
        {
            var sSubType = document.getElementById('subType');
            var sResolution = document.getElementById('selRes');
            var lDeviceName =  document.getElementById('lab1');
            var sDevice =   document.getElementById('device');
            var dev;

            if(sDevice.selectedIndex != -1)
            {
                CloseVideo()

                if(sDevice.selectedIndex == plugin().Device_GetIndex(DeviceMain))
                {
                    dev = DeviceMain;//选中主头
                }
                else if(sDevice.selectedIndex == plugin().Device_GetIndex(DeviceAssist))
                {
                    dev = DeviceAssist;//选中副头
                }


                var SubtypeName;
                if(sSubType.options.selectedIndex != -1)
                {
                    var SubtypeName = sSubType.options[sSubType.options.selectedIndex].text;
                    if(SubtypeName == "YUY2")
                    {
                        SelectType = 1;
                    }
                    else if(SubtypeName == "MJPG")
                    {
                        SelectType = 2;
                    }
                    else if(SubtypeName == "UYVY")
                    {
                        SelectType = 4;
                    }
                }

                var nResolution = sResolution.selectedIndex;

                Video = plugin().Device_CreateVideo(dev, nResolution, SelectType);
                if (Video)
                {
                    view().View_SelectVideo(Video);
                    view().View_SetText("打开视频中，请等待...", 0);

                }
            }
        }

        function CloseVideo()
        {
            if (Video)
            {
                view().View_SetText("", 0);
                plugin().Video_Release(Video);
                Video = null;
            }
        }

        //切换设备
        function changeDev()
        {
            var sSubType = document.getElementById('subType');
            var sResolution = document.getElementById('selRes');
            var lDeviceName =  document.getElementById('lab1');
            var sDevice =   document.getElementById('device');
            var dev;

            if(sDevice.selectedIndex != -1)
            {
                if(sDevice.selectedIndex == plugin().Device_GetIndex(DeviceMain))
                {
                    dev = DeviceMain;//选中主头
                }
                else if(sDevice.selectedIndex == plugin().Device_GetIndex(DeviceAssist))
                {
                    dev = DeviceAssist;//选中副头
                }

                sSubType.options.length = 0;
                var subType = plugin().Device_GetSubtype(dev);
                if (subType & 1)
                {
                    sSubType.add(new Option("YUY2"));
                }
                if (subType & 2)
                {
                    sSubType.add(new Option("MJPG"));
                }
                if (subType & 4)
                {
                    sSubType.add(new Option("UYVY"));
                }
                sSubType.selectedIndex = 0;

                var SubtypeName;
                if(sSubType.options.selectedIndex != -1)
                {
                    var SubtypeName = sSubType.options[sSubType.options.selectedIndex].text;
                    if(SubtypeName == "YUY2")
                    {
                        SelectType = 1;
                    }
                    else if(SubtypeName == "MJPG")
                    {
                        SelectType = 2;
                    }
                    else if(SubtypeName == "UYVY")
                    {
                        SelectType = 4;
                    }
                }

                var nResolution = plugin().Device_GetResolutionCountEx(dev, SelectType);//根据出图模式获取分辨率
                sResolution.options.length = 0;
                for(var i = 0; i < nResolution; i++)
                {
                    var width = plugin().Device_GetResolutionWidthEx(dev, SelectType, i);
                    var heigth = plugin().Device_GetResolutionHeightEx(dev, SelectType, i);
                    sResolution.add(new Option(width.toString() + "*" + heigth.toString()));
                }
                sResolution.selectedIndex = 0;
            }
        }

        //切换出图模式
        function changesubType()
        {
            var sSubType = document.getElementById('subType');
            var sResolution = document.getElementById('selRes');
            var lDeviceName =  document.getElementById('lab1');
            var sDevice =   document.getElementById('device');
            var dev;

            if(sDevice.selectedIndex != -1)
            {
                if(sDevice.selectedIndex == plugin().Device_GetIndex(DeviceMain))
                {
                    dev = DeviceMain;//选中主头
                }
                else if(sDevice.selectedIndex == plugin().Device_GetIndex(DeviceAssist))
                {
                    dev = DeviceAssist;//选中副头
                }

                var SubtypeName;
                if(sSubType.options.selectedIndex != -1)
                {
                    var SubtypeName = sSubType.options[sSubType.options.selectedIndex].text;
                    if(SubtypeName == "YUY2")
                    {
                        SelectType = 1;
                    }
                    else if(SubtypeName == "MJPG")
                    {
                        SelectType = 2;
                    }
                    else if(SubtypeName == "UYVY")
                    {
                        SelectType = 4;
                    }
                }

                var nResolution = plugin().Device_GetResolutionCountEx(dev, SelectType);//根据出图模式获取分辨率
                sResolution.options.length = 0;
                for(var i = 0; i < nResolution; i++)
                {
                    var width = plugin().Device_GetResolutionWidthEx(dev, SelectType, i);
                    var heigth = plugin().Device_GetResolutionHeightEx(dev, SelectType, i);
                    sResolution.add(new Option(width.toString() + "*" + heigth.toString()));
                }
                sResolution.selectedIndex = 0;
            }
        }

        function Load()
        {
            plugin().Global_CreateDir("D:\\test")
            //设备接入和丢失
            //type设备类型， 1 表示视频设备， 2 表示音频设备
            //idx设备索引
            //dbt 1 表示设备到达， 2 表示设备丢失
            addEvent(plugin(), 'DevChange', function (type, idx, dbt)
            {
                if(1 == type)//视频设备
                {
                    if(1 == dbt)//设备到达
                    {
                        var deviceType = plugin().Global_GetEloamType(1, idx);
                        if(1 == deviceType)//主摄像头
                        {
                            if(null == DeviceMain)
                            {
                                DeviceMain = plugin().Global_CreateDevice(1, idx);
                                if(DeviceMain)
                                {
                                    var sSubType = document.getElementById('subType');
                                    var sResolution = document.getElementById('selRes');
                                    var lDeviceName =  document.getElementById('lab1');
                                    var sDevice =   document.getElementById('device');

                                    sDevice.add(new Option(plugin().Device_GetFriendlyName(DeviceMain)));
                                    sDevice.selectedIndex = idx;//选中主头

                                    changeDev();

                                    OpenVideo();//是主头自动打开视频
                                }
                            }
                        }
                        else if(2 == deviceType || 3 == deviceType)//辅摄像头
                        {
                            if(null == DeviceAssist)
                            {
                                DeviceAssist = plugin().Global_CreateDevice(1, idx);
                                if(DeviceAssist)
                                {
                                    var sSubType = document.getElementById('subType');
                                    var sResolution = document.getElementById('selRes');
                                    var lDeviceName =  document.getElementById('lab1');
                                    var sDevice =   document.getElementById('device');

                                    sDevice.add(new Option(plugin().Device_GetFriendlyName(DeviceAssist)));
                                }
                            }
                        }
                    }
                    else if(2 == dbt)//设备丢失
                    {
                        if (DeviceMain)
                        {
                            if (plugin().Device_GetIndex(DeviceMain) == idx)
                            {
                                CloseVideo();
                                plugin().Device_Release(DeviceMain);
                                DeviceMain = null;

                                document.getElementById('device').options.length = 0;
                                document.getElementById('subType').options.length = 0;
                                document.getElementById('selRes').options.length = 0;
                            }
                        }

                        if (DeviceAssist)
                        {
                            if (plugin().Device_GetIndex(DeviceAssist) == idx)
                            {
                                CloseVideo();
                                plugin().Device_Release(DeviceAssist);
                                DeviceAssist = null;

                                document.getElementById('device').options.length = 0;
                                document.getElementById('subType').options.length = 0;
                                document.getElementById('selRes').options.length = 0;
                            }
                        }
                    }
                }
            });

            var title = document.title;
            document.title = title + plugin().version;

            view().Global_SetWindowName("view");
            thumb().Global_SetWindowName("thumb");

            plugin().Global_InitDevs();
            imglist = plugin().Global_CreateImageList();
        }

        function Unload()
        {
            if (Video)
            {
                view().View_SetText("", 0);
                plugin().Video_Release(Video);
                Video = null;
            }
            if(DeviceMain)
            {
                plugin().Device_Release(DeviceMain);
                DeviceMain = null;
            }
            if(DeviceAssist)
            {
                plugin().Device_Release(DeviceAssist);
                DeviceAssist = null;
            }
            plugin().Global_DeinitDevs();
            plugin().Global_RemoveDir("D:\\test")
        }

        function Scan()
        {

            if($("#title").val() == "")
			{
			    alert("请输入标题！")
                $("#title").focus()
				return
			}
            // var date = new Date();
            // var yy = date.getFullYear().toString();
            // var mm = (date.getMonth() + 1).toString();
            // var dd = date.getDate().toString();
            // var hh = date.getHours().toString();
            // var nn = date.getMinutes().toString();
            // var ss = date.getSeconds().toString();
            // var mi = date.getMilliseconds().toString();
            //var Name = "D:\\test\\" + yy + mm + dd + hh + nn + ss + mi + ".jpg";
			var name = img_index
            if(name.length == 1){
                name = "00" + name;
            }
            if(name.length == 2){
                name = "0" + name;
            }
            var Name = "D:\\test\\" + name +".jpg";
            img_index++
            var img = plugin().Video_CreateImage(Video, 0, view().View_GetObject());
            var bSave = plugin().Image_Save(img, Name, 0);
            if (bSave)
            {
                view().View_PlayCaptureEffect();
                thumb().Thumbnail_Add(Name);
                plugin().ImageList_Add(imglist,img);
            }
            plugin().Image_Release(img);
        }

	</script>

	<script type="text/JavaScript">

		function onSave(){
            if (!$ ('#mainForm').validate ().form ()){
                return false;
            }
            var http = plugin().Global_CreateHttp("http://192.168.10.104:8111/aa/servlet/FileSteamUpload?");//java服务器demo地址
            if (http)
            {
                var b = plugin().Http_UploadImageFile(http, "d:\\1.jpg", "2.jpg");
                if (b)
                {
                    alert("上传成功");
                }
                else
                {
                    alert("上传失败");
                }

                plugin().Http_Release(http);
            }
            else
            {
                alert("url 错误");
            }
			return
            //    var http = plugin().Global_CreateHttp(_BP + "document/fileSteamUpload?");//java服务器demo地址
            //    if (http)
            //    {
            //        var b = plugin().Http_Upload(http, 0,pdfName,"","","");
            //        if (b)
            //        {
            //            document.location.href = "document/index"
            //        }
            //        else
            //        {
            //            alert("上传失败");
            //        }
            //
            //        plugin().Http_Release(http);
            //    }
            //    else
            //    {
            //        alert("url 错误");
            //    }

            // var http = plugin().Global_CreateHttp(_BP + "document/fileSteamUpload?");//java服务器demo地址
            // if (http)
            // {
            //     var b = plugin().Http_UploadImageFile(http, "D:\\TEST\\1.jpg","2.jpg");
            //     if (b)
            //     {
            //         alert("上传成功");
            //     }
            //     else
            //     {
            //         alert("上传失败");
            //     }
            //
            //     plugin().Http_Release(http);
            // }
            // else
            // {
            //     alert("url 错误");
            // }
            // return
            // var http =thumb().Thumbnail_HttpUploadCheckImage(_BP + "/FileSteamUpload?",0);
            // if(http)
            // {
            //     var htInfo = thumb().Thumbnail_GetHttpServerInfo();
            //     alert(htInfo);
            // }
            // else
            // {
            //     alert("上传失败！");
            // }

            var thf = thumb().Thumbnail_GetObject()
			var pdfName = "D:\\TEST\\" + $("#title").val() + ".pdf";
            var pdf = plugin().ImageList_SaveToPDF(imglist,2,pdfName,0)

			if(pdf){
                $("#btnSave").css("display","block")
			}
            // var http =thumb().Thumbnail_HttpUploadCheckImage(_BP + "document/FileSteamUpload?",0);
            // if(http)
            // {
            //     var htInfo = thumb().Thumbnail_GetHttpServerInfo();
            //     alert(htInfo);
            // }
            // else
            // {
            //     alert("上传失败！");
            // }


			// var pdfName = "D:\\TEST\\" + $("#title").val() + ".pdf";
            // var pdf = plugin().ImageList_SaveToPDF(imglist,2,pdfName,0)
			// if(pdf){
			// 	alert(_BP)
             //    var http = plugin().Global_CreateHttp(_BP + "document/fileSteamUpload?");//java服务器demo地址
             //    if (http)
             //    {
             //        var b = plugin().Http_Upload(http, 0,pdfName,"","","");
             //        if (b)
             //        {
             //            document.location.href = "document/index"
             //        }
             //        else
             //        {
             //            alert("上传失败");
             //        }
            //
             //        plugin().Http_Release(http);
             //    }
             //    else
             //    {
             //        alert("url 错误");
             //    }

                // var obj = new Object()
                // obj.name = pdfName
                // obj.id = "WU_FILE_0"

                // uploader.upload(new File("WU_FILE_0",pdfName))
			//}
		}

		function onUpload(){
            $("input[name='file']").click();
		}
        function onUploadFinished() {

        }

        function saveDoc(docTypeId,docTypeName,fileId) {
            $.post ('document/saveDoc', {"docTypeId":docTypeId,"docTypeName":docTypeName, "fileId":fileId}, function (result, status) {
                if (result.error){
                    //layer.msg (result.error);
                    //$ ("#name").focus ();
                    return;
                }

                document.location.href = "document/index"
            });

        }

        function Left()
        {
            plugin().Video_RotateLeft(Video);
        }

        function Right()
        {
            plugin().Video_RotateRight(Video);
        }

        function showProgress() {
            layer.open({
                type : 1,
                title : false,
                closeBtn : 0,
                area : [ '100%', '50%' ],
                skin : 'layui-layer-nobg', //没有背景色
                shadeClose : true,
                content : $('#uploader')
            });
        }

        $ (function () {

            uploader = WebUploader.create({
                // swf文件路径
                swf : _BasePath + 'jslib/webuploader/Uploader.swf',
                // 文件接收服务端。
                server : 'comm/attachment/uploader',
                // 选择文件的按钮。可选。
                // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                pick : '#picker',
                // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
                resize : false,
                formData : {
                    category : "${o.docTypeName}",
                    applyTo : "${applyTo}",
                    refNum : "${o.docTypeId}",
                    allowExt : "${allowExt}",
                    allowSize : "${allowSize}",
                    destDir : "${destDir}"
                },
                accept : {
                    extensions : "${allowExt}"
                },
                fileNumLimit : 300,
                fileSizeLimit : "${allowSize}", // 200 M
                fileSingleSizeLimit : "${allowSize}"
                // 50 M
            });
            // 当有文件被添加进队列的时候
            uploader.on('fileQueued', function(file) {

                //showProgress ();
                $("#thelist")
                    .append(
                        '<div id="' + file.id + '" class="item">'
                        + '<h4 class="info">' + file.name
                        + '</h4>'
                        + '<p class="state">等待上传...</p>'
                        + '</div>');
                uploader.upload();
            });
            // 文件上传过程中创建进度条实时显示。
            uploader
                .on(
                    'uploadProgress',
                    function(file, percentage) {
                        var $li = $('#' + file.id), $percent = $li
                            .find('.progress .progress-bar');
                        // 避免重复创建
                        if (!$percent.length) {
                            $percent = $(
                                '<div class="progress progress-striped active">'
                                + '<div class="progress-bar" role="progressbar" style="width: 0%">'
                                + '</div>' + '</div>')
                                .appendTo($li).find(
                                    '.progress-bar');
                        }
                        $li.find('p.state').text('上传中');
                        $percent.css('width', percentage * 100
                            + '%');
                    });
            uploader.on('uploadSuccess', function(file,response) {
                $('#' + file.id).remove();
                var obj = response.entity;
                saveDoc("${o.docTypeId}","${o.docTypeName}",obj.id);
                //$("#grid").trigger("reload");
            });
            uploader.on('uploadError', function(file) {
                $('#' + file.id).find('p.state').text('上传出错');
                $("#grid").datagrid("reload");
                layer.closeAll();
            });
            uploader.on('uploadComplete', function(file) {
                $('#' + file.id).find('.progress').fadeOut();
                $("#grid").datagrid("reload");
            });
            uploader.on('uploadFinished', function() {
                $("#grid").datagrid("reload");
            });
            $("#ctlBtn").on('click', function() {
                uploader.upload();
            });


            $ ('#mainForm').validate ().form ()
            $ (".select2").select2 ();
            $("#btnSave").css("display","none")
        });

	</script>


</head>

<body onload="Load()" onunload="Unload()">



<div id="uploader" class="wu-example">
	<!--用来存放文件信息-->
	<div id="thelist" class="uploader-list"></div>
	<div class="btns" style="display:none;">
		<div id="picker">选择文件</div>
		<button id="ctlBtn" class="btn btn-default">开始上传</button>
	</div>
</div>
	<div class="container-fluid">
		<div>&nbsp;</div>
		<form id="mainForm" class="form-horizontal">

			<div class="breadcrumb content-header form-inline"
				 style="padding:8px;">

				<div class="form-group">

				</div>
			</div>


			<div class="form-group">
				<div class="col-sm-5">
					<object id="view1" type="application/x-eloamplugin" width="600" height="450" name="view"></object>
				</div>
				<div class="col-sm-7">
					<div class="form-group">
						<div class="col-sm-1">
							<label for="device"></label>
							<select id="device" style="width: 90px;display:none" name="device" onchange="changeDev()"></select>
							<select id="subType" style="width: 90px;display:none" name="subType" onchange="changesubType()"></select>
							<select id="selRes" style="width: 90px;display:none" name="selRes"></select>
							<button class="btn btn-info" id="btnAdd" type="button"
									onclick="Scan()">拍照</button>
							<br/>
							<button class="btn btn-info" type="button"
									onclick="onSave()">生成</button>
							<br/>
							<button class="btn btn-info" id="btnSave" type="button"
									onclick="onUpload()">上传</button>
							<br/>
							<button class="btn btn-info"  type="button"
									onclick="Left()">左转</button>
							<br/>
							<button class="btn btn-info"  type="button"
									onclick="Right()">右转</button>
						</div>

						<label class="col-sm-1 control-label" for="title">标题</label>
						<div class="col-sm-10">
							<input class="form-control" id="title" name="title" value="" type="text" required />
						</div>
					</div>
					<div class="form-group">

					</div>


				</div>

			</div>
			<div class="form-group">
				<div class="col-sm-12">
					<object id="thumb1" type="application/x-eloamplugin" width="100%"  name="thumb"></object>
				</div>
			</div>


		</form>

	</div>
</body>
</html>
