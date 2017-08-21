/**
 * 
 */
package com.hls.ws.modules.mail.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.mail.entity.MailReceive;
import com.hls.ws.modules.mail.entity.MsgEmail;
import com.hls.ws.modules.mail.dao.MailReceiveDao;

/**
 * 邮件接收信息Service
 * @author lq
 * @version 2016-05-07
 */
@Service
@Transactional(readOnly = true)
public class MailReceiveService extends CrudService<MailReceiveDao, MailReceive> {

	public MailReceive get(String id) {
		return super.get(id);
	}
	
	public List<MailReceive> findList(MailReceive mailReceive) {
		return super.findList(mailReceive);
	}
	
	public Page<MailReceive> findPage(Page<MailReceive> page, MailReceive mailReceive) {
		return super.findPage(page, mailReceive);
	}
	
	@Transactional(readOnly = false)
	public void save(MailReceive mailReceive) {
		super.save(mailReceive);
	}
	
	@Transactional(readOnly = false)
	public void delete(MailReceive mailReceive) {
		super.delete(mailReceive);
	}
	/**
	 * 根据邮件ID及当前登录者删除收件箱信息
	 * @author JERRY
	 * **/
	@Transactional(readOnly = false)
	public int delReceive(MailReceive mr){
		return dao.delReceive(mr);
	}
	/**
	 * 根据邮件ID查询邮件查阅情况
	 * **/
	public List<MailReceive> mailReadInfo(MailReceive mr){
		return dao.mailRead(mr);
	}
	/**
	 * 邮件标记为已读
	 * **/
	@Transactional(readOnly = false)
	public int readFlag(MailReceive mr){
		return dao.readFlag(mr);
	}
	/**
	 * 更新是否下载文件
	 * @author JERRY
	 * **/
	@Transactional(readOnly=false)
	public int fdCount(MailReceive mr){
		return dao.fdCount(mr);
	}
}