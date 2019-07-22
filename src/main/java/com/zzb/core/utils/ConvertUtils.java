package com.zzb.core.utils;

import com.zzb.core.security.FilterUtils;

public class ConvertUtils {
	public static int Convert2Int(String input) {
		if (!StringUtils.isEmpty(input)) {

			if (StringUtils.isNumeric(input)) {

				return Integer.valueOf(input);
			}
		}
		return 1;
	}

	public static String Convert2String(String input) {
		if (!StringUtils.isEmpty(input)) {
			return FilterUtils.xssClean(input);
		} else {

			return "";
		}
	}
}
