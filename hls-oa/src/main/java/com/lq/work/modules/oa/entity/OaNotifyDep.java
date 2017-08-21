/**
 * 
 */
package com.lq.work.modules.oa.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lq.work.common.persistence.DataEntity;
import com.lq.work.modules.sys.entity.Office;

/**
 * 部门公告记录Entity
 * @author lq
 * @version 2016-05-08
 */
public class OaNotifyDep extends DataEntity<OaNotifyDep> {
	
	private static final long serialVersionUID = 1L;
	private Office depId;		// 部门ID
	private String readFlag;		// 阅读标记
	private Date readDate;		// 阅读时间
	private OaNotify notifyId;		// 公告ID
	
	public OaNotifyDep() {
		super();
	}

	public OaNotifyDep(String id){
		super(id);
	}
	
	public OaNotifyDep(OaNotify notifyId) {
		super();
		this.notifyId = notifyId;
	}

	@Length(min=1, max=1, message="阅读标记长度必须介于 1 和 1 之间")
	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}

	public Office getDepId() {
		return depId;
	}

	public void setDepId(Office depId) {
		this.depId = depId;
	}

	public OaNotify getNotifyId() {
		return notifyId;
	}

	public void setNotifyId(OaNotify notifyId) {
		this.notifyId = notifyId;
	}
	
	
}