<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>岗位信息管理</title>
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
		<li class="active"><a href="${ctx}/system/wsPost/">岗位信息列表</a></li>
		<shiro:hasPermission name="system:wsPost:edit"><li><a href="${ctx}/system/wsPost/form">岗位信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="wsPost" action="${ctx}/system/wsPost/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>岗位名称：</label>
				<form:input path="postName" htmlEscape="false" maxlength="60" class="input-medium"/>
			</li>
			<li><label>是否显示：</label>
				<form:radiobuttons path="isView" items="${fns:getDictList('is_show')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>岗位名称</th>
				<th>排序</th>
				<th>是否显示</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="system:wsPost:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="wsPost">
			<tr>
				<td><a href="${ctx}/system/wsPost/form?id=${wsPost.id}">
					${wsPost.postName}
				</a></td>
				<td>
					${wsPost.postSort}
				</td>
				<td>
					${fns:getDictLabel(wsPost.isView, 'is_show', '')}
				</td>
				<td>
					${wsPost.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${wsPost.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${wsPost.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${wsPost.remarks}
				</td>
				<shiro:hasPermission name="system:wsPost:edit"><td>
    				<a href="${ctx}/system/wsPost/form?id=${wsPost.id}">修改</a>
					<a href="${ctx}/system/wsPost/delete?id=${wsPost.id}" onclick="return confirmx('确认要删除该岗位信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>