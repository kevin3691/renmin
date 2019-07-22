package com.zzb.core.security;

import java.util.Iterator;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.owasp.validator.html.AntiSamy;
import org.owasp.validator.html.CleanResults;
import org.owasp.validator.html.Policy;
import org.owasp.validator.html.PolicyException;
import org.owasp.validator.html.ScanException;

/**
 * 安全工具类 RequestWrapper 过滤Xss字符
 * 
 */
public class RequestWrapper extends HttpServletRequestWrapper {
	public RequestWrapper(HttpServletRequest request) {
		super(request);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String, String[]> getParameterMap() {
		//System.out.println("#############getParameterMap:");
		Map<String, String[]> request_map = super.getParameterMap();
		Iterator iterator = request_map.entrySet().iterator();
		while (iterator.hasNext()) {
			Map.Entry me = (Map.Entry) iterator.next();
			//System.out.println("RequestWrapper getParameterMap key:" +me.getKey()+":");
			String[] values = (String[]) me.getValue();
			for (int i = 0; i < values.length; i++) {
				//System.out.println("RequestWrapper getParameterMap values:" + values[i]);
				values[i] = FilterUtils.xssClean(values[i]);
				values[i] = FilterUtils.sqlClean(values[i]);
			}
		}
		return request_map;
	}

	public String getParameter(String name) {
		//System.out.println("#############getParameter:");
		String text = super.getParameter(name);
		if (text == null)
			return null;
		text = FilterUtils.xssClean(text);
		text = FilterUtils.sqlClean(text);
		//System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$getParameter:" + text);
		return text;
	}

	public String[] getParameterValues(String name) {
		//System.out.println("#############getParameterValues:");
		String[] text = super.getParameterValues(name);
		if (text == null || text.length == 0)
			return text;
		for (int i = 0; i < text.length; i++) {
			text[i] = FilterUtils.xssClean(text[i]);
			text[i] = FilterUtils.sqlClean(text[i]);
			//System.out.println("RequestWrapper getParameterValues values:"+ text[i]);
		}
		return text;
	}

	public String getHeader(String name) {
		//System.out.println("#############getHeader:"+name);
		String text = super.getHeader(name);
		//System.out.println("#############getHeader text:"+text);
		if (text == null)
			return null;
		//if(name.equals("referer"))
		//{
		//	text = clearReferer(text);
		//}
		text = FilterUtils.xssClean(text);
		text = FilterUtils.sqlClean(text);
		//System.out.println("#############getHeader text:"+text);
		return text;
	}
	
	public String clearReferer(String text)
	{
		if(text.indexOf("(")>=0||text.indexOf("{")>=0||text.indexOf("echo")>=0||text.indexOf("NS")>=0||text.indexOf("bin/sh")>=0){
			text = "";
		}
		return text;
	}

	/**
	 * 清除XSS字符，未找到此文件下载地址，暂用自写的方法
	 * 
	 * @param value
	 * @return
	 * 
	 *         private String xssClean(String value) { AntiSamy antiSamy = new
	 *         AntiSamy(); try { Policy policy =
	 *         Policy.getInstance("/antisamy-slashdot.xml"); // CleanResults cr
	 *         = antiSamy.scan(dirtyInput, policyFilePath); final CleanResults
	 *         cr = antiSamy.scan(value, policy); System.out.println("clean:" +
	 *         cr.getCleanHTML()); return cr.getCleanHTML(); } catch
	 *         (ScanException e) { e.printStackTrace(); } catch (PolicyException
	 *         e) { e.printStackTrace(); } return value; }
	 */
}
