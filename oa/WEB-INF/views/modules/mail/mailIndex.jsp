<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>内部邮箱(收件箱)</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.mail-search {
			max-width: 300px;
		}
		.mailbox-content {
			background: 0 0;
			border: none;
			padding: 10px;
		}
		.ibox-content {
			background-color: #fff;
			color: inherit;
			padding: 15px 20px 20px;
			border-color: #e7eaec;
			-webkit-border-image: none;
			-o-border-image: none;
			border-image: none;
			/*border-style: solid solid none;*/
			border-width: 1px 0;
		}
		a {
			cursor: pointer;
			color: #337ab7;
			text-decoration: none;
		}
		.folder-list li a {
			color: #666;
			display: block;
			padding: 5px 0;
			text-decoration: none;
		}
		ol, ul {
			margin-top: 0;
			margin-bottom: 10px;
		}
		.folder-list li {
			border-bottom: 1px solid #e7eaec;
			display: block;
		}
		.pull-right {
			float: right;
		}
		.m-b-md {
			margin-bottom: 20px;
		}
		.file-manager h5 {
			text-transform: uppercase;
		}
		.folder-list li i {
			margin-right: 8px;
			color: #3d4d5d;
		}
		.folder-list li {
			border-bottom: 1px solid #e7eaec;
			display: block;
		}
		.table {
		    width: 100%;
		    max-width: 100%;
		    margin-bottom: 20px;
		}
		.table-mail .check-mail {
		    padding-left: 8px;
			width:5%;
		}
		table.table-mail tr td {
		    padding: 8px;
		}
		.unread td {
		    background-color: #f9f8f8;
		}
		.unread td, .unread td a {
		    font-weight: 600;
		    color: inherit;
		}
		.mail-ontact {
		    width: 11%;
		}
		.text-right {
		    text-align: right;
		}
		.mail-subject{
			width:59%;
		}
		.unread td, .unread td a {
		    font-weight: 600;
		    color: inherit;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			top.$.jBox.closeTip();
			$("#btn_refresh").click(function(){window.location.reload();});
			$("#btn_refresh1").click(function(){window.location.reload();});
			$("#mail_checkbox").click(function(){
				if($(this).prop('checked')){
					$("input[type='checkbox'][name='list_check']").prop('checked',true);
				}else{
					$("input[type='checkbox'][name='list_check']").prop('checked',false);
				}
			});
			/*邮件删除*/
			$("#btn_del").click(function(){
				var nids=[];
				$("input[type='checkbox'][name='list_check']").each(function(i){
					if($(this).prop("checked")){
						nids.push($(this).val());
					}
				});
				if(nids.length<1){
					top.$.jBox.error('请选择邮件数据！', '提示');
				}else{
					top.$.jBox.confirm("确定删除吗？", "提示", function(v,h,f){
						if (v == 'ok'){
							$.getJSON("${ctx}/mail/mailReceive/rdel",{mids:nids.join(",")},function(data){
								if(data.success){
									top.$.jBox.success('邮件删除成功！', '提示', { closed: function () { window.location.reload(); } });
									
								}else{
									top.$.jBox.error('标记失败，'+data.msg, '异常');
								}
							});
						}
					});
				}
			});
			$("#btn_del1").click(function(){
				var nids=[];
				$("input[type='checkbox'][name='list_check']").each(function(i){
					if($(this).prop("checked")){
						nids.push($(this).val());
					}
				});
				if(nids.length<1){
					top.$.jBox.error('请选择邮件数据！', '提示');
				}else{
					top.$.jBox.confirm("确定删除吗？", "提示", function(v,h,f){
						if (v == 'ok'){
							$.getJSON("${ctx}/mail/mailReceive/rdel",{mids:nids.join(",")},function(data){
								if(data.success){
									top.$.jBox.success('邮件删除成功！', '提示', { closed: function () { window.location.reload(); } });
									
								}else{
									top.$.jBox.error('失败，'+data.msg, '异常');
								}
							});
						}
					});
				}
			});
			/*标为已读*/
			$("#btn_read").click(function(){
				var nids=[];
				$("input[type='checkbox'][name='list_check']").each(function(i){
					if($(this).prop("checked")&&$(this).attr("is_read")=='0'){
						nids.push($(this).val());
					}
				});
				if(nids.length<1){
					top.$.jBox.error('请选择邮件信息！', '提示');
				}else{
					$.getJSON("${ctx}/mail/mailReceive/mread",{mids:nids.join(",")},function(data){
						if(data.success){
							top.$.jBox.success('所选邮件标记成功！', '提示', { closed: function () { window.location.reload(); } });
							
						}else{
							top.$.jBox.error('所选邮件标记失败，'+data.msg, '异常');
						}
					});
				}
				
			});
			$("#btn_read1").click(function(){
				var nids=[];
				$("input[type='checkbox'][name='list_check']").each(function(i){
					if($(this).prop("checked")&&$(this).attr("is_read")=='0'){
						nids.push($(this).val());
					}
				});
				if(nids.length<1){
					top.$.jBox.error('请选择邮件信息！', '提示');
				}else{
					$.getJSON("${ctx}/mail/mailReceive/mread",{mids:nids.join(",")},function(data){
						if(data.success){
							top.$.jBox.success('所选邮件标记成功！', '提示', { closed: function () { window.location.reload(); } });
							
						}else{
							top.$.jBox.error('所选邮件标记失败，'+data.msg, '异常');
						}
					});
				}
				
			});
			/*按钮提示信息*/
			$("#mail_operation button").tooltip();
			$("#send_mail").click(function(){
				window.location.href="${ctx}/mail/msgEmail/form";
			});
			$("#unread_,#read_,#allread_").click(function(){
				$("#mailState").val($(this).val());
				$("#searchForm").submit();
			});
			if("${msgEmail.mailState}"==""){
				$("#allread_").prop("checked",true);
			}else if("${msgEmail.mailState}"=="1"){
				$("#read_").prop("checked",true);
			}else if("${msgEmail.mailState}"=="0"){
				$("#unread_").prop("checked",true);
			}
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
	<div class="container-fluid">
        <div class="row-fluid show-grid">
             <!--<div class="row span2">
                <div class="ibox float-e-margins" style="height: 800px;border: 1px solid #e7eaec;border-left: 0px;border-bottom: 0px;border-top: 0px;">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                            <a class="btn btn-block btn-primary compose-mail" href="${ctx}/mail/msgEmail/form">写邮件</a>
							<input id="send_mail" class="btn btn-block btn-primary compose-mail" type="button" value="写邮件"/>
                            <div style="margin:10px 0";></div>
                            <ul class="folder-list m-b-md" style="padding: 0;margin:0;">
								 <li>
                                    <a href="${ctx }/mail/msgEmail/index"> <i class="icon-inbox"></i> 收件箱 </a>
                                </li>
                                <li>
                                    <a href="${ctx }/mail/msgEmail"> <i class="icon-envelope"></i> 已发送</a>
                                </li>
                                <li>
                                    <a href="${ctx }/mail/msgEmail/draft"> <i class="icon-file-alt"></i> 草稿箱 </a>
                                </li>
                                <li>
                                    <a href="${ctx }/mail/msgEmail/mdlist"> <i class="icon-trash"></i> 已删除</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>-->
            <div class="row span10" style="width: 100%;padding: 0px 5px;">
                <div class="mail-box-header">
                    <form:form id="searchForm" modelAttribute="msgEmail" action="${ctx}/mail/msgEmail/index" method="post" class="pull-right mail-search">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<input id="mailState" name="mailState" type="hidden" value=""/>
                        <div class="input-append input-prepend">
                            <!--<input type="text" class="form-control input-sm" name="mailTitle" placeholder="搜索邮件标题，发件人等">-->
							<form:input path="mailTitle" htmlEscape="false" class="form-control input-sm" placeholder="搜索邮件标题，发件人等"/>
                            <div class="input-append input-prepend">
								<input id="btnSubmit" class="btn btn-sm btn-primary" type="submit" value="搜索"/>
                                <!--<button type="submit" class="btn btn-sm btn-primary">
                                    搜索
                                </button>-->
                            </div>
                        </div>
                    </form:form>
                    <h4>
                    ${page.objName} (${page.count})
                </h4>
                    <div style="margin-top:10px;margin-bottom:10px;" id="mail_operation">
                        <!--<button type="button" class="btn btn-primary" id="btn_refresh" data-toggle="tooltip" data-placement="bottom" title="刷新邮件列表"><i class="fa  icon-refresh"></i> </button>
                        <button class="btn btn-primary btn-sm" id="btn_read" data-toggle="tooltip" data-placement="bottom" title="标为已读"><i class="fa icon-eye-open"></i></button>
						<button class="btn btn-primary btn-sm" id="btn_del" data-toggle="tooltip" data-placement="bottom" title="删除"><i class="icon-trash"></i></button>-->
						<input id="btn_read" class="btn btn-primary" type="button" value="标记已读"/>
						<input id="btn_refresh" class="btn btn-primary btn-sm" type="button" value="刷新"/>
						<input id="btn_del" class="btn btn-primary btn-sm" type="button" value="删除"/>
						<input type="radio" id="unread_" name="mailState" value="0" />未读
						<input type="radio" id="read_" name="mailState" value="1" />已读
						<input type="radio" id="allread_" name="mailState" value=""  />全部
						
                    </div>
                </div>
                <div class="mail-box">
                    <table class="table table-hover table-mail">
                        <tbody>
                                   <th width="3%">
										<input type="checkbox" id="mail_checkbox" />
									</th>
									<th width="8%">发件人</th>
									<th width="59%">邮件标题</th>
									<th width="5%">附件</th>
									<th width="10%">发布时间</th>
									<th width="5%">转发</th>
									<th width="10%">状态</th>
                        	<c:if test="${page.count<1 }">
                        		<tr>
                        			<td colspan='5' style="text-align:center;font-weight:600;" >查询无数据显示！</td>
                        		</tr>
                        	</c:if>
                        	<c:if test="${page.count>0 }">
                        		<c:forEach items="${page.list}" var="msgEmail">
									
									
									<tr class="${msgEmail.mailState=='0'?'unread':'' }">
										<td class="check-mail">
		                                    <input type="checkbox" name="list_check" class="i-checks" value="${msgEmail.id}" is_read="${msgEmail.mailState}" />
		                                </td>
										<td class="mail-ontact">
											${msgEmail.createBy.name}											
										</td>
										<td class="mail-subject">
											<a href="${ctx }/mail/msgEmail/detail?id=${msgEmail.id}&fd=${msgEmail.fdCount}">
												${msgEmail.mailTitle}
											</a>
										</td>
										<td>
											<c:if test="${not empty msgEmail.filePath }">
												<i class="icon-paper-clip"></i>
											</c:if>
											
										</td>
										<td class="text-right mail-date">
											<fmt:formatDate value="${msgEmail.sendDate}" pattern="yyyy-MM-dd"/>
										</td>
										<td class="text-right mail-date">
											<a href="${ctx}/mail/msgEmail/mforward?id=${msgEmail.id}" title="邮件转发"><i class="icon-share-alt"></i></a>
										</td>
										<shiro:hasPermission name="mail:msgEmail:attachment">
										<td class="text-right mail-date">
											<c:if test="${msgEmail.fdCount==0&&not empty msgEmail.filePath}">
												<i class="icon-circle-arrow-down" style="color:#157ab5;font-weight:bold;font-size:16px;" title="未下载"></i>
											</c:if>
											<c:if test="${msgEmail.fdCount==1||empty msgEmail.filePath}">
												<i class="icon-circle-arrow-down" style="font-size:16px;" title="已下载"></i>
											</c:if>
										</td></shiro:hasPermission>
									</tr>
								</c:forEach>
                        	</c:if>
                            
                        </tbody>
                    </table>
                </div>
				<div class="pagination">${page}</div>
				<div style="margin-top:10px;margin-bottom:10px;" id="mail_operation">
                        <!--<button type="button" class="btn btn-primary" id="btn_refresh" data-toggle="tooltip" data-placement="bottom" title="刷新邮件列表"><i class="fa  icon-refresh"></i> </button>
                        <button class="btn btn-primary btn-sm" id="btn_read" data-toggle="tooltip" data-placement="bottom" title="标为已读"><i class="fa icon-eye-open"></i></button>
						<button class="btn btn-primary btn-sm" id="btn_del" data-toggle="tooltip" data-placement="bottom" title="删除"><i class="icon-trash"></i></button>-->
						<input id="btn_read1" class="btn btn-primary" type="button" value="标记已读"/>
						<input id="btn_refresh1" class="btn btn-primary btn-sm" type="button" value="刷新"/>
						<input id="btn_del1" class="btn btn-primary btn-sm" type="button" value="删除"/>
						
                    </div>
				<!--end-->
            </div>
        </div>
    </div>
</body>
</html>