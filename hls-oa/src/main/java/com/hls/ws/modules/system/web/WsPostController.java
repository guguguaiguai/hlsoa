/**
 * 
 */
package com.hls.ws.modules.system.web;

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
import com.hls.ws.modules.system.entity.WsPost;
import com.hls.ws.modules.system.service.WsPostService;

/**
 * 岗位信息Controller
 * @author lq
 * @version 2016-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/system/wsPost")
public class WsPostController extends BaseController {

	@Autowired
	private WsPostService wsPostService;
	
	@ModelAttribute
	public WsPost get(@RequestParam(required=false) String id) {
		WsPost entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wsPostService.get(id);
		}
		if (entity == null){
			entity = new WsPost();
		}
		return entity;
	}
	
	@RequiresPermissions("system:wsPost:view")
	@RequestMapping(value = {"list", ""})
	public String list(WsPost wsPost, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WsPost> page = wsPostService.findPage(new Page<WsPost>(request, response), wsPost); 
		model.addAttribute("page", page);
		return "modules/system/wsPostList";
	}

	@RequiresPermissions("system:wsPost:view")
	@RequestMapping(value = "form")
	public String form(WsPost wsPost, Model model) {
		model.addAttribute("wsPost", wsPost);
		return "modules/system/wsPostForm";
	}

	@RequiresPermissions("system:wsPost:edit")
	@RequestMapping(value = "save")
	public String save(WsPost wsPost, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wsPost)){
			return form(wsPost, model);
		}
		wsPostService.save(wsPost);
		addMessage(redirectAttributes, "保存岗位信息成功");
		return "redirect:"+Global.getAdminPath()+"/system/wsPost/?repage";
	}
	
	@RequiresPermissions("system:wsPost:edit")
	@RequestMapping(value = "delete")
	public String delete(WsPost wsPost, RedirectAttributes redirectAttributes) {
		wsPostService.delete(wsPost);
		addMessage(redirectAttributes, "删除岗位信息成功");
		return "redirect:"+Global.getAdminPath()+"/system/wsPost/?repage";
	}

}