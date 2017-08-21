/**
 * 
 */
package com.lq.work.modules.sys.web;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.lq.work.common.config.Global;
import com.lq.work.common.utils.PinyinConvertUtil;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.common.web.BaseController;
import com.lq.work.modules.sys.entity.Office;
import com.lq.work.modules.sys.entity.User;
import com.lq.work.modules.sys.service.OfficeService;
import com.lq.work.modules.sys.utils.DictUtils;
import com.lq.work.modules.sys.utils.UserUtils;

/**
 * 机构Controller
 * 
 * @version 2013-5-15
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/office")
public class OfficeController extends BaseController {

	@Autowired
	private OfficeService officeService;
	
	@ModelAttribute("office")
	public Office get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return officeService.get(id);
		}else{
			return new Office();
		}
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = {""})
	public String index(Office office, Model model) {
//        model.addAttribute("list", officeService.findAll());
		return "modules/sys/officeIndex";
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = {"list"})
	public String list(Office office, Model model) {
        model.addAttribute("list", officeService.findList(office));
		return "modules/sys/officeList";
	}
	
	@RequiresPermissions("sys:office:view")
	@RequestMapping(value = "form")
	public String form(Office office, Model model) {
		User user = UserUtils.getUser();
		if (office.getParent()==null || office.getParent().getId()==null){
			office.setParent(user.getOffice());
		}
		office.setParent(officeService.get(office.getParent().getId()));
		if (office.getArea()==null){
			office.setArea(user.getOffice().getArea());
		}
		// 自动获取排序号
		if (StringUtils.isBlank(office.getId())&&office.getParent()!=null){
			int size = 0;
			List<Office> list = officeService.findAll();
			for (int i=0; i<list.size(); i++){
				Office e = list.get(i);
				if (e.getParent()!=null && e.getParent().getId()!=null
						&& e.getParent().getId().equals(office.getParent().getId())){
					size++;
				}
			}
			office.setCode(office.getParent().getCode() + StringUtils.leftPad(String.valueOf(size > 0 ? size+1 : 1), 3, "0"));
		}
		model.addAttribute("office", office);
		return "modules/sys/officeForm";
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "save")
	public String save(Office office, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/office/";
		}
		if (!beanValidator(model, office)){
			return form(office, model);
		}
		officeService.save(office);
		
		if(office.getChildDeptList()!=null){
			Office childOffice = null;
			for(String id : office.getChildDeptList()){
				childOffice = new Office();
				childOffice.setName(DictUtils.getDictLabel(id, "sys_office_common", "未知"));
				childOffice.setParent(office);
				childOffice.setArea(office.getArea());
				childOffice.setType("2");
				childOffice.setGrade(String.valueOf(Integer.valueOf(office.getGrade())+1));
				childOffice.setUseable(Global.YES);
				officeService.save(childOffice);
			}
		}
		
		addMessage(redirectAttributes, "保存机构'" + office.getName() + "'成功");
		String id = "0".equals(office.getParentId()) ? "" : office.getParentId();
		return "redirect:" + adminPath + "/sys/office/list?id="+id+"&parentIds="+office.getParentIds();
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping(value = "delete")
	public String delete(Office office, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/sys/office/list";
		}
//		if (Office.isRoot(id)){
//			addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
//		}else{
			officeService.delete(office);
			addMessage(redirectAttributes, "删除机构成功");
//		}
		return "redirect:" + adminPath + "/sys/office/list?id="+office.getParentId()+"&parentIds="+office.getParentIds();
	}

	/**
	 * 获取机构JSON数据。
	 * @param extId 排除的ID
	 * @param type	类型（1：公司；2：部门/小组/其它：3：用户）
	 * @param grade 显示级别
	 * @param response
	 * @return
	 */
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<TreeData> treeData(@RequestParam(required=false) String extId, @RequestParam(required=false) String type,
			@RequestParam(required=false) Long grade, @RequestParam(required=false) Boolean isAll, HttpServletResponse response) {
		//List<Map<String, Object>> mapList = Lists.newArrayList();
		List<TreeData> td_list = Lists.newArrayList();
		List<Office> list = officeService.findList(isAll);
		for (int i=0; i<list.size(); i++){
			Office e = list.get(i);
			if ((StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1))
					&& (type == null || (type != null && (type.equals("1") ? type.equals(e.getType()) : true)))
					&& (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))
					&& Global.YES.equals(e.getUseable())){
				/*Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("pIds", e.getParentIds());
				map.put("name", e.getName());
				if (type != null && "3".equals(type)){
					map.put("isParent", true);
				}
				mapList.add(map);*/
				TreeData td = new TreeData(e.getId(),e.getParentId(),e.getParentIds(),e.getName());
				if (type != null && "3".equals(type)){td.setIsParent(Boolean.TRUE);}
				td_list.add(td);
			}
		}
		// 创建字段排序类
		Comparator<Object> comparator = new Comparator<Object>() {
			@Override
			public int compare(Object o1, Object o2) {
				String sort1 = "", sort2 = "";
				if (o1 instanceof TreeData){
					sort1 = ((TreeData)o1).getName();
				}
				if (o2 instanceof TreeData){
					sort2 = ((TreeData)o2).getName();
				}
				return PinyinConvertUtil.getFirstSpell(sort1).compareTo(PinyinConvertUtil.getFirstSpell(sort2));
			}
		};
		Collections.sort(td_list, comparator);
		return td_list;
	}
	/**
	 * 公告阅读情况部门信息查询
	 * @author JERRY
	 * **/
	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "notify")
	public List<Map<String,Object>> notifyOffice(String nid,HttpServletResponse response){
		List<Map<String, Object>> mapList = Lists.newArrayList();
		if(StringUtils.isNotEmpty(nid)){
			//Office o = this.officeService.get("1");
			List<Office> list = this.officeService.notifyOffice(new Office("",nid));
			//list.add(o);
			for (Office e:list){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("pIds", e.getParentIds());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	/**
	 * 更新部门
	 * @author JERRY
	 * **/
	@RequiresPermissions("sys:office:hisup")
	@RequestMapping(value = "hisUp")
	public void hisDep(Office office,HttpServletRequest request,HttpServletResponse response){
		if(StringUtils.equals(office.getDbName(), "oracle")){
			/*测试存储过程*/
			Map map = new HashMap();
			try {
				officeService.hisDep(map);
				if(map!=null){
					String result=map.get("office_result").toString();
					System.out.println(map.get("office_result")+".....>>>");
					if(StringUtils.equals(result, "0")){
						renderString(response, new Message(Boolean.FALSE,"科室信息同步失败！"));
					}else{
						renderString(response, new Message(Boolean.TRUE,"科室信息同步成功！"+result));
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				renderString(response, new Message(Boolean.FALSE,"科室信息同步异常！"+e.getMessage()));
			}
		}else{
			renderString(response, new Message(Boolean.FALSE,"科室数据同步目前只针对ORACLE数据库！"));
		}
	}
	/**
	 * 部门属性结构对象
	 * **/
	public class TreeData{
		private String id;//部门主键
		private String pId;//上级主键
		private String pIds;//上级主键
		private String name;//名称
		private Boolean isParent=Boolean.FALSE;
		
		public TreeData() {}
		public TreeData(String id, String pId, String pIds, String name) {
			this.id = id;
			this.pId = pId;
			this.pIds = pIds;
			this.name = name;
		}
		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getpId() {
			return pId;
		}
		public void setpId(String pId) {
			this.pId = pId;
		}
		public String getpIds() {
			return pIds;
		}
		public void setpIds(String pIds) {
			this.pIds = pIds;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public Boolean getIsParent() {
			return isParent;
		}
		public void setIsParent(Boolean isParent) {
			this.isParent = isParent;
		}
		
	}
}
