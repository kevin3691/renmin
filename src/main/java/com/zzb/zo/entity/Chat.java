package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;
import java.util.Date;
@Entity
public class Chat extends BaseEntity<Chat> {

    private int sendDoId;//发送ID
    private String sendDoName;
    private String sendDoPrName;
    private int sendToId;//接收ID
    private String sendToName;
    private String sendToPrName;
    private String content;//发送的信息内容
    private Date sendTime;//时间

    public int getSendDoId() {
        return sendDoId;
    }

    public void setSendDoId(int sendDoId) {
        this.sendDoId = sendDoId;
    }

    public String getSendDoName() {
        return sendDoName;
    }

    public void setSendDoName(String sendDoName) {
        this.sendDoName = sendDoName;
    }

    public String getSendDoPrName() {
        return sendDoPrName;
    }

    public void setSendDoPrName(String sendDoPrName) {
        this.sendDoPrName = sendDoPrName;
    }

    public int getSendToId() {
        return sendToId;
    }

    public void setSendToId(int sendToId) {
        this.sendToId = sendToId;
    }

    public String getSendToName() {
        return sendToName;
    }

    public void setSendToName(String sendToName) {
        this.sendToName = sendToName;
    }

    public String getSendToPrName() {
        return sendToPrName;
    }

    public void setSendToPrName(String sendToPrName) {
        this.sendToPrName = sendToPrName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }
}
