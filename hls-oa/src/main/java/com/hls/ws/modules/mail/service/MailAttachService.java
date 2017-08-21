/**
 * 
 */
package com.hls.ws.modules.mail.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.mail.entity.MailAttach;
import com.hls.ws.modules.mail.dao.MailAttachDao;

/**
 * 邮件附件Service
 * @author lq
 * @version 2016-09-09
 */
@Service
@Transactional(readOnly = true)
public class MailAttachService extends CrudService<MailAttachDao, MailAttach> {

	public MailAttach get(String id) {
		return super.get(id);
	}
	
	public List<MailAttach> findList(MailAttach mailAttach) {
		return super.findList(mailAttach);
	}
	
	public Page<MailAttach> findPage(Page<MailAttach> page, MailAttach mailAttach) {
		return super.findPage(page, mailAttach);
	}
	
	@Transactional(readOnly = false)
	public void save(MailAttach mailAttach) {
		super.save(mailAttach);
	}
	
	@Transactional(readOnly = false)
	public void delete(MailAttach mailAttach) {
		super.delete(mailAttach);
	}
	/**
	 * 删除邮件附件
	 * **/
	@Transactional(readOnly = false)
	public int del(MailAttach ma){
		return dao.delMa(ma);
	}
}