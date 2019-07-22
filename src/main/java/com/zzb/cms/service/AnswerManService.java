package com.zzb.cms.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.zzb.cms.dao.AnswerManDao;
import com.zzb.cms.entity.AnswerMan;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;

/**
 * @author
 *
 */
@Transactional
@Service("AnswerManService")
public class AnswerManService extends BaseService<AnswerMan> {
	@Resource
	private AnswerManDao answerManDao;

	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<AnswerMan> list(HttpServletRequest request) {
		int itemId = request.getParameter("itemId") != null
				&& !request.getParameter("itemId").equals("") ? Integer
				.valueOf(request.getParameter("itemId")) : 0;
		String answerCont = request.getParameter("answerCont") != null ? request
				.getParameter("answerCont") : "";

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM AnswerMan WHERE 1=1";
		if (itemId > 0) {
			hql += " AND itemId = ?";
			args.add(itemId);
		}
		if (!answerCont.equals("")) {
			hql += " AND answerCont LIKE ?";
			args.add('%' + answerCont + '%');
		}
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<AnswerMan> qr = answerManDao.list(qp);
		return qr;
	}

	public AnswerMan save(AnswerMan person, HttpServletRequest request) {
		// 自动完成RecordInfo数据设置
		person.setRecordInfo(super.GenRecordInfo(person.getRecordInfo(),
				request));
		person = answerManDao.save(person);

		return person;
	}

	public AnswerMan dtl(int id) {
		AnswerMan person = answerManDao.dtl(id);
		return person;
	}

	public void del(int id) {
		answerManDao.del(id);
	}
	/**
	 * 根据调查主题的id删除对应的答案
	 * @param topicId
	 */
	public void delByTopicId(int topicId) {
		String hql = "delete from AnswerMan where topicId = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(topicId);
		answerManDao.executeUpdate(hql, args);
	}
	/**
	 * 根据调查项的id删除对应的答案
	 * @param topicId
	 */
	public void delByItemId(int itemId) {
		String hql = "delete from AnswerMan where itemId = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(itemId);
		answerManDao.executeUpdate(hql, args);
	}
}
