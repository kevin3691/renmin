/**
 * Copyright 2016 the original author or authors.
 * 
 */
package com.zzb.zo.service;

import com.zzb.base.entity.BaseUser;
import com.zzb.comm.entity.CommAttachment;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.baseclass.QueryPara;
import com.zzb.core.baseclass.QueryResult;
import com.zzb.core.utils.SiteConfig;
import com.zzb.workflow.dao.WfInstanceDao;
import com.zzb.workflow.entity.WfInstance;
import com.zzb.zo.dao.SealDao;
import com.zzb.zo.entity.Seal;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 组织机构 Service
 * 
 * 
 * @createdAt 2016年1月29日
 */
@Transactional
@Service("sealService")
public class SealService extends BaseService<Seal> {

	private String allowSuffix = "*.*";// 允许文件格式
	private long allowSize = 200000L;// 允许文件大小
	private String fileName;
	private String[] fileNames;
	private String destDir = "upload/temp/";

	public String getAllowSuffix() {
		return allowSuffix;
	}

	public void setAllowSuffix(String allowSuffix) {
		this.allowSuffix = allowSuffix;
	}

	public long getAllowSize() {
		return allowSize * 1024 * 1024;
	}

	public void setAllowSize(long allowSize) {
		this.allowSize = allowSize;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String[] getFileNames() {
		return fileNames;
	}

	public void setFileNames(String[] fileNames) {
		this.fileNames = fileNames;
	}

	public String getDestDir() {
		return destDir;
	}

	public void setDestDir(String destDir) {
		this.destDir = destDir;
	}

	/**
	 * 生成文件名
	 *
	 * @return
	 */
	private String genFileName() {
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		return fmt.format(new Date());
	}

	public void saveAs(String url, HttpServletRequest request)
			throws FileNotFoundException, IOException {
		String realPath = request.getSession().getServletContext()
				.getRealPath("/");
		url = url.replace("/","\\");
		File srcFile = new File(realPath + "\\" + url);
		if (!srcFile.exists()) {
			return;
		}
		String fileUrl = SiteConfig.getConfig("UploadSaveAsPath");
		System.out.println(fileUrl);
		if (fileUrl != "" && fileUrl != null) {
			String srcImg = srcFile.getAbsoluteFile().toString();
			String destImg = fileUrl + "/" + url;
			File file = new File(destImg);
			checkDirectory(file.getParentFile().getAbsolutePath());
			System.out.println("#########saveAs srcImg:" + srcImg);
			System.out.println("#########saveAs destImg:" + destImg);
			CopyFile(srcImg, destImg);
		}
	}

	/**
	 * 检查目录是否存在
	 *
	 * @param path
	 */
	public void checkDirectory(String path) {
		File file = new File(path);
		// 如果文件夹不存在则创建
		if (!file.exists() && !file.isDirectory()) {
			System.out.println("//不存在");
			file.mkdirs();
		} else {
			System.out.println("//目录存在");
		}
	}

	/**
	 * 复制文件
	 *
	 * @param srcFile
	 * @param destFile
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static void CopyFile(String srcFile, String destFile)
			throws FileNotFoundException, IOException {
		FileInputStream fis = new FileInputStream(srcFile);
		FileOutputStream fos = new FileOutputStream(destFile);

		int len = 0;
		byte[] buf = new byte[1024];
		while ((len = fis.read(buf)) != -1) {
			fos.write(buf, 0, len);
		}
		fis.close();
		fos.close();
	}

	/**
	 * 获取类型图标
	 *
	 * @param ext
	 * @return
	 */
	public String getIcon(String ext) {
		String icon = "fa fa-file ";
		if ("zip,rar,gz".indexOf(ext) >= 0) {
			icon = "fa fa-file-archive-o";
		} else if ("war,mp3".indexOf(ext) >= 0) {
			icon = "fa fa-file-audio-o";
		} else if ("cs,php,java,aspx,jsp,html,htm,asp".indexOf(ext) >= 0) {
			icon = "fa fa-file-code-o";
		} else if ("xls,xlsx,csv".indexOf(ext) >= 0) {
			icon = "fa fa-file-excel-o";
		} else if ("jpg,jpeg,bmp,gif,png,tif,psd".indexOf(ext) >= 0) {
			icon = "fa fa-file-image-o";
		} else if ("mov,mpeg,rm,rmvb,wmv,avi,mp4,3gp,mkv".indexOf(ext) >= 0) {
			icon = "fa fa-file-movie-o";
		} else if ("txt".indexOf(ext) >= 0) {
			icon = "fa fa-file-text-o";
		} else if ("pdf".indexOf(ext) >= 0) {
			icon = "fa fa-file-pdf-o";
		} else if ("ppt,pptx".indexOf(ext) >= 0) {
			icon = "fa fa-file-powerpoint-o";
		} else if ("doc,docx".indexOf(ext) >= 0) {
			icon = "fa fa-file-word-o";
		}
		return icon;
	}



	@Resource
	private SealDao sealDao;
	
	@Resource
	private WfInstanceDao wfInstanceDao;


	/**
	 * 查询
	 * 
	 * @param request
	 * @return
	 */
	public QueryResult<Seal> list(HttpServletRequest request) {
		int isActive = request.getParameter("isPi") != null
				&& !request.getParameter("isPi").equals("") ? Integer
				.valueOf(request.getParameter("isPi")) : -1;
		int orgId = request.getParameter("orgId") != null
				&& !request.getParameter("orgId").equals("") ? Integer
				.valueOf(request.getParameter("orgId")) : -1;
		int sprId = request.getParameter("sprId") != null
				&& !request.getParameter("sprId").equals("") ? Integer
				.valueOf(request.getParameter("sprId")) : -1;
		int sealTypeId = request.getParameter("sealTypeId") != null
				&& !request.getParameter("sealTypeId").equals("") ? Integer
				.valueOf(request.getParameter("sealTypeId")) : -1;
		int status = request.getParameter("status") != null
				&& !request.getParameter("status").equals("") ? Integer
				.valueOf(request.getParameter("status")) : -1;
		String sealdNo = request.getParameter("sealdNo") != null ? request
				.getParameter("sealdNo") : "";
		String type = request.getParameter("type") != null ? request
				.getParameter("type") : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";

		BaseUser user = (BaseUser)SecurityUtils.getSubject()
				.getSession().getAttribute("baseUser");
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM Seal WHERE 1=1";
		if (isActive > 0) {
			hql += " AND isActive=?";
			args.add(isActive);
		}

		if (sprId > 0) {
			hql += " AND sprId=?";
			args.add(sprId);
		}

		if (sealTypeId > 0) {
			hql += " AND sealTypeId=?";
			args.add(sealTypeId);
		}

		if (orgId > 0) {
			if(user.getBaseOrgName().equals("办公室") || user.getBaseRoleName().contains("管理员")){

			}else{
				hql += " AND orgId=?";
				args.add(orgId);
			}

		}

		if (status > -1) {
			hql += " AND status = ?";
			args.add(status);
		}

		if (!type.equals("")) {
			hql += " AND type LIKE ?";
			args.add('%' + type + '%');
		}

		if (!category.equals("")) {
			hql += " AND category LIKE ?";
			args.add('%' + category + '%');
		}



		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<Seal> qr = sealDao.list(qp);
		return qr;
	}

	public QueryResult<Seal> list4sel(HttpServletRequest request) {

		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM Seal WHERE 1=1";

		hql += " AND status LIKE ?";
		args.add("%空闲%");



		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<Seal> qr = sealDao.list(qp);
		return qr;
	}
	


	public Seal save(Seal doc, HttpServletRequest request) {
		doc.setRecordInfo(super.GenRecordInfo(doc.getRecordInfo(), request));
		doc = sealDao.save(doc);
		if(doc.getLineNo() == 0){
			doc.setLineNo(doc.getId());
			doc = sealDao.save(doc);
		}

		return doc;
	}


	/**
	 * 通过用户id更新用户头像
	 * @param uid 用户id
	 * @param avatar 图片路径
	 */

	public void addImg(Integer uid, String avatar) {
		Seal seal = dtl(12);
		avatar = "123123";
		seal.setImg(avatar);
	}

//	/**
//	 * 上传文件
//	 *
//	 * @param file
//	 * @param destDir
//	 * @param request
//	 * @throws Exception
//	 */
//	public Seal upload(MultipartFile file, HttpServletRequest request)
//			throws Exception {
//		String category = request.getParameter("category") != null ? request
//				.getParameter("category").toString() : "";
//		String title = request.getParameter("title") != null ? request
//				.getParameter("title").toString() : "";
//		String share = request.getParameter("share") != null ? request
//				.getParameter("share").toString() : "共享";
//		String applyTo = request.getParameter("applyTo") != null ? request
//				.getParameter("applyTo").toString() : "";
//		int refNum = request.getParameter("refNum") != null ? Integer
//				.valueOf(request.getParameter("refNum")) : 0;
//		allowSuffix = request.getParameter("allowExt") != null ? request
//				.getParameter("allowExt").toString() : allowSuffix;
//		allowSize = request.getParameter("allowSize") != null ? Long
//				.valueOf(request.getParameter("allowSize")) : allowSize;
//		destDir = request.getParameter("destDir") != null ? request
//				.getParameter("destDir").toString() : destDir;
//		Seal att = new Seal();
//		String path = request.getContextPath();
//		String basePath = request.getScheme() + "://" + request.getServerName()
//				+ ":" + request.getServerPort() + path;
//		try {
//			String suffix = file.getOriginalFilename().substring(
//					file.getOriginalFilename().lastIndexOf(".") + 1);
//			String fn = file.getOriginalFilename().substring(0,
//					file.getOriginalFilename().lastIndexOf("."));
//			int length = getAllowSuffix().indexOf(suffix);
//			if (getAllowSuffix().indexOf("*") == -1 && length == -1) {
//				throw new Exception("请上传允许格式的文件");
//			}
//			if (file.getSize() > getAllowSize()) {
//				throw new Exception("您上传的文件大小已经超出范围");
//			}
//
//			String realPath = request.getSession().getServletContext()
//					.getRealPath("/");
//			File destFile = new File(realPath + "/" + destDir);
//			if (!destFile.exists()) {
//				destFile.mkdirs();
//			}
//
//			String fndt = genFileName();
//
//			String newFileName = fn + "_" + fndt + "." + suffix;
//			File f = new File(destFile.getAbsoluteFile() + "/" + newFileName);
//			file.transferTo(f);
//			f.createNewFile();
//			//waterMark(destDir + newFileName, request);
//			saveAs(destDir + newFileName, request);
//
//			if (!title.equals("")) {
//				att.setImg(title);
//			}
//		} catch (Exception e) {
//			throw e;
//		}
//		return att;
//	}


	

	public Seal dtl(int id) {
		Seal doc = sealDao.dtl(id);
		return doc;
	}

	public void del(int id) {
		sealDao.del(id);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 */
	public void sort(int id, String order) {
		sealDao.sort(id, order);
	}
	
	public int checkInsExist(String applyTo,int refNum,int stepId, String actorId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "SELECT COUNT(*) FROM WfInstance WHERE 1=1";
		if (!applyTo.equals("")) {
			hql += " AND applyTo=?";
			args.add(applyTo);
		}
		if (refNum > 0) {
			hql += " AND refNum=? ";
			args.add(refNum);
		}
		if (stepId > 0) {
			hql += " AND stepId=? ";
			args.add(stepId);
		}
		if (!actorId.equals("")) {
			hql += " AND actorId=?";
			args.add(actorId);
		}
		return (int) ((long) wfInstanceDao.uniqueResult(hql, args));
	}
	
	public int delByRefNum(int refNum) {
		List<Object> args = new ArrayList<Object>();

		String hql = "DELETE * FROM WfInstance WHERE refNum=?";
		args.add(refNum);
		
		return (int) ((long) wfInstanceDao.uniqueResult(hql, args));
	}
	
	public List<WfInstance> listIns(int refNum) {
		List<Object> args = new ArrayList<Object>();		
		String hql = "FROM WfInstance WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);
		List<WfInstance> qr = wfInstanceDao.list(hql, args);
		return qr;
	}
	
	public QueryResult<WfInstance> listIns(HttpServletRequest request) {
		int isActive = request.getParameter("isActive") != null ? Integer
				.valueOf(request.getParameter("isActive")) : 0;
		String actorId = request.getParameter("actorId") != null ? 
				request.getParameter("actorId") : "";
		String yesNo = request.getParameter("yesNo") != null ? request
				.getParameter("yesNo") : "";
		String category = request.getParameter("category") != null ? request
				.getParameter("category") : "";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo") : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		String stepName = request.getParameter("stepName") != null ? request
				.getParameter("stepName") : "";
		String actorName = request.getParameter("actorName") != null ? request
				.getParameter("actorName") : "";
		QueryPara qp = new QueryPara(request);
		List<Object> args = new ArrayList<Object>();
		Map<String, Object> alias = new HashMap<String, Object>();

		String hql = "FROM WfInstance WHERE 1=1";
		if (!category.equals("")) {
			if (category.indexOf(",") >= 0) {
				String[] categorys = category.split(",");
				hql += " AND category IN (:categorys)";
				alias.put("categorys", categorys);
			} else {
				hql += " AND category LIKE ?";
				args.add('%' + category + '%');
			}
		}
		if (yesNo.equals("yes")) {
			hql += " AND yesNo=?";
			args.add("yes");
		}else{
			hql += " AND (yesNo != ? OR yesNo is null)";
			args.add("yes");
		}
		if (!actorId.equals("")) {
			hql += " AND actorId=?";
			args.add(actorId);
		}
		if (!applyTo.equals("")) {
			hql += " AND applyTo=?";
			args.add(applyTo);
		}
		if (refNum > 0) {
			hql += " AND refNum=?";
			args.add(refNum);
		}
		if (!stepName.equals("")) {
			if (stepName.indexOf(",") >= 0) {
				String[] stepNames = stepName.split(",");
				hql += " AND stepName IN (:stepNames)";
				alias.put("stepNames", stepNames);
			} else {
				hql += " AND stepName LIKE ?";
				args.add('%' + stepName + '%');
			}
		}
		if (!actorName.equals("")) {
			hql += " AND actorName LIKE ?";
			args.add('%' + actorName + '%');
		}
		hql += " AND isActive=?";
		args.add(isActive);
		qp.setAlias(alias);
		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<WfInstance> qr = wfInstanceDao.list(qp);
		return qr;
	}

	public QueryResult<Seal> listByDocTypeId(int orgId) {
		QueryPara qp = new QueryPara();
		List<Object> args = new ArrayList<Object>();
		String hql = "FROM Seal WHERE 1=1";
		hql += " AND docTypeId IN (SELECT id FROM DocType WHERE id=? OR baseTree.path LIKE ?)";
		args.add(orgId);
		args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<Seal> qr = sealDao.list(qp);
		return qr;
	}

	public QueryResult<Seal> listAllByDocTypeIds(List<Integer> Ids) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM Seal WHERE 1=1";

		hql += " AND docTypeId in (:idList)";
		alias.put("idList", Ids);

		qp.setAlias(alias);
		qp.setHql(hql);
		QueryResult<Seal> qr = sealDao.list4(qp);
		return qr;
	}



	public QueryResult<Seal> listAllUser() {
		QueryPara qp = new QueryPara();
		//List<Object> args = new ArrayList<Object>();
		String hql = "FROM Seal WHERE 1=1";
		//hql += " AND baseOrgId IN (SELECT id FROM BaseOrg WHERE id=? OR baseTree.path LIKE ?)";
		//args.add(orgId);
		//args.add('%' + "." + String.valueOf(orgId) + "." + '%');

		//qp.setArgs(args);
		qp.setHql(hql);
		QueryResult<Seal> qr = sealDao.list4(qp);
		return qr;
	}

	public QueryResult<Seal> listByOrgIds(List<Integer> idList) {
		QueryPara qp = new QueryPara();
		Map<String, Object> alias = new HashMap<String, Object>();
		String hql = "FROM Seal WHERE 1=1 ";
		hql += " AND docTypeId in (:idList)";
		alias.put("idList", idList);
		qp.setHql(hql);
		qp.setAlias(alias);
		QueryResult<Seal> qr = sealDao.listNoTotal(qp);
		return qr;
	}
	
	
	public WfInstance getIns(int refNum,int stepId) {
		List<Object> args = new ArrayList<Object>();		
		String hql = "FROM WfInstance WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);
		hql += " AND stepId=?";
		args.add(stepId);
		WfInstance ins = wfInstanceDao.dtl(hql, args);
		return ins;
	}

	public WfInstance getIns(int refNum,int stepId,String actorId) {
		List<Object> args = new ArrayList<Object>();		
		String hql = "FROM WfInstance WHERE 1=1";
		hql += " AND refNum=?";
		args.add(refNum);
		hql += " AND stepId=?";
		args.add(stepId);
		hql += " AND actorId=?";
		args.add(actorId);
		WfInstance ins = wfInstanceDao.dtl(hql, args);
		return ins;
	}


}
