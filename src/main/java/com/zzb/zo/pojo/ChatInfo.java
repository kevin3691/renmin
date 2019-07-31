package com.zzb.zo.pojo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ChatInfo {
    /**
     * 响应码
     */
    private Integer code;

    /**
     * 响应消息
     */
    private String msg;
    /**
     * 数据集合：接收mine（我的信息），friend（好友的信息）
     */
    private Map data = new HashMap();

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map getData() {
        return data;
    }

    public void setData(Map data) {
        this.data = data;
    }
}

