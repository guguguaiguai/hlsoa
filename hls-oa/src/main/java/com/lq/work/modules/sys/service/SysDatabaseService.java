/**
 * 
 */
package com.lq.work.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.lq.work.modules.sys.entity.SysDatabase;
import com.lq.work.modules.sys.dao.SysDatabaseDao;

/**
 * 数据库备份Service
 * @author lq
 * @version 2016-06-27
 */
@Service
@Transactional(readOnly = true)
public class SysDatabaseService extends CrudService<SysDatabaseDao, SysDatabase> {

	public SysDatabase get(String id) {
		return super.get(id);
	}
	
	public List<SysDatabase> findList(SysDatabase sysDatabase) {
		return super.findList(sysDatabase);
	}
	
	public Page<SysDatabase> findPage(Page<SysDatabase> page, SysDatabase sysDatabase) {
		return super.findPage(page, sysDatabase);
	}
	
	@Transactional(readOnly = false)
	public void save(SysDatabase sysDatabase) {
		super.save(sysDatabase);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysDatabase sysDatabase) {
		super.delete(sysDatabase);
	}
	
}