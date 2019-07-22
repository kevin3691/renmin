package com.zzb.zo.entity;

import com.zzb.core.baseclass.BaseEntity;
import com.zzb.core.baseclass.RecordInfo;

import javax.persistence.Entity;
import java.util.Date;


@Entity
public class DuBan extends BaseEntity<DuBan> {

	private String  title;
	private String dubanren;
	private int dubanrenId;
	private String sym;
	private String source;
	private String type;
	private String template;
	private String fenguanlingdao;
	private String fenguanlingdaoId;
	private String chengbanren;
	private int chengbanrenId;
	private String chengbanchushi;
	private String chengbanchushiId;
	private String xiebanren;
	private String xiebanrenId;
	private String xiebanchushi;
	private String xiebanchushiId;
	private Date starttime;
	private Date finishtime;
	private String content;
	private String category;
	private String colSym;

	private int refNum;
	private int isSms;
	private int isEmail;
	private int warnday;
	private int wardfreq;
	private String miji;
	private String level;
	private Date lixiangtime;

	private int status;
    private String docTypeName;
    private int docTypeId;

	private int isActive;
	private String descr;// 备注
	private int lineNo;// 排序号
	private RecordInfo recordInfo;

    public String getDocTypeName() {
        return docTypeName;
    }

    public void setDocTypeName(String docTypeName) {
        this.docTypeName = docTypeName;
    }

    public int getDocTypeId() {
        return docTypeId;
    }

    public void setDocTypeId(int docTypeId) {
        this.docTypeId = docTypeId;
    }

    public int getRefNum() {
		return refNum;
	}

	public void setRefNum(int refNum) {
		this.refNum = refNum;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getLixiangtime() {
		return lixiangtime;
	}

	public void setLixiangtime(Date lixiangtime) {
		this.lixiangtime = lixiangtime;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getColSym() {
		return colSym;
	}

	public void setColSym(String colSym) {
		this.colSym = colSym;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDubanren() {
		return dubanren;
	}

	public void setDubanren(String dubanren) {
		this.dubanren = dubanren;
	}

	public int getDubanrenId() {
		return dubanrenId;
	}

	public void setDubanrenId(int dubanrenId) {
		this.dubanrenId = dubanrenId;
	}

	public String getSym() {
		return sym;
	}

	public void setSym(String sym) {
		this.sym = sym;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	public String getFenguanlingdao() {
		return fenguanlingdao;
	}

	public void setFenguanlingdao(String fenguanlingdao) {
		this.fenguanlingdao = fenguanlingdao;
	}

	public String getFenguanlingdaoId() {
		return fenguanlingdaoId;
	}

	public void setFenguanlingdaoId(String fenguanlingdaoId) {
		this.fenguanlingdaoId = fenguanlingdaoId;
	}

	public String getChengbanren() {
		return chengbanren;
	}

	public void setChengbanren(String chengbanren) {
		this.chengbanren = chengbanren;
	}

	public int getChengbanrenId() {
		return chengbanrenId;
	}

	public void setChengbanrenId(int chengbanrenId) {
		this.chengbanrenId = chengbanrenId;
	}

	public String getChengbanchushi() {
		return chengbanchushi;
	}

	public void setChengbanchushi(String chengbanchushi) {
		this.chengbanchushi = chengbanchushi;
	}

	public String getChengbanchushiId() {
		return chengbanchushiId;
	}

	public void setChengbanchushiId(String chengbanchushiId) {
		this.chengbanchushiId = chengbanchushiId;
	}

	public String getXiebanren() {
		return xiebanren;
	}

	public void setXiebanren(String xiebanren) {
		this.xiebanren = xiebanren;
	}

	public String getXiebanrenId() {
		return xiebanrenId;
	}

	public void setXiebanrenId(String xiebanrenId) {
		this.xiebanrenId = xiebanrenId;
	}

	public String getXiebanchushi() {
		return xiebanchushi;
	}

	public void setXiebanchushi(String xiebanchushi) {
		this.xiebanchushi = xiebanchushi;
	}

	public String getXiebanchushiId() {
		return xiebanchushiId;
	}

	public void setXiebanchushiId(String xiebanchushiId) {
		this.xiebanchushiId = xiebanchushiId;
	}

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getFinishtime() {
		return finishtime;
	}

	public void setFinishtime(Date finishtime) {
		this.finishtime = finishtime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getIsSms() {
		return isSms;
	}

	public void setIsSms(int isSms) {
		this.isSms = isSms;
	}

	public int getIsEmail() {
		return isEmail;
	}

	public void setIsEmail(int isEmail) {
		this.isEmail = isEmail;
	}

	public int getWarnday() {
		return warnday;
	}

	public void setWarnday(int warnday) {
		this.warnday = warnday;
	}

	public int getWardfreq() {
		return wardfreq;
	}

	public void setWardfreq(int wardfreq) {
		this.wardfreq = wardfreq;
	}

	public String getMiji() {
		return miji;
	}

	public void setMiji(String miji) {
		this.miji = miji;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public int getLineNo() {
		return lineNo;
	}

	public void setLineNo(int lineNo) {
		this.lineNo = lineNo;
	}

	public RecordInfo getRecordInfo() {
		return recordInfo;
	}

	public void setRecordInfo(RecordInfo recordInfo) {
		this.recordInfo = recordInfo;
	}
}
