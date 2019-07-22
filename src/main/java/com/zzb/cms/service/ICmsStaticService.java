/**
 * 
 */
package com.zzb.cms.service;

import java.util.Map;

/**
 * Interface ICmsStaticService 静态化处理服务
 * 
 * 
 * @CreatedAt 2016年09月03日
 */
public interface ICmsStaticService {
	/**
	 * 通用生成静态化处理类，CMS通用栏目在执行保存、审核等操作完成后会调用此类
	 * 
	 * @param template
	 * @param colSym
	 * @param colTitle
	 * @return
	 */
	public boolean handler(Map<String, Object> para);

	public boolean genIndex();
	
	
}
