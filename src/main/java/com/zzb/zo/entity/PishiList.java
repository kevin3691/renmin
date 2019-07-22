package com.zzb.zo.entity;

import java.util.List;

import javax.persistence.Embeddable;

@Embeddable
public class PishiList {
	private List<Pishi> pishiList;

	public List<Pishi> getPishiList() {
		return pishiList;
	}

	public void setPishiList(List<Pishi> pishiList) {
		this.pishiList = pishiList;
	}
	
}
