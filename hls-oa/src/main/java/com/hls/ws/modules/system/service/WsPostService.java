/**
 * 
 */
package com.hls.ws.modules.system.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.hls.ws.modules.system.entity.WsPost;
import com.hls.ws.modules.system.dao.WsPostDao;

/**
 * 岗位信息Service
 * @author lq
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class WsPostService extends CrudService<WsPostDao, WsPost> {

	public WsPost get(String id) {
		return super.get(id);
	}
	
	public List<WsPost> findList(WsPost wsPost) {
		return super.findList(wsPost);
	}
	
	public Page<WsPost> findPage(Page<WsPost> page, WsPost wsPost) {
		return super.findPage(page, wsPost);
	}
	
	@Transactional(readOnly = false)
	public void save(WsPost wsPost) {
		super.save(wsPost);
	}
	
	@Transactional(readOnly = false)
	public void delete(WsPost wsPost) {
		super.delete(wsPost);
	}
	
}