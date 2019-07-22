package com.zzb.comm.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.zzb.comm.entity.CommAttachment;
import com.zzb.core.baseclass.BaseService;
import com.zzb.core.utils.ImageRemarkUtil;
import com.zzb.core.utils.PicWatermark;
import com.zzb.core.utils.SiteConfig;

@Transactional
@Service("commUploaderService")
public class CommUploaderService extends BaseService<CommAttachment> {
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

	/**
	 * 上传文件
	 * 
	 * @param file
	 * @param destDir
	 * @param request
	 * @throws Exception
	 */
	public CommAttachment upload(MultipartFile file, HttpServletRequest request)
			throws Exception {
		String category = request.getParameter("category") != null ? request
				.getParameter("category").toString() : "";
		String title = request.getParameter("title") != null ? request
				.getParameter("title").toString() : "";
		String share = request.getParameter("share") != null ? request
				.getParameter("share").toString() : "共享";
		String applyTo = request.getParameter("applyTo") != null ? request
				.getParameter("applyTo").toString() : "";
		int refNum = request.getParameter("refNum") != null ? Integer
				.valueOf(request.getParameter("refNum")) : 0;
		allowSuffix = request.getParameter("allowExt") != null ? request
				.getParameter("allowExt").toString() : allowSuffix;
		allowSize = request.getParameter("allowSize") != null ? Long
				.valueOf(request.getParameter("allowSize")) : allowSize;
		destDir = request.getParameter("destDir") != null ? request
				.getParameter("destDir").toString() : destDir;
		CommAttachment att = new CommAttachment();
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path;
		try {
			String suffix = file.getOriginalFilename().substring(
					file.getOriginalFilename().lastIndexOf(".") + 1);
			String fn = file.getOriginalFilename().substring(0,
					file.getOriginalFilename().lastIndexOf("."));
			int length = getAllowSuffix().indexOf(suffix);
			if (getAllowSuffix().indexOf("*") == -1 && length == -1) {
				throw new Exception("请上传允许格式的文件");
			}
			if (file.getSize() > getAllowSize()) {
				throw new Exception("您上传的文件大小已经超出范围");
			}

			String realPath = request.getSession().getServletContext()
					.getRealPath("/");
			File destFile = new File(realPath + "/" + destDir);
			if (!destFile.exists()) {
				destFile.mkdirs();
			}

			String fndt = genFileName();
			
			String newFileName = fn + "_" + fndt + "." + suffix;
			File f = new File(destFile.getAbsoluteFile() + "/" + newFileName);
			file.transferTo(f);
			f.createNewFile();
			//waterMark(destDir + newFileName, request);
			saveAs(destDir + newFileName, request);
			att.setCategory(category);
			att.setApplyTo(applyTo);
			att.setRefNum(refNum);
			att.setFileExt(suffix);
			att.setIcon(getIcon(suffix));
			att.setFilePath(f.getAbsolutePath());
			att.setFileSize(file.getSize());
			att.setFileUrl(destDir + newFileName);
			att.setTitle(fn);
			att.setShare(share);
			if (!title.equals("")) {
				att.setTitle(title);
			}
		} catch (Exception e) {
			throw e;
		}
		return att;
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
	 * 上传文件
	 * 
	 * @param files
	 * @param request
	 * @throws Exception
	 */
	public void uploads(MultipartFile[] files, String destDir,
			HttpServletRequest request) throws Exception {
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path;
		try {
			fileNames = new String[files.length];
			int index = 0;
			for (MultipartFile file : files) {
				String suffix = file.getOriginalFilename().substring(
						file.getOriginalFilename().lastIndexOf(".") + 1);
				String fileName = file.getOriginalFilename().substring(0,
						file.getOriginalFilename().lastIndexOf("."));
				int length = getAllowSuffix().indexOf(suffix);
				if (length == -1) {
					throw new Exception("请上传允许格式的文件");
				}
				if (file.getSize() > getAllowSize()) {
					throw new Exception("您上传的文件大小已经超出范围");
				}
				String realPath = request.getSession().getServletContext()
						.getRealPath("/");
				File destFile = new File(realPath + getDestDir());
				if (!destFile.exists()) {
					destFile.mkdirs();
				}
				fileName = fileName + "_" + genFileName() + "." + suffix;
				File f = new File(destFile.getAbsoluteFile() + "\\" + fileName);
				file.transferTo(f);
				f.createNewFile();
				String fileUrl = SiteConfig.getConfig("UploadSaveAsPath");
				if (fileUrl != "" && fileUrl != null) {
					File ff = new File(fileUrl + "/" + fileName);
					file.transferTo(ff);
					ff.createNewFile();
				}
				fileNames[index++] = basePath + getDestDir() + fileName;
			}
		} catch (Exception e) {
			throw e;
		}
	}

	public void waterMark(String url, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext()
				.getRealPath("/");
		File srcFile = new File(realPath + "/" + url);
		if (!srcFile.exists()) {
			return;
		}
		PicWatermark pw = new PicWatermark("");
		BufferedImage buffimg = pw.loadImageLocal(srcFile.getAbsoluteFile()
				.toString());
		String logoText = SiteConfig.getConfig("WaterText");
		ImageRemarkUtil.markImageByText(buffimg, logoText, srcFile
				.getAbsoluteFile().toString(), srcFile.getAbsoluteFile()
				.toString());
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
}
