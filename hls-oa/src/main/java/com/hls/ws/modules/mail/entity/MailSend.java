/**
 * 
 */
package com.hls.ws.modules.mail.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.lq.work.common.persistence.DataEntity;

/**
 * 邮件发送Entity
 * @author lq
 * @version 2016-05-07
 */
public class MailSend extends DataEntity<MailSend> {
	
	private static final long serialVersionUID = 1L;
	private String mailId;		// 邮件主键
	private String sendId;		// 发送者ID
	private String isDel;		// 是否删除
	private Date sendDate;		// 发送时间
	
	public MailSend() {
		super();
	}

	public MailSend(String id){
		super(id);
	}

	@Length(min=1, max=64, message="邮件主键长度必须介于 1 和 64 之间")
	public String getMailId() {
		return mailId;
	}

	public void setMailId(String mailId) {
		this.mailId = mailId;
	}
	
	@Length(min=1, max=64, message="发送者ID长度必须介于 1 和 64 之间")
	public String getSendId() {
		return sendId;
	}

	public void setSendId(String sendId) {
		this.sendId = sendId;
	}
	
	@Length(min=1, max=1, message="是否删除长度必须介于 1 和 1 之间")
	public String getIsDel() {
		return isDel;
	}

	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="发送时间不能为空")
	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	
}