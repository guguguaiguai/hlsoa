/**
 * 
 */
package com.hls.ws.modules.message.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hls.ws.modules.message.dao.InternalReceiveDao;
import com.hls.ws.modules.message.entity.InternalReceive;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;
import com.lq.work.modules.sys.utils.UserUtils;

/**
 * 内部消息接收Service
 * @author lq
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class InternalReceiveService extends CrudService<InternalReceiveDao, InternalReceive> {

	public InternalReceive get(String id) {
		return super.get(id);
	}
	
	public List<InternalReceive> findList(InternalReceive internalReceive) {
		return super.findList(internalReceive);
	}
	
	public Page<InternalReceive> findPage(Page<InternalReceive> page, InternalReceive internalReceive) {
		return super.findPage(page, internalReceive);
	}
	
	/**
	 * 查询阅读情况
	 * **/
	public List<InternalReceive> findReceive(InternalReceive internalReceive) {
		return dao.findReceive(internalReceive);
	}
	
	@Transactional(readOnly = false)
	public void save(InternalReceive internalReceive) {
		super.save(internalReceive);
	}
	
	@Transactional(readOnly = false)
	public void delete(InternalReceive internalReceive) {
		super.delete(internalReceive);
	}
	/**
	 * 查询当前登录者内部消息
	 * **/
	public Page<InternalReceive> unreadList(Page<InternalReceive> page,InternalReceive ir){
		ir.setPage(page);
		page.setList(this.dao.unreadList(ir));
		return page;
	}
	/**
	 * 根据消息ID，接收者ID删除消息
	 * **/
	@Transactional(readOnly = false)
	public int delMsg(InternalReceive ir){
		ir.setCurrentUser(UserUtils.getUser());
		ir.setReceiveId(UserUtils.getUser());
		return dao.delMsg(ir);
	}
	/**
	 * 消息撤回
	 * **/
	@Transactional(readOnly = false)
	public void msgBack(InternalReceive ir){
		/*消息接收更新*/
		dao.msgBack(ir);
	}
	/**
	 * 主页默认读取5条消息
	 * @author JERRY
	 * **/
	public List<InternalReceive> mainInternalReceive(InternalReceive ir){
		return dao.mainInternalReceive(ir);
	}
}