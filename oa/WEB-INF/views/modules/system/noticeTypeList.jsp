<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公告类别信息管理</title>
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
		<li class="active"><a href="${ctx}/system/noticeType/">公告类别信息列表</a></li>
		<shiro:hasPermission name="system:noticeType:edit"><li><a href="${ctx}/system/noticeType/form">公告类别信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="noticeType" action="${ctx}/system/noticeType/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="ntName" htmlEscape="false" maxlength="60" class="input-medium"/>
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
				<th>图标</th>
				<th>名称</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>备注</th>
				<shiro:hasPermission name="system:noticeType:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="noticeType">
			<tr>
				<td>
					<img src="${fn:substring(noticeType.ntFile,1,fn:length(noticeType.ntFile))}" title="${noticeType.ntName}" />
				</td>
				<td><a href="${ctx}/system/noticeType/form?id=${noticeType.id}">
					${noticeType.ntName}
				</a></td>
				<td>
					${noticeType.createBy.name}
				</td>
				<td>
					<fmt:formatDate value="${noticeType.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${noticeType.remarks}
				</td>
				<shiro:hasPermission name="system:noticeType:edit"><td>
    				<a href="${ctx}/system/noticeType/form?id=${noticeType.id}">修改</a>
					<a href="${ctx}/system/noticeType/delete?id=${noticeType.id}" onclick="return confirmx('确认要删除该公告类别信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>