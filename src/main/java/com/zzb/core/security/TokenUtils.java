
package com.zzb.core.security;

import javax.servlet.http.HttpServletRequest;

public class TokenUtils {
	/**
	 * 验证OWASP TOKEN owasp 配置为自动验证POST,此方法一般为手动验证登录页页面之类GET请求
	 * 
	 * @param request
	 * @return
	 */
	public static boolean validateToken(HttpServletRequest request) {
		String token = request.getParameter("OWASP_CSRFTOKEN");
		String stoken = request.getSession().getAttribute("OWASP_CSRFTOKEN") != null ? request
				.getSession().getAttribute("OWASP_CSRFTOKEN").toString()
				: "";
		System.out.println("###########:token:" + token);
		System.out.println("###########:stoken:" + stoken);
		if (token != null && token.equals(stoken)) {
			return true;
		}
		return false;
	}
}
