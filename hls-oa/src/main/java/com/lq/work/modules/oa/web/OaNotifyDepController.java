/**
 * 
 */
package com.lq.work.modules.oa.web;

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
import com.lq.work.modules.oa.entity.OaNotifyDep;
import com.lq.work.modules.oa.service.OaNotifyDepService;

/**
 * 部门公告记录Controller
 * @author lq
 * @version 2016-05-08
 */
@Controller
@RequestMapping(value = "${adminPath}/oa/oaNotifyDep")
public class OaNotifyDepController extends BaseController {

	@Autowired
	private OaNotifyDepService oaNotifyDepService;
	
	@ModelAttribute
	public OaNotifyDep get(@RequestParam(required=false) String id) {
		OaNotifyDep entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = oaNotifyDepService.get(id);
		}
		if (entity == null){
			entity = new OaNotifyDep();
		}
		return entity;
	}
	
	@RequiresPermissions("oa:oaNotifyDep:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaNotifyDep oaNotifyDep, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaNotifyDep> page = oaNotifyDepService.findPage(new Page<OaNotifyDep>(request, response), oaNotifyDep); 
		model.addAttribute("page", page);
		return "modules/oa/oaNotifyDepList";
	}

	@RequiresPermissions("oa:oaNotifyDep:view")
	@RequestMapping(value = "form")
	public String form(OaNotifyDep oaNotifyDep, Model model) {
		model.addAttribute("oaNotifyDep", oaNotifyDep);
		return "modules/oa/oaNotifyDepForm";
	}

	@RequiresPermissions("oa:oaNotifyDep:edit")
	@RequestMapping(value = "save")
	public String save(OaNotifyDep oaNotifyDep, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, oaNotifyDep)){
			return form(oaNotifyDep, model);
		}
		oaNotifyDepService.save(oaNotifyDep);
		addMessage(redirectAttributes, "保存部门公告记录成功");
		return "redirect:"+Global.getAdminPath()+"/oa/oaNotifyDep/?repage";
	}
	
	@RequiresPermissions("oa:oaNotifyDep:edit")
	@RequestMapping(value = "delete")
	public String delete(OaNotifyDep oaNotifyDep, RedirectAttributes redirectAttributes) {
		oaNotifyDepService.delete(oaNotifyDep);
		addMessage(redirectAttributes, "删除部门公告记录成功");
		return "redirect:"+Global.getAdminPath()+"/oa/oaNotifyDep/?repage";
	}

}