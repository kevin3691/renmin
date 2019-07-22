lastTemp = '0';
var startExamObj = {
    'examData'    : null,                                                                                               //考试数据
    'examParams'  : null,                                                                                               //考试参数
    'snapshotRun' : true,                                                                                               //快照比对状态,true=比对并提交, false=暂停状态
    'countdown'   : 0,                                                                                                  //倒计时(s)
    /**
     * 描述 : 考试初始化
     * 参数 :
     *      data   : 考试数据 {
     *          'info'   : 考试信息{}
     *          'data'   : 卷子数据{}
     *          'expand' : {
     *              'examMate' : 考试参数 {
     *                  'duration'          : 考试时长(m),0=从考试开始时间到结束时间
     *                  'examMode'          : 考试方式,1=整卷,2=逐题
     *                  'unityPoint'        : 统一总分,0=使用卷面总分
     *                  'disablesubmit'		: 多少分钟禁止交卷
     *                  'resultPublishTime' : 考试结果发布时间,'1970-01-01 00:00:00'为永不发布(在考试页无用)
     *                  'unityDuration'     : 统一考试时间,0=从进入考试开始算时,1=以考试开始时间算时
     *                  'isAntiCheat'       : 是否防作弊,0=开卷考试,1=防作弊考试
     *                  'isQuestionsRandom' : 是否随机显示试题,0=正常显示,1=随机显示
     *                  'isSurveillance'    : 是否启用考试监控(无用字段,默认便启用)
     *                  'startTime'         : 开始时间
     *                  'endTime'           : 结束时间
     *              }
     *          }
     *      }
     *      params : {
     *          'isExam' : true=考试模式, false=查看模式
     *      }
     * 作者 : Edgar.lee
     */
    'examInit' : function(data, params) {

        var temp;
        startExamObj.examData = data;
        startExamObj.examParams = params;
                                       //初始化完成
        /************************** 防作弊脚本 **************************/
        if( params.isAntiCheat === '1' && !startExamObj.fullScreen(true) )                                              //需要全屏 && 开启失败
        {
            return false;
        }

        /************************** 阻止右键剪切复制粘贴 ****************/
        if(params.noAll === '1')
        {
            document.oncontextmenu = function() {
                return false;
            }
            document.body.oncopy = function() {
                return false;
            }
            document.body.onpaste = function() {
                return false;
            }
            document.body.oncut = function() {
                return false;
            }
            document.onkeydown = function(e){
                if(e.keyCode == 70 && event.ctrlKey){
                    return false;
                }
            }
        }

        /************************** 初始化试卷 **************************/
        params.isExam || $('#submitExam').hide();                                                                       //隐藏提交考试
        $("#paperName").text(data.info.shortname);
        $("#paperName").attr('title',data.info.name);                                                                           //试卷名称
        examCorePapersObj.init(data, {                                                                                  //初始卷子
            "obj"        : document.getElementById("examCorePapersRootBlock"),                                          //卷子根节点
            "rand"       : data.expand.examMate.isQuestionsRandom === '1',                                              //是否随机显示
            "showPoints" : parseFloat(data.expand.examMate.unityPoint)                                                  //展示分数
        });

        /************************** 添加标记和答题卡 **************************/
        $('.exam_core_papers-question_mode').each(function(){                                                           //添加标记
            temp = $(this);
            temp.append('<div class="label" markQuestionId="' +temp.find('.exam_core_papers-question_border').attr('questionid')+ '" onclick="startExamObj.markAnswerCard(\'' +temp.find('.exam_core_papers-question_number').attr('number')+ '\', this)">' +window.L.getText('标记')+ '</div>');
        });

        temp = [$('#ddf-subtitle'), $('#ddf-tagContent')];                                                              //添加答题卡[大题区,试题区,答题对应试题区,当前试题]
        if( $('.exam_core_papers-text_mode').each(function(index){
            temp[3] = $('.exam_core_papers-question_number[number^="' +(index + 1)+ '."]');
            if( temp[3].length )                                                                                        //试题存在
            {
                temp[0].append('<li><a href="#" class="ddf-subtitle_list" onclick="startExamObj.switchAnswerCard(\'' +index+ '\', this); return false;">'+L.sprintf(L.getText('第%s大题'), index+1)+'</a><span class="ddf-subtitle_line"></span></li>');
                temp[2] = $('<div class="ddf-tagContent fl" q-index="'+ index +'" ></div>').appendTo(temp[1]);

                $('.exam_core_papers-question_number[number^="' +(index + 1)+ '."]').each(function(){
                    temp[2].append('<a href="#" class="ddf-ansSheet_num" smallQuestionNum="' +this.getAttribute('number')+ '" onclick="startExamObj.jumpQuestion(\'' +this.getAttribute('number')+ '\'); return false;" >' +this.innerHTML+ '</a>');
                });
            } else {                                                                                                    //试题为空
                $(this).hide();                                                                                         //隐藏对应的试题描述
            }
        }).length === 0 ) {                                                                                             //无题型描述
            startExamObj.toggleAnswerCard();
            $('.test-ansSheetBtn').hide();
        }

        temp[0].find('> li:first a').click();                                                                           //激活第一选项

        // 标记已答试题

        $('#examCorePapersRootBlock').find('.exam_core_papers-question_mode').each(function() {
            var top = $(this), questionid;
            questionid = top.find('.exam_core_papers-question_number').attr('number');

            top.find('input').each(function() {
                if (this.type == 'radio' || this.type == 'checkbox') {
                    $(this).is(':checked') && $('[smallquestionnum="'+questionid+'"]').addClass('ddf-ansSheet_num_wered');
                    return true;
                }

                if (this.type == 'text') {
                    $('[smallquestionnum="'+questionid+'"]').addClass('ddf-ansSheet_num_wered');
                    !$(this).val() && $('[smallquestionnum="'+questionid+'"]').removeClass('ddf-ansSheet_num_wered');
                }
            });

            top.find('textarea').each(function() {
                $(this).val().replace('&nbsp;', '').replace('<p></p>', '') && $('[smallquestionnum="'+questionid+'"]').addClass('ddf-ansSheet_num_wered');
            });
        });

        /************************** 初始化标记 **************************/
        if( data.expand.markList )
        {
            $.each(data.expand.markList, function () {
                $(".label[markQuestionId=" +this+ "]").get(0).click();                                                  //兼容 IE6 的点击方案
            });
        }

        //非逐题模式
        if(data.expand.examMate.examMode != '2'){
            $(window).scroll(function(){
                var scrollHeight = $(window).scrollTop();
                var screnHeight = $(window).height()*0.33;
                $('.exam_core_papers-text_mode').each(function(index){
                    if(($(this).offset().top - scrollHeight)<=screnHeight && ($(this).offset().top - scrollHeight)>=0){
                        temp = index;
                        return false;
                    }
                })
                if(temp != lastTemp){
                    lastTemp = temp;
                    $('#ddf-subtitle li').attr('class','ddf-subtitle_list');
                    $($('#ddf-subtitle li')[temp]).attr('class','ddf-subtitle_list_h');
                    $('#ddf-tagContent div').hide();
                    $($('#ddf-tagContent div')[temp]).show();
                }
            })
        }

        /************************** 逐题模式 **************************/
        data.expand.examMate.examMode === '2' && startExamObj.onlyOneMode("init");
        $('#examCorePapersRootBlock').css({'visibility' : 'visible', 'height' : 'auto'});                               //初始化完成

        /****
         * 说明：考试页面缩略图，点击弹出高清图片
         */
        var smallImg = $('#examCorePapersRootBlock').find('img');
        smallImg.css({'max-width':'300px','cursor':'pointer'});
        smallImg.attr('title', 'Photo by Kelly Clark');
        smallImg.click(function(){
            window.L.open('oDialogDiv')('', 'text:<img style="max-width:1200px;" src="' + $(this).attr('src') + '" onload="startExamObj.maxImgPreview()" />');
        });


        /************************** 初始化倒计时 **************************/
        if( data.expand.examMate.duration === '0' )                                                                     //从考试开始时间到结束时间
        {
            data.expand.examMate.duration = (startExamObj.strtotime(data.expand.examMate.endTime) - startExamObj.strtotime(data.expand.examMate.startTime)) / 60;
        }

        window.L.open('tip')();// 断网是无法获取，预获取tip
        temp = data.expand.examMate.duration * 60;                                                                      //提交倒计时秒
        temp -= startExamObj.strtotime(data.expand.examMate.nowTime) -
            startExamObj.strtotime(data.expand.examMate.unityDuration === '1' ? data.expand.examMate.startTime : data.info.showTime);
        startExamObj.countdown = temp > 0 ? parseInt(temp) : 0;                                                         //存入倒计时
        startExamObj.countdownSubmit();                                                                                 //开始倒计时提交
        examCoreQuestionsObj.event('papers::snapshot', startExamObj.saveSnapshot);                                      //触发保存快照
    },

    //分页图片最大化预览
    'maxImgPreview' : function ()
    {
        window.L.open('oDialogDiv').skinLayout();
    },

    /**
     * 描述 : 逐题模式
     * 作者 : Edgar.lee
     */
    'onlyOneMode' : function (type) {
        $("#examCorePapersRootBlock > .exam_core_papers-text_mode, #examCorePapersRootBlock > .exam_core_papers-question_mode").hide();
        (temp = $(".labelsel[markQuestionId]").eq(-1)).length || (temp = $(".label[markQuestionId]:eq(0)"));            //得到需要显示的标记
        temp = temp.parents(".exam_core_papers-question_mode");                                                         //得到标记所属的试题
        type === "init" ? $("#onlyOneMode").show() : temp = temp.nextAll(".exam_core_papers-question_mode:eq(0)");      //初始化 ? 显示逐题框 : 定位下一试题
        $("#ddf-subtitle > li").eq(
            temp.show().prevAll(".exam_core_papers-text_mode").eq(0).show().end().length - 1                            //显示本题及题型描述
        ).children('a').click();                                                                                        //切换指定选项卡
        temp.nextAll(".exam_core_papers-question_mode:eq(0)").length || $("#nextExam").html(window.L.getText('已到最后一题')).removeAttr('onclick').attr('class','nextExamEnd');                       //有下一题 || 隐藏逐题框
        (temp = temp.find('.label[markquestionid]').get(0)) && temp.click();                                            //兼容IE6 && 做标记

        // 隐藏答题卡
        // $('#answerCardBlock').hide();
    },

    /**
     * 描述 : 倒计时
     * 作者 : Edgar.lee
     */
    'countdownSubmit' : function () {
        var temp = [parseInt(startExamObj.countdown / 86400), new Date(startExamObj.countdown % 86400 * 1000)];
        $('#countdown').html((temp[0] ? temp[0] + L.getText('天 ') : '') + ('0' + temp[1].getUTCHours()).slice(-2) +':'+ ('0' + temp[1].getUTCMinutes()).slice(-2) +':'+ ('0' + temp[1].getUTCSeconds()).slice(-2));
        if(startExamObj.countdown <= 180){
        	$('#countdown').parent('div').removeClass("b_red").css("background","red");
        }
        if(startExamObj.countdown == 300){
            window.L.open('tip')(L.getText('距离考试结束还有5分钟'),10000);
        }
        if( startExamObj.countdown <= 1 )                                                                               //计时结束
        {
            startExamObj.submitExam(true);                                                                              //提交考试
        } else {                                                                                                        //继续倒计时
            startExamObj.examParams.isExam && startExamObj.countdown % 50 === 0 && startExamObj.saveSnapshot();         //考试模式 && 每50s && 保存快照
            setTime = window.setTimeout(function(){startExamObj.countdown -= 1; startExamObj.countdownSubmit();}, 1000);          //定时循环
        }
    },

    /**
     * 描述 : 保存快照提交
     * 作者 : Edgar.lee
     */
    'saveSnapshot' : function () {
        if( startExamObj.snapshotRun ) {
            startExamObj.snapshotRun = false;                                                                           //关闭快照
            examCorePapersObj.snapshot({
                "url"      : window.ROOT_URL + '/exam.php?a=snapshotExam',
                "expand"   : {
                    "resultMateId" : startExamObj.examData.expand.resultMateId,
                    "duration"     : startExamObj.countdown,                                                            //剩余时长(s)
                    "markList"     : $('.labelsel[markQuestionId]').map(function(){                                     //标记列表
                        return this.getAttribute('markQuestionId');
                    }).get()
                },
                "callback" : function (data) {
                    startExamObj.snapshotRun = true;                                                                    //开启快照
                    switch (data) {
                        case '0':                                                                                       //无需提交
                        case '1':                                                                                       //提交成功
                        break;
                        case 'err001':                                                                                  //考试已被作废
                            startExamObj.windowClose(L.getText('试卷已被作废, 您可以退出考试'));
                        break;
                        case 'err002':                                                                                  //考试已被收卷
                            startExamObj.windowClose(L.getText('试卷已被收取, 您可以退出考试'));
                        break;
                        default :
                            window.L.open('tip')(L.getText('网络中断，请检查网络环境'));                                           //保存失败
                    }
                }
            });
        }
    },

    /**
     * 描述 : 提交考试
     * 作者 : Edgar.lee
     */
    'submitExam' : function (enforce) {

    	if(startExamObj.examData.expand.examMate.disablesubmit !==0){												//增加禁止提交试卷功能
    		var  temp = startExamObj.examData.expand.examMate.duration * 60;                                                                      //提交倒计时秒
            var  examStartTime = startExamObj.strtotime(startExamObj.examData.expand.examMate.nowTime) -
                 startExamObj.strtotime(startExamObj.examData.expand.examMate.unityDuration === '1' ? startExamObj.examData.expand.examMate.startTime : startExamObj.examData.info.showTime);
            var  stampTime = examStartTime +(temp- examStartTime - startExamObj.countdown);
	        if(parseInt(startExamObj.examData.expand.examMate.disablesubmit * 60) > stampTime){
                window.L.open('tip')(startExamObj.examData.expand.examMate.disablesubmit+L.getText('分钟内禁止提交试卷'));
                return false;
            }
    	}

        if( startExamObj.examParams.isExam )                                                                            //允许提交
        {
            if( enforce )                                                                                               //强制提交考试
            {
                window.L.open('tip')(L.getText('正在提交请稍候...'), false, false, true);
                startExamObj.snapshotRun = false;                                                                       //停止快照保存
                examCorePapersObj.snapshot({
                    "url"      : window.ROOT_URL + '/exam.php?a=submitExam',
                    "enforce"  : true,                                                                                  //强制提交
                    "callback" : function(data){
                        if(
                            $.type(data = window.L.json(data)) !== 'object' ||                                          //解析失败
                            data.state !== 'done' && data.state !== 'ignore'                                            //wait=等待, error=错误
                        ) {
                            window.L.open('tip')(L.getText('当前交卷人数多,10秒后会重新进入交卷队列'), false, false, true);
                            window.setTimeout(function(){startExamObj.submitExam(true);}, 10000);                       //定时交卷
                        } else if( data.state === 'done' ) {
                    		if(data.scores >= data.pass){
                    			   $.ajax({
                    			        url : ROOT_URL+"/exam.php?a=setUserExamCert",
                    			        type : "POST",
                    			        data : {'type':'E',
                    			        	'typeId' :startExamObj.examData.info.examId}

                    			    });
                    		}
                    	    window.L.open('tip')(window.L.getText('交卷成功'));
                            if(typeof(setTime) != 'undefined'){
                                clearTimeout(setTime);
                            }
                        	if(startExamObj.examParams.resTime === "1970-01-01 01:01:01"){
                                  //  var text_mode='';
//                                   $('.exam_core_papers-text_mode').each(function(){
//                                       text_mode+=$(this).text();
//
//                                   });
                                    var all = $(".ddf-tagContent a").length; // 统计总题数
                                    var num=$("a[class='ddf-ansSheet_num']").length;//判断有多少题未答
                                    var persent = (data.scores/data.points)*100; // 计算正确率
                                    var isPass = data.scores>=data.pass?L.getText('已通过'):L.getText('未通过');
                                    var submitHtml ='text:<div class="hlx-qbox" style="width: 500px;text-align:center;">'+
                                    '<h1 style="margin-top:30px;color:#336699;">'+
                                    L.getText('您本次考试答题结果')+
                                    '</h1><div style="margin:30px auto;padding:0px;"><span style="font-size:40px;font-weight:bold;">'+data.scores+'</span><span style="font-family: Microsoft YaHei; font-size:26px;font-weight:bold;line-height:26px;margin:30px 5px 0px 5px;"><label'+
                                    '">'+L.getText('分')+'<label style="margin:0px 5px;">|</label></label><label>'+isPass+'</label></span></div>'+
                                    '<div style="font-family: Microsoft YaHei;"><span style="margin-right:20px;font-size:16px;">' +
                                    L.getText('总分：&nbsp;')+data.points+L.getText('&nbsp;分')+'</span><span style="font-size:16px;">'+L.getText('及格：&nbsp;')+data.pass+L.getText('&nbsp;分')+'</span></div></div>';
                                    // submitHtml += '<div style="text-align: center;font-size:16px;">'+L.getText('以上分数仅是客观题分数，主观题分数待人工评分后发布')+'</div>';

                                     // if($('.exam_core_questions_shortAnswer-text_border').length>0){
                                     //       window.L.open('oDialogDiv')('提交成功', 'text:<div class="hlx-qbox" style="float:left; with:80%; padding:20px 20px 30px 90px;"><span class="" style="float:left; with:100%; font-size:14px; line-height:24px;"><span style="float:left;">'+L.getText('本次考试客观题得 ：')+'</span><span class=""><span  style="font-size:18px">'+data.scores+'分</span></br>'+L.getText('主观题需要人工评分后再公布成绩')+'</span></span></div>', '400', '200', [1, function () {
                                     //       startExamObj.windowClose();
                                     //    }]);

                                     //  }else{
                                           window.L.open('oDialogDiv')(L.getText('提交成功'), submitHtml, '510', '200', [[L.getText('我知道了')], function (isTrue) {
                                           startExamObj.windowClose();
                                        }]);
                                      // }


                        	}else if(startExamObj.examParams.resTime === "1970-01-01 00:00:00"){

                        		window.L.open('oDialogDiv')(L.getText('提交成功'), 'text:<div class="hlx-qbox" style="float:left; with:80%; padding:20px 20px 30px 80px;"><span class="" style="float:left; with:100%; font-size:14px; "><span style="float:left;">'+L.getText('本次考试成绩不发布')+'</span><span class=""></span></span></div>', '300', '200', [1, function (isTrue) {
                                    startExamObj.windowClose();
                                }]);
                        	}else{
                        		window.L.open('oDialogDiv')(L.getText('提交成功'), 'text:<div class="hlx-qbox" style="float:left; with:80%; padding:20px 20px 30px 60px;"><span class="" style="float:left; with:100%; font-size:14px;"><span style="float:left;">'+L.getText('请等待成绩发布时间')+' ：</span><span class="">'+startExamObj.examParams.resTime+'</span></span></div>', '400', '200', [1, function (isTrue) {
                                    startExamObj.windowClose();
                                }]);
                        	}
                        } else {                                                                                        //ignore=忽略
                            startExamObj.windowClose(L.getText('试卷已提交, 您可以退出考试'));
                        }
                    }
                });
            } else {
                var all = $(".ddf-tagContent a").length; // 统计总题数
                var unNum=$("a[class='ddf-ansSheet_num']").length;//判断有多少题未答
                var num = all-unNum;
                var notice=L.getText('确定要提交试卷？');
                $($('#ddf-subtitle li')[$($("a[class='ddf-ansSheet_num']")[0]).parent().attr('q-index')]).children('a').click();
                $($("a[class='ddf-ansSheet_num']")[0]).click();
                word = L.sprintf(L.getText('您本次考试的试题总数')+'&nbsp;&nbsp;%s&nbsp;&nbsp;'+L.getText('道')+',', all);
                word += L.sprintf(L.getText('已答试题')+'&nbsp;&nbsp;%s&nbsp;&nbsp;'+L.getText('道'), num);
                word2 = L.sprintf(L.getText('未答试题')+'<span style="font-size:22px;font-weight:bold;color:#FFCC33;margin:0px 8px;">%s</span>'+L.getText('道'), unNum);
                window.L.open('oDialogDiv')(L.getText('交卷提醒'),
                'text:<div style="text-align:center;"><h1 style="font-size:20px;color:#336699;margin-top:20px;">'+notice+'</h1><span style="display:inline-block; width:100%; text-align:center; font-size:18px; height:80px; line-height:80px;">'
                +word+'</span><span style="font-size:18px;padding-top:40px;">'+word2+'</span></div>', '600', '400', [
                    2,
                    function (isTrue) {
                    isTrue && startExamObj.submitExam(true);
                }]);
            }
        }
    },
    /**
     * @author DOIT
     * @param NULL
     * @returns 登陆参数设置的考试交卷后是否返回登录界面
     */
   'getSettingParam' : function()
            {

                    var sendurl =window.ROOT_URL+'/exam/examCtl.php?a=getSettingParams';
                   // var params ='setting_param='+encodeURIComponent(L.json(params));
                    var result;
                    $.ajax({
                       type: "POST",
                       async:false,
                       url: sendurl,
                      // data: params,
//                       dataType:"json",
                       success: function(data){
                                    result = data;

                       },
                       error:function (XMLHttpRequest, textStatus, errorThrown) {
                            //alert("上传数据错误"+textStatus);
                            }
                    });
                    return result;
            },

    /**
     * 描述 : 退出考试窗口
     * 作者 : Edgar.lee
     */
    'windowClose' : function (tip) {

        if( typeof tip === 'string' )
        {
            window.L.open('tip')(tip, false, false, true);
            window.L.open('oDialogDiv')(L.getText('提示'), 'text:' + L.sprintf(L.getText('窗口%s秒后自动跳转'), '<font color="red" style="font-weight: bold;"></font>'), '200', '100', [0, {
                'layoutFun' : function () {
                    if( !arguments.callee.countdown )
                    {
                        arguments.callee.showObj = $('.content', arguments[2].oDialogDivObj)
                            .css({'display' : 'block', 'text-align' : 'center', 'margin-top' : '15px'})
                            .find('font');
                        arguments.callee.countdown = 5;
                    }
                    arguments.callee.showObj.html(arguments.callee.countdown);
                    --arguments.callee.countdown && window.setTimeout(arguments.callee, 1000);      //倒计时
                }
            }]);

             if(startExamObj.getSettingParam()==='yes'){
                window.setTimeout(function(){window.location.href=window.ROOT_URL+"/user.php?a=logout"}, 5000);                   //用户退出跳转到登陆界面 或首页（用户状态为已退出）
             }else{
                window.setTimeout(function(){window.location.href=window.ROOT_URL+"/index.php"}, 5000);                  //用户退出跳转到首页 （用户状态仍在线）
            }

        } else {
            startExamObj.fullScreen(false);    //关闭全屏

            if(startExamObj.getSettingParam()==='yes'){
            window.location.href=window.ROOT_URL+"/user.php?a=logout"               ////用户退出跳转到登陆界面 ,或首页（用户状态为已退出）
         }else{
              window.location.href=window.ROOT_URL+"/index.php"
           }


            //window.close();
        }
    },

    /**
     * 描述 : 切换答题卡
     * 作者 : Edgar.lee
     */
    'switchAnswerCard' : function (index, thisObj) {
        $('#ddf-subtitle a').attr('class', 'ddf-subtitle_list');
        thisObj.className = 'ddf-subtitle_list_h';

        $('#ddf-tagContent > div').hide();
        if(top.location != self.location){
            $('#ddf-tagContent > div[q-index=' +index+ ']').show();
        }
        else{
            $('#ddf-tagContent > div[q-index=' +index+ ']').show().find('a:eq(0)').click();
        }
    },

    /**
     * 描述 : 跳转到小题
     * 作者 : Edgar.lee
     */
    'jumpQuestion' : function(index){
        var temp = ($('.exam_core_papers-question_number[number="' +index+ '"]').offset() || {'left' : 0, 'top' : 0}).top - $('#ddf-ansSheetChoosePop').height();
        window.document.body.scrollTop = temp;
        window.document.documentElement.scrollTop = temp;
        if(top.location != self.location){
            $('.scroll',window.parent.document).scrollTop(temp);
        }
    },

    /**
     * 描述 : 标记答题卡
     * 作者 : Edgar.lee
     */
    'markAnswerCard' : function(index, thisObj) {
        var temp = $('#ddf-tagContent a[smallQuestionNum="' +index+ '"]');

        if(temp.attr('class') !== 'ddf-ansSheet_num_sign')          //当前未标记
        {
            temp.attr('classBlockup', temp.attr('class'));          //备份样式
        }
        if( thisObj.className === 'label' )                         //添加标记
        {
            thisObj.className = 'labelsel';
            temp.attr('class', 'ddf-ansSheet_num_sign');
        } else {                                                    //取消标记
            thisObj.className = 'label';
            temp.attr('class', temp.attr('classBlockup'));          //还原样式
        }
    },

    /**
     * 描述 : 答题卡显隐切换
     * 作者 : Edgar.lee
     */
    'toggleAnswerCard' : function() {
        $('#answerCardBlock').toggle();
        $(window).resize();
    },

    /**
     * 描述 : 时间转时间戳
     * 作者 : Edgar.lee
     */
    'strtotime' : function (strings) {
        var _ = strings.split(' ');

        var str = _[0].split('-');
        var fix = _[1] ? _[1].split(':') : [0, 0, 0];

        var year  = str[0] - 0;
        var month = str[1] - 1;
        var day   = str[2] - 0;
        var hour   = fix[0] - 0;
        var minute = fix[1] - 0;
        var second = fix[2] - 0;

        time = (new Date(year, month, day, hour, minute, second)).getTime();
        return parseInt( time / 1000 );
    },

    /**
     * 描述 : 开启或关闭全屏
     * 作者 : Edgar.lee
     */
    'fullScreen' : function (isOpen){
        var ie = document.getElementById("ieFullScreen");

        if( isOpen )                                            //开启全屏
        {
            try{
                ie || (ie = $('<object id="ieFullScreen" width=1 height=1 classid="CLSID:68ACCE8B-F896-4091-BDC5-A93115A051DC">' +
                    '<param name="_version" value="65536">' +
                    '<param name="_extentx" value="164">' +
                    '<param name="_extenty" value="164">' +
                    '<param name="_stockprops" value="0">' +
                '</object>').appendTo(document.body).get(0));

                ie.IsOk();
            } catch(e) {
                startExamObj.windowClose(L.getText('需要在IE浏览器安装并启用全屏插件'));
                return false;
            }

            ie.SetFullScreen(1);                             //启动全屏
            return true;
        } else {
            ie && ie.SetFullScreen(0);
            ie && ie.QuitIE(); //  取消控制， 退出浏览器
            return true;
        }
    }
};

$(function() {
    $(".ddf-ansSheet").pin();                //使答题卡浮动

    var markQuestionAnswered = function(ele) {
        var wrapper = $(ele).parents('.exam_core_papers-question_mode'),
            markFlag = wrapper.find('div:last'),
            index = wrapper.find('span:first').attr('number');
        $('#ddf-tagContent a[smallQuestionNum="' +index+ '"]').addClass('ddf-ansSheet_num_wered');
        // markFlag.hasClass('labelsel') && markFlag.click();
    };
    var unmarkQuestionAnswered = function(ele) {
        var index = $(ele).parents('.exam_core_papers-question_mode').find('span:first').attr('number');
        $('#ddf-tagContent a[smallQuestionNum="' +index+ '"]').removeClass('ddf-ansSheet_num_wered');
    }
    // 单选多选
    $('body').on('click', 'input[type=checkbox], input[type=radio]', function(event) {
        markQuestionAnswered(this);
        event.stopPropagation();
    }).on('click', '#examCorePapersRootBlock ul>span',function(){
        $(this).find('input').click();
    })
    // 填空，简答
    .on('blur', 'input[type=text], input[type=input], div[contenteditable]', function(event) {
        var filled = true;
        $(this).parents('.exam_core_papers-question_mode')
        .find('input, textarea').each(function() {
            var val = $.trim($(this).val());
            if (this.tagName == "TEXTAREA") {
                val = $.trim($(".nicEdit-selected").text());
                val = val.replace(/<br>/g, '').replace(/&nbsp;/g, '').replace(/ /g, '').replace(/<p><\/p>/g, '');
            }
            if (val == '') {
                filled = false;
            }
        });
        if (filled) {
            markQuestionAnswered(this);
        } else {
            unmarkQuestionAnswered(this);
        }
    });

    $('.test-ansSheetBtn').click(function(){
        $(this).children('b').toggleClass( 'upOrDown');
    });


    // 解析试题内多媒体， 添加禁用进度条，循环次数等
    examCoreQuestionsObj.parseMediaPlayer();
});


/**
 * 描述 : 浮动样式脚本
 * 作者 : Edgar.lee
 */
$.fn.smartFloat = function() {
    var position = function(element) {
        var top = element.position().top;
        $(window).scroll(function() {
            var scrolls = $(this).scrollTop();
            if (scrolls -top > element.outerHeight()) {
                if (window.XMLHttpRequest) {
                    element.css({
                        position: "fixed",
                        top: 0
                    });
                } else {
                    element.css({
                        position: "absolute",
                        top: scrolls
                    });
                }
            }else {
                element.css({
                    position: "static",
                    top: 0
                });
            }
        });
    };
    return $(this).each(function() {
        position($(this));
    });
};

if ($.browser.msie){
    $(document).keydown(function(e) { if (e.keyCode == 8) window.event.keyCode = 0;});
}
$(document).unbind('keydown').bind('keydown', function (event) {
    var doPrevent = false;
    if (event.keyCode === 8) {
        var d = event.srcElement || event.target;
        if ((d.tagName.toUpperCase() === 'INPUT' &&
             (
                 d.type.toUpperCase() === 'TEXT' ||
                 d.type.toUpperCase() === 'PASSWORD' ||
                 d.type.toUpperCase() === 'FILE' ||
                 d.type.toUpperCase() === 'EMAIL' ||
                 d.type.toUpperCase() === 'SEARCH' ||
                 d.type.toUpperCase() === 'DATE' )
             ) ||
             d.tagName.toUpperCase() === 'TEXTAREA'||
             (d.tagName.toUpperCase() === 'DIV' && d.getAttribute('contenteditable'))) {
            doPrevent = d.readOnly || d.disabled;
        }
        else {
            doPrevent = true;
        }
    }

    if (doPrevent) {
        event.preventDefault();
    }
});
