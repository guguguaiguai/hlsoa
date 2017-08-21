/**
 * 
 */
package com.hls.ws.modules.message.web;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.hls.ws.modules.message.entity.MsgInternal;
import com.hls.ws.modules.message.service.MsgInternalService;
import com.lq.work.common.config.Global;
import com.lq.work.common.mapper.JsonMapper;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;
import com.lq.work.modules.sys.entity.User;
import com.lq.work.modules.sys.service.SystemService;

/**
 * 内部消息Controller
 * @author lq
 * @version 2016-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/message/msgInternal")
public class MsgInternalController extends BaseController {

	@Autowired
	private MsgInternalService msgInternalService;
	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public MsgInternal get(@RequestParam(required=false) String id) {
		MsgInternal entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = msgInternalService.get(id);
		}
		if (entity == null){
			entity = new MsgInternal();
		}
		return entity;
	}
	
	@RequiresPermissions("message:msgInternal:view")
	@RequestMapping(value = {"list", ""})
	public String list(MsgInternal msgInternal, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MsgInternal> page = msgInternalService.findPage(new Page<MsgInternal>(request, response), msgInternal); 
		model.addAttribute("page", page);
		return "modules/message/msgInternalList";
	}

	@RequiresPermissions("message:msgInternal:view")
	@RequestMapping(value = "form")
	public String form(MsgInternal msgInternal, Model model) {
		/*if(StringUtils.isNotEmpty(msgInternal.getId())){
			this.msgInternalService.receiveList(msgInternal);
		}*/
		/*修改时消息接收者初始化*/
		if(StringUtils.isNotEmpty(msgInternal.getAcceptor())){
			List<String> list = Arrays.asList(StringUtils.split(msgInternal.getAcceptor(), ","));
			List<User> ulist=systemService.receiveUser(list);
			msgInternal.setReceiveUser(JsonMapper.toJsonString(ulist));
			msgInternal.setRuser(ulist);
		}
		model.addAttribute("msgInternal", msgInternal);
		return "modules/message/msgInternalForm";
	}
	/**
	 * 消息详情
	 * @author JERRY
	 * @version 2016-05-10
	 * **/
	@RequiresPermissions("message:msgInternal:view")
	@RequestMapping(value = "detail")
	public String detail(String id, Model model){
		/*更新阅读状态*/
		MsgInternal msgInternal = new MsgInternal(id);
		msgInternal.setMsgState("0");
		msgInternal=this.msgInternalService.detail(msgInternal);
		if(msgInternal!=null)
			this.msgInternalService.updateState(msgInternal);
		//msgInternal.setMsgState("0");
		//msgInternal=this.msgInternalService.get(msgInternal);
		model.addAttribute("msgdetail", msgInternal);
		return "modules/message/msgDetail";
	}
	
	@RequiresPermissions("message:msgInternal:edit")
	@RequestMapping(value = "save")
	public String save(MsgInternal msgInternal, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, msgInternal)){
			return form(msgInternal, model);
		}
		if(StringUtils.isNotEmpty(msgInternal.getId())){
			msgInternal.setMsgState(MsgInternal.MSG_STATE_SEND);
		}
		msgInternalService.save(msgInternal);
		addMessage(redirectAttributes, "消息发送成功");
		return "redirect:"+Global.getAdminPath()+"/message/msgInternal/?repage";
	}
	/**
	 * 批量删除内部消息
	 * @author JERRY
	 * @description 2016-07-06 17:07
	 * **/
	@RequiresPermissions("message:msgInternal:edit")
	@RequestMapping(value = "batchDel")
	public void batch_del(String ids,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(ids)){
			renderString(response, new Message(Boolean.FALSE,"Select data!"));
		}else{
			String[] imids=StringUtils.split(ids, ",");
			if(imids.length>0){
				List<MsgInternal> list=Lists.newArrayList();
				for(String id:imids){
					list.add(new MsgInternal(id));
				}
				int i=this.msgInternalService.batch_del(list);
				renderString(response, new Message(Boolean.TRUE,"删除成功！共删除"+i+"条。"));
			}else{
				renderString(response, new Message(Boolean.FALSE,"Select data!"));
			}
		}
	}
	@RequiresPermissions("message:msgInternal:edit")
	@RequestMapping(value = "delete")
	public String delete(MsgInternal msgInternal, RedirectAttributes redirectAttributes) {
		msgInternalService.delete(msgInternal);
		addMessage(redirectAttributes, "消息删除成功");
		return "redirect:"+Global.getAdminPath()+"/message/msgInternal/?repage";
	}
	/**
	 * 消息撤回
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "msgback")
	public void msgBack(String mid,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(mid)){
			renderString(response, new Message(Boolean.FALSE,"Select data!"));
		}else{
			try {
				msgInternalService.msgBack(new MsgInternal(mid));
				renderString(response, new Message(Boolean.TRUE,""));
			} catch (Exception e) {
				e.printStackTrace();
				renderString(response, new Message(Boolean.FALSE,e.getMessage()));
			}
		}
	}
}