/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.controller;

import com.zzb.base.entity.BaseOrg;
import com.zzb.base.entity.BaseUser;
import com.zzb.base.service.BaseOrgService;
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
import com.zzb.zo.pojo.ChatInfo;
import com.zzb.zo.pojo.EmpInfo;
import com.zzb.zo.pojo.FriendInfo;
import com.zzb.zo.service.*;
import org.apache.shiro.SecurityUtils;
import org.kohsuke.rngom.parse.host.Base;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
	@Resource
	private BaseUserService baseUserService;
	@Resource
	private BaseOrgService baseOrgService;

	@RequestMapping(value = "/index")
	public String index(HttpServletRequest request, Model model) {
		QueryResult<Chat> rslt = chatService.list(request);
		int sendToId = request.getParameter("id") != null
				&& !request.getParameter("id").equals("") ? Integer
				.valueOf(request.getParameter("id")) : -1;
		BaseUser user =	(BaseUser) request.getSession().getAttribute("baseUser");
		int sendDoId = user.getId();
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
									String sendTime,
									HttpServletRequest request) {
		DateFormat timeFormat = new SimpleDateFormat("yyMMddHHmm");
		Date date = new Date();
		try {
			date = timeFormat.parse(sendTime);
		}catch (ParseException e) {
			e.printStackTrace();
		}
		chat.setSendTime(date);
		Map<String, Object> map = new HashMap<String, Object>();
		chat = chatService.save(chat);

		map.put("entity", chat);
		//map.put("ins", ins);
		return map;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 *
	 * @param
	 * @param
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/upState", method = RequestMethod.POST)
	public String  save(Chat chat) {

		chatService.upState(chat);
		//map.put("ins", ins);
		return "upState";
	}
	@ResponseBody
	@RequestMapping(value = "/chatInfoList")
	public ChatInfo ChatInfoList(HttpServletRequest request){
		List<ChatInfo> list = new ArrayList<>();

		List<FriendInfo> friendInfos = friendsGet(request);//好友
		BaseUser mineUser = (BaseUser)request.getSession().getAttribute("baseUser");

		EmpInfo mine = mineGet(mineUser);

		ChatInfo chatInfo = new ChatInfo();
		chatInfo.setCode(0);
		chatInfo.setMsg("ok");
		Map map = chatInfo.getData();
		map.put("mine", mine);
		map.put("friend", friendInfos);
		map.put("group", list);
		return chatInfo;
	}

	public EmpInfo mineGet(BaseUser baseUser){
		EmpInfo empInfo = new EmpInfo();
		empInfo.setUsername(baseUser.getBasePersonName());
		empInfo.setId(baseUser.getId());
		if(baseUser.getOnLineState()==1){
			empInfo.setStatus("online");//在线状态
		}else{
			empInfo.setStatus("offline");//离线线状态
		}
		empInfo.setSign(" ");//签名
		empInfo.setAvatar("images/a.jpg");//头像
		return empInfo;
	}
	public List<FriendInfo> friendsGet (HttpServletRequest request){
		List<FriendInfo> fList = new ArrayList<>();
		List<BaseOrg> orgList =  baseOrgService.listAll(request).getRows();//好友列表
		List<BaseUser> baseUser = baseUserService.listOrder(request).getRows();
		for(BaseOrg o : orgList){
			FriendInfo friendInfo = new FriendInfo();
			friendInfo.setGroupname(o.getName());
			friendInfo.setId(o.getId());
			friendInfo.setList(mineListGet(baseUser,o.getId()));
			fList.add(friendInfo);
		}
		return fList;
	}
	public List<EmpInfo> mineListGet(List<BaseUser> userList,int oId){
		List<EmpInfo> empInfoList = new ArrayList<>();
		for(BaseUser u : userList){
			if(u.getBaseOrgId() == oId){
				EmpInfo e = mineGet(u);
				empInfoList.add(e);
			}
		}
		return empInfoList;
	}

}
