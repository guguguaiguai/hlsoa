/**
 * 
 */
package com.hls.ws.modules.mail.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.mail.entity.MailSend;
import com.hls.ws.modules.mail.dao.MailSendDao;

/**
 * 邮件发送Service
 * @author lq
 * @version 2016-05-07
 */
@Service
@Transactional(readOnly = true)
public class MailSendService extends CrudService<MailSendDao, MailSend> {

	public MailSend get(String id) {
		return super.get(id);
	}
	
	public List<MailSend> findList(MailSend mailSend) {
		return super.findList(mailSend);
	}
	
	public Page<MailSend> findPage(Page<MailSend> page, MailSend mailSend) {
		return super.findPage(page, mailSend);
	}
	
	@Transactional(readOnly = false)
	public void save(MailSend mailSend) {
		super.save(mailSend);
	}
	
	@Transactional(readOnly = false)
	public void delete(MailSend mailSend) {
		super.delete(mailSend);
	}
	
}