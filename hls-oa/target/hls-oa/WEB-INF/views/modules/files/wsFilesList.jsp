<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文件管理</title>
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
		<li class="active"><a href="${ctx}/files/wsFiles/">文件列表</a></li>
		<shiro:hasPermission name="files:wsFiles:edit"><li><a href="${ctx}/files/wsFiles/form">文件添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="wsFiles" action="${ctx}/files/wsFiles/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>文件标题：</label>
				<form:input path="fileTitle" htmlEscape="false" maxlength="1200" class="input-medium"/>
			</li>
			<li><label>文件名称：</label>
				<form:input path="fileNames" htmlEscape="false" maxlength="2100" class="input-medium"/>
			</li>
			<li><label>创建者：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>备注：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="900" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>文件标题</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="files:wsFiles:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="wsFiles">
			<tr>
				<td><a href="${ctx}/files/wsFiles/form?id=${wsFiles.id}">
					${wsFiles.fileTitle}
				</a></td>
				<td>
					<fmt:formatDate value="${wsFiles.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${wsFiles.remarks}
				</td>
				<shiro:hasPermission name="files:wsFiles:edit"><td>
					<a href="${ctx}/files/wsFiles/form?id=${wsFiles.id}">详细</a>
    				<a href="${ctx}/files/wsFiles/form?id=${wsFiles.id}">修改</a>
					<a href="${ctx}/files/wsFiles/delete?id=${wsFiles.id}" onclick="return confirmx('确认要删除该文件吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>