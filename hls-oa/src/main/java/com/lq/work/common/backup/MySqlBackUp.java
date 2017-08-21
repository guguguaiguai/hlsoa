package com.lq.work.common.backup;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import org.joda.time.DateTime;

import com.lq.work.common.config.Global;
import com.lq.work.common.utils.DateUtils;

/**
 * MySql数据库备份，恢复操作
 * **/
public class MySqlBackUp {

	private static String filePath=Global.getConfig("database.mysql.file");
	
	private static String uname=Global.getConfig("jdbc.username");
	
	private static String pwd=Global.getConfig("jdbc.password");
	
	private static String savePath=Global.getConfig("database.save.path");
	/** 
     * 备份数据库 
     *  
     * @param output 
     *            输出流 
     * @param dbname 
     *            要备份的数据库名 
     */  
    public static void backup(OutputStream output, String dbname,String fpath) {  
        String command = filePath + "/mysqldump -h localhost -u" + uname  
                + " -p " + pwd + " --set-charset=utf8 " + dbname;  
        PrintWriter p = null;  
        BufferedReader reader = null;  
        try {  
            p = new PrintWriter(new OutputStreamWriter(output, "utf8"));  
            Process process = Runtime.getRuntime().exec(command);  
            InputStreamReader inputStreamReader = new InputStreamReader(process  
                    .getInputStream(), "utf8");  
            reader = new BufferedReader(inputStreamReader);  
            String line = null;  
            StringBuffer sb = new StringBuffer("");
            while ((line = reader.readLine()) != null) {  
               // p.println(line);  
                sb.append(line + "\r\n");
            }  
            FileOutputStream fout = new FileOutputStream(fpath);
            OutputStreamWriter writer = new OutputStreamWriter(fout, "utf-8");
            writer.write(sb.toString());
            writer.flush();
            p.flush();  
            writer.close();
            fout.close();
        } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            try {  
                if (reader != null) {  
                    reader.close();  
                }  
                if (p != null) {  
                    p.close();  
                }  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  
    }  
    /** 
     * 备份数据库，如果指定路径的文件不存在会自动生成 
     *  
     * @param dest 
     *            备份文件的路径 
     * @param dbname 
     *            要备份的数据库 
     */  
    public static void backup(String dbname) {
    	StringBuffer path_=new StringBuffer(savePath);
    	path_.append("/").append(DateUtils.getYear()).append(DateUtils.getMonth()).append("/");
    	File file = new File(path_.toString());
    	if(!file.exists()){
    		file.mkdirs();
    	}
        try {  
        	String fpath=path_.toString()+"/"+dbname+DateUtils.getYear()+DateUtils.getMonth()+DateUtils.getDay()+".sql";
            OutputStream out = new FileOutputStream(path_.toString()+"/"+dbname+DateUtils.getYear()+DateUtils.getMonth()+DateUtils.getDay()+".sql");  
            backup(out, dbname,fpath);  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
        }  
    }
    public static void main(String[] args) {
    	DateTime now = new DateTime();
    	System.out.println("backup start ....."+now.toDate());
		MySqlBackUp.backup("hls-oa");
		System.out.println("backup end ....."+now.toDate());
	}
}
