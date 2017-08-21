/**
 * 
 */
package com.hls.ws.modules.mail.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.mail.entity.MailCommon;
import com.hls.ws.modules.mail.dao.MailCommonDao;

/**
 * 常用联系人Service
 * @author lq
 * @version 2016-09-10
 */
@Service
@Transactional(readOnly = true)
public class MailCommonService extends CrudService<MailCommonDao, MailCommon> {

	public MailCommon get(String id) {
		return super.get(id);
	}
	
	public List<MailCommon> findList(MailCommon mailCommon) {
		return super.findList(mailCommon);
	}
	
	public Page<MailCommon> findPage(Page<MailCommon> page, MailCommon mailCommon) {
		return super.findPage(page, mailCommon);
	}
	
	@Transactional(readOnly = false)
	public void save(MailCommon mailCommon) {
		super.save(mailCommon);
	}
	
	@Transactional(readOnly = false)
	public void delete(MailCommon mailCommon) {
		super.delete(mailCommon);
	}
	/**
	 * 查询当前登录者常用联系人
	 * @author JERRY
	 * **/
	public List<MailCommon> commonList(MailCommon mailCommon){
		return dao.commonList(mailCommon);
	}
	
	/**
	 * 查询常用联系人用于判断重复使用
	 * @author JERRY
	 * **/
	public List<MailCommon> findCommon(MailCommon mailCommon){
		return dao.findCommon(mailCommon);
	}
	/**
	 * 根据ID删除常用联系人信息
	 * @author JERRY
	 * **/
	 @Transactional(readOnly=false)
	public int delCommon(MailCommon mailCommon){
		return dao.delCommon(mailCommon);
	}
}