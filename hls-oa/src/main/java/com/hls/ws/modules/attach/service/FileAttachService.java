/**
 * 
 */
package com.hls.ws.modules.attach.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.attach.entity.FileAttach;
import com.hls.ws.modules.attach.dao.FileAttachDao;

/**
 * 附件信息Service
 * @author lq
 * @version 2016-09-08
 */
@Service
@Transactional(readOnly = true)
public class FileAttachService extends CrudService<FileAttachDao, FileAttach> {

	public FileAttach get(String id) {
		return super.get(id);
	}
	
	public List<FileAttach> findList(FileAttach fileAttach) {
		return super.findList(fileAttach);
	}
	
	public Page<FileAttach> findPage(Page<FileAttach> page, FileAttach fileAttach) {
		return super.findPage(page, fileAttach);
	}
	
	@Transactional(readOnly = false)
	public void save(FileAttach fileAttach) {
		super.save(fileAttach);
	}
	
	@Transactional(readOnly = false)
	public void delete(FileAttach fileAttach) {
		super.delete(fileAttach);
	}
	/**
	 * 查询邮件附件信息
	 * **/
	public List<FileAttach> fileMail(FileAttach fileAttach){
		return dao.fileMail(fileAttach);
	}
}