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
			/*按钮提示信息*/
			$("#btn_detail button").tooltip();
			var files="${mmail.filePath}";
			var fc="";
			var num_=0;
			if(files.indexOf("|")>=0){
				$.each(files.split("|"),function(i,d){
					if(d!=""){
						fc+="<div class=\"file-box\">";
						fc+="<div class=\"file\">";
						fc+="<a href=\"../../../servlet/fd?url="+decodeURIComponent(d)+"\">";
						fc+=" <span class=\"corner\"></span><div class=\"icon\"><i class=\"icon-folder-close-alt\"></i></div>";
						fc+="<div class=\"file-name\">"+decodeURIComponent(d.substring(d.lastIndexOf("/")+1))+"</div>";
						fc+="</a></div></div>";
						num_++;
					}
				});
			}
			
			var nfiles=${fns:toJson(mmail.files)};
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
		});
	</script>
</head>
<body>
	<div class="container-fluid">
        <div class="row-fluid show-grid">
            <div class="row span12">
                <div class="mail-box-header">
                    <h2>
                    查看邮件<c:if test="${mmail.risDel=='1'}">&nbsp;&nbsp;<span style="color:#FF0000;font-weight:600;">已删</span></c:if>
                </h2>
				<div class="mail-tools tooltip-demo m-t-md">
                        <h3>
                        <span class="font-noraml">主题： </span>${mmail.mailTitle}
                    </h3>
                        <h5>
                        <span class="pull-right font-noraml"><fmt:formatDate value="${mmail.sendDate}" pattern="yyyy-MM-dd"/></span>
                        <span class="font-noraml">发件人： </span>${mmail.createBy.name}
                    </h5>
                    </div>
                    <div class="mail-tools tooltip-demo m-t-md" style="margin-top:10px;margin-bottom:10px;" id="mail_operation">
                       
                    </div>
                </div>
                <div class="mail-box">
					<div class="mail-body">
                        ${fns:unescapeHtml(mmail.mailContent) }
                    </div>
                    <div class="mail-attachment">
                        <p>
                            <span><i class="icon-folder-close-alt"></i> <span id="attach_num"></span> 个附件 </span>
                        </p>

                        <div class="attachment" id="mail_attach">
                        </div>
                    </div>
                </div>
				<!--end-->
            </div>
        </div>
    </div>
</body>
</html>