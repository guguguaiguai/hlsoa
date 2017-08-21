/**
 * 
 */
package com.hls.ws.modules.message.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.lq.work.common.persistence.DataEntity;
import com.lq.work.common.utils.Collections3;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.modules.sys.entity.User;

/**
 * 内部消息Entity
 * @author lq
 * @version 2016-05-06
 */
public class MsgInternal extends DataEntity<MsgInternal> {
	
	private static final long serialVersionUID = 1L;
	public static String MSG_STATE_SEND="0";
	public static String MSG_STATE_BACK="1";
	private String acceptorName;		// 接收人名称
	private String acceptor;		// 收信人
	private String msgContent;		// 消息内容
	private String msgType="0";		// 消息类别,0:消息，1：系统通知
	private Date backDate;		// 撤回时间
	private String msgState="0";		// 消息状态,0:发送，1：撤回
	private Date beginCreateDate;		// 开始 发信时间
	private Date endCreateDate;		// 结束 发信时间
	private List<InternalReceive> list = Lists.newArrayList();/*消息接收者*/
	private String receiveUser;//JSON接收者
	private List<User> ruser;
	
	public MsgInternal() {
		super();
	}

	public MsgInternal(String id){
		super(id);
	}

	public List<User> getRuser() {
		return ruser;
	}

	public void setRuser(List<User> ruser) {
		this.ruser = ruser;
	}

	public String getReceiveUser() {
		return receiveUser;
	}

	public void setReceiveUser(String receiveUser) {
		this.receiveUser = receiveUser;
	}

	@Length(min=1, max=3000, message="接收人名称长度必须介于 1 和 3000 之间")
	public String getAcceptorName() {
		return acceptorName;
	}

	public void setAcceptorName(String acceptorName) {
		this.acceptorName = acceptorName;
	}
	
	@Length(min=1, max=6400, message="收信人长度必须介于 1 和 6400 之间")
	public String getAcceptor() {
		return acceptor;
	}

	public void setAcceptor(String acceptor) {
		this.acceptor = acceptor;
	}
	
	@Length(min=1, max=3000, message="消息内容长度必须介于 1 和 3000 之间")
	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	
	@Length(min=1, max=1, message="消息类别长度必须介于 1 和 1 之间")
	public String getMsgType() {
		return msgType;
	}

	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBackDate() {
		return backDate;
	}

	public void setBackDate(Date backDate) {
		this.backDate = backDate;
	}
	
	@Length(min=1, max=1, message="消息状态长度必须介于 1 和 1 之间")
	public String getMsgState() {
		return msgState;
	}

	public void setMsgState(String msgState) {
		this.msgState = msgState;
	}
	
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public List<InternalReceive> getList() {
		return list;
	}

	public void setList(List<InternalReceive> list) {
		this.list = list;
	}
	/**
	 * 获取通知发送记录部门ID
	 * **/
	public String getReceiveIds(){
		return Collections3.extractToString(list, "receiveId.id", ",");
	}
	/**
	 * 设置通知发送记录部门ID
	 * @return
	 */
	public void setReceiveIds(String rids){
		this.list=Lists.newArrayList();
		for (String id : StringUtils.split(rids, ",")){
			InternalReceive ir=new InternalReceive(this,getCurrentUser(),new User(id),new Date(),"0");
			ir.preInsert();
			this.list.add(ir);
		}
	}
	/**
	 * 获取通知发送记录用户Name
	 * @return
	 */
	public String getReceiveNames() {
		return Collections3.extractToString(list, "receiveId.name", ",") ;
	}
	
	/**
	 * 设置通知发送记录用户Name
	 * @return
	 */
	public void setReceiveNames(String oaNotifyRecord) {
		// 什么也不做
	}
}