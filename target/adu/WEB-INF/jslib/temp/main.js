examCoreQuestionsObj.comList.richtext = {
    /**
     * 描述 : 创建组件并初始化
     * 作者 : Edgar.lee
     */
    'create' : function(params, system) {
        params = $.extend({'value' : '', 'readonly' : false}, params);                                                          //参数初始化

        if( system.isEdit && !params.readonly || system.type === 'form' && system.isEdit !== null )
        {
            if (typeof params.value != 'string') {
                 params.value = '';
            }
            this.comObj = $('<textarea style="width:100%;width:860px\\9;">' +params.value+ '</textarea>').get(0);
            this.comObj.innerText = params.value;
            this.appendChild(this.comObj);
            if( window.L.open('oEditor') )
            {
                this.richtextObj = new oEditor({
                    buttonList : ['bold','italic','underline','left','center','right','justify','ol','ul','fontSize','fontFamily','fontFormat','indent','outdent','upload','forecolor','bgcolor','table','subscript','superscript','strikethrough','removeformat','hr','xhtml'],
                    CustomConfig : {
                        oFileManager: {                                         //oFileManager配置文件
                            quickUploadDir:{                                    //各类型的文件快速上传路径
                                img        : '/pictures/..quickUpload',         //图片快速上传文件夹
                                media      : '/media/..quickUpload',            //媒体快速上传文件夹
                                attachment : '/attachment/..quickUpload'        //媒体快速上传文件夹
                            },
                            browseDir:{                                         //各类型文件预览文件夹
                                img        : '/pictures',                       //图片预览文件夹
                                media      : '/media',                          //媒体预览文件夹
                                attachment : '/attachment'                      //附件上传文件夹
                            }
                        }
                    }
                }).panelInstance(this.comObj);

                $('.nicEdit-main', this).bind('blur focus', {'thisObj' : this}, examCoreQuestionsObj.comList.richtext.blurOrFocus);
            }
        } else {
            this.comObj = this;
            this.innerHTML = params.value.replace(/\s(?![^<]*>)/g,'&nbsp;');
        }
    },

    /**
     * 描述 : 将组件数据同步到内存中
     * 作者 : Edgar.lee
     */
    'update' : function(params, system) {
        params.value = window.L.entity(this.comObj.innerHTML,false);
    },

    /**
     * 描述 : 读取联动数据
     * 参数 :
     *      type   : undefined(默认)=读取全部, true=添加联动, false=删除联动, 对象=展示联动
     *      unique : 字符串=添加一个,
     * 作者 : Edgar.lee
     */
    'linkage' : function (type, unique) {
        var temp, result = [];

        if( type === true )                                                                 //添加联动(编辑)
        {
            temp = $('.nicEdit-main', this).focus();
            this.richtextObj.nicInstances[0].nicCommand('insertImage', 'http://');
            temp.find('img[src="http://"]')
                .after('<input type="button" value="' +unique+ '" linkageBlock="' +unique+ '" disabled>')
                .remove();
            $('<input type="button" value="' +unique+ '" linkageBlock="' +unique+ '" disabled>');
        } else if( type === false ) {                                                       //删除联动(编辑)
            $('.nicEdit-main input[linkageBlock="' +unique+ '"]', this).remove();
        } else if( $.type(type) === 'object' ) {                                           //替换联动(展示)
            $((this.richtextObj ? '.nicEdit-main ' : '') + 'input[linkageBlock="' +unique+ '"]', this)
                .after(type).remove();
        } else {                                                                            //读取联动数据(编辑暂时)
            $((this.richtextObj ? '.nicEdit-main ' : '') + 'input[linkageBlock]', this).each(function(){
                temp = this.getAttribute('linkageBlock');
                result[temp] ? $(this).remove() : result.push(temp);
            });
        }

        return result;
    },

    /**
     * 描述 : 富文本焦点事件
     * 作者 : Edgar.lee
     */
    'blurOrFocus' : function (event) {
        examCoreQuestionsObj.event('questions::linkage::' + (event.type === 'focus' ? 'start' : 'sync'), event.data.thisObj);
    }
};
