/**
 * 
 */
package com.hls.ws.modules.mail.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hls.ws.modules.attach.dao.FileAttachDao;
import com.hls.ws.modules.attach.entity.FileAttach;
import com.hls.ws.modules.mail.dao.MailAttachDao;
import com.hls.ws.modules.mail.dao.MailReceiveDao;
import com.hls.ws.modules.mail.dao.MsgEmailDao;
import com.hls.ws.modules.mail.entity.MailAttach;
import com.hls.ws.modules.mail.entity.MailReceive;
import com.hls.ws.modules.mail.entity.MsgEmail;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.lq.work.common.utils.StringUtils;

/**
 * 内部邮件Service
 * @author lq
 * @version 2016-05-07
 */
@Service
@Transactional(readOnly = true)
public class MsgEmailService extends CrudService<MsgEmailDao, MsgEmail> {

	@Autowired
	private MailReceiveDao mailReceiveDao;
	@Autowired
	private MailAttachDao mailAttachDao;
	@Autowired
	private FileAttachDao fileAttachDao;
	public MsgEmail get(String id) {
		/*根据邮件ID查询收件人信息*/
		MsgEmail me=new MsgEmail(id);
		me=super.get(id);
		me.setReceive(this.mailReceiveDao.mailRead(new MailReceive(me)));
		/*查询附件*/
		FileAttach fa = new FileAttach();
		fa.setMid(id);
		me.setFiles(fileAttachDao.fileMail(fa));
		return me;
	}
	
	public List<MsgEmail> findList(MsgEmail msgEmail) {
		return super.findList(msgEmail);
	}
	
	public Page<MsgEmail> findPage(Page<MsgEmail> page, MsgEmail msgEmail) {
		msgEmail.getSqlMap().put("dsf", dataScopeFilter(msgEmail.getCurrentUser(), "o", "u"));
		return super.findPage(page, msgEmail);
	}
	/**
	 * 查询当前登录者收件箱信息
	 * **/
	public Page<MsgEmail> findReceiveList(Page<MsgEmail> page,MsgEmail msgEmail){
		msgEmail.setPage(page);
		page.setList(dao.findReceiveList(msgEmail));
		return page;
	}
	/**
	 * 草稿箱信息
	 * @author JERRY
	 * **/
	public Page<MsgEmail> draftMailList(Page<MsgEmail> page,MsgEmail msgEmail){
		msgEmail.getSqlMap().put("dsf", dataScopeFilter(msgEmail.getCurrentUser(), "o", "u"));
		msgEmail.setPage(page);
		page.setList(dao.draftMailList(msgEmail));
		return page;
	}
	@Transactional(readOnly = false)
	public void save(MsgEmail msgEmail) {
		msgEmail.setFilePath(msgEmail.getFids());
		super.save(msgEmail);
		/*插入邮件接收信息*/
		msgEmail.setReceiveIds(msgEmail.getMailAcceptor());
		if(msgEmail.getReceive().size()>0){
			this.mailReceiveDao.mailDel(new MailReceive(msgEmail));
			this.mailReceiveDao.insertAll(msgEmail.getReceive());
		}
		/*插入附件信息*/
		if(StringUtils.isNotEmpty(msgEmail.getFids())){
			mailAttachDao.delMa(new MailAttach(null,msgEmail.getId()));/*删除邮件附件*/
			for(String fid:StringUtils.split(msgEmail.getFids(),",")){
				MailAttach ma = new MailAttach(fid,msgEmail.getId());
				mailAttachDao.insert(ma);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(MsgEmail msgEmail) {
		super.delete(msgEmail);
	}
	/**
	 * 草稿箱邮件删除
	 * **/
	@Transactional(readOnly = false)
	public int draftDel(MsgEmail msgEmail){
		msgEmail.setIsSend("1");
		int dd=dao.draftDel(msgEmail);
		/*删除邮件接收者*/
		this.mailReceiveDao.mailDel(new MailReceive(msgEmail));
		return dd;
	}
	/**
	 * 收件箱删除邮件
	 * **/
	public Page<MsgEmail> mailDelList(Page<MsgEmail> page,MsgEmail msgEmail){
		msgEmail.setPage(page);
		page.setList(dao.mailDelList(msgEmail));
		return page;
	}
	/**
	 * 邮件详情
	 * **/
	public MsgEmail detail(MsgEmail msgEmail){
		/*根据邮件ID查询收件人信息*/
		MsgEmail me=new MsgEmail();
		me=dao.detail(msgEmail);
		me.setReceive(this.mailReceiveDao.mailRead(new MailReceive(me)));
		/*查询附件*/
		FileAttach fa = new FileAttach();
		fa.setMid(msgEmail.getId());
		me.setFiles(fileAttachDao.fileMail(fa));
		return me;
	}
	/**
	 * 邮件撤回
	 * **/
	@Transactional(readOnly=false)
	public int mailBack(MsgEmail msgEmail){
		/*删除接收者信息*/
		MailReceive mr = new MailReceive(msgEmail);
		mr.setIsDel("1");
		int mi=this.mailReceiveDao.backDel(mr);
		int mbi=dao.mailBack(msgEmail);
		return mbi;
	}
	/**
	 * 首页邮件查询
	 * @author JERRY
	 * **/
	public List<MsgEmail> mainMail(MsgEmail msgEmail){
		return dao.mainMail(msgEmail);
	}
	/**
	 * 收件箱邮件删除
	 * @author JERRY
	 * **/
	@Transactional(readOnly=false)
	public int receiveDel(MsgEmail msgEmail){
		return dao.receiveDel(msgEmail);
	}
}