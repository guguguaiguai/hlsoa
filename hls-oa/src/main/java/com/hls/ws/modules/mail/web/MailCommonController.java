/**
 * 
 */
package com.hls.ws.modules.mail.web;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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

import com.hls.ws.modules.mail.entity.MailCommon;
import com.hls.ws.modules.mail.service.MailCommonService;
import com.lq.work.common.config.Global;
import com.lq.work.common.persistence.Page;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;
import com.lq.work.modules.sys.entity.User;
import com.lq.work.modules.sys.utils.UserUtils;

/**
 * 常用联系人Controller
 * @author lq
 * @version 2016-09-10
 */
@Controller
@RequestMapping(value = "${adminPath}/mail/mailCommon")
public class MailCommonController extends BaseController {

	@Autowired
	private MailCommonService mailCommonService;
	
	@ModelAttribute
	public MailCommon get(@RequestParam(required=false) String id) {
		MailCommon entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = mailCommonService.get(id);
		}
		if (entity == null){
			entity = new MailCommon();
		}
		return entity;
	}
	
	@RequiresPermissions("mail:mailCommon:view")
	@RequestMapping(value = {"list", ""})
	public String list(MailCommon mailCommon, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<MailCommon> page = mailCommonService.findPage(new Page<MailCommon>(request, response), mailCommon); 
		model.addAttribute("page", page);
		return "modules/mail/mailCommonList";
	}

	@RequiresPermissions("mail:mailCommon:view")
	@RequestMapping(value = "form")
	public String form(MailCommon mailCommon, Model model) {
		model.addAttribute("mailCommon", mailCommon);
		return "modules/mail/mailCommonForm";
	}

	@RequiresPermissions("mail:mailCommon:edit")
	@RequestMapping(value = "save")
	public String save(MailCommon mailCommon, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, mailCommon)){
			return form(mailCommon, model);
		}
		mailCommonService.save(mailCommon);
		addMessage(redirectAttributes, "保存常用联系人成功");
		return "redirect:"+Global.getAdminPath()+"/mail/mailCommon/?repage";
	}
	/**
	 * 查询当前登录者常用联系人信息
	 * @author JERRY
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "mclist")
	public void mailCommonList(HttpServletRequest request,HttpServletResponse response){
		List<MailCommon> list = mailCommonService.commonList(new MailCommon());
		renderString(response, new Message(Boolean.TRUE,list));
	}
	/**
	 * 批量添加常用联系人，已添加过的需要判断
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "add")
	public void add(String mcids,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(mcids)){
			renderString(response, new Message(Boolean.FALSE,"请选择人员！"));
		}else{
			List<MailCommon> list = mailCommonService.commonList(new MailCommon());
			Set<String> set = new HashSet<String>(Arrays.asList(StringUtils.split(mcids, ",")));
			if(set.contains(UserUtils.getUser().getId()))
				set.remove(UserUtils.getUser().getId());
			if(list.size()>0){
				for(MailCommon mc:list){
					if(set.contains(mc.getLinkUser().getId()))
						set.remove(mc.getLinkUser().getId());
				}
			}
			/*如果set不为空则执行插入操作*/
			if(set.size()>0){
				for(String id:set){
					User link_user = new User(id);
					MailCommon mc = new MailCommon();
					mc.setLinkUser(link_user);
					mailCommonService.save(mc);
				}
				renderString(response, new Message(Boolean.TRUE, "添加成功"));
			}else{
				renderString(response, new Message(Boolean.TRUE, "添加重复"));
			}
		}
	}
	/**
	 * 根据ID删除常用联系人信息
	 * @author JERRY
	 * **/
	@RequiresPermissions("user")
	@RequestMapping(value = "del")
	public void delCommon(String ids,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.isEmpty(ids)){
			renderString(response, new Message(Boolean.FALSE,"请选择常用人员信息！"));
		}else{
			int i=0;
			String[] id_=StringUtils.split(ids, ",");
			for(String id:id_){
				i+=mailCommonService.delCommon(new MailCommon(id));
			}
			renderString(response, new Message(Boolean.TRUE,"成功删除"+i+"条信息！"));
		}
	}
	@RequiresPermissions("mail:mailCommon:edit")
	@RequestMapping(value = "delete")
	public String delete(MailCommon mailCommon, RedirectAttributes redirectAttributes) {
		mailCommonService.delete(mailCommon);
		addMessage(redirectAttributes, "删除常用联系人成功");
		return "redirect:"+Global.getAdminPath()+"/mail/mailCommon/?repage";
	}

}