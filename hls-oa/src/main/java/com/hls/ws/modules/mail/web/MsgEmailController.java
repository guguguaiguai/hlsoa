/**
 * 
 */
package com.hls.ws.modules.mail.web;

import java.util.Arrays;
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

import com.google.common.collect.Lists;
import com.hls.ws.modules.mail.entity.MailCommon;
import com.hls.ws.modules.mail.entity.MailReceive;
import com.hls.ws.modules.mail.entity.MsgEmail;
import com.hls.ws.modules.mail.service.MailCommonService;
import com.hls.ws.modules.mail.service.MailReceiveService;
import com.hls.ws.modules.mail.service.MsgEmailService;
import com.lq.work.common.config.Global;
import com.lq.work.common.mapper.JsonMapper;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.utils.DateUtils;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;
import com.lq.work.modules.sys.entity.User;
import com.lq.work.modules.sys.service.SystemService;
import com.lq.work.modules.sys.utils.UserUtils;

/**
 * 内部邮件Controller
 * @author lq
 * @version 2016-05-07
 */
@Controller
@RequestMapping(value = "${adminPath}/mail/msgEmail")
public class MsgEmailController extends BaseController {

	@Autowired
	private MsgEmailService msgEmailService;
	@Autowired
	private MailReceiveService mailReceiveService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private MailCommonService mailCommonService;
	
	@ModelAttribute
	public MsgEmail get(@RequestParam(required=false) String id) {
		MsgEmail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = msgEmailService.get(id);
		}
		if (entity == null){
			entity = new MsgEmail();
		}
		return entity;
	}
	/**
	 * 邮件回复
	 * @author JERRY
	 * @description 2016-07-04
	 * **/
	@RequiresPermissions("mail:msgEmail:edit")
	@RequestMapping(value = "mreply")
	public String mailReply(MsgEmail msgEmail, Model model){
		StringBuffer mail_content=new StringBuffer("<BR><BR><BR><span>------------------ 原始邮件 ------------------</span>");
		mail_content.append("<div><span style=\"font-weight:bold;\">发件人：</span>"+msgEmail.getCreateBy().getName()+"</div>");
		mail_content.append("<div><span style=\"font-weight:bold;\">发送时间：</span>"+DateUtils.formatDateTime(msgEmail.getCreateDate())+"</div>");
		mail_content.append("<div><span style=\"font-weight:bold;\">收件人：</span>"+msgEmail.getAcceptorNames()+"</div>");
		mail_content.append("<div><span style=\"font-weight:bold;\">主题：</span>"+msgEmail.getMailTitle()+"</div>");
		if(StringUtils.isNotEmpty(msgEmail.getMailContent()))
			mail_content.append("<div><span style=\"font-weight:bold;\">邮件内容：</span>"+msgEmail.getMailContent()+"</div>");
		//mail_content.append("<div>------------------ 原始邮件 ------------------END</div>");
		List<User> list = Lists.newArrayList();
		list.add(msgEmail.getCreateBy());
		msgEmail.setRuser(list);
		msgEmail.setMailContent(mail_content.toString());
		msgEmail.setMailTitle("Re:"+msgEmail.getMailTitle());
		model.addAttribute("mailReply", msgEmail);
		return "modules/mail/mailReply";
	}
	/**
	 * 邮件转发
	 * **/
	@RequiresPermissions("mail:msgEmail:edit")
	@RequestMapping(value = "mforward")
	public String mailForward(MsgEmail msgEmail, Model model){
		StringBuffer mail_content=new StringBuffer("<BR><BR><BR><span>------------------ 原始邮件 ------------------</span>");
		mail_content.append("<div><span style=\"font-weight:bold;\">发件人：</span>"+msgEmail.getCreateBy().getName()+"</div>");
		mail_content.append("<div><span style=\"font-weight:bold;\">发送时间：</span>"+DateUtils.formatDateTime(msgEmail.getCreateDate())+"</div>");
		mail_content.append("<div><span style=\"font-weight:bold;\">收件人：</span>"+msgEmail.getAcceptorNames()+"</div>");
		mail_content.append("<div><span style=\"font-weight:bold;\">主题：</span>"+msgEmail.getMailTitle()+"</div>");
		if(StringUtils.isNotEmpty(msgEmail.getMailContent()))
			mail_content.append("<div><span style=\"font-weight:bold;\">邮件内容：</span>"+msgEmail.getMailContent()+"</div>");
		//mail_content.append("<div>------------------ 原始邮件 ------------------END</div>");
		msgEmail.setMailContent(mail_content.toString());
		msgEmail.setMailTitle("Fw:"+msgEmail.getMailTitle());
		model.addAttribute("mailReply", msgEmail);
		return "modules/mail/mailForward";
	}
	/**
	 * 发件箱
	 * **/
	@RequiresPermissions("mail:msgEmail:view")
	@RequestMapping(value = {"list", ""})
	public String list(MsgEmail msgEmail, HttpServletRequest request, HttpServletResponse response, Model model) {
		msgEmail.setIsSend("0");
		Page<MsgEmail> page = msgEmailService.findPage(new Page<MsgEmail>(request, response), msgEmail); 
		page.setObjName("发件箱");
		model.addAttribute("page", page);
		return "modules/mail/mailSend";
	}
	/**
	 * 草稿箱
	 * **/
	@RequiresPermissions("mail:msgEmail:view")
	@RequestMapping(value = "draft")
	public String draftMail(MsgEmail msgEmail, HttpServletRequest request, HttpServletResponse response, Model model){
		msgEmail.setIsSend("1");
		Page<MsgEmail> page = msgEmailService.draftMailList(new Page<MsgEmail>(request, response), msgEmail);
		page.setObjName("草稿箱");
		model.addAttribute("dpage", page);
		return "modules/mail/mailDraft";
	}
	/**
	 * 草稿箱邮件删除,直接删除邮件信息及接收者信息
	 * @author JERRY
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "dd")
	public void draftDel(String mids, HttpServletRequest request, HttpServletResponse response){
		if(StringUtils.isEmpty(mids)){
			renderString(response, new Message(Boolean.FALSE,"请选择邮件信息！"));
		}else{
			int i=0;
			for(String mid:StringUtils.split(mids, ",")){
				i+=this.msgEmailService.draftDel(new MsgEmail(mid));
			}
			renderString(response, new Message(Boolean.TRUE,"所选邮件删除成功！"+String.valueOf(i)));
		}
	}
	
	@RequiresPermissions("mail:msgEmail:view")
	@RequestMapping(value = "form")
	public String form(MsgEmail msgEmail, Model model) {
		if(StringUtils.isNotEmpty(msgEmail.getReceiveIds())){
			List<String> list = Arrays.asList(StringUtils.split(msgEmail.getReceiveIds(), ","));
			List<User> ulist=systemService.receiveUser(list);
			msgEmail.setRuser(ulist);
			msgEmail.setReceiveUser(JsonMapper.toJsonString(ulist));
		}
		/*查询当前登录者常用联系人信息*/
		List<MailCommon> list = mailCommonService.commonList(new MailCommon());
		model.addAttribute("mclist",list);
		model.addAttribute("msgEmail", msgEmail);
		return "modules/mail/msgEmailForm";
	}
	/**
	 * 收件删除列表
	 * @author JERRY
	 * @version 2016-05-11
	 * **/
	@RequiresPermissions("mail:msgEmail:view")
	@RequestMapping(value = "mdlist")
	public String mailDelList(MsgEmail msgEmail, Model model,HttpServletRequest request,HttpServletResponse response){
		Page<MsgEmail> page = msgEmailService.mailDelList(new Page<MsgEmail>(request, response), msgEmail);
		page.setObjName("已删除");
		model.addAttribute("mdpage", page);
		return "modules/mail/mailDel";
	}
	/**
	 * 邮件详情
	 * @author JERRY
	 * @version 2016-05-11
	 * **/
	@RequiresPermissions("mail:msgEmail:view")
	@RequestMapping(value = "detail")
	public String mailSend(String id,String fd, Model model){
		if(StringUtils.isEmpty(id)){
			model.addAttribute("msgEmail", new MsgEmail());
		}else{
			MsgEmail msgEmail=this.msgEmailService.detail(new MsgEmail(id));
			if(msgEmail==null){
				model.addAttribute("msgEmail", new MsgEmail());
				return "modules/mail/mailDetail";
			}
			/**
			 * 查询是否已读，如果未读则更新
			 * **/
			MailReceive mr = new MailReceive(UserUtils.getUser(),new MsgEmail(msgEmail.getId()));
			if(StringUtils.equals(mr.getMailState(), "0")&&StringUtils.equals(mr.getIsDel(), "0")){
				mr.setMailState("1");mr.setReadDate(new Date());
				this.mailReceiveService.readFlag(mr);
				msgEmail.setFdCount(Integer.valueOf(fd));
				model.addAttribute("msgEmail", msgEmail);
			}else if(StringUtils.equals(mr.getIsDel(), "1")){
				model.addAttribute("msgEmail", new MsgEmail());
			}else{
				msgEmail.setFdCount(Integer.valueOf(fd));
				model.addAttribute("msgEmail", msgEmail);
			}
		}
		return "modules/mail/mailDetail";
	}
	/**
	 * 收件箱查看邮件
	 * @author JERRY
	 * **/
	@RequiresPermissions("mail:msgEmail:view")
	@RequestMapping(value = "rdetail")
	public String rmailSend(String id,String fd, Model model){
		if(StringUtils.isEmpty(id)){
			model.addAttribute("msgEmail", new MsgEmail());
		}else{
			MsgEmail msgEmail=this.msgEmailService.detail(new MsgEmail(id));
			if(msgEmail==null){
				model.addAttribute("msgEmail", new MsgEmail());
				return "modules/mail/sendMailDetail";
			}else{
				model.addAttribute("msgEmail", msgEmail);
			}
			/**
			 * 查询是否已读，如果未读则更新
			MailReceive mr = new MailReceive(UserUtils.getUser(),new MsgEmail(msgEmail.getId()));
			if(StringUtils.equals(mr.getMailState(), "0")&&StringUtils.equals(mr.getIsDel(), "0")){
				mr.setMailState("1");mr.setReadDate(new Date());
				this.mailReceiveService.readFlag(mr);
				msgEmail.setFdCount(Integer.valueOf(fd));
				model.addAttribute("msgEmail", msgEmail);
			}else if(StringUtils.equals(mr.getIsDel(), "1")){
				model.addAttribute("msgEmail", new MsgEmail());
			}else{
				msgEmail.setFdCount(Integer.valueOf(fd));
				model.addAttribute("msgEmail", msgEmail);
			}**/
		}
		return "modules/mail/sendMailDetail";
	}
	/**
	 * 邮箱主页,返回收件箱信息
	 * **/
	@RequiresPermissions("mail:msgEmail:view")
	@RequestMapping(value = "index")
	public String index(MsgEmail msgEmail, Model model, HttpServletResponse response,HttpServletRequest request){
		/*默认查询收件箱未读信息*/
		Page<MsgEmail> page = msgEmailService.findReceiveList(new Page<MsgEmail>(request, response), msgEmail);
		page.setObjName("收件箱");
		model.addAttribute("page", page);
		return "modules/mail/mailIndex";
	}
	@RequiresPermissions("mail:msgEmail:edit")
	@RequestMapping(value = "save")
	public String save(MsgEmail msgEmail, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, msgEmail)){
			return form(msgEmail, model);
		}
		msgEmail.setSendDate(new Date());
		msgEmail.setDraftDate(new Date());
		msgEmailService.save(msgEmail);
		if(StringUtils.equals(msgEmail.getIsSend(), "0")){//发送
			addMessage(redirectAttributes, "内部邮发送成功");
		}else{//草稿
			addMessage(redirectAttributes, "内部邮存稿成功");
			//return "redirect:"+Global.getAdminPath()+"/mail/msgEmail/mailDraft?repage";
		}
		return "redirect:"+Global.getAdminPath()+"/mail/msgEmail/?repage";
	}
	
	@RequiresPermissions("mail:msgEmail:edit")
	@RequestMapping(value = "delete")
	public String delete(MsgEmail msgEmail, RedirectAttributes redirectAttributes) {
		msgEmailService.delete(msgEmail);
		addMessage(redirectAttributes, "删除内部邮件成功");
		return "redirect:"+Global.getAdminPath()+"/mail/msgEmail/?repage";
	}
	/**
	 * 已发送邮件撤回，超过n小时后不能撤回
	 * @author JERRY
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "mback")
	public void mailBack(String mids,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(mids)){
			renderString(response, new Message(Boolean.FALSE, "请选择邮件"));
		}else{
			int i=0;
			for(String id:StringUtils.split(mids, ",")){
				i+=this.msgEmailService.mailBack(new MsgEmail(id));
			}
			renderString(response, new Message(Boolean.TRUE,"邮件撤回成功。"+String.valueOf(i)));
		}
	}
	/**
	 * 收件箱邮件删除
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "rmdel")
	public void receiveDel(String mids,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(mids)){
			renderString(response, new Message(Boolean.FALSE, "请选择邮件"));
		}else{
			int i=0;
			for(String id:StringUtils.split(mids, ",")){
				i+=this.msgEmailService.receiveDel(new MsgEmail(id));
			}
			renderString(response, new Message(Boolean.TRUE,"邮件删除成功。"+String.valueOf(i)));
		}
	}
	
}