/**
 * 
 */
package com.hls.ws.modules.message.entity;

import org.hibernate.validator.constraints.Length;

import com.lq.work.modules.sys.entity.User;

import javax.validation.constraints.NotNull;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.lq.work.common.persistence.DataEntity;

/**
 * 内部消息接收Entity
 * @author lq
 * @version 2016-05-06
 */
public class InternalReceive extends DataEntity<InternalReceive> {
	
	private static final long serialVersionUID = 1L;
	private MsgInternal msgId;		// 消息ID
	private User sendId;		// 发送人ID
	private User receiveId;		// 接收人ID
	private Date readDate;		// 阅读时间
	private String readState="0";		// 阅读状态,0:未读，1：已读
	
	public InternalReceive() {
		super();
	}

	public InternalReceive(MsgInternal msgId) {
		this.msgId = msgId;
	}

	public InternalReceive(MsgInternal msgId, Date readDate) {
		this.msgId = msgId;
		this.readDate = readDate;
	}

	public InternalReceive(String id){
		super(id);
	}

	public InternalReceive(MsgInternal msgId, User sendId, User receiveId,Date readDate, String readState) {
		super();
		this.msgId = msgId;
		this.sendId = sendId;
		this.receiveId = receiveId;
		this.readDate = readDate;
		this.readState = readState;
	}

	public MsgInternal getMsgId() {
		return msgId;
	}

	public void setMsgId(MsgInternal msgId) {
		this.msgId = msgId;
	}

	@NotNull(message="发送人ID不能为空")
	public User getSendId() {
		return sendId;
	}

	public void setSendId(User sendId) {
		this.sendId = sendId;
	}
	
	@NotNull(message="接收人ID不能为空")
	public User getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(User receiveId) {
		this.receiveId = receiveId;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}
	
	@Length(min=1, max=1, message="阅读状态,0:未读，1：已读长度必须介于 1 和 1 之间")
	public String getReadState() {
		return readState;
	}

	public void setReadState(String readState) {
		this.readState = readState;
	}
	
}