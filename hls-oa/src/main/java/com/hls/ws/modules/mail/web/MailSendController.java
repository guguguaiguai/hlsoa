/**
 * 
 */
package com.hls.ws.modules.mail.web;

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

import com.lq.work.common.config.Global;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.web.BaseController;
import com.lq.work.common.utils.StringUtils;
import com.hls.ws.modules.mail.entity.MailSend;
import com.hls.ws.modules.mail.service.MailSendService;

/**
 * 邮件发送Controller
 * @author lq
 * @version 2016-05-07
 */
@Controller
@RequestMapping(value = "${adminPath}/mail/mailSend")
public class MailSendController extends BaseController {

	@Autowired
	private MailSendService mailSendService;
	
	@ModelAttribute
	public MailSend get(@RequestParam(required=false) String id) {
		MailSend entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = mailSendService.get(id);
		}
		if (entity == null){
			entity = new MailSend();
		}
		return entity;
	}
	
	@RequiresPermissions("mail:mailSend:view")
	@RequestMapping(value = {"list", ""})
	public String list(MailSend mailSend, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MailSend> page = mailSendService.findPage(new Page<MailSend>(request, response), mailSend); 
		model.addAttribute("page", page);
		return "modules/mail/mailSendList";
	}

	@RequiresPermissions("mail:mailSend:view")
	@RequestMapping(value = "form")
	public String form(MailSend mailSend, Model model) {
		model.addAttribute("mailSend", mailSend);
		return "modules/mail/mailSendForm";
	}

	@RequiresPermissions("mail:mailSend:edit")
	@RequestMapping(value = "save")
	public String save(MailSend mailSend, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, mailSend)){
			return form(mailSend, model);
		}
		mailSendService.save(mailSend);
		addMessage(redirectAttributes, "保存邮件发送成功");
		return "redirect:"+Global.getAdminPath()+"/mail/mailSend/?repage";
	}
	
	@RequiresPermissions("mail:mailSend:edit")
	@RequestMapping(value = "delete")
	public String delete(MailSend mailSend, RedirectAttributes redirectAttributes) {
		mailSendService.delete(mailSend);
		addMessage(redirectAttributes, "删除邮件发送成功");
		return "redirect:"+Global.getAdminPath()+"/mail/mailSend/?repage";
	}

}