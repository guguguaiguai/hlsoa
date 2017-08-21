/**
 * 
 */
package com.hls.ws.modules.mail.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lq.work.common.persistence.DataEntity;
import com.lq.work.modules.sys.entity.User;

/**
 * 邮件接收信息Entity
 * @author lq
 * @version 2016-05-07
 */
public class MailReceive extends DataEntity<MailReceive> {
	
	private static final long serialVersionUID = 1L;
	private User mailReceive;		// 邮件接收者
	private MsgEmail mailId;		// 邮件主键
	private User mailSender;		// 发送者主键
	private String mailState="0";		// 阅读状态 0:未读，1：已读
	private Date readDate;		// 阅读时间
	private String isDel="0";		// 删除标记 0:正常，1：删除
	private Integer fdCount=0;    //当前接收者是否已经下载过附件
	
	public MailReceive() {
		super();
	}

	public MailReceive(String id){
		super(id);
	}

	public MailReceive(MsgEmail mailId) {
		this.mailId = mailId;
	}

	public MailReceive(User mailReceive, MsgEmail mailId) {
		this.mailReceive = mailReceive;
		this.mailId = mailId;
	}

	public MailReceive(String id,User mailReceive, MsgEmail mailId, User mailSender,Date readDate) {
		this.id=id;
		this.mailReceive = mailReceive;
		this.mailId = mailId;
		this.mailSender = mailSender;
		this.readDate = readDate;
	}

	public Integer getFdCount() {
		return fdCount;
	}

	public void setFdCount(Integer fdCount) {
		this.fdCount = fdCount;
	}

	@NotNull(message="请选择邮件接收者")
	public User getMailReceive() {
		return mailReceive;
	}

	public void setMailReceive(User mailReceive) {
		this.mailReceive = mailReceive;
	}
	@NotNull(message="邮件发送失败，Email ID is NULL!")
	public MsgEmail getMailId() {
		return mailId;
	}

	public void setMailId(MsgEmail mailId) {
		this.mailId = mailId;
	}
	@NotNull(message="Email sender is null!")
	public User getMailSender() {
		return mailSender;
	}

	public void setMailSender(User mailSender) {
		this.mailSender = mailSender;
	}

	@Length(min=1, max=1, message="阅读状态长度必须介于 1 和 1 之间")
	public String getMailState() {
		return mailState;
	}

	public void setMailState(String mailState) {
		this.mailState = mailState;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}
	
	@Length(min=1, max=1, message="删除标记长度必须介于 1 和 1 之间")
	public String getIsDel() {
		return isDel;
	}

	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
	/**
	 * 计算发送时间时长,计算当前时间与发送时间超过8小时
	 * **/
	public long getTimeLength(){
		long time = new Date().getTime()-mailId.getCreateDate().getTime();
		long flag=time/(60*60*1000);
		return flag;
		
	}
}