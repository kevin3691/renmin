package com.zzb.core.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;

/**
 * Utils StringUtils 字符串工具
 * 
 */
public class StringUtils extends org.apache.commons.lang.StringUtils {

	/**
	 * 返回纯文本,去掉html的所有标签,并且去掉空行
	 * 
	 * @param input
	 * @return
	 */
	public static String htmlFilter(String html) {
		html = StringEscapeUtils.unescapeHtml(html);
		if (html == null || html.trim().equals("")) {
			return "";
		}
		/*
		 * // 去掉所有html元素, String str = html.replaceAll("\\&[a-zA-Z]{1,10};",
		 * "").replaceAll( "<[^>]*>", ""); str = str.replaceAll("[(/>)<]", "");
		 */
		String str = delHTMLTag(html);
		// 去除字符串中的空格、回车、换行符、制表符
		Pattern p = Pattern.compile("\\s*|\t|\r|\n");
		Matcher m = p.matcher(str);
		str = m.replaceAll("");
		return str;
	}

	public static String delHTMLTag(String htmlStr) {
		String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>"; // 定义script的正则表达式
		String regEx_style = "<style[^>]*?>[\\s\\S]*?<\\/style>"; // 定义style的正则表达式
		String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式

		Pattern p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
		Matcher m_script = p_script.matcher(htmlStr);
		htmlStr = m_script.replaceAll(""); // 过滤script标签

		Pattern p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
		Matcher m_style = p_style.matcher(htmlStr);
		htmlStr = m_style.replaceAll(""); // 过滤style标签

		Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
		Matcher m_html = p_html.matcher(htmlStr);
		htmlStr = m_html.replaceAll(""); // 过滤html标签

		return htmlStr.trim(); // 返回文本字符串
	}

	/**
	 * 删除input字符串中的html格式
	 * 
	 * @param input
	 * @param length
	 *            显示的字符的个数
	 * @return
	 */
	public static String htmlFilter(String html, int length) {
		if (html == null || html.trim().equals("")) {
			return "";
		}

		String str = delHTMLTag(html);
		/*// 去掉所有html元素,
		String str = html.replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "");
		str = str.replaceAll("[(/>)<]", "").trim();*/
		int len = str.length();
		if (length == 0 || len <= length) {
			return str;
		} else {
			str = str.substring(0, length);
		}
		return str;
	}

	public static boolean isValidDate(String str) {
		boolean convertSuccess = true;
		// 指定日期格式为四位年/两位月份/两位日期，注意yyyy/MM/dd区分大小写；
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		try {
			// 设置lenient为false.
			// 否则SimpleDateFormat会比较宽松地验证日期，比如2007/02/29会被接受，并转换成2007/03/01
			format.setLenient(false);
			format.parse(str);
		} catch (ParseException e) {
			// e.printStackTrace();
			// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
			convertSuccess = false;
		}
		return convertSuccess;
	}

}
