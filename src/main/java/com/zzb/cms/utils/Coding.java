package com.zzb.cms.utils;

public class Coding {

	public static String getSysCoding(){
		String coding = (String) System.getProperties().get("file.encoding");
		return coding;
	}
}
