package com.zzb.core.baseclass;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class BaseDao<T> {
	@Resource
	protected SessionFactory sessionFactory;

	/**
	 * 创建一个Class的对象来获取泛型的class
	 */
	private Class<?> entityClass;

	public Class<?> getEntityClass() {
		if (entityClass == null) {
			// 获取泛型的Class对象
			entityClass = ((Class<?>) (((ParameterizedType) (this.getClass().getGenericSuperclass()))
					.getActualTypeArguments()[0]));
		}
		return entityClass;
	}

	/**
	 * 构造方法，根据实例类自动获取实体类类型
	 */
	public BaseDao() {
		if (entityClass == null) {
			Type type = getClass().getGenericSuperclass();
			Type trueType = ((ParameterizedType) type).getActualTypeArguments()[0];
			this.entityClass = (Class<?>) trueType;
		}
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	/**
	 * 数据库同步
	 */
	public void flush() {
		getSession().flush();
	}

	/**
	 * 清除缓存
	 */
	public void clear() {
		getSession().clear();
	}

	/**
	 * 执行更新
	 * 
	 * @param hql
	 */
	public void executeUpdate(String hql) {
		executeUpdate(hql, null);
	}

	/**
	 * 
	 * @param hql
	 */
	public void executeUpdate(String hql, List<Object> args) {
		executeUpdate(hql, args, null);
	}

	/**
	 * 执行更新
	 * 
	 * @param hql
	 * @param args
	 * @param alias
	 */
	public void executeUpdate(String hql, List<Object> args, Map<String, Object> alias) {
		Query query = getSession().createQuery(hql);
		setParameter(query, args);
		setAliasParameter(query, alias);
		query.executeUpdate();
		flush();
	}

	/**
	 * 返回唯一值
	 * 
	 * @param hql
	 * @return
	 */
	public Object uniqueResult(String hql) {
		return uniqueResult(hql, null);
	}

	/**
	 * 
	 * @param hql
	 * @param args
	 * @return
	 */
	public Object uniqueResult(String hql, List<Object> args) {
		return uniqueResult(hql, args, null);
	}

	/**
	 * 返回唯一值
	 * 
	 * @param hql
	 * @param args
	 * @return
	 */
	public Object uniqueResult(String hql, List<Object> args, Map<String, Object> alias) {
		Query query = getSession().createQuery(hql);
		query.setFirstResult(0);
		query.setMaxResults(1);
		setParameter(query, args);
		setAliasParameter(query, alias);
		return query.uniqueResult();
	}

	/**
	 * 返回Object对象列表
	 * 
	 * @param hql
	 * @return
	 */
	public List<Object> excuteQuery(String hql) {
		return excuteQuery(hql, null);
	}

	/**
	 * 返回Object对象列表
	 * 
	 * @param hql
	 * @param args
	 * @return
	 */
	public List<Object> excuteQuery(String hql, List<Object> args) {
		return excuteQuery(hql, args, null);
	}

	/**
	 * 返回Object对象列表
	 * 
	 * @param hql
	 * @param args
	 * @return
	 */
	public List<Object> excuteQuery(String hql, List<Object> args, Map<String, Object> alias) {
		Query query = getSession().createQuery(hql);
		setParameter(query, args);
		setAliasParameter(query, alias);
		return query.list();
	}

	/**
	 * 返回Object对象列表
	 * 
	 * @param hql
	 * @return
	 */
	public List<Object> excuteSqlQuery(String hql) {
		return excuteSqlQuery(hql, null);
	}

	/**
	 * 返回Object对象列表
	 * 
	 * @param hql
	 * @param args
	 * @return
	 */
	public List<Object> excuteSqlQuery(String hql, List<Object> args) {
		return excuteSqlQuery(hql, args, null);
	}

	/**
	 * 返回Object对象列表
	 * 
	 * @param hql
	 * @param args
	 * @return
	 */
	public List<Object> excuteSqlQuery(String hql, List<Object> args, Map<String, Object> alias) {
		Query query = getSession().createSQLQuery(hql);
		setParameter(query, args);
		setAliasParameter(query, alias);
		return query.list();
	}

	/**
	 * 返回指定类型列表
	 * 
	 * @param hql
	 * @return
	 */
	public List<T> list(String hql) {
		return list(hql, null);
	}

	/**
	 * 返回指定类型列表
	 * 
	 * @param hql
	 * @param args
	 * @return
	 */
	public List<T> list(String hql, List<Object> args) {
		return list(hql, args, null);
	}

	/**
	 * 返回指定类型列表
	 * 
	 * @param hql
	 * @param args
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<T> list(String hql, List<Object> args, Map<String, Object> alias) {
		Query query = getSession().createQuery(hql);
		setParameter(query, args);
		setAliasParameter(query, alias);
		List<T> rows = query.list();
		return rows;
	}

	/**
	 * 查询
	 * 
	 * @param para
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public QueryResult<Object> unionList(QueryPara qp) {
		String hql = qp.getHql();
		String chql = getCountHql(hql);

		hql = initSort(hql, qp.getOrderBy(), qp.getOrderDirection());
		Query cquery = getSession().createQuery(chql);
		Query query = getSession().createQuery(hql);
		// 设置别名参数
		setAliasParameter(cquery, qp.getAlias());
		setAliasParameter(query, qp.getAlias());
		// 设置参数
		setParameter(query, qp.getArgs());
		setParameter(cquery, qp.getArgs());
		long total = (Long) cquery.uniqueResult();

		long totalPage = 0;
		int index = qp.getPageIndex();
		int size = qp.getPageSize();
		if (index > 0 & size > 0) {
			totalPage = total % size == 0 ? total / size : total / size + 1;
			int first = (index - 1) * size;
			// 最后一页时，设置pageSize为所剩记录数
			if (index == (int) totalPage) {
				size = (int) total % size;
			}
			// 设置分页
			setPager(query, first, size);
		}

		List<Object> rows = query.list();

		QueryResult<Object> rslt = new QueryResult<Object>();
		rslt.setTotal(totalPage);
		rslt.setRows(rows);
		return rslt;
	}

	/**
	 * sql联表查询 带分组
	 * 
	 * @param para
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public QueryResult<Object> sqlUnionGList(QueryPara qp) {
		String hql = qp.getHql();
		String chql = getCountHql(hql);

		hql = initSort(hql, qp.getOrderBy(), qp.getOrderDirection());
		Query cquery = getSession().createSQLQuery(chql);
		Query query = getSession().createSQLQuery(hql);
		// 设置参数
		setParameter(query, qp.getArgs());
		setParameter(cquery, qp.getArgs());
		long total = Long.valueOf(cquery.uniqueResult().toString());

		long totalPage = 0;
		int index = qp.getPageIndex();
		int size = qp.getPageSize();
		if (index > 0 & size > 0) {
			totalPage = total % size == 0 ? total / size : total / size + 1;
			int first = (index - 1) * size;
			// 最后一页时，设置pageSize为所剩记录数
			if (index == (int) totalPage) {
				size = (int) total % size;
				if (size == 0) {
					size = qp.getPageSize();
				}
			}
			// 设置分页
			setPager(query, first, size);
		}

		List<Object> rows = query.list();

		QueryResult<Object> rslt = new QueryResult<Object>();
		rslt.setRecords(total);
		rslt.setTotal(totalPage);
		rslt.setRows(rows);
		return rslt;
	}

	/**
	 * 查询
	 * 
	 * @param para
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public QueryResult<T> list(QueryPara qp) {
		String ename = getEntityClass().getSimpleName();
		String hql = qp.getHql();
		// 如果hql为空，则生成默认语句
		hql = hql == null || hql.equals("") ? "FROM " + ename : hql;
		String chql = getCountHql(hql);

		hql = initSort(hql, qp.getOrderBy(), qp.getOrderDirection());
		Query cquery = getSession().createQuery(chql);
		Query query = getSession().createQuery(hql);
		// 设置别名参数
		setAliasParameter(cquery, qp.getAlias());
		setAliasParameter(query, qp.getAlias());
		// 设置参数
		setParameter(query, qp.getArgs());
		setParameter(cquery, qp.getArgs());
		long total = (Long) cquery.uniqueResult();

		long totalPage = 0;
		int index = qp.getPageIndex();
		int size = qp.getPageSize();
		if (index > 0 & size > 0) {
			totalPage = total % size == 0 ? total / size : total / size + 1;
			int first = (index - 1) * size;
			// 最后一页时，设置pageSize为所剩记录数
			if (index == (int) totalPage) {
				size = (int) total % size;
				if (size == 0) {
					size = qp.getPageSize();
				}
			}
			// 设置分页
			setPager(query, first, size);
		}

		List<T> rows = query.list();

		QueryResult<T> rslt = new QueryResult<T>();
		rslt.setRecords(total);
		rslt.setTotal(totalPage);
		rslt.setRows(rows);
		return rslt;
	}
	
	
	@SuppressWarnings("unchecked")
	public QueryResult<T> list4(QueryPara qp) {
		String ename = getEntityClass().getSimpleName();
		String hql = qp.getHql();
		// 如果hql为空，则生成默认语句
		hql = hql == null || hql.equals("") ? "FROM " + ename : hql;
		String chql = getCountHql(hql);

		hql = initSort(hql, qp.getOrderBy(), qp.getOrderDirection());
		Query cquery = getSession().createQuery(chql);
		Query query = getSession().createQuery(hql);
		// 设置别名参数
		setAliasParameter(cquery, qp.getAlias());
		setAliasParameter(query, qp.getAlias());
		// 设置参数
		setParameter(query, qp.getArgs());
		setParameter(cquery, qp.getArgs());
		long total = (Long) cquery.uniqueResult();

		long totalPage = 0;
		
		List<T> rows = query.list();

		QueryResult<T> rslt = new QueryResult<T>();
		rslt.setRecords(total);
		rslt.setTotal(totalPage);
		rslt.setRows(rows);
		return rslt;
	}
	
	@SuppressWarnings("unchecked")
	public QueryResult<T> listNoTotal(QueryPara qp) {
		String ename = getEntityClass().getSimpleName();
		String hql = qp.getHql();
		// 如果hql为空，则生成默认语句
		hql = hql == null || hql.equals("") ? "FROM " + ename : hql;
		String chql = getCountHql(hql);

		hql = initSort(hql, qp.getOrderBy(), qp.getOrderDirection());
		Query cquery = getSession().createQuery(chql);
		Query query = getSession().createQuery(hql);
		// 设置别名参数
		setAliasParameter(cquery, qp.getAlias());
		setAliasParameter(query, qp.getAlias());
		// 设置参数
		setParameter(query, qp.getArgs());
		setParameter(cquery, qp.getArgs());
		//long total = (Long) cquery.uniqueResult();

		long totalPage = 0;
		
		List<T> rows = query.list();

		QueryResult<T> rslt = new QueryResult<T>();
		//rslt.setRecords(total);
		rslt.setTotal(totalPage);
		rslt.setRows(rows);
		return rslt;
	}
	
	
	
	@SuppressWarnings("unchecked")
	public List<Object[]> list4Object(QueryPara qp) {
		String ename = getEntityClass().getSimpleName();
		String hql = qp.getHql();
		// 如果hql为空，则生成默认语句
		hql = hql == null || hql.equals("") ? "FROM " + ename : hql;
		String chql = getCountHql(hql);

		hql = initSort(hql, qp.getOrderBy(), qp.getOrderDirection());
		Query cquery = getSession().createQuery(chql);
		Query query = getSession().createQuery(hql);
		// 设置别名参数
		setAliasParameter(cquery, qp.getAlias());
		setAliasParameter(query, qp.getAlias());
		// 设置参数
		setParameter(query, qp.getArgs());
		setParameter(cquery, qp.getArgs());
		long total = (Long) cquery.uniqueResult();

		long totalPage = 0;
		
		List<Object[]> rows = query.list();

		return rows;
	}

	/**
	 * 添加、更新
	 * 
	 * @param entity
	 * @return
	 */
	public T save(T entity) {
		getSession().saveOrUpdate(entity);
		flush();
		return entity;
	}

	/**
	 * 获取实体 根据id
	 * 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public T dtl(int id) {
		return (T) getSession().get(entityClass, id);
	}

	/**
	 * 获取实体 根据hql及参数
	 * 
	 * @param hql
	 * @param args
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public T dtl(String hql, List<Object> args) {
		Query query = getSession().createQuery(hql);
		setParameter(query, args);
		query.setMaxResults(1);
		List<T> rslt = query.list();
		System.out.println("##########rslt.size" + rslt.size());
		if (rslt.size() > 0) {
			return rslt.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 删除
	 * 
	 * @param id
	 */
	public void delete(int id) {
		del(id);
	}

	/**
	 * 根据id删除
	 * 
	 * @param id
	 */
	public void del(int id) {
		getSession().delete(this.dtl(id));
		flush();
	}

	/**
	 * 删除多条记录，ids("1,2,3")
	 * 
	 * @param ids
	 */
	public void del(String ids) {
		String ename = getEntityClass().getSimpleName();
		String[] idar = ids.split(",");
		String hql = "DELETE " + ename + " WHERE id IN (:ids)";
		Query query = getSession().createQuery(hql);
		query.setParameterList("ids", idar);
		query.executeUpdate();
		flush();
	}

	/**
	 * 根据实体对象删除
	 * 
	 * @param entity
	 */
	public void del(T entity) {
		getSession().delete(entity);
		flush();
	}

	/**
	 * 树节点删除
	 * 
	 * @param id
	 */
	public void delTree(int id) {
		String ename = getEntityClass().getSimpleName();
		// 查询父节id
		String hql = "SELECT baseTree.parentId FROM " + ename + " WHERE id = :id";
		Query query = getSession().createQuery(hql);
		query.setParameter("id", id);
		int pid = (int) query.uniqueResult();

		// 删除当前及其下节点
		hql = "DELETE " + ename + " WHERE id = :id OR baseTree.path LIKE :path";
		query = getSession().createQuery(hql);
		query.setParameter("id", id);
		query.setParameter("path", '%' + String.valueOf(id) + '%');
		query.executeUpdate();
		// 设置父节点isLeaf
		setLeaf(pid);
	}

	/**
	 * 排序
	 * 
	 * @param id
	 * @param order
	 */
	public void sort(int id, String order) {
		String ename = getEntityClass().getSimpleName();
		String hql = "SELECT lineNo FROM " + ename + " WHERE id=?";
		Query query = getSession().createQuery(hql);
		query.setParameter(0, id);
		int lineno = (int) query.uniqueResult();
		if (order.equals("up")) {
			hql = "SELECT id,lineNo FROM " + ename + " WHERE lineNo < ? ORDER BY lineNo DESC";
		} else {
			hql = "SELECT id,lineNo FROM " + ename + " WHERE lineNo > ? ORDER BY lineNo ASC";
		}
		query = getSession().createQuery(hql);
		query.setParameter(0, lineno);

		query.setFirstResult(0);
		query.setMaxResults(1);
		Object[] obj = (Object[]) query.uniqueResult();
		if (obj != null) {
			int did = (int) obj[0];
			int dlineno = (int) obj[1];
			hql = "UPDATE " + ename + " SET lineNo=? WHERE id=?";
			query = getSession().createQuery(hql);
			query.setParameter(0, dlineno);
			query.setParameter(1, id);
			query.executeUpdate();

			hql = "UPDATE " + ename + " SET lineNo=? WHERE id=?";
			query = getSession().createQuery(hql);
			query.setParameter(0, lineno);
			query.setParameter(1, did);
			query.executeUpdate();
		}
	}

	/**
	 * 排序
	 * 
	 * @param id
	 * @param order
	 */
	public void sort(int id, String order, String wc, List<Object> args) {
		String ename = getEntityClass().getSimpleName();
		String hql = "SELECT lineNo FROM " + ename + " WHERE id=?";
		Query query = getSession().createQuery(hql);
		query.setParameter(0, id);
		int lineno = (int) query.uniqueResult();
		if (order.equals("up")) {
			hql = "SELECT id,lineNo FROM " + ename + " WHERE lineNo <  ? " + wc + " ORDER BY lineNo DESC";
		} else {
			hql = "SELECT id,lineNo FROM " + ename + " WHERE lineNo > ?" + wc + " ORDER  BY lineNo ASC";
		}
		query = getSession().createQuery(hql);
		query.setParameter(0, lineno);
		for (int i = 0; i < args.size(); i++) {
			query.setParameter(i + 1, args.get(i));
		}
		query.setFirstResult(0);
		query.setMaxResults(1);
		Object[] obj = (Object[]) query.uniqueResult();
		if (obj != null) {
			int did = (int) obj[0];
			int dlineno = (int) obj[1];
			hql = "UPDATE " + ename + " SET lineNo=? WHERE id=?";
			query = getSession().createQuery(hql);
			query.setParameter(0, dlineno);
			query.setParameter(1, id);
			query.executeUpdate();

			hql = "UPDATE " + ename + " SET lineNo=? WHERE id=?";
			query = getSession().createQuery(hql);
			query.setParameter(0, lineno);
			query.setParameter(1, did);
			query.executeUpdate();
		}
	}

	/**
	 * 排序(树同级节点排序)
	 * 
	 * @param id
	 * @param order
	 */
	@SuppressWarnings("unchecked")
	public void sortTree(int id, String order) {
		String ename = getEntityClass().getSimpleName();
		String hql = "SELECT lineNo,baseTree.parentId FROM " + ename + " WHERE id=?";
		Query query = getSession().createQuery(hql);
		query.setParameter(0, id);
		Object[] obj = (Object[]) query.uniqueResult();
		int lineno = (int) obj[0];
		int pid = (int) obj[1];

		if (order.equals("up")) {
			hql = "SELECT id,lineNo FROM " + ename + " WHERE baseTree.parentId=? AND lineNo < " + lineno
					+ " ORDER BY lineNo DESC";
		} else {
			hql = "SELECT id,lineNo FROM " + ename + " WHERE  baseTree.parentId=? AND  lineNo > " + lineno
					+ " ORDER BY lineNo ASC";
		}
		query = getSession().createQuery(hql);
		query.setParameter(0, pid);
		query.setFirstResult(0);
		query.setMaxResults(1);
		obj = (Object[]) query.uniqueResult();
		if (obj != null) {
			int did = (int) obj[0];
			int dlineno = (int) obj[1];
			hql = "UPDATE " + ename + " SET lineNo=? WHERE id=?";
			query = getSession().createQuery(hql);
			query.setParameter(0, dlineno);
			query.setParameter(1, id);
			query.executeUpdate();

			hql = "UPDATE " + ename + " SET lineNo=? WHERE id=?";
			query = getSession().createQuery(hql);
			query.setParameter(0, lineno);
			query.setParameter(1, did);
			query.executeUpdate();
		}
	}

	/**
	 * 设置叶子节点属性 (仅Tree适用)
	 * 
	 * @param id
	 */
	public void setLeaf(int id) {
		String ename = getEntityClass().getSimpleName();
		String hql = "SELECT COUNT(*) FROM " + ename + " WHERE baseTree.parentId = ?";
		Query query = getSession().createQuery(hql);
		query.setParameter(0, id);
		long cnt = (long) query.uniqueResult();
		int isLeaf = cnt > 0 ? 0 : 1;
		hql = "UPDATE " + ename + " SET baseTree.isLeaf = ? WHERE id = ?";
		query = getSession().createQuery(hql);
		query.setParameter(0, isLeaf);
		query.setParameter(1, id);
		query.executeUpdate();
	}

	/**
	 * 初始化排序
	 * 
	 * @param hql
	 * @param orderby
	 * @param direction
	 * @return
	 */
	private String initSort(String hql, String orderby, String direction) {
		direction = direction == "" ? "asc" : direction;
		if (orderby != null && !"".equals(orderby.trim())) {
			if (orderby.indexOf(",") >= 0) {
				// 多个属性排序
				String[] ar = orderby.split(",");
				String order = "";
				for (String s : ar) {
					if (s.toLowerCase().indexOf("asc") >= 0
							|| s.toLowerCase().indexOf("desc") >= 0) {
						order += "," + s;
					} else {
						order += "," + s + " " + direction;
						;
					}
				}
				order = order.substring(1);
				hql += " ORDER BY " + order;
				
			} else {
				// 只根据一个属性排序
				hql += " ORDER BY " + orderby + " " + direction;
			}

		}
		return hql;
	}

	/**
	 * 获取查询记录总数HQL
	 * 
	 * @param hql
	 * @param isHql
	 * @return
	 */
	private String getCountHql(String hql) {
		if (hql.toUpperCase().indexOf("FROM") >= 0) {
			hql = hql.substring(hql.toUpperCase().indexOf("FROM"));
		}
		hql = "SELECT COUNT(*) " + hql;
		if (hql.toUpperCase().indexOf("FETCH") >= 0)
			hql = hql.replaceAll("fetch", "");
		return hql;
	}

	/**
	 * 设置别名参数
	 * 
	 * @param query
	 * @param alias
	 */
	@SuppressWarnings("rawtypes")
	private void setAliasParameter(Query query, Map<String, Object> alias) {
		if (alias != null) {
			Set<String> keys = alias.keySet();
			for (String key : keys) {
				Object val = alias.get(key);
				if (val instanceof Collection) {
					// 查询条件是列表
					query.setParameterList(key, (Collection) val);
				} else if (val instanceof Object[]) {
					query.setParameterList(key, (Object[]) val);
				} else {
					query.setParameter(key, val);
				}
			}
		}
	}

	/**
	 * 设置HQL参数
	 * 
	 * @param query
	 * @param args
	 */
	private void setParameter(Query query, List<Object> args) {
		if (args != null && args.size() > 0) {
			int index = 0;
			for (Object arg : args) {
				query.setParameter(index++, arg);
			}
		}
	}

	/**
	 * 设置分页
	 * 
	 * @param query
	 * @param index
	 * @param size
	 */
	private void setPager(Query query, int first, int max) {
		if (first >= 0 && max > 0) {
			query.setFirstResult(first).setMaxResults(max);
		}
	}

	/**
	 * 返回实参类型是否包含属性
	 * 
	 * @param fieldname
	 * @return
	 */
	@SuppressWarnings("unused")
	private boolean hasField(String fieldname) {
		Field[] fields = getEntityClass().getDeclaredFields();
		for (Field f : fields) {
			if (f.getName().equals(fieldname)) {
				return true;
			}
		}
		return false;
	}

}
