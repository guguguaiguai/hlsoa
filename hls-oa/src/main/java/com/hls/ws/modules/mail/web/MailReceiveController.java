/**
 * 
 */
package com.hls.ws.modules.mail.web;

import java.util.Date;
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

import com.hls.ws.modules.mail.entity.MailReceive;
import com.hls.ws.modules.mail.entity.MsgEmail;
import com.hls.ws.modules.mail.service.MailReceiveService;
import com.lq.work.common.config.Global;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;
import com.lq.work.modules.sys.utils.UserUtils;

/**
 * 邮件接收信息Controller
 * @author lq
 * @version 2016-05-07
 */
@Controller
@RequestMapping(value = "${adminPath}/mail/mailReceive")
public class MailReceiveController extends BaseController {

	@Autowired
	private MailReceiveService mailReceiveService;
	
	@ModelAttribute
	public MailReceive get(@RequestParam(required=false) String id) {
		MailReceive entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = mailReceiveService.get(id);
		}
		if (entity == null){
			entity = new MailReceive();
		}
		return entity;
	}
	
	@RequiresPermissions("mail:mailReceive:view")
	@RequestMapping(value = {"list", ""})
	public String list(MailReceive mailReceive, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MailReceive> page = mailReceiveService.findPage(new Page<MailReceive>(request, response), mailReceive); 
		model.addAttribute("page", page);
		return "modules/mail/mailReceiveList";
	}

	@RequiresPermissions("mail:mailReceive:view")
	@RequestMapping(value = "form")
	public String form(MailReceive mailReceive, Model model) {
		model.addAttribute("mailReceive", mailReceive);
		return "modules/mail/mailReceiveForm";
	}

	@RequiresPermissions("mail:mailReceive:edit")
	@RequestMapping(value = "save")
	public String save(MailReceive mailReceive, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, mailReceive)){
			return form(mailReceive, model);
		}
		mailReceiveService.save(mailReceive);
		addMessage(redirectAttributes, "保存邮件接收信息成功");
		return "redirect:"+Global.getAdminPath()+"/mail/mailReceive/?repage";
	}
	
	@RequiresPermissions("mail:mailReceive:edit")
	@RequestMapping(value = "delete")
	public String delete(MailReceive mailReceive, RedirectAttributes redirectAttributes) {
		mailReceiveService.delete(mailReceive);
		addMessage(redirectAttributes, "删除邮件接收信息成功");
		return "redirect:"+Global.getAdminPath()+"/mail/mailReceive/?repage";
	}
	/**
	 * 收件箱邮件删除
	 * @author JERRY
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "rdel")
	public void receiveDel(String mids,HttpServletResponse response){
		if(StringUtils.isEmpty(mids)){
			renderString(response, new Message(Boolean.FALSE,"请选择需要删除的邮件数据！"));
		}else{
			int i=StringUtils.split(mids, ",").length;
			int j=0;
			for(String id:StringUtils.split(mids, ",")){
				MailReceive mr = new MailReceive(new MsgEmail(id));
				mr.setIsDel("1");mr.setMailReceive(UserUtils.getUser());
				j+=this.mailReceiveService.delReceive(mr);
			}
			renderString(response, new Message(Boolean.TRUE,String.valueOf(j)));
		}
	}
	/**
	 * 批量标记为已读
	 * @author JERRY
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "mread")
	public void mailRead(String mids,HttpServletResponse response){
		if(StringUtils.isEmpty(mids)){
			renderString(response, new Message(Boolean.FALSE,"请选择需要删除的邮件数据！"));
		}else{
			int i=StringUtils.split(mids, ",").length;
			int j=0;
			for(String id:StringUtils.split(mids, ",")){
				MailReceive mr = new MailReceive(new MsgEmail(id));
				mr.setReadDate(new Date());
				mr.setMailState("1");mr.setMailReceive(UserUtils.getUser());
				j+=this.mailReceiveService.readFlag(mr);
			}
			renderString(response, new Message(Boolean.TRUE,String.valueOf(j)));
		}
	}
	/**
	 * 查询邮件接收人阅读信息
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "mri")
	public String mainReadInfo(String mid, Model model){
		List<MailReceive> list = this.mailReceiveService.mailReadInfo(new MailReceive(new MsgEmail(mid)));
		model.addAttribute("mrlist", list);
		return "modules/mail/readInfo";
	}
}