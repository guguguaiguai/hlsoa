<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>常用联系人管理</title>
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
		<li class="active"><a href="${ctx}/mail/mailCommon/">常用联系人列表</a></li>
		<shiro:hasPermission name="mail:mailCommon:edit"><li><a href="${ctx}/mail/mailCommon/form">常用联系人添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="mailCommon" action="${ctx}/mail/mailCommon/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>联系人ID</th>
				<th>备注</th>
				<shiro:hasPermission name="mail:mailCommon:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="mailCommon">
			<tr>
				<td><a href="${ctx}/mail/mailCommon/form?id=${mailCommon.id}">
					${mailCommon.linkUser.id}
				</a></td>
				<td>
					${mailCommon.remarks}
				</td>
				<shiro:hasPermission name="mail:mailCommon:edit"><td>
    				<a href="${ctx}/mail/mailCommon/form?id=${mailCommon.id}">修改</a>
					<a href="${ctx}/mail/mailCommon/delete?id=${mailCommon.id}" onclick="return confirmx('确认要删除该常用联系人吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>