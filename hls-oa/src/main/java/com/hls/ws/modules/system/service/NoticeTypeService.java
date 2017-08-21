/**
 * 
 */
package com.hls.ws.modules.system.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.system.entity.NoticeType;
import com.hls.ws.modules.system.dao.NoticeTypeDao;

/**
 * 公告类别Service
 * @author lq
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class NoticeTypeService extends CrudService<NoticeTypeDao, NoticeType> {

	public NoticeType get(String id) {
		return super.get(id);
	}
	
	public List<NoticeType> findList(NoticeType noticeType) {
		return super.findList(noticeType);
	}
	
	public Page<NoticeType> findPage(Page<NoticeType> page, NoticeType noticeType) {
		return super.findPage(page, noticeType);
	}
	
	@Transactional(readOnly = false)
	public void save(NoticeType noticeType) {
		super.save(noticeType);
	}
	
	@Transactional(readOnly = false)
	public void delete(NoticeType noticeType) {
		super.delete(noticeType);
	}
	
}