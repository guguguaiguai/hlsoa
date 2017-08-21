package com.lq.work.modules.sys.security;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;

import com.lq.work.common.utils.MD5Util;

public class CustomCredentialsMatcher extends SimpleCredentialsMatcher {

	@Override
	public boolean doCredentialsMatch(AuthenticationToken authcToken,AuthenticationInfo info) {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;  
		
        Object tokenCredentials = encrypt(token.getUsername()+String.valueOf(token.getPassword()));  
        Object accountCredentials = getCredentials(info);  
		if(token.getPassword().length<1&&accountCredentials==null){
			return Boolean.TRUE;
		}else if(token.getPassword().length>0&&accountCredentials==null){
			return Boolean.FALSE;
		}
        //将密码加密与系统加密后的密码校验，内容一致就返回true,不一致就返回false  
        return equals(tokenCredentials, accountCredentials);  
	}
	//将传进来密码加密方法  
    private String encrypt(String data) {  
        String sha384Hex="";
		try {
			sha384Hex = MD5Util.encodeByMD5(data);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//这里可以选择自己的密码验证方式 比如 md5或者sha256等  
        return sha384Hex;  
    }  

}
