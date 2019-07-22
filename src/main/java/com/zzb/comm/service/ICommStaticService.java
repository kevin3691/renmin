
package com.zzb.comm.service;

import java.util.Map;


public interface ICommStaticService {
	/**
	 * 
	 * 
	 * @param template
	 * @param colSym
	 * @param colTitle
	 * @return
	 */
	public boolean handler(Map<String, Object> para);

	public boolean genIndex();
	
	
}
