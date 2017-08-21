/**
 * 
 */
package com.hls.ws.modules.message.web;

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

import com.hls.ws.modules.message.entity.InternalReceive;
import com.hls.ws.modules.message.entity.MsgInternal;
import com.hls.ws.modules.message.service.InternalReceiveService;
import com.lq.work.common.config.Global;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;

/**
 * 内部消息接收Controller
 * @author lq
 * @version 2016-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/message/internalReceive")
public class InternalReceiveController extends BaseController {

	@Autowired
	private InternalReceiveService internalReceiveService;
	
	@ModelAttribute
	public InternalReceive get(@RequestParam(required=false) String id) {
		InternalReceive entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = internalReceiveService.get(id);
		}
		if (entity == null){
			entity = new InternalReceive();
		}
		return entity;
	}
	
	@RequiresPermissions("message:internalReceive:view")
	@RequestMapping(value = {"list", ""})
	public String list(InternalReceive internalReceive, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InternalReceive> page = internalReceiveService.findPage(new Page<InternalReceive>(request, response), internalReceive); 
		model.addAttribute("page", page);
		return "modules/message/internalReceiveList";
	}
	/**
	 * 查询消息阅读情况
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "fr")
	public String findReceive(String mid, HttpServletRequest request, HttpServletResponse response, Model model) {
		InternalReceive internalReceive=new InternalReceive(new MsgInternal(mid));
		model.addAttribute("rlist", internalReceiveService.findReceive(internalReceive));
		return "modules/message/receiveList";
	}
	/**
	 * 查询当前登录者收到的消息
	 * @author JERRY
	 * **/
	@RequiresPermissions("message:internalReceive:view")
	@RequestMapping(value = "unreadList")
	public String unreadList(InternalReceive internalReceive, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<InternalReceive> page = internalReceiveService.unreadList(new Page<InternalReceive>(request, response), internalReceive); 
		model.addAttribute("rlist", page);
		return "modules/message/unreadList";
	}
	@RequiresPermissions("message:internalReceive:view")
	@RequestMapping(value = "form")
	public String form(InternalReceive internalReceive, Model model) {
		model.addAttribute("internalReceive", internalReceive);
		return "modules/message/internalReceiveForm";
	}

	@RequiresPermissions("message:internalReceive:edit")
	@RequestMapping(value = "save")
	public String save(InternalReceive internalReceive, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, internalReceive)){
			return form(internalReceive, model);
		}
		internalReceiveService.save(internalReceive);
		addMessage(redirectAttributes, "保存内部消息成功");
		return "redirect:"+Global.getAdminPath()+"/message/internalReceive/?repage";
	}
	
	@RequiresPermissions("message:internalReceive:edit")
	@RequestMapping(value = "delete")
	public String delete(InternalReceive internalReceive, RedirectAttributes redirectAttributes) {
		internalReceiveService.delete(internalReceive);
		addMessage(redirectAttributes, "删除内部消息成功");
		return "redirect:"+Global.getAdminPath()+"/message/internalReceive/?repage";
	}
	/**
	 * 删除已接收的消息
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "delmsg")
	public void delMsg(String mid,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(mid)){
			renderString(response, new Message(Boolean.FALSE,"Select data!"));
		}else{
			String[] ids=StringUtils.split(mid, ",");
			try {
				for(String id:ids){
					internalReceiveService.delMsg(new InternalReceive(new MsgInternal(id)));
				}
				renderString(response, new Message(Boolean.TRUE,""));
			} catch (Exception e) {
				e.printStackTrace();
				renderString(response, new Message(Boolean.FALSE,e.getMessage()));
			}
		}
		
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
				internalReceiveService.msgBack(new InternalReceive(new MsgInternal(mid)));
				renderString(response, new Message(Boolean.TRUE,""));
			} catch (Exception e) {
				e.printStackTrace();
				renderString(response, new Message(Boolean.FALSE,e.getMessage()));
			}
		}
	}
}