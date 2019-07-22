package com.zzb.comm.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zzb.comm.entity.CommNoti;
import com.zzb.comm.service.CommNotiService;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/comm/noti")
public class CommNotiController {
	// 构造方法
	public CommNotiController() {

	}

	@Resource
	private CommNotiService commNotiService;

	/**
	 * 获取列表数据 list
	 * 
	 * @param
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<CommNoti> list(HttpServletRequest request) {
		QueryResult<CommNoti> rslt = commNotiService.list(request);
		return rslt;
	}

	/**
	 * 保存数据（添加、编辑）方法
	 * 
	 * @param
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(CommNoti noti, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		noti = commNotiService.save(noti, request);
		map.put("entity", noti);
		return map;
	}

	/**
	 * saveStts 改状态
	 * 
	 * @param
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/saveStts", method = RequestMethod.POST)
	public Map<String, Object> saveStts(CommNoti noti,
			HttpServletRequest request) {
		noti = commNotiService.saveStts(noti, request);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("entity", noti);
		return map;
	}

	/**
	 * 删除数据 假删除
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delby", method = RequestMethod.POST)
	public Map<String, Object> delby(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("IsSuccess", true);
		CommNoti noti = new CommNoti();
		commNotiService.delBy(noti, request);
		return map;
	}

	/**
	 * 删除数据
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/del", method = RequestMethod.POST)
	public Map<String, Object> del(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		map.put("IsSuccess", true);
		commNotiService.del(id);
		return map;
	}

}
