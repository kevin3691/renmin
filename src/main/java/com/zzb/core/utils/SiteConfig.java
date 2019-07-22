
package com.zzb.core.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import javax.servlet.ServletContext;
import com.google.common.collect.Maps;


public class SiteConfig {

	// 保存全局属性值
	private static Map<String, String> map = Maps.newHashMap();

	/**
	 * 
	 */
	public SiteConfig() {

	}

	/**
	 * 获取配置 优先读取全局如无则获取并放入
	 * 
	 * @param key
	 * @return
	 */
	public static String getConfig(String key) {
		return getConfig(null, key);
	}

	/**
	 * 获取配置 优先读取全局如无则获取并放入
	 * 
	 * @param path
	 * @param key
	 * @return
	 */
	public static String getConfig(String path, String key) {
		String value = map.get(key);
		if (value == null) {
			if (path == null) {
				// 默认配置文件路径为config.properties
				path = "config.properties";
			}
			Properties prop = loadProperties(path);
			if (prop.containsKey(key)) {
				value = prop.getProperty(key);
			} else {
				value = "";
			}
			map.put(key, value);
		}
		return value;
	}

	/**
	 * 根据配置文件名获取配置，并处理perperties中文乱码问题
	 * 
	 * @param resourcesPaths
	 * @return
	 */
	private static Properties loadProperties(String... resourcesPaths) {
		Properties props = new Properties();
		InputStream stream = SiteConfig.class.getClassLoader()
				.getResourceAsStream("config.properties");
		Reader reader = null;
		try {
			reader = new InputStreamReader(stream, "UTF-8");
			props.load(reader);
		} catch (IOException e) {

			// TODO 错误处理

		} finally {
			if (null != reader) {
				try {
					reader.close();
				} catch (IOException e) {
					// ignore
				}
			}
		}
		return props;
	}

	/**
	 * 将properties遍历放入context
	 * 
	 * @param session
	 */
	public static void setContextConfig(ServletContext context) {
		if (context == null) {
			return;
		}
		if (context.getAttribute("WorkplateTitle") != null) {
			return;
		}
		System.out.println("SiteConfig setContextConfig...");
		Properties props = loadProperties("config.properties");
		Iterator<Entry<Object, Object>> it = props.entrySet().iterator();
		while (it.hasNext()) {
			Entry<Object, Object> entry = it.next();
			String key = entry.getKey().toString();
			Object value = entry.getValue();
			context.setAttribute(key, value);
			System.out.println("key   :" + key);
			System.out.println("value :" + value);
			System.out.println("---------------");
		}
	}

	// 载入多个文件, 文件路径使用Spring Resource格式.
	/***
	 * private static Properties loadProperties(String... resourcesPaths) {
	 * Properties props = new Properties(); for (String location :
	 * resourcesPaths) { // logger.debug("Loading properties file from:" +
	 * location); InputStream is = null; try { Resource resource =
	 * resourceLoader.getResource(location); is = resource.getInputStream();
	 * props.load(is); is.close(); } catch (IOException ex) {
	 * logger.info("Could not load properties from path:" + location + ", " +
	 * ex.getMessage()); } } return props; }
	 ***/
}
