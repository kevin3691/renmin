/**
 * 
 */
package com.zzb.cms.service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringEscapeUtils;

import com.zzb.cms.dao.CmsNewsDao;
import com.zzb.cms.entity.CmsNews;
import com.zzb.cms.service.CmsNewsService;
import com.zzb.cms.service.ICmsStaticService;
import com.zzb.core.utils.FreeMarkerUtils;
import com.zzb.core.utils.SiteConfig;
import com.zzb.core.utils.StringUtils;

import freemarker.template.Configuration;

/**
 * Implements CmsStaticServiceImpl 静态化处理服务
 * 
 * 
 * @CreatedAt 2016年09月03日
 */
public class CmsStaticServiceImpl implements ICmsStaticService {
	@Resource
	private CmsNewsService cmsNewsService;

	@Resource
	private CmsNewsDao cmsNewsDao;

	private String rootPath = "";
	private String urlPath = "";
	private String webStaticPath = "";
	private Configuration config = null;
	private Map<String, String> colTitleMap = new HashMap<String, String>();

	/**
	 * 构造函数
	 */
	public CmsStaticServiceImpl() {
		// genIndex();
		getRootPath();
		getUrlPath();
		webStaticPath = SiteConfig.getConfig("WebStaticPath");
		webStaticPath = webStaticPath == "" ? "html" : webStaticPath;
		System.out.print("rootPath:" + rootPath);
		System.out.print("urlPath:" + urlPath);
		System.out.print("webStaticPath:" + webStaticPath);
		colTitleMap.put("公司简介", "Introduction");
		colTitleMap.put("典型案例", "Typical case");
		colTitleMap.put("企业招聘", "Enterprise recruitment");
		colTitleMap.put("联系我们", "Contact us");
		colTitleMap.put("站点地图", "Site Map");
		colTitleMap.put("法律声明", "Legal Notices");
		System.out.println("生成静态页构造函数...");
	}

	/**
	 * 分类处理生成静态页
	 */
	@Override
	public boolean handler(Map<String, Object> para) {
		String template = para.get("template").toString();
		String colSym = para.get("colSym").toString();
		String flag = para.containsKey("flag") ? para.get("flag").toString()
				: "";
		System.out.println("##########template:" + template + ",colSym:"
				+ colSym + ",flag:" + flag);
		String templateDir = getRootPath() + "WEB-INF/template";
		FreeMarkerUtils.initConfig(templateDir);
		switch (template) {
		case "单篇文章":
			genNewsArticle(para);
			break;
		case "新闻列表":
			genNewsList(para);
			if (colSym == "lb_PORTAL_CPJFA") {
				genIndex();
			}
			break;
		case "横幅广告":
			genIndex();
			break;
		default:
			break;
		}
		// 生成静态页调用
		switch (flag) {
		case "所有":
			genIndex();
			genNewsArticle(para);
			genAllNewsList();
			break;
		case "首页":
			genIndex();
			break;
		case "新闻列表":
			genAllNewsList();
			break;
		case "单篇文章":
			genNewsArticle(para);
			break;
		default:
			break;
		}
		return true;
	}

	/**
	 * 生成首页
	 */
	@Override
	public boolean genIndex() {
		Map<String, Object> data = new HashMap<>();
		data.put("urlPath", urlPath);
		data.put("webStaticPath", webStaticPath);
		// 首页轮换图片
		String hql = "FROM CmsNews WHERE colSym=? ORDER BY lineNo ASC";
		List<Object> args = new ArrayList<Object>();
		args.add("lb_PORTAL_BANNER");
		List<CmsNews> banners = cmsNewsDao.list(hql, args);
		data.put("banners", banners);

		// 首页产品及方案
		hql = "FROM CmsNews WHERE colSym=? ORDER BY top DESC,publishAt DESC";
		args = new ArrayList<Object>();
		args.add("lb_PORTAL_CPJFA");
		List<CmsNews> products = cmsNewsDao.list(hql, args);
		data.put("products", products);

		String htmlPath = rootPath + ("/html/index.html");
		FreeMarkerUtils.processTemplate("index.ftl", data, htmlPath);
		return true;
	}

	/**
	 * 生成单篇文章
	 * 
	 * @param colSym
	 * @param colTitle
	 * @return
	 */
	public boolean genNewsArticle(Map<String, Object> para) {
		CmsNews news = new CmsNews();
		Map<String, Object> data = new HashMap<>();

		if (para.get("colSym").toString() != "") {
			// 生成指定栏目
			if (para.containsKey("news")) {
				news = (CmsNews) para.get("news");
			} else {
				news = cmsNewsService.dtl(para.get("colSym").toString(), "");
			}
			data.put("urlPath", urlPath);
			data.put("webStaticPath", webStaticPath);
			//设置栏目英文名
			String colEnTitle = "";
			if (colTitleMap.containsKey(news.getColTitle())) {
				colEnTitle = colTitleMap.get(news.getColTitle());
			}
			data.put("colEnTitle", colEnTitle);
			data.put("news", news);
			String htmlPath = getRootPath()
					+ ("/html/" + news.getColSym().toLowerCase().substring(12) + ".html");
			FreeMarkerUtils.processTemplate("article.ftl", data, htmlPath);
		} else {
			// 生成所有栏目
			String hql = "FROM CmsNews WHERE template=?";
			List<Object> args = new ArrayList<Object>();
			args.add("单篇文章");
			List<CmsNews> rows = cmsNewsDao.list(hql, args);
			for (CmsNews row : rows) {
				data.put("urlPath", urlPath);
				data.put("webStaticPath", webStaticPath);
				data.put("news", row);
				//设置栏目英文名
				String colEnTitle = "";
				if (colTitleMap.containsKey(row.getColTitle())) {
					colEnTitle = colTitleMap.get(row.getColTitle());
				}
				data.put("colEnTitle", colEnTitle);
				String htmlPath = getRootPath()
						+ ("/html/"
								+ row.getColSym().toLowerCase().substring(12) + ".html");
				FreeMarkerUtils.processTemplate("article.ftl", data, htmlPath);
			}
		}
		return true;
	}

	/**
	 * 生成所有新闻列表类栏目
	 * 
	 * @return
	 */
	public boolean genAllNewsList() {
		// 查出所有栏目，按栏目生成分页和详细
		String hql = "SELECT sym FROM BaseMenu WHERE template=?";
		List<Object> args = new ArrayList<Object>();
		args.add("新闻列表");
		List<Object> rows = cmsNewsDao.excuteQuery(hql, args);
		for (Object sym : rows) {
			genNewsPager(String.valueOf(sym));
			genNewsPage(String.valueOf(sym));
		}
		return true;
	}

	/**
	 * 生成新闻列表
	 * 
	 * @param colSym
	 * @param colTitle
	 * @return
	 */
	public boolean genNewsList(Map<String, Object> para) {
		CmsNews news = new CmsNews();
		Map<String, Object> data = new HashMap<>();
		data.put("urlPath", urlPath);
		data.put("webStaticPath", webStaticPath);
		if (para.containsKey("news")) {
			news = (CmsNews) para.get("news");
			// 如果状态是审核则生成新闻详细页
			if (news.getStts().equals("已审核")) {
				String path = rootPath
						+ ("html/"
								+ news.getColSym().toLowerCase().substring(12) + "/");
				System.out.println("#######path:" + path);
				checkDirectory(path);
				data.put("news", news);
				String htmlPath = path + "info_" + String.valueOf(news.getId())
						+ ".html";
				FreeMarkerUtils.processTemplate("info.ftl", data, htmlPath);
			}
			// 创建时间==更新时间则为添加，重新生成分页
			if (news.getRecordInfo().getCreatedAt() == news.getRecordInfo()
					.getUpdatedAt()) {
				// 生成分页
				genNewsPager(news.getColSym());
			}
			if (para.containsKey("flag")) {
				// 删除，则重新生成分页
				if (para.get("flag").toString() == "del") {
					genNewsPager(news.getColSym());
				}
			}
		}
		return true;
	}

	/**
	 * 生成新闻分页
	 * 
	 * @param colSym
	 * @return
	 */
	public boolean genNewsPager(String colSym) {
		// 每页记录条数
		int pageSize = 5;
		// 静态页路径
		String path = rootPath + "/html/" + colSym.toLowerCase().substring(12)
				+ "/";
		checkDirectory(path);
		// 获取本栏目所有记录
		String hql = "FROM CmsNews WHERE stts=? AND colSym=?";
		List<Object> args = new ArrayList<Object>();
		args.add("已审核");
		args.add(colSym);
		hql += "  ORDER BY top DESC,publishAt DESC";
		List<CmsNews> list = cmsNewsDao.list(hql, args);
		// 替换模板所需数据
		Map<String, Object> data = new HashMap<>();
		data.put("urlPath", urlPath);
		data.put("webStaticPath", webStaticPath);
		data.put("pageSize", pageSize);
		data.put("pageCount", (list.size()/pageSize)+1);
		List<Object> newslist = new ArrayList<Object>();
		// 第一页
		String htmlPath = path + "index.html";
		// 如果只有一页
		if (list.size() < pageSize) {
			data.put("newslist", newslist);
			data.put("pageIndex", 1);
			FreeMarkerUtils.processTemplate("list.ftl", data, htmlPath);
		} else {
			// 超过一页
			int pageIndex = 1;
			for (int i = 0; i < list.size(); i++) {
				if (i > 0 & i % 5 == 0) {
					pageIndex = Integer.valueOf(i / 5);
					if (pageIndex > 1) {
						htmlPath = path + "index_" + String.valueOf(pageIndex)
								+ ".html";
					}
					data.put("newslist", newslist);
					data.put("pageIndex", pageIndex);
					FreeMarkerUtils.processTemplate("list.ftl", data, htmlPath);
					newslist = new ArrayList<Object>();
				}
				newslist.add(list.get(i));
			}
			// 最后一页
			if (newslist.size() > 0) {
				data.put("newslist", newslist);
				data.put("pageIndex", pageIndex + 1);
				htmlPath = path + "index_" + String.valueOf(pageIndex + 1)
						+ ".html";
				FreeMarkerUtils.processTemplate("list.ftl", data, htmlPath);
				newslist = new ArrayList<Object>();
			}
		}
		return true;
	}

	/**
	 * 重新生成所有新闻
	 * 
	 * @param colSym
	 * @return
	 */
	public boolean genNewsPage(String colSym) {
		String path = rootPath
				+ ("/html/" + colSym.toLowerCase().substring(12) + "/");
		checkDirectory(path);
		String hql = "FROM CmsNews WHERE template=? AND stts=? AND colSym=? ORDER BY top DESC,publishAt DESC";
		List<Object> args = new ArrayList<Object>();
		args.add("新闻列表");
		args.add("已审核");
		args.add(colSym);
		List<CmsNews> list = cmsNewsDao.list(hql, args);
		// 替换模板所需数据
		Map<String, Object> data = new HashMap<>();
		data.put("urlPath", urlPath);
		data.put("webStaticPath", webStaticPath);
		for (int i = 0; i < list.size(); i++) {
			data.put("news", list.get(i));
			String htmlPath = path + "info_"
					+ String.valueOf(list.get(i).getId()) + ".html";
			FreeMarkerUtils.processTemplate("info.ftl", data, htmlPath);
		}
		return true;
	}

	/**
	 * 获取webapp路径
	 * 
	 * @return
	 */
	public String getRootPath() {
		if (rootPath == "") {
			URL url = this.getClass().getResource("/");
			try {
				rootPath = URLDecoder.decode(url.getPath(), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			rootPath = rootPath.substring(0, rootPath.length() - 16);
		}
		return rootPath;
	}

	/**
	 * 获取webapp URL路径
	 * 
	 * @return
	 */
	public String getUrlPath() {
		if (urlPath == "") {
			URL url = this.getClass().getResource("/");
			try {
				urlPath = URLDecoder.decode(url.getPath(), "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			urlPath = urlPath.substring(0, urlPath.indexOf("/WEB-INF"));
			urlPath = urlPath.substring(urlPath.lastIndexOf("/") + 1);
		}
		return urlPath;
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
			file.mkdir();
		} else {
			System.out.println("//目录存在");
		}
	}

}
