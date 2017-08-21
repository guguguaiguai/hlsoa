<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>附件信息管理</title>
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
		<li class="active"><a href="${ctx}/attach/fileAttach/">附件信息列表</a></li>
		<shiro:hasPermission name="attach:fileAttach:edit"><li><a href="${ctx}/attach/fileAttach/form">附件信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="fileAttach" action="${ctx}/attach/fileAttach/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>文件名：</label>
				<form:input path="fileOname" htmlEscape="false" maxlength="900" class="input-medium"/>
			</li>
			<li><label>文件扩展名：</label>
				<form:input path="fileExt" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>附件类型：</label>
				<form:input path="fileType" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>文件名</th>
				<th>新文件名</th>
				<th>文件扩展名</th>
				<th>附件类型</th>
				<th>文件大小</th>
				<th>文件存放路径</th>
				<th>创建时间</th>
				<shiro:hasPermission name="attach:fileAttach:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="fileAttach">
			<tr>
				<td><a href="${ctx}/attach/fileAttach/form?id=${fileAttach.id}">
					${fileAttach.fileOname}
				</a></td>
				<td>
					${fileAttach.fileName}
				</td>
				<td>
					${fileAttach.fileExt}
				</td>
				<td>
					${fileAttach.fileType}
				</td>
				<td>
					${fileAttach.totalBytes}
				</td>
				<td>
					${fileAttach.filePath}
				</td>
				<td>
					<fmt:formatDate value="${fileAttach.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="attach:fileAttach:edit"><td>
    				<a href="${ctx}/attach/fileAttach/form?id=${fileAttach.id}">修改</a>
					<a href="${ctx}/attach/fileAttach/delete?id=${fileAttach.id}" onclick="return confirmx('确认要删除该附件信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>