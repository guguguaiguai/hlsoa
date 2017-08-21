<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文件共享管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/files/fileReleased/">文件共享列表</a></li>
		<li class="active"><a href="${ctx}/files/fileReleased/form?id=${fileReleased.id}">文件共享<shiro:hasPermission name="files:fileReleased:edit">${not empty fileReleased.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="files:fileReleased:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="fileReleased" action="${ctx}/files/fileReleased/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">文件主键：</label>
			<div class="controls">
				<form:input path="fileId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件共享人，文件查看权，单个人共享：</label>
			<div class="controls">
				<sys:treeselect id="fileShare" name="fileShare" value="${fileReleased.fileShare}" labelName="" labelValue="${fileReleased.}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件授权者，共享文件的人（文件拥有人）：</label>
			<div class="controls">
				<sys:treeselect id="fileGrantee" name="fileGrantee.id" value="${fileReleased.fileGrantee.id}" labelName="fileGrantee.fileGrantee.id" labelValue="${fileReleased.fileGrantee.fileGrantee.id}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件下载权，是否拥有文件下载权，0：有，1：无：</label>
			<div class="controls">
				<form:radiobuttons path="fileDownload" items="${fns:getDictList('file_download')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件修改权，0：有，1：无：</label>
			<div class="controls">
				<form:radiobuttons path="fileEdit" items="${fns:getDictList('file_edit')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">共享文件到部门：</label>
			<div class="controls">
				<sys:treeselect id="fileDep" name="fileDep.id" value="${fileReleased.fileDep.id}" labelName="fileDep.fileDep.name" labelValue="${fileReleased.fileDep.fileDep.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="900" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="files:fileReleased:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>