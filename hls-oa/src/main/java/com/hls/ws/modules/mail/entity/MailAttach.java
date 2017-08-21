/**
 * 
 */
package com.hls.ws.modules.mail.entity;

import org.hibernate.validator.constraints.Length;

import com.lq.work.common.persistence.DataEntity;

/**
 * 邮件附件Entity
 * @author lq
 * @version 2016-09-09
 */
public class MailAttach extends DataEntity<MailAttach> {
	
	private static final long serialVersionUID = 1L;
	private String attachId;		// 附件ID
	private String mailId;		// 邮件ID
	
	public MailAttach() {
		super();
	}

	public MailAttach(String id){
		super(id);
	}

	public MailAttach(String attachId, String mailId) {
		this.attachId = attachId;
		this.mailId = mailId;
	}

	@Length(min=1, max=64, message="附件ID长度必须介于 1 和 64 之间")
	public String getAttachId() {
		return attachId;
	}

	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}
	
	@Length(min=1, max=64, message="邮件ID长度必须介于 1 和 64 之间")
	public String getMailId() {
		return mailId;
	}

	public void setMailId(String mailId) {
		this.mailId = mailId;
	}
	
}