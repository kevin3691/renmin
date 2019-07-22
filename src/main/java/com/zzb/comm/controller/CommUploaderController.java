package com.zzb.comm.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zzb.comm.entity.CommAttachment;
import com.zzb.comm.service.CommAttachmentService;
import com.zzb.comm.service.CommUploaderService;

@Controller
@RequestMapping("/comm/uploader")
public class CommUploaderController {
	@Resource
	private CommUploaderService commUploaderService;
	
	@Resource
	private CommAttachmentService attService;

	/**
	 * 
	 */
	public CommUploaderController() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * View 简单上传页 upload
	 * 
	 * @return
	 */
	@RequestMapping(value = "/upload")
	private String upload() {
		return "/comm/uploader/upload";
	}

	/**
	 * View 预览上传页 preUpload
	 * 
	 * @return
	 */
	@RequestMapping(value = "/preUpload")
	private String preUpload() {
		return "/comm/uploader/preUpload";
	}

	/**
	 * View 图片裁剪上传页 corpUpload
	 * 
	 * @return
	 */
	@RequestMapping(value = "/cropUpload")
	private String cropUpload() {
		return "/comm/uploader/cropUpload";
	}

	@ResponseBody
	@RequestMapping("/uploader")
	public Map<String, Object> uploader(
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) {
		CommAttachment att = new CommAttachment();
		try {
			att = commUploaderService.upload(file, request);
			// response.getWriter().print(getFileName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("CommAttachemnt", att);
		return map;
	}

	/**
	 * 另存图片并加水印
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	@ResponseBody
	@RequestMapping("/saveAs")
	public Map<String, Object> saveAs(HttpServletRequest request)
			throws FileNotFoundException, IOException {
		String url = request.getParameter("url")!=null?request.getParameter("url"):"";
		String path = request.getContextPath();
		url = url.replace(path,"");
		commUploaderService.waterMark(url,request);
		commUploaderService.saveAs(url,request);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("IsSuccess", true);
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/updateRefNum")
	public Map<String, Object> updateRefNum(HttpServletRequest request)
			throws FileNotFoundException, IOException {
		int id = request.getParameter("id")!=null?Integer.valueOf(request.getParameter("id")):-1;
		int refNum = request.getParameter("refNum")!=null?Integer.valueOf(request.getParameter("refNum")):-1;
		CommAttachment att = attService.dtl(id);
		att.setRefNum(refNum);
		att = attService.save(att, request);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("IsSuccess", true);
		return map;
	}
}
