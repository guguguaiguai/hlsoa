<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文件共享管理</title>
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
		<li class="active"><a href="${ctx}/files/fileReleased/">文件共享列表</a></li>
		<shiro:hasPermission name="files:fileReleased:edit"><li><a href="${ctx}/files/fileReleased/form">文件共享添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="fileReleased" action="${ctx}/files/fileReleased/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>文件共享人，文件查看权，单个人共享：</label>
				<sys:treeselect id="fileShare" name="fileShare" value="${fileReleased.fileShare}" labelName="" labelValue="${fileReleased.}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>文件授权者，共享文件的人（文件拥有人）：</label>
				<sys:treeselect id="fileGrantee" name="fileGrantee.id" value="${fileReleased.fileGrantee.id}" labelName="fileGrantee.fileGrantee.id" labelValue="${fileReleased.fileGrantee.fileGrantee.id}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>共享文件到部门：</label>
				<sys:treeselect id="fileDep" name="fileDep.id" value="${fileReleased.fileDep.id}" labelName="fileDep.fileDep.name" labelValue="${fileReleased.fileDep.fileDep.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${fileReleased.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${fileReleased.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
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
				<th>文件授权者，共享文件的人（文件拥有人）</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="files:fileReleased:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="fileReleased">
			<tr>
				<td><a href="${ctx}/files/fileReleased/form?id=${fileReleased.id}">
					${fileReleased.fileGrantee.fileGrantee.id}
				</a></td>
				<td>
					<fmt:formatDate value="${fileReleased.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${fileReleased.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fileReleased.remarks}
				</td>
				<shiro:hasPermission name="files:fileReleased:edit"><td>
    				<a href="${ctx}/files/fileReleased/form?id=${fileReleased.id}">修改</a>
					<a href="${ctx}/files/fileReleased/delete?id=${fileReleased.id}" onclick="return confirmx('确认要删除该文件共享吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>