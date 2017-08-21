/**
 * 
 */
package com.hls.ws.modules.files.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.files.entity.FileReleased;
import com.hls.ws.modules.files.dao.FileReleasedDao;

/**
 * 文件共享Service
 * @author lq
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class FileReleasedService extends CrudService<FileReleasedDao, FileReleased> {

	public FileReleased get(String id) {
		return super.get(id);
	}
	
	public List<FileReleased> findList(FileReleased fileReleased) {
		return super.findList(fileReleased);
	}
	
	public Page<FileReleased> findPage(Page<FileReleased> page, FileReleased fileReleased) {
		return super.findPage(page, fileReleased);
	}
	
	@Transactional(readOnly = false)
	public void save(FileReleased fileReleased) {
		super.save(fileReleased);
	}
	
	@Transactional(readOnly = false)
	public void delete(FileReleased fileReleased) {
		super.delete(fileReleased);
	}
	
}