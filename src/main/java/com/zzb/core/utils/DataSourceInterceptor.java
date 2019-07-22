package com.zzb.core.utils;

import java.lang.reflect.Method;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.reflect.MethodSignature;

import com.zzb.core.annotation.DataSourceKey;
import com.zzb.core.annotation.ReadOnlyKey;

public class DataSourceInterceptor {
	/**
	 * 设置切点数据源
	 * <p>
	 * 调试输出数据源.
	 * </p>
	 *
	 * @param joinPoint
	 *            切点
	 * @param dataSourceKey
	 *            当前数据源键值
	 */
	private void setDataSourceByKey(JoinPoint joinPoint, String dataSourceKey) {
		DataSourceContextHolder.setDataSource(dataSourceKey);
		System.out.println(joinPoint.getTarget().getClass().getSimpleName()
				+ "." + joinPoint.getSignature().getName() + "配置数据源："
				+ DataSourceContextHolder.getDataSource());
	}

	/**
	 * 切换数据源
	 * <p>
	 * 切换优先级由高到底如下；方法上注解DataSourceKey，方法上注解ReadOnlyKey，类上注解DataSourceKey；<br>
	 * 如果未注解，则默认设置写数据源.
	 * </p>
	 *
	 * @param joinPoint
	 *            切点
	 * @see DataSourceKey
	 * @see ReadOnlyKey
	 * @see DbType
	 */
	public void switchDataSource(JoinPoint joinPoint) {
		Class<?> targetClass = joinPoint.getTarget().getClass();
		String methodName = joinPoint.getSignature().getName();

		Method method = ((MethodSignature) joinPoint.getSignature())
				.getMethod();

		try {

			// 如果是桥则要获得实际拦截的method
			if (method.isBridge()) {
				Class[] parameterTypes = ((MethodSignature) joinPoint
						.getSignature()).getMethod().getParameterTypes();
				Object[] args = joinPoint.getArgs();
				for (int i = 0; i < args.length; i++) {
					// 获得泛型类型
					Class genClazz = GenericsUtils
							.getSuperClassGenricType(targetClass);
					// 根据实际参数类型替换parameterType中的类型
					if (args[i].getClass().isAssignableFrom(genClazz)) {
						parameterTypes[i] = genClazz;
					}
				}
				// 获得parameterType参数类型的方法
				method = targetClass.getMethod(methodName, parameterTypes);
			}
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DataSourceKey dataSourceKey = (DataSourceKey) method
				.getAnnotation(DataSourceKey.class);
		if (dataSourceKey != null) {
			setDataSourceByKey(joinPoint, dataSourceKey.dataSourceKey());

		} else {
			setDataSourceByKey(joinPoint, "dataSource");
		}

	}

}
