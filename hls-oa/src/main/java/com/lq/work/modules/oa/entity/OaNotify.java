/**
 * 
 */
package com.lq.work.modules.oa.entity;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.google.common.collect.Lists;
import com.lq.work.common.persistence.DataEntity;
import com.lq.work.common.utils.Collections3;
import com.lq.work.common.utils.IdGen;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.modules.sys.entity.Office;
import com.lq.work.modules.sys.entity.User;

/**
 * 通知通告Entity
 * 
 * @version 2014-05-16
 */
public class OaNotify extends DataEntity<OaNotify> {
	
	private static final long serialVersionUID = 1L;
	private String type;		// 类型
	private String title;		// 标题
	private String content;		// 类型
	private String files;		// 附件
	private String fileName;   //附件名称
	private String status;		// 状态

	private String readNum;		// 已读
	private String unReadNum;	// 未读
	
	private boolean isSelf;		// 是否只查询自己的通知
	
	private String readFlag;	// 本人阅读状态
	private String notifyScope="0"; //公告发布范围,0:全院，1：部门
	private String isBack="0";//是否回退 0：正常，1：回退
	
	private List<OaNotifyRecord> oaNotifyRecordList = Lists.newArrayList();
	private List<OaNotifyDep> oadep = Lists.newArrayList();//部门公告
	
	public OaNotify() {
		super();
	}

	public OaNotify(String id){
		super(id);
	}

	public String getIsBack() {
		return isBack;
	}

	public void setIsBack(String isBack) {
		this.isBack = isBack;
	}

	@Length(min=0, max=200, message="标题长度必须介于 0 和 200 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=1, max=64, message="类型长度必须介于 0 和 64 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=1, message="状态长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=2000, message="附件长度必须介于 0 和 2000 之间")
	public String getFiles() {
		return files;
	}

	public void setFiles(String files) {
		this.files = files;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReadNum() {
		return readNum;
	}

	public void setReadNum(String readNum) {
		this.readNum = readNum;
	}

	public String getUnReadNum() {
		return unReadNum;
	}

	public void setUnReadNum(String unReadNum) {
		this.unReadNum = unReadNum;
	}
	
	public List<OaNotifyRecord> getOaNotifyRecordList() {
		return oaNotifyRecordList;
	}

	public void setOaNotifyRecordList(List<OaNotifyRecord> oaNotifyRecordList) {
		this.oaNotifyRecordList = oaNotifyRecordList;
	}
	/**
	 * 获取通知发送记录部门ID
	 * **/
	public String getOaNotifyDepIds(){
		return Collections3.extractToString(oadep, "depId.id", ",");
	}
	/**
	 * 设置通知发送记录部门ID
	 * @return
	 */
	public void setOaNotifyDepIds(String depIds){
		this.oadep=Lists.newArrayList();
		for (String id : StringUtils.split(depIds, ",")){
			OaNotifyDep entity = new OaNotifyDep();
			entity.setId(IdGen.uuid());
			entity.setNotifyId(this);
			entity.setDepId(new Office(id));
			entity.setReadFlag("0");
			this.oadep.add(entity);
		}
	}
	/**
	 * 获取通知发送记录用户ID
	 * @return
	 */
	public String getOaNotifyRecordIds() {
		return Collections3.extractToString(oaNotifyRecordList, "user.id", ",") ;
	}
	
	/**
	 * 设置通知发送记录用户ID
	 * @return
	 */
	public void setOaNotifyRecordIds(String oaNotifyRecord) {
		this.oaNotifyRecordList = Lists.newArrayList();
		for (String id : StringUtils.split(oaNotifyRecord, ",")){
			OaNotifyRecord entity = new OaNotifyRecord();
			entity.setId(IdGen.uuid());
			entity.setOaNotify(this);
			entity.setUser(new User(id));
			entity.setReadFlag("0");
			this.oaNotifyRecordList.add(entity);
		}
	}

	/**
	 * 获取通知发送记录用户Name
	 * @return
	 */
	public String getOaNotifyRecordNames() {
		return Collections3.extractToString(oaNotifyRecordList, "user.name", ",") ;
	}
	
	/**
	 * 设置通知发送记录用户Name
	 * @return
	 */
	public void setOaNotifyRecordNames(String oaNotifyRecord) {
		// 什么也不做
	}
	/**
	 * 获取通知发送记录部门Name
	 * @return
	 */
	public String getOaNotifyDepNames() {
		return Collections3.extractToString(oadep, "depId.name", ",") ;
	}
	
	/**
	 * 设置通知发送记录部门Name
	 * @return
	 */
	public void setOaNotifyDepNames(String oaNotifyRecord) {
		// 什么也不做
	}

	public boolean isSelf() {
		return isSelf;
	}

	public void setSelf(boolean isSelf) {
		this.isSelf = isSelf;
	}

	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getNotifyScope() {
		return notifyScope;
	}

	public void setNotifyScope(String notifyScope) {
		this.notifyScope = notifyScope;
	}

	public List<OaNotifyDep> getOadep() {
		return oadep;
	}

	public void setOadep(List<OaNotifyDep> oadep) {
		this.oadep = oadep;
	}
	
}