package com.zzb.core.baseclass;

import java.beans.PropertyEditorSupport;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.zzb.core.utils.DateUtils;


public class BaseController {
	@Resource
	public HttpServletRequest request;
	
	@Resource
	public HttpServletResponse response;

	/**
	 * 格式化表单参数，绑定实例实体类
	 * 
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		// SimpleDateFormat dateFormat = new
		// SimpleDateFormat("yyyy-MM-dd HH:mm");
		// dateFormat.setLenient(false);
		// binder.registerCustomEditor(Date.class, new
		// CustomDateEditor(dateFormat, true));

		// String类型转换，将所有传递进来的String进行HTML编码，防止XSS攻击
		binder.registerCustomEditor(String.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) {
				//setValue(text == null ? null : cleanXSS(text.trim()));
				setValue(text == null ? null : text.trim());
			}

			@Override
			public String getAsText() {
				Object value = getValue();
				return value != null ? value.toString() : "";
			}
		});

		// Date 类型转换
		binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) {
				setValue(DateUtils.parse(text));
			}
		});

		// int 类型转换
		binder.registerCustomEditor(int.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) throws IllegalArgumentException {
				if (text == null || text.equals("")) {
					text = "0";
				}
				setValue(Integer.parseInt(text));
			}

			@Override
			public String getAsText() {
				return getValue().toString();
			}
		});

		// long 类型转换
		binder.registerCustomEditor(long.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) throws IllegalArgumentException {
				if (text == null || text.equals("")) {
					text = "0";
				}
				setValue(Long.parseLong(text));
			}

			@Override
			public String getAsText() {
				return getValue().toString();
			}
		});

		// double 类型转换
		binder.registerCustomEditor(double.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) throws IllegalArgumentException {
				if (text == null || text.equals("")) {
					text = "0";
				}
				setValue(Double.parseDouble(text));
			}

			@Override
			public String getAsText() {
				return getValue().toString();
			}
		});

		// float 类型转换
		binder.registerCustomEditor(float.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) throws IllegalArgumentException {
				if (text == null || text.equals("")) {
					text = "0";
				}
				setValue(Float.parseFloat(text));
			}

			@Override
			public String getAsText() {
				return getValue().toString();
			}
		});
	}

	/**
	 * 过滤html js字符串，避免xss攻击
	 * 
	 * @param value
	 * @return
	 */
	private String cleanXSS(String value) {
		// You'll need to remove the spaces from the html entities below
		value = value.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
		value = value.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
		value = value.replaceAll("'", "& #39;");
		value = value.replaceAll("eval\\((.*)\\)", "");
		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']",
				"\"\"");
		value = value.replaceAll("script", "");
		return value;
	}

}
