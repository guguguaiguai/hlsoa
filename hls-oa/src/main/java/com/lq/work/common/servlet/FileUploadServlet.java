package com.lq.work.common.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.joda.time.DateTime;

import com.google.common.collect.Lists;
import com.hls.ws.modules.attach.entity.FileAttach;
import com.hls.ws.modules.attach.service.FileAttachService;
import com.lq.work.common.config.Global;
import com.lq.work.common.mapper.JsonMapper;
import com.lq.work.common.utils.Encodes;
import com.lq.work.common.utils.FileUtils;
import com.lq.work.common.utils.SpringContextHolder;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.modules.sys.entity.User;
import com.lq.work.modules.sys.utils.UserUtils;
/**
 * 文件上传
 * @author JERRY
 * **/
public class FileUploadServlet extends HttpServlet {

	private Log logger=LogFactory.getLog(FileUploadServlet.class);
	/*附件service*/
	private FileAttachService fileAttachService=SpringContextHolder.getBean(FileAttachService.class);
	private ServletConfig servletConfig=null;
	private String tempPath=""; // 临时文件目录 
	private String fileCat="others";
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String uid=req.getParameter("uid");
		User user = UserUtils.getUser();
		if(StringUtils.isNotEmpty(uid))
			user=UserUtils.get(uid);
		List<FileAttach> list = Lists.newArrayList();
		DateTime now = new DateTime();
		String files=Global.getConfig("userfiles.basedir");//文件保存路径
		String fileModule="";// 附件模块
		String filePath="";// 附件路径
		StringBuffer uploadPath=new StringBuffer(); // 上传文件的目录
		if(StringUtils.isEmpty(files)){
			files=req.getSession().getServletContext().getRealPath("/userfiles");
		}
		//指定保存至某个目录,若提交时，指定了该参数值，则表示保存的操作　
		String fileId="";
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		try {
			File tempFile= new File(files+"/temp");
			if(!tempFile.exists())
				tempFile.mkdirs();
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 缓存大小默认40k
			factory.setSizeThreshold(1024 * 1024);
			factory.setRepository(tempFile);
			ServletFileUpload fu=new ServletFileUpload(factory);

	        @SuppressWarnings("unchecked")
			List<FileItem> fileItems = fu.parseRequest(req); 
	        //取得相关参数值
	        for(FileItem fi:fileItems){
	        	if("fileModule".equals(fi.getFieldName())){
	        		fileModule=fi.getString();
	        	}
	        	if(StringUtils.equals("filePath", fi.getFieldName())){
	        		filePath=fi.getString();
	        	}
	        }
	        /*上传路径，需与现有上传文件目录一致*/
	        uploadPath.append(files).append("/userfiles/").append(user.getId()).append("/files/").append(Encodes.urlDecode(filePath))
	        .append("/").append(now.getYear()).append("/").append(now.getMonthOfYear()<10?("0"+now.getMonthOfYear()):now.getMonthOfYear());
	        System.out.println(uploadPath.toString());
	        logger.info("fileId:" + fileId);
	        Iterator<FileItem> i = fileItems.iterator();
	        //目前处理每次只上传一个文件
	        while(i.hasNext()) {
	        	FileItem fi = (FileItem)i.next();
	            if(fi.getContentType()==null){
	            	continue;
	            }
	            //返回文件名及路径及fileId.
	            String path = fi.getName();
		        int start=path.lastIndexOf("\\");
		        //原文件名
		        String fileName=path.substring(start+1);
		        String nfileName=FileUtils.generateFilename(fileName);
		        File dirPath=new File(uploadPath.toString());
		        
		        if(!dirPath.exists()){
		        	dirPath.mkdirs();
		        }
		        fi.write(new File(uploadPath+"/"+nfileName));
		        fi.delete();
		        /**保存数据到数据库**/
		        StringBuffer sb = new StringBuffer();
		        FileAttach file=new FileAttach();
		        file.setFileExt(fileName.substring(fileName.lastIndexOf(".")+1));/*文件类型*/
		        file.setFileName(nfileName);/*新文件名*/
		        file.setFileOname(fileName);/*旧文件名*/
		        file.setFilePath(sb.append(files).append("/userfiles/").append(user.getId()).append("/files/").append(filePath)
		    	        .append("/").append(now.getYear()).append("/").append(now.getMonthOfYear()<10?("0"+now.getMonthOfYear()):now.getMonthOfYear()).toString());/*保存路径*/
		        file.setFileType("email");/*附件模块类型*/
		        file.setTotalBytes(fi.getSize());/*文件大小，单位：B*/
		        file.setCreateBy(user);file.setUpdateBy(user);
		        fileAttachService.save(file);
		        list.add(file);
		       /* if(!"".equals(filePath)){
		        	file=fileAttachService.getByPath(filePath);
		        	file.setTotalBytes(fi.getSize());
		        	file.setNote(getStrFileSize(fi.getSize()));
		        	fileAttachService.save(file);
		        }
		        if(!"".equals(fileId)){
		        	file=fileAttachService.get(new Long(fileId));
		        	file.setTotalBytes(fi.getSize());
		        	file.setNote(getStrFileSize(fi.getSize()));
		        	fileAttachService.save(file);
		        }
		        if(file==null) {
		        	file=new FileAttach();
			        file.setCreatetime(new Date());
			        AppUser curUser = ContextUtil.getCurrentUser();
			        if(StringUtils.isNotEmpty("isFlex") && StringUtils.isNotEmpty(flexUserId)){
			        	curUser = appUserService.get(new Long(flexUserId));
			        }
			        if(curUser != null){
			        	file.setCreator(curUser.getFullname());
			        	file.setCreatorId(curUser.getUserId());
			        } else {
			        	file.setCreator("UNKown");
			        }
			        int dotIndex=fileName.lastIndexOf(".");
			        file.setExt(fileName.substring(dotIndex+1));
			        file.setFileName(fileName);
			        file.setFilePath(relativeFullPath);
			        file.setFileType(fileCat);
			        if(globalType == null){
			        	globalType = globalTypeService.findByFileType(fileCat);
			        }  
			        if(globalType != null){			        	
			        	file.setGlobalType(globalType);
			        }
			        file.setTotalBytes(fi.getSize());
			        file.setNote(getStrFileSize(fi.getSize()));
			        file.setCreatorId(curUser.getUserId());
			        file.setDelFlag(FileAttach.FLAG_NOT_DEL);
			        fileAttachService.save(file);
		        }
		        StringBuffer sb = new StringBuffer("");
		        String isFlex = req.getParameter("isFlex"); // 判断是否为flex文件上传操作
		        if(StringUtils.isNotEmpty(isFlex) && isFlex.equalsIgnoreCase("true")){
		        	 sb = new StringBuffer("{\"success\":\"true\"");
				     sb.append(",\"fileId\":").append(file.getFileId())
				     .append(",\"fileName\":\"").append(file.getFileName())
				     .append("\",\"filePath\":\"").append(file.getFilePath())
				     .append("\",\"message\":\"upload file success.("+ fi.getSize()+" bytes)\"");
				     sb.append("}");
		        } else {
			        sb = new StringBuffer("{success:true");
			        sb.append(",fileId:").append(file.getFileId())
			        .append(",fileName:'").append(file.getFileName())
			        .append("',filePath:'").append(file.getFilePath()).append("',message:'upload file success.("+ fi.getSize()+" bytes)'");
			        sb.append("}");
		        }*/
		     //   resp.setContentType("text/html;charset=UTF-8");
				//PrintWriter writer = resp.getWriter();
				
				//writer.println(sb.toString());
		        resp.setContentType("text/xml; charset=UTF-8");
				resp.setHeader("Cache-Control", "no-cache");
				resp.setHeader("Pragma", "no-cache");
		        PrintWriter out = resp.getWriter();
		        out.print(JsonMapper.toJsonString(file));
		        out.close();
	        }
	        System.out.println(list.size()+"...size");
	    }    
	    catch(Exception e) {   
	    	e.printStackTrace();
	    	resp.getWriter().write("{'success':false,'message':'error..."+e.getMessage()+"'}");
	    }
		
	}
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		this.servletConfig=config;
	}
	
	/*public void init() throws ServletException {
	   
		//初始化上传的路径及临时文件路径
		
		//uploadPath=getServletContext().getRealPath("/attachFiles/");
		
	    File uploadPathFile=new File("");
	    if(!uploadPathFile.exists()){
	    	uploadPathFile.mkdirs();
	    }
	    tempPath=uploadPath+"/temp";
	    
	    File tempPathFile=new File(tempPath); 
	    if(!tempPathFile.exists()){
	    	tempPathFile.mkdirs();
	    }
	}*/
	/**
	 * 保存文档到服务器磁盘，返回值true，保存成功，返回值为false时，保存失败。
	 * **/
	/*public boolean saveFileToDisk(String fileNameDisk)
	{
		File officeFileUpload = null;
		FileItem officeFileItem =null ;
		
		boolean result=true ;
		try
		{
			if(!"".equalsIgnoreCase(fileNameDisk)&&officeFileItem!=null)
			{
				officeFileUpload =  new File(uploadPath+fileNameDisk);
				officeFileItem.write(officeFileUpload);
			}
		}catch(FileNotFoundException e){
			
		}catch(Exception e){
			e.printStackTrace();
			result=false;
		}
		return result;	
	}*/
	/**
	 * 读取文件大小
	 * **/
	private String getStrFileSize(double size){
	    DecimalFormat df=new DecimalFormat("0.00");
		if(size>1024*1024){
			 double ss=size/(1024*1024);
		 	 return df.format(ss)+" M";
		}else if(size>1024){
			double ss=size/1024;
			return df.format(ss)+" KB";
		}else{
			return size+" bytes";
		}
    }
}
