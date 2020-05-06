<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
    <jsp:include page="/WEB-INF/views/include/head4.jsp"/>
    <meta charset="utf-8">
    <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
       Remove this if you use the .htaccess -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="initial-scale=1.0, target-densitydpi=device-dpi"/>
    <!-- this is for mobile (Android) Chrome -->
    <meta name="viewport" content="initial-scale=1.0, width=device-height">
    <!--  mobile Safari, FireFox, Opera Mobile  -->
    <script src="jslib/jsjs/modernizr.js"></script>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="jslib/jsjs/flashcanvas.js"></script>
    <![endif]-->
    <style type="text/css">

        div {
            margin-top: 1em;
            margin-bottom: 1em;
        }

        input {
            padding: .5em;
            margin: .5em;
        }

        select {
            padding: .5em;
            margin: .5em;
        }

        #signatureparent {
            color: darkblue;
            background-color: darkgrey;
            /*max-width:600px;*/
            padding: 20px;
        }

        /*This is the div within which the signature canvas is fitted*/
        #signature {
            border: 2px dotted black;
            background-color: lightgrey;
        }

        /* Drawing the 'gripper' for touch-enabled devices */
        html.touch #content {
            float: left;
            width: 92%;
        }

        html.touch #scrollgrabber {
            float: right;
            width: 4%;
            margin-right: 2%;
            background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAFCAAAAACh79lDAAAAAXNSR0IArs4c6QAAABJJREFUCB1jmMmQxjCT4T/DfwAPLgOXlrt3IwAAAABJRU5ErkJggg==)
        }

        html.borderradius #scrollgrabber {
            border-radius: 1em;
        }

    </style>
</head>
<body>
<div>
    <div id="content">
        <div id="signatureparent">
            <div id="signature"></div>
        </div>
        <div id="tools"></div>
        <input type="button" value="完成" id="btnTest">
<%--        手写的值为:<input type="text" name="" id="memo">--%>
        <p><input type="file" name="files" multiple="multiple"></p>
        <div><p>显示所手写:</p>
            <div id="displayarea"></div>
        </div>
    </div>
    <div id="scrollgrabber"></div>
</div>
<script src="jslib/jsjs/jquery.js"></script>
<script type="text/javascript">
    jQuery.noConflict()
</script>
<script>
    /*  @preserve
    jQuery pub/sub plugin by Peter Higgins (dante@dojotoolkit.org)
    Loosely based on Dojo publish/subscribe API, limited in scope. Rewritten blindly.
    Original is (c) Dojo Foundation 2004-2010. Released under either AFL or new BSD, see:
    http://dojofoundation.org/license for more information.
    */
    (function ($) {
        var topics = {};
        $.publish = function (topic, args) {
            if (topics[topic]) {
                var currentTopic = topics[topic],
                    args = args || {};

                for (var i = 0, j = currentTopic.length; i < j; i++) {
                    currentTopic[i].call($, args);
                }
            }
        };
        $.subscribe = function (topic, callback) {
            if (!topics[topic]) {
                topics[topic] = [];
            }
            topics[topic].push(callback);
            return {
                "topic": topic,
                "callback": callback
            };
        };
        $.unsubscribe = function (handle) {
            var topic = handle.topic;
            if (topics[topic]) {
                var currentTopic = topics[topic];

                for (var i = 0, j = currentTopic.length; i < j; i++) {
                    if (currentTopic[i] === handle.callback) {
                        currentTopic.splice(i, 1);
                    }
                }
            }
        };
    })(jQuery);

</script>
<script src="jslib/jsjs/jSignature.min.noconflict.js"></script>
<script>
    (function ($) {

        $(document).ready(function () {

            // This is the part where jSignature is initialized.
            var $sigdiv = $("#signature").jSignature({'UndoButton': true})

                // All the code below is just code driving the demo.
                , $tools = $('#tools')
                , $extraarea = $('#displayarea')
                , pubsubprefix = 'jSignature.demo.'

            // 点击按钮显示值
            $("#btnTest").bind('click', function (e) {
                // 取得所画的模板
                var data = $sigdiv.jSignature('getData', 'image')
                console.log("图画数据"+data)

                // $.post("seal/autograph1",{"img": data});

                // $.ajax({
                //     "url":"seal/autograph1",
                //     "data":data,
                //     "type":"post",
                //     "dataType":"json",
                //     "success":function(json) {
                //
                //     }
                //
                // });






                // 将取得值设置到文本中
                $("#memo").val(data.join(','))
                // 将取得的值设置到显示区域
                $.publish(pubsubprefix + data[0], data);
                var i = new Image()
               i.src = 'data:' + data[0] + ',' + data[1]

                $(i).appendTo($extraarea)


                $.ajax({
                    "url":"seal/addImg",
                    //"data":{"img": data},
                    "data":new FormData(),
                    "type":"post",
                    "contentType":"application/x-www-form-urlencoded",
                    "dataType":"text",
                    "success":function(json) {

                    }

                });







            }).appendTo($tools)




            $('<input type="button" value="修改">').bind('click', function (e) {
                $sigdiv.jSignature('reset')
            }).appendTo($tools)

            if (Modernizr.touch) {
                $('#scrollgrabber').height($('#content').height())
            }

        })

    })(jQuery)
</script>
<%--<script>--%>
<%--    //将base64转换为文件--%>
<%--    dataURLtoFile: function(dataurl, filename) {--%>
<%--        var arr = dataurl.split(','),--%>
<%--            mime = arr[0].match(/:(.*?);/)[1],--%>
<%--            bstr = atob(arr[1]),--%>
<%--            n = bstr.length,--%>
<%--            u8arr = new Uint8Array(n);--%>
<%--        while (n--) {--%>
<%--            u8arr[n] = bstr.charCodeAt(n);--%>
<%--        }--%>
<%--        return new File([u8arr], filename, { type: mime });--%>
<%--    }--%>

<%--    //调用--%>
<%--    var file = dataURLtoFile(data, imgName);--%>
<%--    console.log("文件名"+file)--%>
<%--</script>--%>
</body>
</html>
