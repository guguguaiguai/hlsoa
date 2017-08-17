<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日志管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(function(){
			$("#log_check").click(function(){
				if($(this).prop('checked')){
					$("input[type='checkbox'][name='list_check']").prop('checked',true);
				}else{
					$("input[type='checkbox'][name='list_check']").prop('checked',false);
				}
			});
			$("#btnDel").click(function(){
				var log_ids=[];
				$("input[type='checkbox'][name='list_check']").each(function(i){
					if($(this).prop('checked'))
						log_ids.push($(this).val());
				});
				if(log_ids.length<1){
					top.$.jBox.info("请选择删除数据！","提示",{opacity:0.6});
				}else{
					top.$.jBox.confirm("确定删除已选数据？","确认",function(v,h,f){
						if(v=='ok'){
							$.getJSON("${ctx}/sys/log/del",{ids:log_ids.join(',')},function(data){
								if(data.success){
									top.$.jBox.info(data.msg,"提示",{opacity:0.3,closed:function(){
										window.location.reload();
									}});
								}else{
									top.$.jBox.error("数据删除失败："+data.msg,"异常",{opacity:0.3});
								}
							});
						}
					},{opacity:0.3})
				}
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
<!-- 	<ul class="nav nav-tabs"> -->
<%-- 		<li class="active"><a href="${ctx}/sys/log/">日志列表</a></li> --%>
<!-- 	</ul> -->
	<form:form id="searchForm" action="${ctx}/sys/log/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div>
		    <!--  <label>操作菜单：</label><input id="title" name="title" type="text" maxlength="50" class="input-mini" value="${log.title}"/> -->
			<label>用户ID：</label><input id="createBy.id" name="createBy.id" type="text" maxlength="50" class="input-mini" value="${log.createBy.id}"/>
			<!--  <label>URI：</label><input id="requestUri" name="requestUri" type="text" maxlength="50" class="input-mini" value="${log.requestUri}"/> -->
		</div><div style="margin-top:8px;">
			<label>日期范围：&nbsp;</label><input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
				value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			<label>&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
				value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>&nbsp;&nbsp;
			&nbsp;<label for="exception"><input id="exception" name="exception" type="checkbox"${log.exception eq '1'?' checked':''} value="1"/>只查询异常信息</label>
			&nbsp;&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
			<!--  <input id="btnDel" class="btn btn-primary" type="button" value="删除"/>  -->
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><!-- <th><input type="checkbox" id="log_check" /></th>--><th>操作用户id</th><th>操作用户</th><th>所在院区</th><th>所在科室</th><th>操作者IP</th><th>操作者级别</th><th>总计</th></thead>
		<tbody><%request.setAttribute("strEnter", "\n");request.setAttribute("strTab", "\t");%>
		<c:forEach items="${page.list}" var="log">
			<tr>
			    <!--  
			    <td>
					<input type="checkbox" name="list_check" value="${log.createBy.id}" />
				</td>
				-->
				<td>${log.createBy.id}</td>
				<td>${log.createBy.name}</td>
				<td>${log.createBy.company.name}</td>
				<td>${log.createBy.office.name}</td>
				<td>${log.remoteAddr}</td>
				<td>${log.ygjb}</td>
				<td>
				<c:if test="${log.total<20}">
				    <font color="red">${log.total}</font>
				</c:if>
				<c:if test="${log.total>=20}">
				    ${log.total}
				</c:if> 
				
				</td>
			</tr>
			<c:if test="${not empty log.exception}"><tr>
				<td colspan="8" style="word-wrap:break-word;word-break:break-all;">
<%-- 					用户代理: ${log.userAgent}<br/> --%>
<%-- 					提交参数: ${fns:escapeHtml(log.params)} <br/> --%>
					异常信息: <br/>
					${fn:replace(fn:replace(fns:escapeHtml(log.exception), strEnter, '<br/>'), strTab, '&nbsp; &nbsp; ')}</td>
			</tr></c:if>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>