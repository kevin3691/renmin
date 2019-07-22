package com.zzb.comm.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zzb.comm.entity.CommAttachment;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.comm.service.CommUploaderService;
import com.zzb.core.baseclass.BaseController;
import com.zzb.core.baseclass.QueryResult;

@Controller
@RequestMapping("/comm/attachment")
public class CommAttachmentController extends BaseController {

	@Resource
	private CommAttachmentService attachmentService;

	@Resource
	private CommUploaderService commUploaderService;

	String mode = "RW";
	String category = "";
	String uploadLabel = "";
	String applyTo = "";
	int refNum = 0;
	String title = "";
	String allowExt = "*.*";
	long allowSize = 20000 * 1024 * 1024L;
	String destDir = "upload/temp/";

	/**
	 * 构造函数
	 */
	public CommAttachmentController() {
		// System.out.println("this is constructed function... ");
	}

	/**
	 * View 列表页 index
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index")
	private String index() {
		return "/comm/attachment/index";
	}

	/**
	 * View 列表页预览模式 preIndex
	 * 
	 * @return
	 */
	@RequestMapping(value = "/preIndex")
	private String preIndex() {
		return "/comm/attachment/preIndex";
	}

	/**
	 * View 简单上传页 upload
	 * 
	 * @return
	 */
	@RequestMapping(value = "/upload")
	private String upload(HttpServletRequest request, ModelMap model) {
		setPara(request, model);
		return "/comm/attachment/upload";
	}

	/**
	 * View 单张图片 singleImage
	 * 
	 * @return
	 */
	@RequestMapping(value = "/album")
	private String album(HttpServletRequest request, ModelMap model) {
		setPara(request, model);
		CommAttachment att = attachmentService.dtlBy(request);
		model.addAttribute("o", att);
		return "/comm/attachment/album";
	}

	/**
	 * View 预览上传页 preUpload
	 * 
	 * @return
	 */
	@RequestMapping(value = "/preUpload")
	private String preUpload(HttpServletRequest request, ModelMap model) {
		setPara(request, model);
		return "/comm/attachment/preUpload";
	}

	/**
	 * View 图片裁剪上传页 corpUpload
	 * 
	 * @return
	 */
	@RequestMapping(value = "/cropUpload")
	private String cropUpload(HttpServletRequest request, ModelMap model) {
		return "/comm/attachment/cropUpload";
	}

	/**
	 * View 列表页测试引用 testIndex
	 * 
	 * @return
	 */
	@RequestMapping(value = "/testIndex")
	private String testIndex() {
		return "/comm/attachment/testIndex";
	}

	/**
	 * View 列表页(通用附件页) index4
	 * 
	 * @return
	 */
	@RequestMapping(value = "/index4")
	private String index4(HttpServletRequest request, ModelMap model) {
		setPara(request, model);
		return "/comm/attachment/index4";
	}

	/**
	 * View 列表页(通用附件页) simpleIndex4
	 * 
	 * @return
	 */
	@RequestMapping(value = "/simpleIndex4")
	private String simpleIndex4(HttpServletRequest request, ModelMap model) {
		setPara(request, model);
		return "/comm/attachment/simpleIndex4";
	}

	/**
	 * View 添加 编辑 edit
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public String edit(HttpServletRequest request, ModelMap model) {
		String sid = request.getParameter("id");
		int id = 0;
		if (sid != null) {
			id = Integer.valueOf(request.getParameter("id"));
		}
		CommAttachment att = new CommAttachment();
		if (id > 0) {
			att = attachmentService.dtl(id);
		}

		if (att == null) {
			att = new CommAttachment();
		}
		model.addAttribute("o", att);
		return "/comm/attachment/edit";
	}

	/**
	 * 获取列表数据list
	 * 
	 * @param attachment
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list")
	public QueryResult<CommAttachment> list(CommAttachment attachment,
			HttpServletRequest request) {
		return attachmentService.list(request);
	}

	@ResponseBody
	@RequestMapping(value = "/list4")
	public QueryResult<CommAttachment> list4(CommAttachment attachment,
											 HttpServletRequest request) {
		return attachmentService.list4(request);
	}

	@ResponseBody
	@RequestMapping(value = "/list5")
	public QueryResult<CommAttachment> list5(CommAttachment attachment,
											 HttpServletRequest request) {
		return attachmentService.list5(request);
	}
	/**
	 * 保存 save
	 * 
	 * @param attachment
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public Map<String, Object> save(CommAttachment attachment,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		attachment = attachmentService.save(attachment, request);
		map.put("entity", attachment);
		return map;
	}

	/**
	 * 删除 del
	 * 
	 * @param attachment
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/del", method = RequestMethod.POST)
	public Map<String, Object> del(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		map.put("IsSuccess", true);
		System.out.println("AttachmentController DEL:" + id);
		attachmentService.del(id);
		return map;
	}

	/**
	 * 排序
	 * 
	 * @param attachment
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/sort", method = RequestMethod.POST)
	public Map<String, Object> sort(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		int id = Integer.valueOf(request.getParameter("id"));
		String order = request.getParameter("order");
		System.out.println("asdasdasd" + id);
		map.put("IsSuccess", true);
		attachmentService.sort(id, order);
		return map;
	}

	@ResponseBody
	@RequestMapping("/uploader")
	public Map<String, Object> uploader(
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) {
		CommAttachment att = new CommAttachment();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			att = commUploaderService.upload(file, request);
			map = save(att, request);
			// response.getWriter().print(getFileName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * 修改refNum
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateRefNumById")
	public Map<String, Object> updateRefNumById(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		attachmentService.updateRefNumById(request);
		map.put("entity", "");
		return map;
	}

	/**
	 * 获取请求参数并设置ModelMap
	 * 
	 * @param request
	 * @param model
	 */
	public void setPara(HttpServletRequest request, ModelMap model) {
		mode = request.getParameter("mode") != null ? request.getParameter(
				"mode").toString() : mode;
		category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : category;
		uploadLabel = request.getParameter("uploadLabel") != null ? request
				.getParameter("uploadLabel").toString() : "";
		applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : applyTo;
		refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : refNum;
		title = request.getParameter("title") != null ? request.getParameter(
				"title").toString() : title;
		allowExt = request.getParameter("allowExt") != null ? request
				.getParameter("allowExt").toString() : allowExt;
		allowSize = request.getParameter("allowSize") != null ? Long
				.valueOf(request.getParameter("allowSize")) : allowSize;
		destDir = request.getParameter("destDir") != null
				&& request.getParameter("destDir") != "" ? request
				.getParameter("destDir").toString() : destDir;
		model.put("mode", mode);
		model.put("category", category);
		model.put("uploadLabel", uploadLabel);
		model.put("applyTo", applyTo);
		model.put("refNum", String.valueOf(refNum));
		model.put("allowExt", allowExt);
		model.put("allowSize", String.valueOf(allowSize));
		model.put("destDir", destDir);
	}

	/**
	 * 文件下载
	 * 
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("download")
	public ResponseEntity<byte[]> download() throws IOException {
		String path = request.getParameter("filePath") != null ? request
				.getParameter("filePath").toString() : "";
		String fileName = request.getParameter("fileName") != null ? request
				.getParameter("fileName").toString() : "";
		File file = new File(path);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		// 判断文件是否存在，不存在则返回一个文件名和内容都是“文件不存在”的文件
		if (file.exists()) {
			fileName = processFileName(request,file.getName());
			headers.setContentDispositionFormData("attachment", fileName);
			return new ResponseEntity<byte[]>(
					FileUtils.readFileToByteArray(file), headers, HttpStatus.OK);
		}
		fileName = processFileName(request,"文件不存在.txt");
		headers.setContentDispositionFormData("attachment", fileName);
		return new ResponseEntity<byte[]>("文件不存在".getBytes(), headers,
				HttpStatus.OK);
	}

	/**
	 * ie,chrom,firfox下处理文件名显示乱码
	 * 
	 * @param request
	 * @param fileNames
	 * @return
	 */
	public static String processFileName(HttpServletRequest request,
			String fileNames) {
		String codedfilename = null;
		try {
			String agent = request.getHeader("USER-AGENT");
			if (null != agent && -1 != agent.indexOf("MSIE") || null != agent
					&& -1 != agent.indexOf("Trident")) {// ie

				String name = java.net.URLEncoder.encode(fileNames, "UTF8");

				codedfilename = name;
			} else if (null != agent && -1 != agent.indexOf("Mozilla")) {// 火狐,chrome等

				codedfilename = new String(fileNames.getBytes("UTF-8"),
						"iso-8859-1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return codedfilename;
	}

}
