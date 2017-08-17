<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var nrid="";
		$(document).ready(function() {
			$("#notify_check").click(function(){
				if($(this).prop('checked')){
					$("input[type='checkbox'][name='list_check']").prop('checked',true);
				}else{
					$("input[type='checkbox'][name='list_check']").prop('checked',false);
				}
			});
			/*通知批量撤回*/
			$("#btn_back").click(function(){
				var news_ids=[];
				$("input[type='checkbox'][name='list_check']").each(function(i){
					if($(this).prop('checked'))
						news_ids.push($(this).val());
				});
				if(news_ids.length<1){
					top.$.jBox.info("请选择撤回通知！","提示",{opacity:0.3});
				}else{
					top.$.jBox.confirm("确定撤回？","确认",function(v,h,f){
						if(v=='ok'){
							$.getJSON("${ctx}/oa/oaNotify/nback",{nids:news_ids.join(',')},function(data){
								if(data.success){
									top.$.jBox.info("通知撤回成功！","提示",{opacity:0.3,closed:function(){
										window.location.reload();
									}});
								}else{
									top.$.jBox.info(data.msg,"异常",{opacity:0.3});
								}
							});
						}
					},{opacity:0.3})
				}
			});
			/*添加*/
			$("#btn_add").click(function(){
				window.location.href="${ctx}/oa/oaNotify/form";
			});
		});
		function back_notify(id){
			if(id==''||id==null){
				top.$.jBox.info("请选择撤回通知！","提示",{opacity:0.3});
				return;
			}
			top.$.jBox.confirm("确定撤回？","确认",function(v,h,f){
				if(v=='ok'){
					$.getJSON("${ctx}/oa/oaNotify/nback",{nids:id},function(data){
						if(data.success){
							top.$.jBox.info("通知撤回成功！","提示",{opacity:0.3,closed:function(){
								window.location.reload();
							}});
						}else{
							top.$.jBox.info(data.msg,"异常",{opacity:0.3});
						}
					});
				}
			},{opacity:0.3});
		}
		function read_info(rid){
			nrid=rid;
			$("#notify_id").val(rid);
			$.jBox("iframe:${ctx}/oa/oaNotify/rindex",{top:"1%",showClose:true,width:1100,height:550,title:"公告阅读情况",id:"jBox_notify_read",persistent:true,opacity:0.4,buttons:{'关闭':true}});
		}
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<input type="hidden" id="notify_id" />
	<form:form id="searchForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${ht:noticeTypeList()}" itemLabel="ntName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<c:if test="${!requestScope.oaNotify.self}"><li><label>状态：</label>
				<form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li></c:if>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			<li class="btns"><input id="btn_back" class="btn btn-primary" type="button" value="撤回"/>
			<li class="btns"><input id="btn_add" class="btn btn-primary" type="button" value="添加"/>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="3%">
					<input type="checkbox" id="notify_check" />
				</th>
				<th width="40%">标题</th>
				<th width="10%">类型</th>
				<th width="7%">状态</th>
				<th width="7%">查阅状态</th>
				<th width="12%">发送时间</th>
				<c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit"><th width="12%">操作</th></shiro:hasPermission></c:if>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaNotify">
			<tr>
				<td>
					<input type="checkbox" name="list_check" value="${oaNotify.id}" />
				</td>
				<td>
					<c:if test="${not empty oaNotify.files}">
						<i class=" icon-paper-clip"></i>
					</c:if>
					<a href="${ctx}/oa/oaNotify/${requestScope.oaNotify.self?'view':'form'}?id=${oaNotify.id}">
					<c:if test="${oaNotify.status=='0'}">
						<font color="#23c6c8"><strong><span style="font-size:13px;font-weight:bold;">${fns:abbr(oaNotify.title,50)}</span></strong></font>
					</c:if>
					<c:if test="${oaNotify.status=='1'}">
						<font color="#A9A9A9"><strong><span style="font-size:13px;font-weight:bold;">${fns:abbr(oaNotify.title,50)}</span></strong></font>
					</c:if>					
				</a></td>
				<td>
					${ht:noticeTypeName(oaNotify.type,'未知')}
				</td>
				<td>
					${fns:getDictLabel(oaNotify.status, 'oa_notify_status', '')}
				</td>
				<td>
					<c:if test="${requestScope.oaNotify.self}">
						${fns:getDictLabel(oaNotify.readFlag, 'oa_notify_read', '')}
					</c:if>
					<c:if test="${!requestScope.oaNotify.self}">
						${(oaNotify.readNum==''||oaNotify.readNum==null)?'0':oaNotify.readNum} / <a href="javascript:read_info('${oaNotify.id }');">${(oaNotify.unReadNum==''||oaNotify.unReadNum==null)?0:oaNotify.unReadNum}</a>
					</c:if>
				</td>
				<td>
					<fmt:formatDate value="${oaNotify.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="oa:oaNotify:edit"><td>
					<shiro:hasPermission name="oa:oaNotify:back">
					<c:if test="${oaNotify.status=='1'}">
					<a href="javascript:void(0);" onclick="back_notify('${oaNotify.id}')">撤回</a></c:if></shiro:hasPermission>
					<c:if test="${oaNotify.status=='0'}">
						<a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">修改</a>
						<a href="${ctx}/oa/oaNotify/delete?id=${oaNotify.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)">删除</a>
					</c:if>
					
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>