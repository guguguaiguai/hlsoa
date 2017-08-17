<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.table-input{width:257px;}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#no").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
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
		<li><a href="${ctx}/sys/user/list">用户列表</a></li>
		<li class="active"><a href="${ctx}/sys/user/form?id=${user.id}">用户<shiro:hasPermission name="sys:user:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:user:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered">
			<tr>
				<th width="10%">总/分院：</th>
				<td width="40%">
					<sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
					title="总/分院" url="/sys/office/treeData?type=1" cssClass="required"/>
				</td>
				<th width="10%">科室：</th>
				<td width="40%">
					<sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
					title="科室" url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="true"/>
				</td>
			</tr>
			<tr>
				<th>姓名：</th>
				<td>
					<form:input path="name" htmlEscape="false" maxlength="50" class="table-input required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</td>
				<th>拼音码：</th>
				<td>
					<form:input path="pydm" htmlEscape="false" maxlength="50" class="table-input required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</td>
			</tr>
			<tr>
				<th>工号：</th>
				<td>
					<form:input path="no" htmlEscape="false" maxlength="50" class="table-input required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</td>
				<th>登录名：</th>
				<td>
					<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
					<form:input path="loginName" htmlEscape="false" maxlength="50" class="table-input required userName"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</td>
			</tr>
			<tr>
				<th>密码：</th>
				<td>
					<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="table-input ${empty user.id?'required':''}"/>
					<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
					<c:if test="${not empty user.id}"><span class="help-inline">若不修改密码，请留空。</span></c:if>
				</td>
				<th>确认密码：</th>
				<td>
					<input id="confirmNewPassword" name="confirmNewPassword" type="password" class="table-input" value="" maxlength="50" minlength="3" equalTo="#newPassword"/>
					<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
				</td>
			</tr>
			<tr>
				<th>邮箱：</th>
				<td>
					<form:input path="email" htmlEscape="false" maxlength="100" class="table-input email"/>
				</td>
				<th>电话：</th>
				<td>
					<form:input path="phone" htmlEscape="false" maxlength="100" class="table-input"/>
				</td>
			</tr>
			<tr>
				<th>手机：</th>
				<td>
					<form:input path="mobile" htmlEscape="false" maxlength="100" class="table-input"/>
				</td>
				<th>是否允许登录:</th>
				<td>
					<form:select path="loginFlag">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> “是”代表此账号允许登录，“否”则表示此账号不允许登录</span>
				</td>
			</tr>
			<tr>
				<th>用户角色：</th>
				<td colspan="3">
					<form:checkboxes path="roleIdList" items="${allRoles}" itemLabel="name" itemValue="id" htmlEscape="false" class="required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</td>
			</tr>
			<tr>
				<th>用户类型：</th>
				<td>
					<form:select path="userType" class="input-xlarge">
						<form:option value="" label="请选择"/>
						<form:options items="${fns:getDictList('sys_user_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
				<th>备注</th>
				<td>
					<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge"/>
				</td>
			</tr>
			<c:if test="${not empty user.id}">
			<tr>
				<th>创建时间:</th>
				<td>
					<fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/>
				</td>
				<th>最后登陆:</th>
				<td>
					IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/>
				</td>
			</tr>
		</c:if>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>