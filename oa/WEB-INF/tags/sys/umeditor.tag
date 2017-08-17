<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="replace" type="java.lang.String" required="true" description="需要替换的textarea编号"%>
<%@ attribute name="uploadPath" type="java.lang.String" required="false" description="文件上传路径，路径后自动添加年份。若不指定，则编辑器不可上传文件"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="编辑器宽度"%>
<%@ attribute name="height" type="java.lang.String" required="false" description="编辑器高度"%>
<script type="text/javascript">include('umeditor_lib','${ctxStatic}/umeditor/',['umeditor.js']);</script>
<script type="text/javascript">
	var ${replace}Umeditor = UMEDITOR.replace("${replace}");
	${replace}Umeditor.config.height = "${height}";//<c:if test="${not empty uploadPath}">
	${replace}Umeditor.config.width = "${width}";
	${replace}Umeditor.config.ckfinderPath="${ctxStatic}/ckfinder";
	var date = new Date(), year = date.getFullYear(), month = (date.getMonth()+1)>9?date.getMonth()+1:"0"+(date.getMonth()+1);
	${replace}Umeditor.config.ckfinderUploadPath="${uploadPath}/"+year+"/"+month+"/";//</c:if>
</script>