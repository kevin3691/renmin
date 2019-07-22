package com.zzb.cms.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.cms.dao.SurveyTopicsDao;
import com.zzb.cms.entity.SurveyTopics;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.utils.DateUtils;

/**
 * 
 * @author
 *
 */
@Transactional
@Service("surveyTopicsService")
public class SurveyTopicsService extends BaseService<SurveyTopics> {
	@Resource
	private SurveyTopicsDao surveyTopicsDao;
	@Resource
	private SurveyItemsService surveyItemsService;
	@Resource
	private AnswerManService answerManService;

	public QueryResult<SurveyTopics> list(HttpServletRequest request) {
		
		String topicTitle = request.getParameter("topicTitle") != null ? request
				.getParameter("topicTitle") : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM SurveyTopics WHERE 1=1";
		if (!topicTitle.equals("")) {
			hql += " AND topicTitle like ?";
			args.add('%' + topicTitle + '%');
		}
		qp.setHql(hql);
		qp.setArgs(args);
		return surveyTopicsDao.list(qp);
	}

	public SurveyTopics save(SurveyTopics log, HttpServletRequest request) {
		log.setRecordInfo(super.GenRecordInfo(log.getRecordInfo(), request));
		log = surveyTopicsDao.save(log);
		return log;
	}

	public SurveyTopics dtl(int id) {
		SurveyTopics log = surveyTopicsDao.dtl(id);
		return log;
	}

	public void del(int id) {
		surveyTopicsDao.del(id);
		//删除对应调查项的内容
		surveyItemsService.delByTopicId(id);
		//删除对应的答案内容
		answerManService.delByTopicId(id);
	}

	public void sort(int id, String order) {
		surveyTopicsDao.sort(id, order);
	}

}
