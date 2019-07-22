package com.zzb.core.baseclass;

import java.util.Date;

import javax.persistence.MappedSuperclass;
import javax.security.auth.Subject;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;

import com.zzb.core.utils.DateUtils;
import com.zzb.core.utils.IPUtils;

/**
 * Service基类
 */
@MappedSuperclass
public class BaseService<T> {

	public BaseService() {
		super();
	}

	/**
	 * 自动设置RecordInfo基础信息
	 * 
	 * @param info
	 * @param request
	 * @return
	 */
	public RecordInfo GenRecordInfo(RecordInfo info, HttpServletRequest request) {
		if(info==null)
		{
			info = new RecordInfo();
		}
		Date ct = new Date();
		int personId = -1;
		int userId = -1;
		String personName = "";
		
		if (request != null && request.getSession() != null) {
			if(request.getSession().getAttribute("baseUserId")!=null)
			{
				personId = (int)request.getSession().getAttribute("baseUserId");
				userId = (int)request.getSession().getAttribute("baseUserId");
				personName = request.getSession().getAttribute("basePersonName").toString();
			}
		}
		String cip = IPUtils.getIpAddr(request);
		if (info.getCreatedAt() == null
				|| DateUtils.format(info.getCreatedAt(), "yyyy-MM-dd")
						.equalsIgnoreCase("1900-01-01")) {
			info.setCreatedAt(ct);
			info.setCreatedBy(personId);
			info.setCreatedByName(personName);
			info.setCreatedByUser(userId);
		}
		info.setUpdatedAt(ct);
		info.setUpdatedBy(personId);
		info.setUpdatedByName(personName);
		info.setUpdatedByUser(userId);
		info.setClientIP(cip);
		return info;
	}

}
