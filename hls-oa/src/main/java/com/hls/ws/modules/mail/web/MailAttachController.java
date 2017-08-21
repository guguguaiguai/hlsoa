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
import com.hls.ws.modules.mail.entity.MailAttach;
import com.hls.ws.modules.mail.service.MailAttachService;

/**
 * 邮件附件Controller
 * @author lq
 * @version 2016-09-09
 */
@Controller
@RequestMapping(value = "${adminPath}/mail/mailAttach")
public class MailAttachController extends BaseController {

	@Autowired
	private MailAttachService mailAttachService;
	
	@ModelAttribute
	public MailAttach get(@RequestParam(required=false) String id) {
		MailAttach entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = mailAttachService.get(id);
		}
		if (entity == null){
			entity = new MailAttach();
		}
		return entity;
	}
	
	@RequiresPermissions("mail:mailAttach:view")
	@RequestMapping(value = {"list", ""})
	public String list(MailAttach mailAttach, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MailAttach> page = mailAttachService.findPage(new Page<MailAttach>(request, response), mailAttach); 
		model.addAttribute("page", page);
		return "modules/mail/mailAttachList";
	}

	@RequiresPermissions("mail:mailAttach:view")
	@RequestMapping(value = "form")
	public String form(MailAttach mailAttach, Model model) {
		model.addAttribute("mailAttach", mailAttach);
		return "modules/mail/mailAttachForm";
	}

	@RequiresPermissions("mail:mailAttach:edit")
	@RequestMapping(value = "save")
	public String save(MailAttach mailAttach, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, mailAttach)){
			return form(mailAttach, model);
		}
		mailAttachService.save(mailAttach);
		addMessage(redirectAttributes, "保存邮件附件成功");
		return "redirect:"+Global.getAdminPath()+"/mail/mailAttach/?repage";
	}
	
	@RequiresPermissions("mail:mailAttach:edit")
	@RequestMapping(value = "delete")
	public String delete(MailAttach mailAttach, RedirectAttributes redirectAttributes) {
		mailAttachService.delete(mailAttach);
		addMessage(redirectAttributes, "删除邮件附件成功");
		return "redirect:"+Global.getAdminPath()+"/mail/mailAttach/?repage";
	}

}