/**
 * 
 */
package com.lq.work.modules.oa.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.lq.work.modules.oa.entity.OaNotifyDep;
import com.lq.work.modules.oa.dao.OaNotifyDepDao;

/**
 * 部门公告记录Service
 * @author lq
 * @version 2016-05-08
 */
@Service
@Transactional(readOnly = true)
public class OaNotifyDepService extends CrudService<OaNotifyDepDao, OaNotifyDep> {

	public OaNotifyDep get(String id) {
		return super.get(id);
	}
	
	public List<OaNotifyDep> findList(OaNotifyDep oaNotifyDep) {
		return super.findList(oaNotifyDep);
	}
	
	public Page<OaNotifyDep> findPage(Page<OaNotifyDep> page, OaNotifyDep oaNotifyDep) {
		return super.findPage(page, oaNotifyDep);
	}
	
	@Transactional(readOnly = false)
	public void save(OaNotifyDep oaNotifyDep) {
		super.save(oaNotifyDep);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaNotifyDep oaNotifyDep) {
		super.delete(oaNotifyDep);
	}
	@Transactional(readOnly = false)
	public int deleteByOaNotifyId(String oaNotifyId){
		return this.dao.deleteByOaNotifyId(oaNotifyId);
	}
	/**
	 * 插入通知记录
	 * @param oaNotifyRecordList
	 * @return
	 */
	@Transactional(readOnly = false)
	public int insertAll(List<OaNotifyDep> depList){
		return this.dao.insertAll(depList);
	}
}