/**
 * 
 */
package com.hls.ws.modules.mail.dao;

import com.lq.work.common.persistence.CrudDao;
import com.lq.work.common.persistence.annotation.MyBatisDao;
import com.hls.ws.modules.mail.entity.MailAttach;

/**
 * 邮件附件DAO接口
 * @author lq
 * @version 2016-09-09
 */
@MyBatisDao
public interface MailAttachDao extends CrudDao<MailAttach> {
	/**
	 * 删除邮件附件
	 * **/
	public int delMa(MailAttach ma);
}