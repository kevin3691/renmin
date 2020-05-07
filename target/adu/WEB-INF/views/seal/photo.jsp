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
    <title>GET VIDEO</title>
    <meta charset="utf-8">
</head>
<body onload="getMedia()">
<%--<input type="button" title="开启摄像头" value="开启摄像头" onclick="getMedia()" />--%>
<button id="snap" onclick="takePhoto()">拍照</button>
<video id="video" width="500px" height="500px" autoplay="autoplay"></video>
<canvas id="canvas" width="500px" height="500px"></canvas>
<script>
    //获得video摄像头区域
    let video = document.getElementById("video");
    function getMedia() {
        let constraints = {
            video: {width: 500, height: 500},
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
    function takePhoto() {
        //获得Canvas对象
        let canvas = document.getElementById("canvas");
        // let ctx = canvas.getContext('2d');
        // ctx.drawImage(video, 0, 0, 500, 500);

        let that = this
        that.canvas.getContext('2d').drawImage(this.video, 0, 0, 300, 220)

        let dataurl = that.canvas.toDataURL('image/jpeg')
        let blob = that.dataURLtoFile(dataurl, 'camera.jpg') // base64 转图片file
        console.log("图片数据??"+blob)

        $("#photo").val(blob);



    }

    $.post ('seal/save', $ ("#mainForm").serialize (), function (result, status) {

    });
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
