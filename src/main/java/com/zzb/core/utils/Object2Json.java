package com.zzb.core.utils;

import com.google.gson.Gson;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

public class Object2Json {
	public static String toJson(Object obj){
		Gson gson = new Gson();
		
		return gson.toJson(obj);
	}
	
	public static <T> T toBean(String jsonStr,Class<T> cls){
		Gson gson = new Gson();
		T obj=(T)gson.fromJson(jsonStr, cls);
		return obj;
	}
}
