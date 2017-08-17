<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>邮件详情</title>
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
		.mail-box-header h2 {
    margin-top: 0;
}
h2 {
    font-size: 24px;
}
.h1, .h2, .h3, h1, h2, h3 {
    margin-top: 20px;
    margin-bottom: 10px;
}
.h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
    font-family: inherit;
    font-weight: 500;
    line-height: 1.1;
    color: inherit;
}
h3, h4, h5 {
    margin-top: 5px;
    font-weight: 600;
}
h3 {
    font-size: 16px;
}
h3, h4, h5 {
    margin-top: 5px;
    font-weight: 600;
}
h3 {
    font-size: 16px;
}
h5{font-size:12px;}
.font-noraml {
    font-weight: 400;
}
.pull-right {
    float: right!important;
}
.mail-box {
    background-color: #fff;
    border: 1px solid #e7eaec;
    border-top: 0;
    padding: 0;
    margin-bottom: 20px;
	border-left:0;
	border-right:0;
	border-bottom:0;
}
.mail-body {
    border-top: 1px solid #e7eaec;
    padding: 20px;
}
.mail-attachment {
    border-top: 1px solid #e7eaec;
    padding: 20px;
    font-size: 12px;
}
.file-box {
    float: left;
    width: 220px;
}
.mail-body {
    border-top: 1px solid #e7eaec;
    padding: 20px;
}
.text-right {
    text-align: right;
}
.mail-box-header {
    background-color: #fff;
    border: 1px solid #e7eaec;
    border-bottom: 0;
    padding: 30px 20px 20px;
	    border-left: 0;
    border-top: 0;
    border-right: 0;
}
.file .icon i {
    font-size: 70px;
    color: #dadada;
}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#send_mail").click(function(){
				window.location.href="${ctx}/mail/msgEmail/form";
			});
			$("#btn_back").click(function(){
				history.go(-1);
			});
			/*按钮提示信息*/
			$("#btn_detail button").tooltip();
			var files="${msgEmail.filePath}";
			var fc="";
			var num_=0;
			if(files.indexOf("|")>=0){
				$.each(files.split("|"),function(i,d){
					if(d!=""){
						fc+="<div class=\"file-box\">";
						fc+="<div class=\"file\">";
						fc+="<a href=\"../../../servlet/fd?fid=&url="+decodeURIComponent(d)+"&fd=${msgEmail.fdCount}&m=${msgEmail.id}\" style=\"line-height:30px;\">";
						fc+=" <span class=\"corner\"></span><div class=\"icon\" style=\"text-align:center;\"><i class=\"icon-folder-close-alt\" style=\"font-size:50px;\"></i></div>";
						fc+="<div class=\"file-name\" style=\"text-align:center;\">"+decodeURIComponent(d.substring(d.lastIndexOf("/")+1))+"</div>";
						fc+="</a></div></div>";
						num_++;
					}
				});
			}
			
			var nfiles=${fns:toJson(msgEmail.files)};
			$.each(nfiles,function(i,d){
				fc+="<div class=\"file-box\">";
					fc+="<div class=\"file\">";
					fc+="<a href=\"../../../servlet/fd?url=&fid="+d.id+"&fd=${msgEmail.fdCount}&m=${msgEmail.id}\" style=\"line-height:30px;\">";
					fc+=" <span class=\"corner\"></span><div class=\"icon\" style=\"text-align:center;\"><i class=\"icon-folder-close-alt\" style=\"font-size:50px;\"></i></div>";
					fc+="<div class=\"file-name\" style=\"text-align:center;\">"+d.fileOname+"</div>";
					fc+="</a></div></div>";
					num_++;
			});
			$("#attach_num").html(num_++);
			$("#mail_attach").append(fc);
			$("#mail_reply").click(function(){
				window.location.href="${ctx }/mail/msgEmail/mreply?id="+$(this).attr("reply_");
			});
			$("#mail_forward").click(function(){
				window.location.href="${ctx }/mail/msgEmail/mforward?id="+$(this).attr("mf_");
			});
			$("#btn_del").click(function(){
				id_=$(this).attr("del_");
				top.$.jBox.confirm("确定删除吗？", "提示", function(v,h,f){
					if (v == 'ok'){
						$.getJSON("${ctx}/mail/msgEmail/dd",{mids:id_},function(data){
							if(data.success){
								top.$.jBox.success('所选邮件删除成功！', '提示', { closed: function () { window.location.reload(); } });
							}else{
								top.$.jBox.error('所选邮件删除失败，'+data.msg, '异常');
							}
						});
					}
				});
			});
		});
	</script>
</head>
<body>
	<div class="container-fluid">
        <div class="row-fluid show-grid">
             <!--<div class="row span2" >
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
					<div class="pull-right tooltip-demo" id="btn_detail">
						<c:if test="${msgEmail.risDel=='0'}">
							<!--<a href="${ctx }/mail/msgEmail/mreply?id=${msgEmail.id}"><button class="btn btn-primary btn-sm" id="btn_refresh" data-toggle="tooltip" data-placement="bottom" title="回复">回复 </button></a>
							<button class="btn btn-primary btn-sm" id="btn_read" data-toggle="tooltip" data-placement="bottom" title="删除"><i class="icon-trash"></i></button>-->
							<input id="mail_reply" class="btn btn-primary btn-sm" type="button" value="回复" reply_="${msgEmail.id}"/>
							<input id="mail_forward" class="btn btn-primary btn-sm" type="button" value="转发" mf_="${msgEmail.id}"/>
							<input id="btn_del" class="btn btn-primary btn-sm" type="button" value="删除" del_="${msgEmail.id}"/>
						</c:if>
						<!--<a href="javascript:history.go(-1);"><button class="btn btn-primary btn-sm" id="btn_refresh" data-toggle="tooltip" data-placement="bottom" title="返回"><i class=" icon-reply"></i> </button></a>-->
						<input id="btn_back" class="btn btn-primary btn-sm" type="button" value="返回"/>
                        <!--<a href="mail_compose.html" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="回复"><i class="fa fa-reply"></i> 回复</a>
                        <a href="mail_detail.html#" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="打印邮件"><i class="fa fa-print"></i> </a>
                        <a href="mailbox.html" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="标为垃圾邮件"><i class="fa fa-trash-o"></i> </a>
						-->
                    </div>
                    <h4>
                    查看邮件<c:if test="${msgEmail.risDel=='1'}">&nbsp;&nbsp;<span style="color:#FF0000;font-weight:600;">已删</span></c:if>
                </h4>
				<div class="mail-tools tooltip-demo m-t-md">
                        <h3>
                        <span class="font-noraml">主题： </span>${msgEmail.mailTitle}
                    </h3>
                        <h5>
							<span class="pull-right font-noraml"><fmt:formatDate value="${msgEmail.sendDate}" pattern="yyyy-MM-dd"/></span>
							<span class="font-noraml">发件人： </span>${msgEmail.createBy.name}
						</h5>
						<h5>
							<span class="font-noraml">收件人： </span>${msgEmail.acceptorNames}
						</h5>
                    </div>
                    <div class="mail-tools tooltip-demo m-t-md" style="margin-top:10px;margin-bottom:10px;" id="mail_operation">
                       
                    </div>
                </div>
                <div class="mail-box">
					<div class="mail-body">
                        ${fns:unescapeHtml(msgEmail.mailContent) }
                    </div>
                    <div class="mail-attachment">
                        <p>
                            <span ><i class="icon-folder-close-alt"></i> <span id="attach_num" style="font-size:14px;font-weight:600;"></span> 个附件 </span>
                        </p>

                        <div class="attachment" id="mail_attach" style="font-size:14px;">
                        </div>
                    </div>
                </div>
				<!--end-->
            </div>
        </div>
    </div>
</body>
</html>