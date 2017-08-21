/**
 * 
 */
package com.lq.work.modules.oa.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.hls.ws.modules.util.NotifyUtil;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;
import com.lq.work.modules.oa.entity.OaNotify;
import com.lq.work.modules.oa.entity.OaNotifyRecord;
import com.lq.work.modules.oa.service.OaNotifyService;

/**
 * 通知通告Controller
 * 
 * @version 2014-05-16
 */
@Controller
@RequestMapping(value = "${adminPath}/oa/oaNotify")
public class OaNotifyController extends BaseController {

	@Autowired
	private OaNotifyService oaNotifyService;
	
	@ModelAttribute
	public OaNotify get(@RequestParam(required=false) String id) {
		OaNotify entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = oaNotifyService.get(new OaNotify(id));
		}
		if (entity == null){
			entity = new OaNotify();
		}
		return entity;
	}
	
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaNotify oaNotify, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaNotify> page = oaNotifyService.findNotifyList(new Page<OaNotify>(request, response), oaNotify);
		model.addAttribute("page", page);
		return "modules/oa/oaNotifyList";
	}

	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "form")
	public String form(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())){
			oaNotify = oaNotifyService.getRecordList(oaNotify);
		}
		model.addAttribute("oaNotify", oaNotify);
		return "modules/oa/oaNotifyForm";
	}
	/**
	 * 通知主页面
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "index")
	public String index(OaNotify oaNotify, Model model,HttpServletRequest request,HttpServletResponse response){
		oaNotify.setSelf(Boolean.TRUE);
		Page<OaNotify> page = oaNotifyService.find(new Page<OaNotify>(request, response), oaNotify);
		page.setObjName(NotifyUtil.noticeTypeName(oaNotify.getType(), "通知公告"));
		model.addAttribute("nindex", page);
		return "modules/oa/notifyIndex";
	}
	/**
	 * 通知详情页面
	 * @author JERRY
	 * @version 2016-05-08
	 * **/
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "detail")
	public String notifyDetail(String id,Model model){
		OaNotify notify = new OaNotify();
		if(StringUtils.isNotEmpty(id))
			notify=this.oaNotifyService.detail(new OaNotify(id));
		model.addAttribute("ond", notify);
		return "modules/oa/oaNotifyDetail";
	}
	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "save")
	public String save(OaNotify oaNotify, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, oaNotify)){
			return form(oaNotify, model);
		}
		// 如果是修改，则状态为已发布，则不能再进行操作
		if (StringUtils.isNotBlank(oaNotify.getId())){
			OaNotify e = oaNotifyService.get(oaNotify.getId());
			if ("1".equals(e.getStatus())){
				addMessage(redirectAttributes, "已发布，不能操作！");
				return "redirect:" + adminPath + "/oa/oaNotify/form?id="+oaNotify.getId();
			}
		}
		oaNotify.setIsBack("0");/*草稿或者正式都更新回退状态为0*/
		oaNotifyService.save(oaNotify);
		addMessage(redirectAttributes, "保存通知'" + oaNotify.getTitle() + "'成功");
		return "redirect:" + adminPath + "/oa/oaNotify/?repage";
	}
	
	@RequiresPermissions("oa:oaNotify:edit")
	@RequestMapping(value = "delete")
	public String delete(OaNotify oaNotify, RedirectAttributes redirectAttributes) {
		oaNotifyService.delete(oaNotify);
		addMessage(redirectAttributes, "删除通知成功");
		return "redirect:" + adminPath + "/oa/oaNotify/?repage";
	}
	
	/**
	 * 我的通知列表
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "self")
	public String selfList(OaNotify oaNotify, HttpServletRequest request, HttpServletResponse response, Model model) {
		oaNotify.setSelf(true);
		Page<OaNotify> page = oaNotifyService.find(new Page<OaNotify>(request, response), oaNotify); 
		model.addAttribute("page", page);
		return "modules/oa/oaNotifyList";
	}

	/**
	 * 我的通知列表-数据
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "selfData")
	@ResponseBody
	public Page<OaNotify> listData(OaNotify oaNotify, HttpServletRequest request, HttpServletResponse response, Model model) {
		oaNotify.setSelf(true);
		Page<OaNotify> page = oaNotifyService.find(new Page<OaNotify>(request, response), oaNotify);
		return page;
	}
	
	/**
	 * 查看我的通知
	 */
	@RequestMapping(value = "view")
	public String view(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())){
			oaNotifyService.updateReadFlag(oaNotify);
			oaNotify = oaNotifyService.getRecordList(oaNotify);
			model.addAttribute("oaNotify", oaNotify);
			return "modules/oa/oaNotifyForm";
		}
		return "redirect:" + adminPath + "/oa/oaNotify/self?repage";
	}

	/**
	 * 查看我的通知-数据
	 */
	@RequestMapping(value = "viewData")
	@ResponseBody
	public OaNotify viewData(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())){
			oaNotifyService.updateReadFlag(oaNotify);
			return oaNotify;
		}
		return null;
	}
	
	/**
	 * 查看我的通知-发送记录
	 */
	@RequestMapping(value = "viewRecordData")
	@ResponseBody
	public OaNotify viewRecordData(OaNotify oaNotify, Model model) {
		if (StringUtils.isNotBlank(oaNotify.getId())){
			oaNotify = oaNotifyService.getRecordList(oaNotify);
			return oaNotify;
		}
		return null;
	}
	
	/**
	 * 获取我的通知数目
	 */
	@RequestMapping(value = "self/count")
	@ResponseBody
	public String selfCount(OaNotify oaNotify, Model model) {
		oaNotify.setSelf(true);
		oaNotify.setReadFlag("0");
		return String.valueOf(oaNotifyService.findCount(oaNotify));
	}
	/**
	 * 查询公告阅读情况
	 * @author JERRY
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "rinfo")
	public String readInfo(String depId,String nid,String qm,Model model){
		List<OaNotifyRecord> list = Lists.newArrayList();
		if(StringUtils.isNotEmpty(nid)){
			OaNotifyRecord onr = new OaNotifyRecord(new OaNotify(nid),depId);
			onr.setPm(qm);
			OaNotify oa = this.oaNotifyService.notifyReadInfo(onr);
			list=oa.getOaNotifyRecordList();
		}
		model.addAttribute("nr", list);
		return "modules/oa/notifyRead";
	}
	/**
	 * 公告查阅情况主页
	 * @author JERRY
	 * **/
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "rindex")
	public String readIndex(){
		return "modules/oa/notifyReadIndex";
	}
	/**
	 * 标记已读
	 * **/
	@RequiresPermissions("oa:oaNotify:view")
	@RequestMapping(value = "rf")
	public void readFlag(String nids,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(nids)){
			renderString(response,new Message(Boolean.FALSE,"请选择数据"));
		}else{
			try {
				this.oaNotifyService.read_notify(nids);
				renderString(response,new Message(Boolean.TRUE,""));
			} catch (Exception e) {
				renderString(response,new Message(Boolean.FALSE,e.getMessage()));
			}
			
		}
	}
	/**
	 * 查询未读消息数量
	 * @author JERRY
	 * @version 2016-05-10
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "count")
	public void count(HttpServletRequest request,HttpServletResponse response){
		Map<String,String> map = this.oaNotifyService.count();
		if(map!=null){
			MessageCount mc = new MessageCount(Long.valueOf(map.get("notifyCount")),
					Long.valueOf(map.get("msgCount")),Long.valueOf(map.get("mailCount")),
					Boolean.TRUE,"");
			renderString(response, mc);
		}
	}
	/**
	 * 通知回退
	 * @author JERRY
	 * **/
	@RequiresPermissions("oa:oaNotify:back")
	@RequestMapping(value = "nback")
	public void notifyBack(String nids,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(nids)){
			renderString(response, new Message(Boolean.FALSE, "请选择撤回通知！"));
		}else{
			int bs=0;//撤回成功
			int bf=0;//撤回失败
			for(String id:StringUtils.split(nids, ",")){
				OaNotify n = new OaNotify(id);
				n.setStatus("0");
				int i=this.oaNotifyService.notifyBack(n);
				if(i>0)
					bs+=i;
				else
					bf++;
			}
			if(bs==0)
				renderString(response, new Message(Boolean.FALSE, "已选通知撤回失败"));
			else
				renderString(response, new Message(Boolean.TRUE, "通知撤回成功！"+String.valueOf(bs)));
		}
	}
	/*消息数量统计*/
	class MessageCount{
		private Long notifyCount=0l;//未读通知数目
		private Long msgCount=0l;//未读内部消息数量
		private Long mailCount=0l;//未读邮件数量
		private Boolean success=Boolean.TRUE;
		private String msg="";
		
		public MessageCount() {
		}
		public MessageCount(Long notifyCount, Long msgCount, Long mailCount,
				Boolean success, String msg) {
			this.notifyCount = notifyCount;
			this.msgCount = msgCount;
			this.mailCount = mailCount;
			this.success = success;
			this.msg = msg;
		}
		
		public Long getNotifyCount() {
			return notifyCount;
		}
		public void setNotifyCount(Long notifyCount) {
			this.notifyCount = notifyCount;
		}
		public Long getMsgCount() {
			return msgCount;
		}
		public void setMsgCount(Long msgCount) {
			this.msgCount = msgCount;
		}
		public Long getMailCount() {
			return mailCount;
		}
		public void setMailCount(Long mailCount) {
			this.mailCount = mailCount;
		}
		public Boolean getSuccess() {
			return success;
		}
		public void setSuccess(Boolean success) {
			this.success = success;
		}
		public String getMsg() {
			return msg;
		}
		public void setMsg(String msg) {
			this.msg = msg;
		}
		
	}
}