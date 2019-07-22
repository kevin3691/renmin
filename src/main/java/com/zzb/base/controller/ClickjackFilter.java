/**
 *  Software published by the Open Web Application Security Project (http://www.owasp.org)
 *  This software is licensed under the new BSD license.
 *
 * @author     Jeff Williams <a href="http://www.aspectsecurity.com">Aspect Security</a>
 * @created    February 6, 2009
 */

package com.zzb.base.controller;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class ClickjackFilter implements Filter 
{

	private String mode = "DENY";
	
	/**
	 * Add X-FRAME-OPTIONS response header to tell IE8 (and any other browsers who
	 * decide to implement) not to display this content in a frame. For details, please
	 * refer to http://blogs.msdn.com/sdl/archive/2009/02/05/clickjacking-defense-in-ie8.aspx.
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{
		System.out.println("$$$$$$$$$$$$$$$$$$$$#223doFilter:"+mode);
        HttpServletResponse res = (HttpServletResponse)response;
        chain.doFilter(request, response);
        res.addHeader("X-FRAME-OPTIONS", mode );
        res.setHeader("X-FRAME-OPTIONS",mode);
        res.addHeader("Content-Type","text/html");
        res.addHeader("X-Content-Type-Options", "nosniff");
	}

	public void destroy() {
		System.out.println("$$$$$$$$$$$$$$$$$$$$#destroy");
	}

	public void init(FilterConfig filterConfig) {
		System.out.println("$$$$$$$$$$$$$$$$$$$$#init");
		String configMode = filterConfig.getInitParameter("mode");
		if ( configMode != null ) {
			mode = configMode;
		}
	}
	
}
