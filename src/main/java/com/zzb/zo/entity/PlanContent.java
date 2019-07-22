package com.zzb.zo.entity;

import javax.persistence.Embeddable;
import java.util.Date;

@Embeddable
public class PlanContent {
	private String content;
	private String content2;
	private Date day;
	private int refNum;

	public String getContent() {
		return content;
	}

	public String getContent2() {
		return content2;
	}

	public void setContent2(String content2) {
		this.content2 = content2;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDay() {
		return day;
	}

	public void setDay(Date day) {
		this.day = day;
	}

	public int getRefNum() {
		return refNum;
	}

	public void setRefNum(int refNum) {
		this.refNum = refNum;
	}
}
