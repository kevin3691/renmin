package com.zzb.core.security;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;

/**
 * 安全工具类 FilterUtils 敏感字符串过滤
 * 
 */
public class FilterUtils {
	// 需要替换的字符串
	public static String REPLACESTR = " ";

	/**
	 * 过虑XSS
	 * 
	 * @param text
	 * @return
	 */
	public static String xssClean(String text) {
		//中文会被转义，暂放弃
		//text = StringEscapeUtils.escapeHtml(text);
		//text = StringEscapeUtils.escapeJavaScript(text);
		text = text.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		text = text.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
		text = text.replaceAll("'", "&#39;");
		text = text.replaceAll("eval\\((.*)\\)", "");
		text = text.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']",
				"\"\"");
		text = text.replaceAll("script", "");
		
		return text;
	}

	/**
	 * 过滤SQL
	 * 
	 * @param text
	 * @return
	 */
	public static String sqlClean(String text) {
		text = StringEscapeUtils.escapeSql(text);
		return text;
	}

	/**
	 * 对非法字符进行替换
	 * 
	 * @param text
	 * @return
	 */
	public static String regexReplace(String text, String regex) {
		if (isNullStr(text)) {
			return text;
		} else {
			return text.replaceAll(regex, REPLACESTR);
		}
	}

	/**
	 * 匹配字符是否含特殊字符
	 * 
	 * @param text
	 * @return
	 */
	public static boolean regexMatches(String text, String regex) {
		if (text == null) {
			return false;
		}
		Pattern pattern = Pattern.compile(regex);
		return pattern.matcher(text).matches();
	}

	/**
	 * 判断是否为空串
	 * 
	 * @param value
	 * @return
	 */
	public static boolean isNullStr(String value) {
		return value == null || value.trim().equals("");
	}

}
