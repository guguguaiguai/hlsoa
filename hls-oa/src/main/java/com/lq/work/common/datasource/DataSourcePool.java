package com.lq.work.common.datasource;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.concurrent.Future;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServlet;

import org.apache.tomcat.jdbc.pool.DataSource;

/**
 * 获取数据库连接，tomcat配置中
 * **/
public class DataSourcePool {
	private Connection con = null;  
    private static DataSource  datasource;  
  
    /** 
     * @see HttpServlet#HttpServlet() 
     */  
    public DataSourcePool() {  
        super();  
        try {  
            //获取数据源  
            datasource = getInstance();  
            //连接池同步  
            Future<Connection> future = datasource.getConnectionAsync();  
            while (!future.isDone()) {  
                // 等待连接池同步  
                Thread.sleep(100);  
            }
            // 获取连接池  
            con = future.get();
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
    /**
     * 获取数据源
     * @return 
     * **/
    public static Connection getConnection(){
    	DataSourcePool dsp = new DataSourcePool();
    	return dsp.getConn();
    }
    /**
     * 获取数据源
     * **/
    public Connection getConn(){
    	return con;
    }
  
    /** 
     * 单例模式获取数据源 
     * @return 
     * @throws NamingException 
     */  
    private DataSource getInstance() throws NamingException {  
        if (datasource == null) {  
        	Context initCtx=new InitialContext();
        	Context envCtx=(Context)initCtx.lookup("java:/comp/env");
        	datasource=(DataSource)envCtx.lookup("jdbc/hisrun");//jdbc/pdbqz必须与Resource name 一致。 
        }  
        return datasource;  
    }  		
    public static void main(String[] args) {
		/*DataSourcePool dsp=new DataSourcePool();
		try {
			DataSource  datasource=dsp.getInstance();
			Connection conn=datasource.getConnection();
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery("select * from hh_oldman");
			while(rs.next()){
				System.out.println(rs.getString("om_name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}*/
    	
    	Connection con = null;
    	try {
    		Context initCtx=new InitialContext();
        	Context envCtx=(Context)initCtx.lookup("java:/comp/env");
        	DataSource datasource=(DataSource)envCtx.lookup("jdbc/hisrun");//jdbc/pdbqz必须与Resource name 一致。
        	Future<Connection> future = datasource.getConnectionAsync();
    	  while (!future.isDone()) {
    	      System.out.println("Connection is not yet available. Do some background work");
    	      try {
    	      Thread.sleep(100); //simulate work
    	      }catch (InterruptedException x) {
    	      Thread.currentThread().interrupted();
    	      }
    	  }
    	  con = future.get(); //should return instantly
    	  Statement st = con.createStatement();
    	  ResultSet rs = st.executeQuery("select sysdate from dual");
    	  //System.out.println(rs.getString(0));
    	}catch(Exception e){
    		e.printStackTrace();
    	}finally {
    	      if (con!=null) try {con.close();}catch (Exception ignore) {}
        }
	}
}
