package com.zzb.base.entity;

import javax.persistence.Embeddable;
import java.util.List;

@Embeddable
public class TopMenu {
    private String title;
    private String icon;
    private Boolean isCurrent;
    private List<Children> menu;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Boolean getCurrent() {
        return isCurrent;
    }

    public void setCurrent(Boolean current) {
        isCurrent = current;
    }

    public List<Children> getMenu() {
        return menu;
    }

    public void setMenu(List<Children> menu) {
        this.menu = menu;
    }
}
