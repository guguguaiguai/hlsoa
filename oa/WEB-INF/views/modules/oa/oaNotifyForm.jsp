<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%

String path = request.getContextPath();

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<html>
<head>
	<title>发布通告</title>
	<meta name="decorator" content="default"/>
	<base href="<%=basePath%>">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/uploadify/uploadify.css" />
	<script type="text/javascript" src="${ctxStatic}/uploadify/jquery.uploadify.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ueditor/ueditor.all.js"></script>
    <script type="text/javascript">
    //UEDITOR_CONFIG.UEDITOR_HOME_URL = './umeditor/';
    window.UEDITOR_HOME_URL ="${ctxStatic}/ueditor"
    var editor = UE.getEditor('content');
    </script>
	<style type="text/css">
	.uploadify{
	height: 10px; width: 50px;
	}
	</style>
	<script type="text/javascript">
	var file_ids=new Array();var tree=null;
	var update_file=${fns:toJson(oaNotify.files)};
	if(update_file.length>0){
		$.each(update_file,function(i,d){
			file_ids.push(d.id);
		});
	} 
	$(document).ready(function() {
		var notify_scope="${oaNotify.notifyScope}";
		var nid_="${oaNotify.id}";
		
		if($("#id").val()!=''&&notify_scope=="1")
			$("#notify_dep").show();
		$("input[name='notifyScope']").click(function(){notify_dep
			var v=$("input[name='notifyScope']:checked").val();
			if(v=="0")
				$("#notify_dep").hide();
			else if(v=="1")
				$("#notify_dep").show();
		});
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
		
		
		var path=encodeURIComponent("公告附件");
		$('#mailUpload').uploadify({
	   　　  'swf':'${ctxStatic}/uploadify/uploadify.swf',
	 　　　   'uploader':'<%=basePath%>/servlet/fu?uid=${fns:getUser().id}',
			/* 'cancelImg':'${ctxStatic}/uploadify/uploadify-cancel.png', */
			'formData':{'fileModule':'notify','filePath':'/'+path},
			'queueID': 'fileQueue',
			'width': '60',  
			'height': '30',
			'fileSizeLimit':'100MB',
			'queueSizeLimit':'20',
			'buttonText': '选择文件',
			'preventCaching' :  true,
		   	'removeCompleted' :true,
			'removeTimeout' : 0,
			//限制文件格式,不设置默认全部格式
	            'fileTypeExts' : '',
	            //上传结束时调用的方法
	            onUploadSuccess: function (file,data,response) {//上传完成时触发（每个文件触发一次）
				data = $.parseJSON(data);
	            	if (data==null||data.id==""||data.id==undefined||data.id==null) {
	            		$.jBox.alert("文件保存失败","错误");
	            	}
	            	else {	         
						var li_="<li id="+data.id+">";
						li_+="<a href=\"<%=basePath%>/servlet/fd?url=&fid="+data.id+"&fd=1&m=0\" url=\"\" target=\"_blank\">"+data.fileOname+"</a>&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"removeFile('"+data.id+"',this)\">×</a>"
						li_+="</li>";
						$("#filesPreview").append(li_);
						//alert("data.id"+data.id);
						file_ids.push(data.id);
	            	}
	            	$("#fids").val(file_ids.join(","));
	            }, 
	            //上传开始时调用的方法
	            onUploadStart : function(file) {
	            },
				onUploadComplete:function(file){
					console.log(file);
				},
	            onUploadError: function(file) {
	                alert("文件:" + file.name + "上传失败");
	            },
				onSelectError:function(file, errorCode, errorMsg){
	            switch(errorCode) {
	                case -100:
	                	this.queueData.errorMsg = "上传的文件数量已经超出系统限制的"+$('#mailUpload').uploadify('settings','queueSizeLimit')+"个文件！";
	                    break;
	                case -110:
	                	this.queueData.errorMsg = "文件 ["+file.name+"] 大小超出系统限制的"+$('#mailUpload').uploadify('settings','fileSizeLimit')+"大小！";
	                    break;
	                case -120:
	                	this.queueData.errorMsg = "文件 ["+file.name+"] 大小异常！";
	                    break;
	                case -130:
	                	this.queueData.errorMsg =  "文件 ["+file.name+"] 类型不正确！";
	                    break;
	            }
	        }
	           });
	　　　});
	
	/**
	*逻辑删除附件信息 2016-10-22
	**/
	function removeFile(id,obj){
		$("li").remove("#" +id);
		file_ids.remove(id);
	}
	/**
	*删除附件
	**/
	function fileDel(id,obj){
		if(id==""||id==null){
			$.jBox.alert("附件删除错误","提示");
		}else{
			$.post("${ctx}/attach/fileAttach/fdel",{"id":id},function(data){
				if(data.success){
					file_ids.remove(id);
					$(obj).parent().remove();
				}else{
					$.jBox.error(data.msg,"异常");
				}
			})
		}
	}
	</script>
</head>
<body>
	<form:form id="inputForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="fids"/>
		<sys:message content="${message}"/>	
		
		<div class="control-group">
			<label class="control-label">类&nbsp;&nbsp;型：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge required">
					<form:option value="" label="请选择"/>
					<form:options items="${ht:noticeTypeList()}" itemLabel="ntName" itemValue="id" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>	
		<div class="control-group">
			<label class="control-label">标&nbsp;&nbsp;题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<c:if test="${oaNotify.status ne '1'}">
				<shiro:hasPermission name="oa:oaNotify:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<div class="control-group">
			<div class="controls">
			    <div>
			    <script id="content" type="text/plain" name="ceshi"></script>
			    
			    </div>
			    <form:textarea id="content" htmlEscape="false" path="content" rows="4" maxlength="200" class="input-xxlarge required"/>
				<!--<form:textarea id="content" htmlEscape="false" path="content" rows="4" maxlength="200" class="input-xxlarge required"/>-->
				<sys:ckeditor replace="content" uploadPath="/通知通告/内容图片" />
				<%-- <form:textarea path="content" htmlEscape="false" rows="6" maxlength="2000" class="input-xxlarge required"/> --%>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<c:if test="${oaNotify.status ne '1'}">			
				<%-- 
				<div class="control-group">
				<label class="control-label">附件：</label>
				<div class="controls">
					<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge"/>
					<sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true"/>
				</div> 
				</div>
				--%>
				<div class="control-group">
								<label class="control-label">附&nbsp;&nbsp;件：</label>
								<div class="controls">
									<input type="file" name="fileName" id="mailUpload" />
									<div id="fileQueue">
										<ol id="filesPreview">
										<c:forEach items="${oaNotify.files}" var="mf">
											<li id="${mf.id}">
												<a href="<%=basePath%>/servlet/fd?url=&fid=${mf.id}&fd=1&m=0" url="" target="_blank">${mf.fileOname}</a>&nbsp;&nbsp;
												<%-- <a href="javascript:" onclick="fileDel('${mf.id}',this)">×</a> --%>
												<a href="javascript:" onclick="removeFile('${mf.id}',this)">×</a>
											</li>
										</c:forEach>
											
										</ol>
									</div>
								</div>
				</div>
			
			<div class="control-group">
				<label class="control-label">发布范围：</label>
				<div class="controls">
					<form:radiobuttons path="notifyScope" items="${fns:getDictList('oa_notify_limit')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
					<span class="help-inline"><font color="red">*</font></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">状态：</label>
				<div class="controls">
					<form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
					<span class="help-inline"><font color="red">*</font> 发布后不能进行操作。</span>
				</div>
			</div>
			<div class="control-group hide" id="notify_dep">
				<label class="control-label">部门:</label>
				<div class="controls">
	                <sys:treeselect id="oaNotifyDepIds" name="oaNotifyDepIds" value="${oaNotify.oaNotifyDepIds}" labelName="oaNotifyDepNames" labelValue="${oaNotify.oaNotifyDepNames}"
						title="部门" url="/sys/office/treeData?type=2" cssClass="vinput-xxlarge required" notAllowSelectParent="true" checked="true"/>
				</div>
			</div>
			<div class="control-group hide">
				<label class="control-label">接受人：</label>
				<div class="controls">
	                <sys:treeselect id="oaNotifyRecord" name="oaNotifyRecordIds" value="${oaNotify.oaNotifyRecordIds}" labelName="oaNotifyRecordNames" labelValue="${oaNotify.oaNotifyRecordNames}"
						title="用户" url="/sys/office/treeData?type=3" cssClass="input-xxlarge required" notAllowSelectParent="true" checked="true"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</c:if>
		<c:if test="${oaNotify.status eq '1'}">
			<%-- <div class="control-group">
				<label class="control-label">附件：</label>
				<div class="controls">
					<form:hidden id="files" path="files" htmlEscape="false" maxlength="255" class="input-xlarge"/>
					<sys:ckfinder input="files" type="files" uploadPath="/oa/notify" selectMultiple="true" readonly="true" />
				</div>
			</div> --%>
			<div class="control-group">
								<!-- 2016-10-23
								<label class="control-label">附&nbsp;&nbsp;件2：</label> -->
								<div class="controls">
									<!-- <input type="file" name="mailUpload" id="mailUpload" /> -->
									<div id="fileQueue">
										<ol id="filesPreview">
										<c:forEach items="${oaNotify.files}" var="mf">
											<li id="${mf.id}">
											    <a href="<%=basePath%>/servlet/fd?url=&fid=${mf.id}&fd=1&m=0" url="" target="_blank">${mf.fileOname}</a>&nbsp;&nbsp;											
												<%-- <a href="javascript:" onclick="fileDel('${mf.id}',this)">×</a>removeFile --%>
												<%-- <a href="javascript:" onclick="removeFile'${mf.id}')">×</a> --%>
											</li>
										</c:forEach>
										</ol>
									</div>
								</div>
							
			</div>
			<%-- <div class="control-group">
				<label class="control-label">接受人：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>接受人</th>
								<th>接受部门</th>
								<th>阅读状态</th>
								<th>阅读时间</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${oaNotify.oaNotifyRecordList}" var="oaNotifyRecord">
							<tr>
								<td>
									${oaNotifyRecord.user.name}
								</td>
								<td>
									${oaNotifyRecord.user.office.name}
								</td>
								<td>
									${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}
								</td>
								<td>
									<fmt:formatDate value="${oaNotifyRecord.readDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					已查阅：${oaNotify.readNum} &nbsp; 未查阅：${oaNotify.unReadNum-oaNotify.readNum} &nbsp; 总共：${oaNotify.unReadNum}
				</div>
			</div> --%>
		</c:if>
		<div class="form-actions">
			<c:if test="${oaNotify.status ne '1'}">
				<shiro:hasPermission name="oa:oaNotify:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			</c:if>
			<input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>