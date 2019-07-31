package com.zzb.zo.pojo;

import java.util.List;

public class FriendInfo {
    //群名
    private String groupname;
    //群id
    private Integer id;
    //list集合接收多个群
    private List<EmpInfo> list;

    public String getGroupname() {
        return groupname;
    }

    public void setGroupname(String groupname) {
        this.groupname = groupname;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public List<EmpInfo> getList() {
        return list;
    }

    public void setList(List<EmpInfo> list) {
        this.list = list;
    }
}
