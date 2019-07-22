package com.zzb.cms.entity;

import javax.persistence.Entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

/**
 * 答案
 * @author
 *
 */
@Entity
public class AnswerMan extends BaseEntity<AnswerMan>{

	private String answerCont; //答案内容
	private int itemId; //调查项id
	private String itemTitle; //调查项标题
	private int topicId; //调查主题id（方便后续删除）
	private String descr;
	
	private RecordInfo recordInfo;

	public String getAnswerCont() {
		return answerCont;
	}

	public void setAnswerCont(String answerCont) {
		this.answerCont = answerCont;
	}

	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getItemTitle() {
		return itemTitle;
	}

	public void setItemTitle(String itemTitle) {
		this.itemTitle = itemTitle;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}

	public int getTopicId() {
		return topicId;
	}

	public void setTopicId(int topicId) {
		this.topicId = topicId;
	}
	
	
}
