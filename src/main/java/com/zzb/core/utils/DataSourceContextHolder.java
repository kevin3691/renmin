package com.zzb.core.utils;

import org.springframework.util.StringUtils;


public class DataSourceContextHolder {


	  
	  /**
	     * 数据源类型管理
	     * <p>
	     * 考虑多线程，为保证线程之间互不干扰，所以使用ThreadLocal作线程隔离；<br>
	     * 参数是数据源键值
	     * </p>
	     *
	     * @see ThreadLocal
	     */
	    private static ThreadLocal<String> contextHolder = new ThreadLocal<String>();

	    /**
	     * 获取数据源
	     * <p>
	     * 如果未设置，默认返回读数据源
	     * </p>
	     *
	     * @return 数据源键值
	     */
	    public static String getDataSource() {
	    	    return contextHolder.get();

	    }

	    /**
	     * 设置数据源
	     *
	     * @param dataSourceKey 数据源键值
	     */
	    public static void setDataSource(String dataSourceKey) {
	        contextHolder.set(dataSourceKey);
	    }
}
