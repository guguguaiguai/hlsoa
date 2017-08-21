/**
 * 
 */
package com.hls.ws.modules.mail.entity;

import com.lq.work.modules.sys.entity.User;
import javax.validation.constraints.NotNull;

import com.lq.work.common.persistence.DataEntity;

/**
 * 常用联系人Entity
 * @author lq
 * @version 2016-09-10
 */
public class MailCommon extends DataEntity<MailCommon> {
	
	private static final long serialVersionUID = 1L;
	private User linkUser;		// 联系人ID
	
	public MailCommon() {
		super();
	}

	public MailCommon(String id){
		super(id);
	}

	@NotNull(message="联系人ID不能为空")
	public User getLinkUser() {
		return linkUser;
	}

	public void setLinkUser(User linkUser) {
		this.linkUser = linkUser;
	}
	
}