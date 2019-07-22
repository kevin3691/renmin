package com.zzb.core.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * FreeMarker模板工具
 * 
 */
public class FreeMarkerUtils {
	private static Configuration config = new Configuration(
			Configuration.VERSION_2_3_22);

	/**
	 * 根据模板生成静态页
	 * 
	 * @param templateName
	 *            模板名字
	 * @param root
	 *            模板目录 用于在模板内输出结果集
	 * @param out
	 *            输出对象 具体输出到哪里
	 */
	public static void processTemplate(String templateName, Map<?, ?> map,
			String file) {
		Writer writer = null;
		try {
			writer = new OutputStreamWriter(new FileOutputStream(file), "UTF-8");
			// 获得模板
			Template template = config.getTemplate(templateName, "utf-8");
			// 生成文件（这里是我们是生成html）
			template.process(map, writer);
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		} finally {
			try {
				writer.close();
				writer = null;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * 初始化模板配置
	 * 
	 * @param servletContext
	 *            javax.servlet.ServletContext
	 * @param templateDir
	 *            模板位置
	 * @throws IOException 
	 */
	public static void initConfig(String templateDir) {
		config.setLocale(Locale.CHINA);
		config.setDefaultEncoding("utf-8");
		config.setEncoding(Locale.CHINA, "utf-8");
		//config.setServletContextForTemplateLoading(servletContext, templateDir);
		try {
			config.setDirectoryForTemplateLoading(new File(templateDir));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// config.setObjectWrapper(new DefaultObjectWrapper());
	}

}
