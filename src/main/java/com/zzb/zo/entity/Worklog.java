package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;
import java.util.Date;

@Entity
public class Worklog  extends BaseEntity<Worklog> {
    private int personIdi;
    private String personi;
    private int orgIdi;
    private String orgi;
    private Date makedayi;
    private int statusi;
    private Date startdatei;
    private Date finishdatei;
    private String starttimei;
    private String finishtimei;
    private String titlei;
    private int repeateri;
    private int roundi;
    private int leveli;
    private String typei;
    private String contenti;
    private String descri;// 备注

    public int getPersonIdi() {
        return personIdi;
    }

    public void setPersonIdi(int personIdi) {
        this.personIdi = personIdi;
    }

    public String getPersoni() {
        return personi;
    }

    public void setPersoni(String personi) {
        this.personi = personi;
    }

    public int getOrgIdi() {
        return orgIdi;
    }

    public void setOrgIdi(int orgIdi) {
        this.orgIdi = orgIdi;
    }

    public String getOrgi() {
        return orgi;
    }

    public void setOrgi(String orgi) {
        this.orgi = orgi;
    }

    public Date getMakedayi() {
        return makedayi;
    }

    public void setMakedayi(Date makedayi) {
        this.makedayi = makedayi;
    }

    public int getStatusi() {
        return statusi;
    }

    public void setStatusi(int statusi) {
        this.statusi = statusi;
    }

    public Date getStartdatei() {
        return startdatei;
    }

    public void setStartdatei(Date startdatei) {
        this.startdatei = startdatei;
    }

    public Date getFinishdatei() {
        return finishdatei;
    }

    public void setFinishdatei(Date finishdatei) {
        this.finishdatei = finishdatei;
    }

    public String getStarttimei() {
        return starttimei;
    }

    public void setStarttimei(String starttimei) {
        this.starttimei = starttimei;
    }

    public String getFinishtimei() {
        return finishtimei;
    }

    public void setFinishtimei(String finishtimei) {
        this.finishtimei = finishtimei;
    }

    public String getTitlei() {
        return titlei;
    }

    public void setTitlei(String titlei) {
        this.titlei = titlei;
    }

    public int getRepeateri() {
        return repeateri;
    }

    public void setRepeateri(int repeateri) {
        this.repeateri = repeateri;
    }

    public int getRoundi() {
        return roundi;
    }

    public void setRoundi(int roundi) {
        this.roundi = roundi;
    }

    public int getLeveli() {
        return leveli;
    }

    public void setLeveli(int leveli) {
        this.leveli = leveli;
    }

    public String getTypei() {
        return typei;
    }

    public void setTypei(String typei) {
        this.typei = typei;
    }

    public String getContenti() {
        return contenti;
    }

    public void setContenti(String contenti) {
        this.contenti = contenti;
    }

    public String getDescri() {
        return descri;
    }

    public void setDescri(String descri) {
        this.descri = descri;
    }
}