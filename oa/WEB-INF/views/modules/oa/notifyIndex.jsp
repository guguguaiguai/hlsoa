<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.mail-search {
			max-width: 300px;
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
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btn_refresh").click(function(){window.location.reload();});
			$("#notify_check").click(function(){
				if($(this).prop('checked')){
					$("input[type='checkbox'][name='list_check']").prop('checked',true);
				}else{
					$("input[type='checkbox'][name='list_check']").prop('checked',false);
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
					top.$.jBox.error('请选择未读公告信息！', '提示');
				}else{
					$.getJSON("${ctx}/oa/oaNotify/rf",{nids:nids.join(",")},function(data){
						if(data.success){
							top.$.jBox.success('操作成功！', '提示', { closed: function () { window.location.reload(); } });
							
						}else{
							top.$.jBox.error('标记失败，'+data.msg, '异常');
						}
					});
				}
				
			});
			$("#notify_index").click(function(){
				window.location.href="${ctx}/oa/oaNotify/index";
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
        <div class="row-fluid">
           <!--   <div class="span2">
                <div class="ibox float-e-margins">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                            <!--<a class="btn btn-block btn-primary compose-mail" href="${ctx}/oa/oaNotify/index">通知通告</a>
							<input id="notify_index" class="btn btn-block btn-primary compose-mail" type="button" value="通知通告"/>
                            <div style="margin:10px 0";></div>
                            <ul class="folder-list m-b-md" style="padding: 0;margin:0;">
								<c:forEach items="${ht:noticeTypeList()}" var="nt">
									<li>
										<a href="${ctx}/oa/oaNotify/index?type=${nt.id}"> <i class="icon-external-link "></i> ${nt.ntName} 
										</a>
									</li>
								</c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>-->
            <div class="span10" style="width:100%;">
                <div class="mail-box-header">
					<form:form id="searchForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/index" method="post" class="pull-right mail-search">
						<input id="pageNo" name="pageNo" type="hidden" value="${nindex.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${nindex.pageSize}"/>
						<div class="input-append input-prepend">
							<form:input path="title" htmlEscape="false" maxlength="200" class="form-control input-sm" placeholder="搜索公告标题，正文等"/>
                               <input type="submit" class="btn btn-sm btn-primary" value="搜索" />
                        </div>
					</form:form>
                    <h2>
                    ${nindex.objName} (${nindex.count})
                </h2>
                    <div class="mail-tools tooltip-demo m-t-md" style="margin-top:10px;margin-bottom:10px;">
                        <!--<button class="btn btn-primary btn-sm" id="btn_refresh" data-toggle="tooltip" data-placement="left" title="刷新邮件列表"><i class="fa  icon-refresh"></i> 刷新</button>
                        <button class="btn btn-primary btn-sm" id="btn_read" data-toggle="tooltip" data-placement="top" title="标为已读"><i class="fa icon-eye-open"></i>已读
                        </button>-->
						<input id="btn_refresh" class="btn btn-primary btn-sm" type="button" value="刷新"/>
						<input id="btn_read" class="btn btn-primary btn-sm" type="button" value="标记已读"/>
						<c:forEach items="${ht:noticeTypeList()}" var="nt">
										<a href="${ctx}/oa/oaNotify/index?type=${nt.id}"><input id="btn_read1" class="btn btn-primary btn-sm" type="button" value="${nt.ntName}"/> 
										</a>
									
						</c:forEach>
						
                    </div>
                </div>
                <div class="mail-box">
                    <table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>
									<input type="checkbox" id="notify_check" />
								</th>
								<th>标题</th>
								<th>类型</th>
								<th>状态</th>
								<th>查阅状态</th>
								<th>通告时间</th>
								<th>发布者</th>
								<%-- <c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit"><th>操作</th></shiro:hasPermission></c:if> --%>
							</tr>
						</thead>
						<tbody>
						<c:if test="${nindex.count<1}">
							<tr>
								<td colspan="7" style="text-align:center;">查询无数据显示！</td>
							</tr>
						</c:if>
						<c:if test="${nindex.count>0}">
							<c:forEach items="${nindex.list}" var="oaNotify">
								<tr>
									<td>
										<input type="checkbox" name="list_check" value="${oaNotify.id}" is_read="${oaNotify.readFlag}" />
									</td>
									<td><a href="${ctx}/oa/oaNotify/detail?id=${oaNotify.id}">
									    <c:if test="${oaNotify.readFlag=='0'}">
											<span style="font-size:13px;font-weight:bold;"><font color="#23c6c8"><strong>${fns:abbr(oaNotify.title,50)}</strong></font></span>
										</c:if>
										<c:if test="${oaNotify.readFlag=='1'}">
										<span style="font-size:13px;font-weight:bold;">
										   <font color="#A9A9A9"><strong>${fns:abbr(oaNotify.title,50)}</strong></font>
										</span>											
										</c:if>
									</a></td>
									<td>
										${ht:noticeTypeName(oaNotify.type,'未知')}
									</td>
									<td>
										${fns:getDictLabel(oaNotify.status, 'oa_notify_status', '')}
									</td>
									<td>
										<c:if test="${requestScope.oaNotify.self}">
											${fns:getDictLabel(oaNotify.readFlag, 'oa_notify_read', '')}
										</c:if>
										<c:if test="${!requestScope.oaNotify.self}">
											${(oaNotify.readNum==null||oaNotify.readNum=="")?0:oaNotify.readNum} / ${oaNotify.unReadNum}
										</c:if>
									</td>
									<td>
										<fmt:formatDate value="${oaNotify.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
									${oaNotify.name}
									</td>
									<%-- <c:if test="${!requestScope.oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit"><td>
										<a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">修改</a>
										<a href="${ctx}/oa/oaNotify/delete?id=${oaNotify.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)">删除</a>
									</td></shiro:hasPermission></c:if> --%>
								</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
					<div class="pagination">${nindex}</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>