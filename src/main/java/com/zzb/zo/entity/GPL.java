package com.zzb.zo.entity;

import javax.persistence.Embeddable;
import java.util.List;

@Embeddable
public class GPL {
	private List<GPList> plans;

	public List<GPList> getPlans() {
		return plans;
	}

	public void setPlans(List<GPList> plans) {
		this.plans = plans;
	}
}
