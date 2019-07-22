package com.zzb.base.dao;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.zzb.base.entity.BaseMenu;
import com.zzb.base.entity.BasePower;
import com.zzb.core.baseclass.BaseDao;
import com.zzb.core.baseclass.BaseTree;
import com.zzb.core.baseclass.RecordInfo;
import com.zzb.core.utils.DateUtils;
import com.zzb.core.utils.IPUtils;

@Repository("basePowerDao")
public class BasePowerDao extends BaseDao<BasePower> {
	/**
	 * 从菜单同步生成权限
	 * 
	 * @param flag
	 */
	@SuppressWarnings("unchecked")
	public void syncWithMenu(String flag) {
		// 查询所有菜单，按parentId排序
		String hql = "FROM BaseMenu ORDER BY baseTree.parentId,lineNo";
		Query query = getSession().createQuery(hql);
		List<BaseMenu> menus = query.list();
		// 查询所有权限，按parentId排序
		hql = "FROM BasePower ORDER BY baseTree.parentId";
		query = getSession().createQuery(hql);
		List<BasePower> powers = query.list();

		BasePower power;
		for (BaseMenu menu : menus) {
			power = dtlByMenuId(powers, menu.getId());

			// 如果不是更新，存在则跳过
			if (!flag.equals("add") && power.getId() > 0) {

			} else {
				power.setBaseMenuId(menu.getId());
				power.setBaseMenuSym(menu.getSym());
				power.setBaseMenuTitle(menu.getTitle());
				power.setSym(menu.getSym());
				power.setTitle(menu.getTitle());
				power.setDescr(menu.getDescr());
				power.setIsActive(1);
				BaseTree tree = new BaseTree();
				tree.setIsLeaf(0);
				power.setRecordInfo(GenRecordInfo(power.getRecordInfo(),null));
				
				// 如果非根节点，则需要设置baseTree字段父属性
				if (menu.getBaseTree().getParentId() > 0) {
					// 遍历权限节点找出与菜单父节点对应的权限节点
					BasePower ppower = dtlByMenuId(powers, menu.getBaseTree()
							.getParentId());

					tree.setParentId(ppower.getId());
					String path = ppower.getBaseTree().getPath();
					String pathName = ppower.getBaseTree().getPathName();
					path = path == null || path.equals("") ? "."
							+ String.valueOf(ppower.getId()) + "." : path
							+ String.valueOf(ppower.getId()) + ".";
					pathName = pathName == null || pathName.equals("") ? "."
							+ ppower.getTitle() + "." : pathName
							+ ppower.getTitle() + ".";
					tree.setPath(path);
					tree.setPathName(pathName);
				}
				power.setBaseTree(tree);
				power = this.save(power);
				power.setLineNo(power.getId());
				powers.add(power);
			}
			// 菜单根节点，添加下属权限
			if (menu.getBaseTree().getIsLeaf() == 1) {
				BasePower cpower = new BasePower();
				String[] ar = { ":RO", ":RW", ":DEL" };
				String[] arTitle = { "_浏览", "_编辑", "_删除" };
				for (int i = 0; i < ar.length; i++) {
					cpower = dtlByMenuIdSuffix(powers, menu.getId(),
							power.getSym() + ar[i]);
					if (flag.equals("add") && cpower.getId() > 0) {
						continue;
					}
					cpower.setBaseMenuId(power.getBaseMenuId());
					cpower.setBaseMenuSym(power.getBaseMenuSym());
					cpower.setBaseMenuTitle(power.getBaseMenuTitle());
					cpower.setTitle(power.getTitle() + arTitle[i]);
					cpower.setSym(power.getSym() + ar[i]);
					BaseTree tree = new BaseTree();
					tree.setIsLeaf(1);
					tree.setParentId(power.getId());
					tree.setPath(power.getBaseTree().getPath()
							+ String.valueOf(power.getId()) + ".");
					tree.setPathName(power.getBaseTree().getPathName()
							+ String.valueOf(power.getTitle()) + ".");
					cpower.setBaseTree(tree);
					cpower.setRecordInfo(GenRecordInfo(cpower.getRecordInfo(),null));
					cpower.setIsActive(1);
					cpower = this.save(cpower);
					cpower.setLineNo(cpower.getId());
					powers.add(cpower);
				}
			}
		}
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

	/**
	 * 检查是否存在指定menuid的权限
	 * 
	 * @param powers
	 * @param menuid
	 * @return
	 */
	private BasePower dtlByMenuId(List<BasePower> powers, int menuid) {
		BasePower power = new BasePower();
		for (BasePower p : powers) {
			if (p.getBaseMenuId() == menuid) {
				power = p;
				break;
			}
		}
		return power;
	}

	/**
	 * 检查是否存在指定menuid,suffix的权限
	 * 
	 * @param powers
	 * @param menuid
	 * @param suffix
	 * @return
	 */
	private BasePower dtlByMenuIdSuffix(List<BasePower> powers, int menuid,
			String sym) {
		BasePower power = new BasePower();
		for (BasePower p : powers) {
			if (p.getBaseMenuId() == menuid && p.getSym().equals(sym)) {
				power = p;
				break;
			}
		}
		return power;
	}
}
