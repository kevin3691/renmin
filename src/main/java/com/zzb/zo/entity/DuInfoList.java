package com.zzb.zo.entity;

import java.util.List;

import javax.persistence.Embeddable;

import com.zzb.workflow.entity.WfInstance;

@Embeddable
public class DuInfoList {
	private List<WfInstance> infoList;

	private WfInstance orgInfo;

	public List<WfInstance> getInfoList() {
		return infoList;
	}

	public void setInfoList(List<WfInstance> infoList) {
		this.infoList = infoList;
	}

	public WfInstance getOrgInfo() {
		return orgInfo;
	}

	public void setOrgInfo(WfInstance orgInfo) {
		this.orgInfo = orgInfo;
	}
	
}
