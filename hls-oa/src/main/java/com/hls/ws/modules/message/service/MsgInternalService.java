/**
 * 
 */
package com.hls.ws.modules.message.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hls.ws.modules.message.dao.InternalReceiveDao;
import com.hls.ws.modules.message.dao.MsgInternalDao;
import com.hls.ws.modules.message.entity.InternalReceive;
import com.hls.ws.modules.message.entity.MsgInternal;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.service.CrudService;

/**
 * 内部消息Service
 * @author lq
 * @version 2016-05-06
 */
@Service
@Transactional(readOnly = true)
public class MsgInternalService extends CrudService<MsgInternalDao, MsgInternal> {

	@Autowired
	private InternalReceiveDao internalReceiveDao;
	public MsgInternal get(String id) {
		MsgInternal mi = new MsgInternal(id);
		mi=super.get(id);
		mi.setList(internalReceiveDao.findList(new InternalReceive(mi)));
		return mi;
	}
	
	public List<MsgInternal> findList(MsgInternal msgInternal) {
		msgInternal.getSqlMap().put("dsf", dataScopeFilter(msgInternal.getCurrentUser(), "o", "cu"));
		return super.findList(msgInternal);
	}
	
	public Page<MsgInternal> findPage(Page<MsgInternal> page, MsgInternal msgInternal) {
		msgInternal.getSqlMap().put("dsf", dataScopeFilter(msgInternal.getCurrentUser(), "o", "cu"));
		return super.findPage(page, msgInternal);
	}
	
	@Transactional(readOnly = false)
	public void save(MsgInternal msgInternal) {
		super.save(msgInternal);
		/*插入消息接收者数据*/
		msgInternal.setReceiveIds(msgInternal.getAcceptor());
		if(msgInternal.getList().size()>0){
			this.internalReceiveDao.delReceive(msgInternal.getId());
			this.internalReceiveDao.insertAll(msgInternal.getList());
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(MsgInternal msgInternal) {
		super.delete(msgInternal);
	}
	/**
	 * 查询接收者信息
	 * **/
	public MsgInternal receiveList(MsgInternal msgInternal){
		//List<InternalReceive> list = this.internalReceiveDao.findList(new InternalReceive(msgInternal));
		msgInternal.setList(this.internalReceiveDao.findList(new InternalReceive(msgInternal)));
		return msgInternal;
	}
	/**
	 * 更新消息阅读状态
	 * **/
	@Transactional(readOnly = false)
	public int updateState(MsgInternal msgInternal){
		int i=0;
		if(this.internalReceiveDao.selectRead(new InternalReceive(msgInternal))<1)
			i=this.internalReceiveDao.updateState(new InternalReceive(msgInternal,new Date()));
		return i;
	}
	/**
	 * 消息撤回
	 * **/
	@Transactional(readOnly = false)
	public void msgBack(MsgInternal msg){
		/*回退信息*/
		msg.preUpdate();
		msg.setBackDate(new Date());
		dao.msgBack(msg);
		/*更新接收信息*/
		InternalReceive ir = new InternalReceive(msg);
		this.internalReceiveDao.msgBack(ir);
	}
	/**
	 * 详情
	 * **/
	public MsgInternal detail(MsgInternal msg){
		return dao.detail(msg);
	}
	/**
	 * 批量删除
	 * **/
	@Transactional(readOnly=false)
	public int batch_del(List<MsgInternal> list){
		return dao.batch_del(list);
	}
}