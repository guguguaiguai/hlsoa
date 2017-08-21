/**
 * 
 */
package com.hls.ws.modules.mail.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.hls.ws.modules.mail.entity.MailSend;

/**
 * 邮件发送DAO接口
 * @author lq
 * @version 2016-05-07
 */
@MyBatisDao
public interface MailSendDao extends CrudDao<MailSend> {
	
}