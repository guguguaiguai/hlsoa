<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>内部邮箱--垃圾箱</title>
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
    padding: 12px;
}
.unread td {
    background-color: #f9f8f8;
}
.unread td, .unread td a {
    font-weight: 600;
    color: inherit;
}
.mail-ontact {
    width: 23%;
}
.text-right {
    text-align: right;
}
.mail-subject{
	width:40%;
}
.unread td, .unread td a {
    font-weight: 600;
    color: inherit;
}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			top.$.jBox.closeTip();
			$("[id=btn_refresh]").click(function(){window.location.reload();});
			$("#mail_checkbox").click(function(){
				if($(this).prop('checked')){
					$("input[type='checkbox'][name='list_check']").prop('checked',true);
				}else{
					$("input[type='checkbox'][name='list_check']").prop('checked',false);
				}
			});
			/*邮件删除*/
			$("[id=btn_del]").click(function(){
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
							$.getJSON("${ctx}/mail/mailReceive/ldel",{mids:nids.join(",")},function(data){
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
			/*标为已读*/
			$("[id=btn_read]").click(function(){
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
             <!-- <div class="row span2" >
                <div class="ibox float-e-margins" style="height: 800px;border: 1px solid #e7eaec;border-left: 0px;border-bottom: 0px;border-top: 0px;">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                            <!-- <a class="btn btn-block btn-primary compose-mail" href="${ctx}/mail/msgEmail/form">写邮件</a>
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
                    <form:form id="searchForm" modelAttribute="msgEmail" action="${ctx}/mail/msgEmail/mdlist" method="post" class="pull-right mail-search">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                        <div class="input-append input-prepend">
                            <input type="text" class="form-control input-sm" name="mailTitle" placeholder="搜索邮件标题等">
                            <div class="input-append input-prepend">
								<input id="btnSubmit" class="btn btn-sm btn-primary" type="submit" value="搜索"/>
                                <!--<button type="submit" class="btn btn-sm btn-primary">
                                    搜索
                                </button>-->
                            </div>
                        </div>
                    </form:form>
                    <h4>
                    ${mdpage.objName} (${mdpage.count})
                </h4>
                    <div class="mail-tools tooltip-demo m-t-md" style="margin-top:10px;margin-bottom:10px;" id="mail_operation">
                       <!-- <button class="btn btn-primary btn-sm" id="btn_refresh" data-toggle="tooltip" data-placement="bottom" title="刷新邮件列表"><i class="fa  icon-refresh"></i> </button>
                        <button class="btn btn-primary btn-sm" id="btn_read" data-toggle="tooltip" data-placement="bottom" title="标为已读"><i class="fa icon-eye-open"></i></button>
						<button class="btn btn-primary btn-sm" id="btn_del" data-toggle="tooltip" data-placement="bottom" title="删除"><i class="icon-trash"></i></button>-->
						<input id="btn_refresh" class="btn btn-primary btn-sm" type="button" value="刷新"/>
						<input id="btn_del" class="btn btn-primary btn-sm" type="button" value="删除"/>
                    </div>
                </div>
                <div class="mail-box">
                    <table class="table table-hover table-mail">
                        <tbody>
                                    <th width="3%">
										<input type="checkbox" id="mail_checkbox" />
									</th>
									<th width="8%">收件人</th>
									<th width="59%">邮件标题</th>
									
									<th width="5%">附件</th>
									<th width="10%">发布时间</th>
                        	<c:if test="${mdpage.count<1 }">
                        		<tr>
                        			<td style="text-align:center;font-weight:600;" colspan='5'>查询无数据显示！</td>
                        		</tr>
                        	</c:if>
                        	<c:if test="${mdpage.count>0 }">
                        		<c:forEach items="${mdpage.list}" var="msgEmail">
									<tr class="${msgEmail.mailState=='0'?'unread':'' }">
										<td class="check-mail">
		                                    <input type="checkbox" name="list_check" class="i-checks" value="${msgEmail.mmid}" is_read="${msgEmail.mailState}" />
		                                </td>
										<td class="mail-ontact">
											${msgEmail.createBy.name}
										</td>
										<td class="mail-subject">
											<a href="${ctx }/mail/msgEmail/detail?id=${msgEmail.id}&fd=0">
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
									</tr>
								</c:forEach>
                        	</c:if>
                            
                        </tbody>
                    </table>
                </div>
                
				<div class="pagination">${mdpage}</div>
				<div class="mail-tools tooltip-demo m-t-md" style="margin-top:10px;margin-bottom:10px;" id="mail_operation">
                       <!-- <button class="btn btn-primary btn-sm" id="btn_refresh" data-toggle="tooltip" data-placement="bottom" title="刷新邮件列表"><i class="fa  icon-refresh"></i> </button>
                        <button class="btn btn-primary btn-sm" id="btn_read" data-toggle="tooltip" data-placement="bottom" title="标为已读"><i class="fa icon-eye-open"></i></button>
						<button class="btn btn-primary btn-sm" id="btn_del" data-toggle="tooltip" data-placement="bottom" title="删除"><i class="icon-trash"></i></button>-->
						<input id="btn_refresh" class="btn btn-primary btn-sm" type="button" value="刷新"/>
						<input id="btn_del" class="btn btn-primary btn-sm" type="button" value="删除"/>
                    </div>
				<!--end-->
            </div>
        </div>
    </div>
</body>
</html>