/**
 * 
 */
package com.lq.work.modules.sys.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.service.TreeService;
import com.lq.work.modules.sys.dao.OfficeDao;
import com.lq.work.modules.sys.entity.Office;
import com.lq.work.modules.sys.utils.UserUtils;

/**
 * 机构Service
 * 
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class OfficeService extends TreeService<OfficeDao, Office> {

	public List<Office> findAll(){
		return UserUtils.getOfficeList();
	}

	public List<Office> findList(Boolean isAll){
		if (isAll != null && isAll){
			return UserUtils.getOfficeAllList();
		}else{
			return UserUtils.getOfficeList();
		}
	}
	
	@Transactional(readOnly = true)
	public List<Office> findList(Office office){
		office.setParentIds(office.getParentIds()+"%");
		return dao.findByParentIdsLike(office);
	}
	
	@Transactional(readOnly = false)
	public void save(Office office) {
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Office office) {
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}
	/**
	 * 根据公告ID查询部门信息
	 * @author JERRY
	 * **/
	public List<Office> notifyOffice(Office office){
		return this.dao.notifyOffice(office);
	}
	/**
	 * 更新部门信息并接收存储过程返回的值
	 * @author JERRY
	 * **/
	public Map hisDep(Map map){
		return dao.hisDep(map);
	}
}
