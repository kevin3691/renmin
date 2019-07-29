/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseUserService;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.workflow.entity.WfWorkflow;
import com.zzb.workflow.service.WfInstanceService;
import com.zzb.workflow.service.WfStepService;
import com.zzb.workflow.service.WfWorkflowService;
import com.zzb.zo.entity.*;
import com.zzb.zo.service.*;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 人员 Controller
 * 
 * @author 
 * @createdAt 2016-01-26
 */
@Controller
@RequestMapping("/chat")
public class ChatController extends BaseController {
	@Resource
	private ChatService chatService;


	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, Model model) {
		QueryResult<Chat> rslt = chatService.list(request);
		int sendDoId = request.getParameter("sendDoId") != null
				&& !request.getParameter("sendDoId").equals("") ? Integer
				.valueOf(request.getParameter("sendDoId")) : -1;
		int sendToId = request.getParameter("sendToId") != null
				&& !request.getParameter("sendToId").equals("") ? Integer
				.valueOf(request.getParameter("sendToId")) : -1;
		model.addAttribute("sendDoId",sendDoId);
		model.addAttribute("sendToId",sendToId);
		return "/base/user/chat";
	}
	/**
	 * 获取列表数据 list
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<Chat> list(HttpServletRequest request) {
		QueryResult<Chat> rslt = chatService.list(request);

		return rslt;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(Chat chat,
									HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		chat = chatService.save(chat);

		map.put("entity", chat);
		//map.put("ins", ins);
		return map;
	}

}
