/**
 * 
 */
package com.lq.work.modules.oa.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.hls.ws.modules.mail.dao.MailReceiveDao;
import com.hls.ws.modules.mail.entity.MailReceive;
import com.hls.ws.modules.message.dao.MsgInternalDao;
import com.hls.ws.modules.message.entity.MsgInternal;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.lq.work.common.utils.IdGen;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.modules.oa.dao.OaNotifyDao;
import com.lq.work.modules.oa.dao.OaNotifyDepDao;
import com.lq.work.modules.oa.dao.OaNotifyRecordDao;
import com.lq.work.modules.oa.entity.OaNotify;
import com.lq.work.modules.oa.entity.OaNotifyDep;
import com.lq.work.modules.oa.entity.OaNotifyRecord;
import com.lq.work.modules.sys.dao.OfficeDao;
import com.lq.work.modules.sys.entity.Office;

/**
 * 通知通告Service
 * 
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OaNotifyService extends CrudService<OaNotifyDao, OaNotify> {

	@Autowired
	private OaNotifyRecordDao oaNotifyRecordDao;
	@Autowired
	private OaNotifyDepDao oaNotifyDepDao;
	@Autowired
	private MsgInternalDao msgInternalDao;
	@Autowired
	private MailReceiveDao mailReceiveDao;
	@Autowired
	private OfficeDao officeDao;

	public OaNotify get(String id) {
		OaNotify entity = dao.get(id);
		return entity;
	}
	
	/**
	 * 获取通知发送记录
	 * @param oaNotify
	 * @return
	 */
	public OaNotify getRecordList(OaNotify oaNotify) {
		oaNotify.setOaNotifyRecordList(oaNotifyRecordDao.findList(new OaNotifyRecord(oaNotify)));
		oaNotify.setOadep(oaNotifyDepDao.findList(new OaNotifyDep(oaNotify)));
		return oaNotify;
	}
	
	public Page<OaNotify> find(Page<OaNotify> page, OaNotify oaNotify) {
		oaNotify.setPage(page);
		//page.setList(dao.findList(oaNotify));
		page.setList(dao.findNotifyDep(oaNotify));
		return page;
	}
	/**
	 * 公告管理列表
	 * **/
	public Page<OaNotify> findNotifyList(Page<OaNotify> page,OaNotify oaNotify){
		oaNotify.setPage(page);
		page.setList(dao.findNotifyList(oaNotify));
		return page;
	}
	/**
	 * 获取通知数目
	 * @param oaNotify
	 * @return
	 */
	public Long findCount(OaNotify oaNotify) {
		return dao.findCount(oaNotify);
	}
	/**
	 * 查询各类通知数量
	 * **/
	public Map<String,String> count(){
		Map<String,String> map = new HashMap<String,String>();
		/*未读公告数量*/
		OaNotify oaNotify = new OaNotify();
		oaNotify.setSelf(true);
		oaNotify.setReadFlag("0");
		map.put("notifyCount", String.valueOf(dao.findCount(oaNotify)));
		/*未读消息数量*/
		MsgInternal msg = new MsgInternal();
		map.put("msgCount", String.valueOf(this.msgInternalDao.msgCount(msg)));
		/*未读邮件数量*/
		map.put("mailCount", String.valueOf(this.mailReceiveDao.unreadCount(new MailReceive())));
		return map;
	}
	
	@Transactional(readOnly = false)
	public void save(OaNotify oaNotify) {
		super.save(oaNotify);
		// 更新发送接受人记录
		oaNotifyRecordDao.deleteByOaNotifyId(oaNotify.getId());
		if (oaNotify.getOaNotifyRecordList().size() > 0){
			oaNotifyRecordDao.insertAll(oaNotify.getOaNotifyRecordList());
		}
		//更新部门
		oaNotifyDepDao.deleteByOaNotifyId(oaNotify.getId());
		if(StringUtils.equals(oaNotify.getNotifyScope(), "0")){
			List<OaNotifyDep> list = Lists.newArrayList();
			List<Office> office = this.officeDao.findAllList(new Office());
			for (Office o : office){
				OaNotifyDep entity = new OaNotifyDep();
				entity.setId(IdGen.uuid());
				entity.setNotifyId(oaNotify);
				entity.setDepId(o);
				entity.setReadFlag("0");
				list.add(entity);
			}
			oaNotify.setOadep(list);
		}
		if(oaNotify.getOadep().size()>0){
			oaNotifyDepDao.insertAll(oaNotify.getOadep());
		}
	}
	/**
	 * 获取详情
	 * **/
	@Transactional(readOnly=false)
	public OaNotify detail(OaNotify oaNotify){
		oaNotify=super.get(oaNotify.getId());
		if(StringUtils.equals(oaNotify.getIsBack(), "0")){
			/*查看详情时插入查看记录*/
			Long count=this.oaNotifyRecordDao.notifyReadCount(new OaNotifyRecord(oaNotify));
			if(count==0){
				OaNotifyRecord onr = new OaNotifyRecord(oaNotify,oaNotify.getCurrentUser(),"1",new DateTime().toDate());
				onr.setId(IdGen.uuid());
				this.oaNotifyRecordDao.insert(onr);
			}
			return dao.detail(oaNotify);
		}else{
			return new OaNotify();
		}
	}
	/**
	 * 更新阅读状态
	 */
	@Transactional(readOnly = false)
	public void updateReadFlag(OaNotify oaNotify) {
		OaNotifyRecord oaNotifyRecord = new OaNotifyRecord(oaNotify);
		oaNotifyRecord.setUser(oaNotifyRecord.getCurrentUser());
		oaNotifyRecord.setReadDate(new Date());
		oaNotifyRecord.setReadFlag("1");
		oaNotifyRecordDao.update(oaNotifyRecord);
	}
	/**
	 * 按照部门分组统计各部门已读与未读人数
	 * @author JERRY
	 * **/
	public OaNotify notifyReadInfo(OaNotifyRecord onr){
		OaNotify oa = new OaNotify();
		oa.setOaNotifyRecordList(this.oaNotifyRecordDao.notifyReadInfo(onr));
		return oa;
	}
	/**
	 * 批量标记已读
	 * **/
	@Transactional(readOnly=false)
	public Boolean read_notify(String ids){
		if(StringUtils.isNotEmpty(ids)){
			try {
				for(String nid:StringUtils.split(ids, ",")){
					OaNotify oaNotify = this.dao.get(nid);
					OaNotifyRecord onr = new OaNotifyRecord(oaNotify,oaNotify.getCurrentUser(),"1",new DateTime().toDate());
					onr.setId(IdGen.uuid());
					this.oaNotifyRecordDao.insert(onr);
				}
			} catch (Exception e) {
				return Boolean.FALSE;
			}
			return Boolean.TRUE;
		}else{
			return Boolean.FALSE;
		}
	}
	/**
	 * 通知回退
	 * **/
	@Transactional(readOnly=false)
	public int notifyBack(OaNotify oaNotify){
		/*删除通知接收部门*/
		int i=this.oaNotifyDepDao.deleteByOaNotifyId(oaNotify.getId());
		if(i>0){
			/*删除通知阅读者信息*/
			this.oaNotifyRecordDao.deleteByOaNotifyId(oaNotify.getId());
			return dao.notifyBack(oaNotify);
		}else{
			return 0;
		}
		
	}
	/**
	 * 首页公告信息
	 * @author JERRY
	 * **/
	public List<OaNotify> mainNotify(OaNotify oaNotify){
		return dao.mainNotify(oaNotify);
	}
}