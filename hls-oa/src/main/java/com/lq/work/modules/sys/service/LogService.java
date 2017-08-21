package com.lq.work.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.lq.work.common.utils.DateUtils;
import com.lq.work.modules.sys.dao.LogDao;
import com.lq.work.modules.sys.entity.Log;

/**
 * 日志Service
 * 
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class LogService extends CrudService<LogDao, Log> {

	public Page<Log> findPage(Page<Log> page, Log log) {
		
		// 设置默认时间范围，默认当前月
		if (log.getBeginDate() == null){
			log.setBeginDate(DateUtils.setDays(DateUtils.parseDate(DateUtils.getDate()), 1));
		}
		if (log.getEndDate() == null){
			log.setEndDate(DateUtils.addMonths(log.getBeginDate(), 1));
		}
		
		return super.findPage(page, log);
		
	}
	/**
	 * 批量删除日志信息
	 * **/
	@Transactional(readOnly=false)
	public int del(List<Log> list){
		return dao.del(list);
	}
}
