package com.project.cotudy.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import org.springframework.stereotype.Component;
 
@Component
public class SHA256Util {

	//암호화. salt는 string
    public static String getEncrypt(String source, String salt) {
        return getEncrypt(source, salt.getBytes());
    }

    //암호화. salt는 byte[]
    public static String getEncrypt(String source, byte[] salt) {
         
        String result = "";
         
        byte[] a = source.getBytes();
        byte[] bytes = new byte[a.length + salt.length];
         
        System.arraycopy(a, 0, bytes, 0, a.length);
        System.arraycopy(salt, 0, bytes, a.length, salt.length);
         
        try {
            // 암호화 방식 지정 
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(bytes);
             
            byte[] byteData = md.digest();
             
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
            }
             
            result = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
         
        return result;
    }
     
    //salt얻어옴. 비밀번호와 salt를 조합해 암호화 
    public static String generateSalt() {
        Random random = new Random();
         
        byte[] salt = new byte[8];
        random.nextBytes(salt);
         
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < salt.length; i++) {
            // byte 값을 Hex 값으로 바꾸기.
            sb.append(String.format("%02x",salt[i]));
        }
         
        return sb.toString();
    }
     
}