package com.zzb.core.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.util.StringUtils;

/**
 * 日期工具
 * 
 */
public class DateUtils {

	public static String[] patterns = { "yyyy-MM-dd HH:mm:ss",
			"yyyy-MM-dd HH:mm", "yyyy-MM-dd", "yyyy/MM/dd",
			"yyyy/MM/dd HH:mm:ss", "yyyy/MM/dd HH:mm" };

	public DateUtils() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 获取当前日期字符串 默认格式“yyyy-MM-dd”
	 * 
	 * @return
	 */
	public static String getDate() {
		Date today = new Date();
		return format(today);
	}

	public static String getDate(String pattern) {
		Date today = new Date();
		return format(today, pattern);
	}

	/**
	 * 使用预设Format格式化Date成字符串
	 */
	public static String format(Date date) {
		return date == null ? " " : format(date, patterns[0]);
	}

	/**
	 * 使用参数Format格式化Date成字符串
	 */
	public static String format(Date date, String pattern) {
		return date == null ? " " : new SimpleDateFormat(pattern).format(date);
	}

	/**
	 * 使用预设格式将字符串转为Date
	 */
	public static Date parse(String strDate) {
		for (String p : patterns) {
			Date d = parse(strDate, p);
			if (d != null) {
				return d;
			}
		}
		return null;
	}

	/**
	 * 使用参数Format将字符串转为Date
	 */
	public static Date parse(String strDate, String pattern) {
		try {
			return StringUtils.isEmpty(strDate) ? null : new SimpleDateFormat(
					pattern).parse(strDate);
		} catch (ParseException ex) {
			return null;
		}
	}

	/**
	 * 在日期上增加数个整月
	 */
	public static Date addMonth(Date date, int n) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, n);
		return cal.getTime();
	}

	/**
	 * 获取当年的第一天
	 * 
	 * @param year
	 * @return
	 */
	public static Date getCurrYearFirst() {
		Calendar currCal = Calendar.getInstance();
		int currentYear = currCal.get(Calendar.YEAR);
		return getYearFirst(currentYear);
	}

	/**
	 * 获取当年的最后一天
	 * 
	 * @param year
	 * @return
	 */
	public static Date getCurrYearLast() {
		Calendar currCal = Calendar.getInstance();
		int currentYear = currCal.get(Calendar.YEAR);
		return getYearLast(currentYear);
	}

	/**
	 * 获取某年第一天日期
	 * 
	 * @param year
	 *            年份
	 * @return Date
	 */
	public static Date getYearFirst(int year) {
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.set(Calendar.YEAR, year);
		Date yearFirst = calendar.getTime();
		return yearFirst;
	}

	/**
	 * 获取某年最后一天日期
	 * 
	 * @param year
	 *            年份
	 * @return Date
	 */
	public static Date getYearLast(int year) {
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.set(Calendar.YEAR, year);
		calendar.roll(Calendar.DAY_OF_YEAR, -1);
		Date yearLast = calendar.getTime();
		return yearLast;
	}

	/**
	 * 获取当前月第一天
	 * 
	 * @return
	 */
	private static Date getCurrMonthFirst() {
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH);
		return getMonthFirst(year, month);
	}

	/**
	 * 获取当前月最后一天
	 * 
	 * @return
	 */
	private static Date getCurrMonthLast() {
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH);
		return getMonthLast(year, month);
	}

	/**
	 * 获取某年某月第一天
	 * 
	 * @return
	 */
	private static Date getMonthFirst(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, month);
		calendar.add(Calendar.MONTH, 0);
		calendar.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
		Date monthFirst = calendar.getTime();
		return monthFirst;
	}

	/**
	 * 获取某年某月最后一天
	 * 
	 * @return
	 */
	private static Date getMonthLast(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, month);
		calendar.set(Calendar.DAY_OF_MONTH,
				calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		Date monthLast = calendar.getTime();
		return monthLast;
	}
	
	
	 public static String secToTime(int time) {  
	        String timeStr = null;  
	        int hour = 0;  
	        int minute = 0;  
	        int second = 0;  
	        if (time <= 0)  
	            return "00分钟00秒";  
	        else {  
	            minute = time / 60;  
	            if (minute < 60) {  
	                second = time % 60;  
	                timeStr = unitFormat(minute) + "分钟" + unitFormat(second) + "秒";  
	            } else {  
	                hour = minute / 60;  
	                if (hour > 99)  
	                    return "99小时59分钟59秒";  
	                minute = minute % 60;  
	                second = time - hour * 3600 - minute * 60;  
	                timeStr = unitFormat(hour) + "小时" + unitFormat(minute) + "分钟" + unitFormat(second) + "秒";  
	            }  
	        }  
	        return timeStr;  
	    }  
	  
	    public static String unitFormat(int i) {  
	        String retStr = null;  
	        if (i >= 0 && i < 10)  
	            retStr = "0" + Integer.toString(i);  
	        else  
	            retStr = "" + i;  
	        return retStr;  
	    }  

}
