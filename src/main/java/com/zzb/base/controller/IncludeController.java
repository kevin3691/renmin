package com.zzb.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/include")
public class IncludeController {

	/**
	 * View head 后台通用头部
	 * 
	 * @return
	 */
	@RequestMapping(value = "/head")
	public String head() {
		return "/WEB-INF/views/include/head.jsp";
	}

	/**
	 * View head 简单头部 只加载最基础的js css
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simplehead")
	public String simple_head() {
		return "/WEB-INF/views/include/simplehead.jsp";
	}

	/**
	 * View lte_head AdminLTE后台的头部代码 js,css等
	 * 
	 * @return
	 */
	@RequestMapping(value = "/ltehead")
	public String lte_head() {
		return "/WEB-INF/views/include/ltehead.jsp";
	}
}
