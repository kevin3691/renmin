/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.cms.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.cms.dao.SurveyItemsDao;
import com.zzb.cms.entity.SurveyItems;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

/**
 * @author
 *
 */
@Transactional
@Service("surveyItemsService")
public class SurveyItemsService extends BaseService<SurveyItems> {
	@Resource
	private SurveyItemsDao surveyItemsDao;
	@Resource
	private AnswerManService answerManService;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<SurveyItems> list(HttpServletRequest request) {
		int topicId = request.getParameter("topicId") != null
				&& !request.getParameter("topicId").equals("") ? Integer
				.valueOf(request.getParameter("topicId")) : 0;
		String itemTitle = request.getParameter("itemTitle") != null ? request
				.getParameter("itemTitle") : "";

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM SurveyItems WHERE 1=1";
		if (topicId > 0) {
			hql += " AND topicId = ?";
			args.add(topicId);
		}
		if (!itemTitle.equals("")) {
			hql += " AND itemTitle LIKE ?";
			args.add('%' + itemTitle + '%');
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<SurveyItems> qr = surveyItemsDao.list(qp);
		return qr;
	}

	public SurveyItems save(SurveyItems person, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		person.setRecordInfo(super.GenRecordInfo(person.getRecordInfo(),
				request));
		person = surveyItemsDao.save(person);

		return person;
	}

	public SurveyItems dtl(int id) {
		SurveyItems person = surveyItemsDao.dtl(id);
		return person;
	}

	public void del(int id) {
		surveyItemsDao.del(id);
		//删除对应的答案内容
		answerManService.delByItemId(id);
	}
	/**
	 * 根据调查主题的id删除对应的调查项
	 * @param topicId
	 */
	public void delByTopicId(int topicId) {
		String hql = "delete from SurveyItems where topicId = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(topicId);
		surveyItemsDao.executeUpdate(hql, args);
	}
}
