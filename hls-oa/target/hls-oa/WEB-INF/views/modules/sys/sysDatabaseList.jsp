<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>数据库备份管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
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
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/sysDatabase/">数据库备份列表</a></li>
		<shiro:hasPermission name="sys:sysDatabase:edit"><li><a href="${ctx}/sys/sysDatabase/form">数据库备份添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysDatabase" action="${ctx}/sys/sysDatabase/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>数据库类型：</label>
				<form:select path="databaseType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('database_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>备份开始时间：</label>
				<input name="beginStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${sysDatabase.beginStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${sysDatabase.endStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备份结束时间：</label>
				<input name="beginEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${sysDatabase.beginEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${sysDatabase.endEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>数据库类型</th>
				<th>备份开始时间</th>
				<th>备份结束时间</th>
				<th>备份文件大小</th>
				<shiro:hasPermission name="sys:sysDatabase:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysDatabase">
			<tr>
				<td><a href="${ctx}/sys/sysDatabase/form?id=${sysDatabase.id}">
					${fns:getDictLabel(sysDatabase.databaseType, 'database_type', '')}
				</a></td>
				<td>
					<fmt:formatDate value="${sysDatabase.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${sysDatabase.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysDatabase.fileSize}
				</td>
				<shiro:hasPermission name="sys:sysDatabase:edit"><td>
    				<a href="${ctx}/sys/sysDatabase/form?id=${sysDatabase.id}">修改</a>
					<a href="${ctx}/sys/sysDatabase/delete?id=${sysDatabase.id}" onclick="return confirmx('确认要删除该数据库备份吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>