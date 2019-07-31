/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.service;

import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.dao.WfInstanceDao;
import com.zzb.zo.dao.ChatDao;
import com.zzb.zo.entity.Chat;
import com.zzb.zo.entity.DuBan;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 组织机构 Service
 * 
 * 
 * @createdAt 2016年1月29日
 */

@Transactional
@Service("chatService")
public class ChatService extends BaseService<DuBan> {
	@Resource
	private ChatDao chatDao;


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<Chat> list(HttpServletRequest request) {
		int sendDoId = request.getParameter("sendDoId") != null
				&& !request.getParameter("sendDoId").equals("") ? Integer
				.valueOf(request.getParameter("sendDoId")) : -1;
		int sendToId = request.getParameter("sendToId") != null
				&& !request.getParameter("sendToId").equals("") ? Integer
				.valueOf(request.getParameter("sendToId")) : -1;
		int state = request.getParameter("state") != null
				&& !request.getParameter("state").equals("") ? Integer
				.valueOf(request.getParameter("state")) : -1;
		String sendTime =  request.getParameter("sendTime") != null ? request
				.getParameter("sendTime") : "";
		String content =  request.getParameter("content") != null ? request
				.getParameter("content") : "";

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM Chat WHERE 1=1";

		if (sendDoId>0) {
			hql += " AND sendDoId in (?,?) ";
			args.add(sendDoId);
			args.add(sendToId);
		}
		if (sendToId>0) {
			hql += " AND sendToId in (?,?)";
			args.add(sendToId);
			args.add(sendDoId);
		}
		if (state>=0) {
			hql += " AND state = ?";
			args.add(state);
		}
		if (!content.equals("")) {
			hql += " AND content like ?";
			args.add("%"+content+"%");
		}
		if (!sendTime.equals("")) {
			hql += " AND date_format(sendTime,'%Y-%m-%d') = ?";
			args.add(sendTime);
		}
		qp.setArgs(args);
		qp.setHql(hql);
		qp.setOrderBy("sendTime");
		QueryResult<Chat> qr = chatDao.list(qp);
		return qr;
	}



	public Chat save(Chat chat) {
		chat = chatDao.save(chat);
		return chat;
	}

	public void upState(Chat chat){
		String sql = "update Chat set state = 1 where sendToId = ? and sendDoId = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(chat.getSendToId());
		args.add(chat.getSendDoId());
		chatDao.executeUpdate(sql,args);
	}
}
