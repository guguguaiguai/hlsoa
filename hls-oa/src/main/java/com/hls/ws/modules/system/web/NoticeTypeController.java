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
import com.lq.work.common.utils.CacheUtils;
import com.lq.work.common.utils.StringUtils;
import com.hls.ws.modules.system.entity.NoticeType;
import com.hls.ws.modules.system.service.NoticeTypeService;
import com.hls.ws.modules.util.NotifyUtil;

/**
 * 公告类别Controller
 * @author lq
 * @version 2016-05-06
 */
@Controller
@RequestMapping(value = "${adminPath}/system/noticeType")
public class NoticeTypeController extends BaseController {

	@Autowired
	private NoticeTypeService noticeTypeService;
	
	@ModelAttribute
	public NoticeType get(@RequestParam(required=false) String id) {
		NoticeType entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = noticeTypeService.get(id);
		}
		if (entity == null){
			entity = new NoticeType();
		}
		return entity;
	}
	
	@RequiresPermissions("system:noticeType:view")
	@RequestMapping(value = {"list", ""})
	public String list(NoticeType noticeType, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<NoticeType> page = noticeTypeService.findPage(new Page<NoticeType>(request, response), noticeType); 
		model.addAttribute("page", page);
		return "modules/system/noticeTypeList";
	}

	@RequiresPermissions("system:noticeType:view")
	@RequestMapping(value = "form")
	public String form(NoticeType noticeType, Model model) {
		model.addAttribute("noticeType", noticeType);
		return "modules/system/noticeTypeForm";
	}

	@RequiresPermissions("system:noticeType:edit")
	@RequestMapping(value = "save")
	public String save(NoticeType noticeType, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, noticeType)){
			return form(noticeType, model);
		}
		noticeTypeService.save(noticeType);
		CacheUtils.remove(NotifyUtil.NOTIFY_TYPE_LIST);
		addMessage(redirectAttributes, "保存公告类别信息成功");
		return "redirect:"+Global.getAdminPath()+"/system/noticeType/?repage";
	}
	
	@RequiresPermissions("system:noticeType:edit")
	@RequestMapping(value = "delete")
	public String delete(NoticeType noticeType, RedirectAttributes redirectAttributes) {
		noticeTypeService.delete(noticeType);
		CacheUtils.remove(NotifyUtil.NOTIFY_TYPE_LIST);
		addMessage(redirectAttributes, "删除公告类别信息成功");
		return "redirect:"+Global.getAdminPath()+"/system/noticeType/?repage";
	}

}