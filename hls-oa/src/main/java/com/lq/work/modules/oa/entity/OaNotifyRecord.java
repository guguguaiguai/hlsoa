/**
 * 
 */
package com.lq.work.modules.oa.entity;

import org.hibernate.validator.constraints.Length;

import com.lq.work.common.persistence.DataEntity;
import com.lq.work.modules.sys.entity.User;

import java.util.Date;

/**
 * 通知通告记录Entity
 * 
 * @version 2014-05-16
 */
public class OaNotifyRecord extends DataEntity<OaNotifyRecord> {
	
	private static final long serialVersionUID = 1L;
	private OaNotify oaNotify;		// 通知通告ID
	private User user;		// 接受人
	private String readFlag;		// 阅读标记（0：未读；1：已读）
	private Date readDate;		// 阅读时间
	
	/*阅读情况*/
	private String depId;/*部门主键*/
	private String depName;/*部门名称*/
	private String uname;/*用户名称*/
	private String pm;/*阅读者姓名，查询条件*/
	
	public OaNotifyRecord() {
		super();
	}

	public OaNotifyRecord(OaNotify oaNotify, String depId) {
		super();
		this.oaNotify = oaNotify;
		this.depId = depId;
	}

	public OaNotifyRecord(OaNotify oaNotify, User user, String readFlag,
			Date readDate) {
		super();
		this.oaNotify = oaNotify;
		this.user = user;
		this.readFlag = readFlag;
		this.readDate = readDate;
	}

	public OaNotifyRecord(String id){
		super(id);
	}
	
	public OaNotifyRecord(OaNotify oaNotify){
		this.oaNotify = oaNotify;
	}

	public String getPm() {
		return pm;
	}

	public void setPm(String pm) {
		this.pm = pm;
	}

	public OaNotify getOaNotify() {
		return oaNotify;
	}

	public void setOaNotify(OaNotify oaNotify) {
		this.oaNotify = oaNotify;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=0, max=1, message="阅读标记（0：未读；1：已读）长度必须介于 0 和 1 之间")
	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}
	
	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}

	public String getDepId() {
		return depId;
	}

	public void setDepId(String depId) {
		this.depId = depId;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}
	
}