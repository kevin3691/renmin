package com.zzb.zo.entity;

import javax.persistence.Embeddable;
import java.util.List;

@Embeddable
public class PlanList {
	private List<PlanContent> planList;

	public List<PlanContent> getPlanList() {
		return planList;
	}

	public void setPlanList(List<PlanContent> planList) {
		this.planList = planList;
	}
}
