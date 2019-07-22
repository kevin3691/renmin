package com.zzb.base.entity;

import org.apache.poi.poifs.property.Child;

import javax.persistence.Embeddable;
import java.util.List;

@Embeddable
public class Children {
    private String title;
    private String href;
    private Boolean isCurrent;
    private List<Children> children;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public Boolean getCurrent() {
        return isCurrent;
    }

    public void setCurrent(Boolean current) {
        isCurrent = current;
    }

    public List<Children> getChildren() {
        return children;
    }

    public void setChildren(List<Children> children) {
        this.children = children;
    }
}
