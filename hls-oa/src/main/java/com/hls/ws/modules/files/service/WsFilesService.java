/**
 * 
 */
package com.hls.ws.modules.files.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.files.entity.WsFiles;
import com.hls.ws.modules.files.dao.WsFilesDao;

/**
 * 文件Service
 * @author lq
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class WsFilesService extends CrudService<WsFilesDao, WsFiles> {

	public WsFiles get(String id) {
		return super.get(id);
	}
	
	public List<WsFiles> findList(WsFiles wsFiles) {
		return super.findList(wsFiles);
	}
	
	public Page<WsFiles> findPage(Page<WsFiles> page, WsFiles wsFiles) {
		return super.findPage(page, wsFiles);
	}
	
	@Transactional(readOnly = false)
	public void save(WsFiles wsFiles) {
		super.save(wsFiles);
	}
	
	@Transactional(readOnly = false)
	public void delete(WsFiles wsFiles) {
		super.delete(wsFiles);
	}
	
}