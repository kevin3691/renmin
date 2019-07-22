package com.zzb.core.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface DataSourceKey {
    /**
     * 配置数据源键值
     * <p>
     * 默认：dataSource.
     * </p>
     *
     * @return 键值
     */
    String dataSourceKey() default "dataSource";
}
