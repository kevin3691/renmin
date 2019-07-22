package com.zzb.core.security;

import java.io.IOException;  
import javax.servlet.Filter;  
import javax.servlet.FilterChain;  
import javax.servlet.FilterConfig;  
import javax.servlet.ServletException;  
import javax.servlet.ServletRequest;  
import javax.servlet.ServletResponse;  
import javax.servlet.http.HttpServletRequest;  

/**
 * 安全工具类 XssFilter 过滤Xss字符
 * 
 */
public class XssSqlFilter implements Filter {
	@SuppressWarnings("unused")    
	private FilterConfig filterConfig;    
	public void destroy() {    
	    this.filterConfig = null;    
	}    
	public void doFilter(ServletRequest request, ServletResponse response,    
	        FilterChain chain) throws IOException, ServletException {
		HttpServletRequest r = (HttpServletRequest) request;
		String text = r.getHeader("referer");
		String sname = request.getServerName();
		System.out.println("###################:"+text);
		if(text!=null&&text.indexOf(sname)==-1){
			return;
		}
	    chain.doFilter(new RequestWrapper((HttpServletRequest) request), response);    
	}    
	public void init(FilterConfig filterConfig) throws ServletException {    
	    this.filterConfig = filterConfig;    
	}       
}
