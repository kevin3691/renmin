<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/28 0028
  Time: 14:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/views/include/head4.jsp"/>
    <link rel="stylesheet" href="css/viewimg.css">
    <link rel="stylesheet" href="css/viewer.min.css">

    <title>GET VIDEO</title>
    <meta charset="utf-8">
</head>
<body onload="getMedia();" oncontextmenu=self.event.returnValue=false>
<%--<input type="button" title="开启摄像头" value="开启摄像头" onclick="getMedia()" />--%>
<video id="video" width="1920px" height="1080px" autoplay="autoplay"></video>
<button id="snap" onclick="takePhoto()">拍照</button>
<button id="snap" onclick="onSave()">完成</button>
<style>

    #displayarea img{
        display: block;
        width: 200px;
        height: 100px;
    }
    #canvas {
        position: fixed;
        width: 100px;
        height: 100px;
        left: -100px;
        top: 0;
    }
</style>
<canvas id="canvas" width="1920px" height="1080px"></canvas>

<div>
    <ul id="displayarea">
    </ul>
</div>
<script src="jslib/jsjs/jquery.js"></script>


<script src="jslib/viewer.min.js"></script>
<script>


    function DeleteImage(imgdiv) {
        var imgtitle = $("img", $(imgdiv).parent().parent())[0].title;
        var mess = confirm("是否删除图片?");
        if (mess == true) {//开始删除图片
            $(imgdiv).parent().parent().remove();
        }

    }

    //获得video摄像头区域
    let video = document.getElementById("video");
    function getMedia() {
        let constraints = {
            video: {width: 1920, height: 1080},
            // video: {width: 1000, height: 500},
            audio: true
        };
        /*
        这里介绍新的方法:H5新媒体接口 navigator.mediaDevices.getUserMedia()
        这个方法会提示用户是否允许媒体输入,(媒体输入主要包括相机,视频采集设备,屏幕共享服务,麦克风,A/D转换器等)
        返回的是一个Promise对象。
        如果用户同意使用权限,则会将 MediaStream对象作为resolve()的参数传给then()
        如果用户拒绝使用权限,或者请求的媒体资源不可用,则会将 PermissionDeniedError作为reject()的参数传给catch()
        */
        let promise = navigator.mediaDevices.getUserMedia(constraints);
        promise.then(function (MediaStream) {
            video.srcObject = MediaStream;
            video.play();
        }).catch(function (PermissionDeniedError) {
            console.log(PermissionDeniedError);
        })


    }
    let photos = "";
    let index = 0;
    function takePhoto() {

        // $extraarea = $('#displayarea')


        //获得Canvas对象
        let canvas = document.getElementById("canvas");
        let ctx = canvas.getContext('2d');
        ctx.drawImage(video, 0, 0, 1920, 1080);
        let dataURL=canvas.toDataURL("img/jpeg");
        var src =  dataURL

        parent.onTakePhotoOk(src);

        // var str = genImgList(src)
        // $extraarea.append(str)

        /*var i = new Image()
        i.src = src*/
        // $(i).appendTo($extraarea)


        /*viewer = new Viewer(document.getElementById('displayarea'), {
            url: 'data-original'
        });*/

    }

    function genImgList(src) {
       /* var str = '';
        str += '<li style="cursor: hand"><div class="imgbox">';
        str += '<img data-original="' + src + '" width="200px";height="100px"; src="' + src + '" title="' + index + '" />';
        str += '<div class="text"><div class="imgtext" onclick="DeleteImage(this)"> 删  除</div></div></div></li>';*/
        var str = '';
        str += '<li style="cursor: hand">';
        str += '<img data-original="' + src + '" width="200px";height="100px"; src="' + src + '" title="' + index + '" />';
        str += '<div class="text"><div class="imgtext" onclick="DeleteImage(this)"> 删  除</div></div></li>';
        return str;
    }

    function onSave() {

        $('#displayarea').find("img").each(function(i,v){
            photos+=v.src+"|";
        });
        parent.onTakePhotoOk(photos);
    }

    function deletePhoto() {
        var oldnode = document.getElementsByTagName('img')[0];
          oldnode.parentNode.removeChild(oldnode)
    }
    var viewer;
    function initImgList(){
        if("${o.photo}" != "")
        {
            var data="${o.photo}".split("|");
            for (var t=0;t<data.length-1;t++){
                $('#displayarea').append(genImgList(data[t]))
            }

           /* viewer = new Viewer(document.getElementById('displayarea'), {
                url: 'data-original'
            });*/
        }
    }


    $ (function () {
        //$(document.body).toggleClass("html-body-overflow");
        // IFrameResize();

        initImgList()
    })

</script>



<script>
    /*var viewer = new Viewer(document.getElementById('displayarea'), {
        url: 'data-original'
    });*/
</script>

<form id="mainForm" class="form-horizontal">
    <input type="hidden" id="id" name="id" value="${o.id}" />
    <input type="hidden" id="orgId" name="orgId" value="${o.orgId}" />
    <input type="hidden" id="personId" name="personId" value="${o.personId}" />
    <input type="hidden" id="org" name="org" value="${o.org}" />
    <input type="hidden" id="sprId" name="sprId" value="${o.sprId}" />
    <input type="hidden" id="spr" name="spr" value="${o.spr}" />
    <input type="hidden" id="actAt" name="actAt" value="${o.actAt}" />
    <input type="hidden" id="status" name="status" value="${o.status}" />
    <input type="hidden" id="sealTypeName" name="sealTypeName" value="${o.sealTypeName}" />
    <input type="hidden" id="isActive" name="isActive" value="${o.isActive}" />
    <input type="hidden" id="descr" name="descr" value="${o.descr}" />
    <input type="hidden" id="lineNo" name="lineNo" value="${o.lineNo}" />
    <input type="hidden" id="img" name="img" value="${o.img}" />
    <input type="hidden" id="person" name="person" value="${o.person}" />
    <input type="hidden" id="sqrq" name="sqrq" value="${o.sqrq}" />
    <input type="hidden" id="sqyy" name="sqyy" value="${o.sqyy}" />
    <input type="hidden" id="content" name="content" value="${o.content}" />
    <input type="hidden" id="photo" name="photo" value="${o.photo}" />

    <jsp:include page="/WEB-INF/views/include/recordinfo.jsp" />
</form>
</body>
</html>
