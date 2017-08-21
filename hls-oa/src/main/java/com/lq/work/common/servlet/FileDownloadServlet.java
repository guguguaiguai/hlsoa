package com.lq.work.common.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hls.ws.modules.attach.entity.FileAttach;
import com.hls.ws.modules.attach.service.FileAttachService;
import com.hls.ws.modules.mail.entity.MailReceive;
import com.hls.ws.modules.mail.entity.MsgEmail;
import com.hls.ws.modules.mail.service.MailReceiveService;
import com.lq.work.common.config.Global;
import com.lq.work.common.utils.Encodes;
import com.lq.work.common.utils.RequestUtils;
import com.lq.work.common.utils.SpringContextHolder;
import com.lq.work.common.utils.StringUtils;
import com.lq.work.modules.sys.entity.User;
import com.lq.work.modules.sys.utils.UserUtils;

public class FileDownloadServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		FileAttachService fileAttachService = SpringContextHolder.getBean(FileAttachService.class);
		String fid = req.getParameter("fid");
		String uri = req.getParameter("url");
		String fd_count=req.getParameter("fd");//是否已下载
		String mid=req.getParameter("m");//主键
		
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		if(StringUtils.isNotEmpty(uri)){
			String filename=StringUtils.substring(uri, uri.lastIndexOf("/")+1);
			String file_type=StringUtils.split(uri, ".")[1];
			resp.setContentType(RequestUtils.getContentType(file_type));
			ServletOutputStream out = null;
			try {
				java.io.FileInputStream fileIn = new java.io.FileInputStream(Global.getUserfilesBaseDir() +Global.USERFILES_BASE_URL+ uri.split("userfiles")[1]);
				resp.addHeader("Content-Disposition","attachment;filename="+ new String(filename.getBytes("gbk"), "ISO-8859-1"));
				out = resp.getOutputStream();
				byte[] buff = new byte[1024];
				int leng = fileIn.read(buff);
				while (leng > 0) {
					out.write(buff, 0, leng);
					leng = fileIn.read(buff);
				}
				fdCount(mid,fd_count);
			} catch (Exception ex) {
				ex.printStackTrace();
				resp.addHeader("Content-Disposition","attachment;filename="+ new String("文件已删除".getBytes("gbk"), "ISO-8859-1"));
			} finally {
				if (out != null) {
					try {
						out.flush();
					} catch (IOException e) {
						e.printStackTrace();
					}
					try {
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

			}
		}else if(StringUtils.isNotEmpty(fid)){
			FileAttach fa = fileAttachService.get(fid);
			resp.setContentType(RequestUtils.getContentType(fa.getFileExt()));
			ServletOutputStream out = null;
			try {
				java.io.FileInputStream fileIn = new java.io.FileInputStream(Encodes.urlDecode(fa.getFilePath())+"/"+fa.getFileName());
				resp.addHeader("Content-Disposition","attachment;filename="+ new String(fa.getFileOname().getBytes("gbk"), "ISO-8859-1"));
				out = resp.getOutputStream();
				byte[] buff = new byte[1024];
				int leng = fileIn.read(buff);
				while (leng > 0) {
					out.write(buff, 0, leng);
					leng = fileIn.read(buff);
				}
				fdCount(mid,fd_count);
			} catch (Exception ex) {
				ex.printStackTrace();
				resp.addHeader("Content-Disposition","attachment;filename="+ new String("文件已删除".getBytes("gbk"), "ISO-8859-1"));
			} finally {
				if (out != null) {
					try {
						out.flush();
					} catch (IOException e) {
						e.printStackTrace();
					}
					try {
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

			}
		}
	}
/**
 * 执行修改操作
 * @param id 邮件ID
 * 		  fd 是否已下载过
 * **/
	private Boolean fdCount(String id,String fd){
		User u = UserUtils.getUser();
		if(StringUtils.isNotEmpty(id)&&fd.equals("0")&u!=null){
			 MailReceiveService mailReceiveService = SpringContextHolder.getBean(MailReceiveService.class);
			 MailReceive mr = new MailReceive(u,new MsgEmail(id));
			 mailReceiveService.fdCount(mr);
		}
		return Boolean.TRUE;
	}
}
