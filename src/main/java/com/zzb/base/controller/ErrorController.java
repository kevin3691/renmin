package com.zzb.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ErrorController {

	/**
	 * error 通用错误页
	 * 
	 * @See 通用错误页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/error")
	public String error() {
		return "/error/error";
	}

	/**
	 * 显示未授权错误信息 auth=authorization
	 * 
	 * @return
	 */
	@RequestMapping(value = "/unauth")
	public String eunauth() {
		return "/error/unauth";
	}

	/**
	 * csrf 跨域请求拦截
	 * 
	 * @See 通用错误页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/csrf")
	public String csrf() {
		return "/error/csrf";
	}

	/**
	 * 400 Bad Request 请求出现语法错误
	 * 
	 * @See 一种常见的情况是form提交页面自动装填实体属时出现的格式问题
	 * 
	 * @return
	 */
	@RequestMapping(value = "/400")
	public String e400() {
		return "/error/400";
	}

	/**
	 * 403 Forbidden 资源不可用
	 * 
	 * @See 服务器理解客户的请求，但拒绝处理它。通常由于服务器上文件或目录的权限设置导致
	 * 
	 * @return
	 */
	@RequestMapping(value = "/403")
	public String e403() {
		return "/error/403";
	}

	/**
	 * 404 Not Found 无法找到指定位置的资源
	 * 
	 * @return
	 */
	@RequestMapping(value = "/404")
	public String e404() {
		return "/error/404";
	}

	/**
	 * 500 Internal Server Error 服务器遇到了意料不到的情况，不能完成客户的请求。
	 * 
	 * @return
	 */
	@RequestMapping(value = "/500")
	public String e500() {
		return "/error/500";
	}

	/**
	 * 显示未授权错误信息 auz=authorization
	 * 
	 * @return
	 */
	@RequestMapping(value = "/intercept")
	public String intercept() {
		return "/error/intercept";
	}

}
