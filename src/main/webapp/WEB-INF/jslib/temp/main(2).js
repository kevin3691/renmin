examCoreQuestionsObj.comList.select = {
    /**
     * 描述 : 创建组件并初始化
     * 作者 : Edgar.lee
     */
    'create' : function(params, system) {
        var temp;
        params = $.extend({'multiple' : false, 'value' : {}, 'options' : {}, 'size' : 1}, params);                          //参数初始化

        this.comObj = $('<select size="' + params.size + '" ' + (params.multiple ? '"multiple"' : '') + ' name="examComponentsInput_' + system.key + '_' + system.questionId + '" ></select>').get(0);
        this.appendChild(this.comObj);

        temp = ['', false];                                                                                                 //初始化选项
        $.each(params.options, function (key) {
            if( $.type(this) === 'string' )
            {
                temp[0] += '<option value="' +key+ '" ' +($.inArray(key, params.value) > -1 ? 'selected' : '')+ '>' +window.L.entity(this,true)+ '</option>';
            } else {
                temp[1] && (temp[0] += '</optgroup>');
                temp[0] += '<optgroup label="' +key+ '">';
                temp[1] = true;
            }
        });
        temp[1] && (temp[0] += '</optgroup>');
        $(temp[0]).appendTo(this.comObj);

        if( system.isEdit && system.type === 'form' )                                                                       //未完成
        {
            //this.comObj.size = 5;
            //$(this.comObj).bind('mousedown click', examCoreQuestionsObj.comList.input.radioChecked);
        }
    },

    /**
     * 描述 : 将组件数据同步到内存中
     * 作者 : Edgar.lee
     */
    'update' : function(params, system) {
        var comObj = $(this.comObj);

        params.value = $(this.comObj).val();
        typeof params.value === 'string' && (params.value = [params.value]);

        params.options = {};
        comObj.children('*').each(function () {
            if( this.tagName === 'OPTGROUP' )
            {
                params.options[this.getAttribute('lable')] = null;
            } else {
                params.options[this.getAttribute('value')] = this.innerHTML;
            }
        });
    }
};