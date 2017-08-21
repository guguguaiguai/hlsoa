/**
 * 
 */
package com.hls.ws.modules.mail.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.hls.ws.modules.attach.entity.FileAttach;
import com.lq.work.common.persistence.DataEntity;
import com.lq.work.common.utils.Collections3;
import com.lq.work.common.utils.IdGen;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.modules.sys.entity.User;

/**
 * 内部邮件Entity
 * @author lq
 * @version 2016-05-07
 */
public class MsgEmail extends DataEntity<MsgEmail> {
	
	private static final long serialVersionUID = 1L;
	private String mailAcceptor;		// 邮件接收者
	private String acceptorNames;		// 接收者姓名
	private String mailTitle;		// 邮件标题
	private String mailContent;		// 邮件内容
	private String fileNames;		// 文件名称
	private String filePath;		// 附件路径
	private String isRemind="0";		// 是否提醒
	private String isSend="0";		// 是否发送，0:发送，1：草稿，2：撤回
	private Date sendDate;		// 发送时间
	private Date draftDate;		// 存稿时间
	private String isDel="0";		// 是否删除,0:正常，1：删除
	private Date beginSendDate;		// 开始 发送时间
	private Date endSendDate;		// 结束 发送时间
	
	private String mailState;//收件箱阅读状态
	private String risDel;//收件箱邮件删除状态
	private List<MailReceive> receive=Lists.newArrayList();//邮件接收者
	private String receiveUser;//邮件接收者JSON
	private List<User> ruser;//邮件接收者
	private String fids;/*附件主键信息*/
	private List<FileAttach> files=Lists.newArrayList();
	
	private Integer fdCount;//当前邮件接收者是否已下载附件，不与数据库对应
	
	public MsgEmail() {
		super();
	}

	public MsgEmail(String id){
		super(id);
	}

	public String getFids() {
		return fids;
	}

	public void setFids(String fids) {
		this.fids = fids;
	}

	public List<FileAttach> getFiles() {
		return files;
	}

	public void setFiles(List<FileAttach> files) {
		this.files = files;
	}

	public Integer getFdCount() {
		return fdCount;
	}

	public void setFdCount(Integer fdCount) {
		this.fdCount = fdCount;
	}

	public List<User> getRuser() {
		return ruser;
	}

	public void setRuser(List<User> ruser) {
		this.ruser = ruser;
	}

	public String getReceiveUser() {
		return receiveUser;
	}

	public void setReceiveUser(String receiveUser) {
		this.receiveUser = receiveUser;
	}

	public String getRisDel() {
		return risDel;
	}

	public void setRisDel(String risDel) {
		this.risDel = risDel;
	}

	public String getMailAcceptor() {
		return mailAcceptor;
	}

	public void setMailAcceptor(String mailAcceptor) {
		this.mailAcceptor = mailAcceptor;
	}
	
	public String getAcceptorNames() {
		return acceptorNames;
	}

	public void setAcceptorNames(String acceptorNames) {
		this.acceptorNames = acceptorNames;
	}
	
	@Length(min=1, max=300, message="请填写邮件主题")
	public String getMailTitle() {
		return mailTitle;
	}

	public void setMailTitle(String mailTitle) {
		this.mailTitle = mailTitle;
	}
	
	public String getMailContent() {
		return mailContent;
	}

	public void setMailContent(String mailContent) {
		this.mailContent = mailContent;
	}
	
	public String getFileNames() {
		return fileNames;
	}

	public void setFileNames(String fileNames) {
		this.fileNames = fileNames;
	}
	
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Length(min=1, max=1, message="是否提醒长度必须介于 1 和 1 之间")
	public String getIsRemind() {
		return isRemind;
	}

	public void setIsRemind(String isRemind) {
		this.isRemind = isRemind;
	}
	
	@Length(min=1, max=1, message="是否发送长度必须介于 1 和 1 之间")
	public String getIsSend() {
		return isSend;
	}

	public void setIsSend(String isSend) {
		this.isSend = isSend;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDraftDate() {
		return draftDate;
	}

	public void setDraftDate(Date draftDate) {
		this.draftDate = draftDate;
	}
	
	@Length(min=1, max=1, message="是否删除,0:正常，1：删除长度必须介于 1 和 1 之间")
	public String getIsDel() {
		return isDel;
	}

	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
	
	public Date getBeginSendDate() {
		return beginSendDate;
	}

	public void setBeginSendDate(Date beginSendDate) {
		this.beginSendDate = beginSendDate;
	}
	
	public Date getEndSendDate() {
		return endSendDate;
	}

	public void setEndSendDate(Date endSendDate) {
		this.endSendDate = endSendDate;
	}
	/**
	 * 获取邮接收者ID
	 * **/
	public String getReceiveIds(){
		return Collections3.extractToString(receive, "mailReceive.id", ",");
	}
	/**
	 * 设置邮件接收者ID
	 * @return
	 */
	public void setReceiveIds(String rids){
		this.receive=Lists.newArrayList();
		for (String id : StringUtils.split(rids, ",")){
			MailReceive mr = new MailReceive(IdGen.uuid(),new User(id),this,getCurrentUser(),new Date());
			this.receive.add(mr);
		}
	}
	/**
	 * 获取邮件接收者Name
	 * @return
	 */
	public String getReceiveNames() {
		return Collections3.extractToString(receive, "mailReceive.name", ",") ;
	}
	
	/**
	 * 设置邮件接收者Name
	 * @return
	 */
	public void setReceiveNames(String oaNotifyRecord) {
		// 什么也不做
	}

	public List<MailReceive> getReceive() {
		return receive;
	}

	public void setReceive(List<MailReceive> receive) {
		this.receive = receive;
	}

	public String getMailState() {
		return mailState;
	}

	public void setMailState(String mailState) {
		this.mailState = mailState;
	}
	
}