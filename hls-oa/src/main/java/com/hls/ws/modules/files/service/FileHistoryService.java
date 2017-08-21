/**
 * 
 */
package com.hls.ws.modules.files.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.files.entity.FileHistory;
import com.hls.ws.modules.files.dao.FileHistoryDao;

/**
 * 文件下载记录Service
 * @author lq
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class FileHistoryService extends CrudService<FileHistoryDao, FileHistory> {

	public FileHistory get(String id) {
		return super.get(id);
	}
	
	public List<FileHistory> findList(FileHistory fileHistory) {
		return super.findList(fileHistory);
	}
	
	public Page<FileHistory> findPage(Page<FileHistory> page, FileHistory fileHistory) {
		return super.findPage(page, fileHistory);
	}
	
	@Transactional(readOnly = false)
	public void save(FileHistory fileHistory) {
		super.save(fileHistory);
	}
	
	@Transactional(readOnly = false)
	public void delete(FileHistory fileHistory) {
		super.delete(fileHistory);
	}
	
}