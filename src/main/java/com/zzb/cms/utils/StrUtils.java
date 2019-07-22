package com.zzb.cms.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class StrUtils {

	/**
	 * 用字符串，替换两个字符串之间的字符串
	 * @param indexHtmlStr	原字符串
	 * @param strStart	开始字符串
	 * @param strEnd	结束字符串
	 * @param replace	要替换的字符串
	 * @return
	 */
	public static String replaceAssStr(String str, String strStart,
			String strEnd, String replace) {
		String[] split = str.split(strStart);
		String[] split2 = split[1].split(strEnd);
		return split[0]+replace+split2[1];
	}
	/**
	 * 获取list标签中标识符符中的内容
       String ddd  = "<!--lb_list_start tag='ty' rows='20' index='5'-->范德萨发生大</lb_list_end>";
       ps:传入  tag='  返回 ty  传入  rows='  返回 20    传入  index='  返回 5    
	 * @param str
	 * @param tag
	 * @return
	 */
	public static String getContent(String str,String tag) {
    	int indexOf = str.indexOf(tag);
    	int indexOf2 = str.indexOf("'",indexOf+tag.length());
    	String substring = str.substring(indexOf+tag.length(), indexOf2);
    	return substring;
	}
	public static void main(String[] args) {
		String aa = "g:\\a\\bb\\cc.gif";  
        System.out.println(aa);  
        /**  
         * 因为涉及到两层,一个是JAVA的转义,一个是源代码的转义 
         * 正则表达式需要转义用\\表示\;  
         * 而java的源代码里，字符串中需要转义用\\表示\。  
         * 因此累加在一起就必须是四个斜线\\\\,这样java转义后就是\\,而\\在正则里转义后为\这样就可以进行匹配了 
         * 有点绕,呵呵~ 
         */   
        String[] xx = aa.split("\\");  
        for(String cell:xx){  
            System.out.println(cell);  
        }  
	}

}
