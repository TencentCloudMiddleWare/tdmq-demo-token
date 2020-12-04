package com.tencent.tdmq_demo;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author vvwei
 * @date 2020年3月30日 下午3:26:12
 * @decription
 * @version 
 */
public class ToolsString {
    /**
     *  null
     */
    public static final String _NULL = null;

    /**
     * 空字符串
     */
    public static final String _EMPTY = "";

    /**
     * 校验字符串是否为null
     * @param str
     * @return
     */
    public static boolean isNull(String str){
        return str == _NULL;
    }

    /**
     * 校验是否为null
     * @param str
     * @return
     */
    public static boolean isNull(Object obj){
        return obj == _NULL;
    }

    /**
     * 校验字符串是否为空
     * @param str null or 空字符串都归类为空
     * @return true:为空，false：不为空
     */
    public static boolean isEmpty(String str){
        if (str == null) {
            return true;
        }
        boolean flag = false;
        if (str.length() == 0 || str.trim().equals("")
                || str.trim().equals("null")) {
            flag = true;
        }
        return flag;
    }

    /**
     * 判断该str对象是否为空,并且返回空字符串或者不为空的结果
     * @param str
     * @return 返回字符串
     */
    public static String checkEmpty(String str) {
        return checkEmpty(str, "");
    }

    /**
     * 判断该str对象是否为空,并且返回空字符串或者不为空的结果
     * @param str
     * @return 返回字符串
     */
    public static String checkEmptyAndTrim(String str) {
        return checkEmpty(str, "").trim();
    }

    /**
     * 判断该str对象是否为空,并且返回空字符串或者不为空的结果
     * @param str
     * @return 返回字符串
     */
    public static String checkEmptyAndTrim(Object obj) {
        return checkEmpty(obj, "").trim();
    }

    /**
     * 判断该str对象是否为空,并且返回默认值
     * @param str
     * @param defaultValue
     * @return
     */
    public static String checkEmpty(String str, String defaultValue) {
        String result = defaultValue;
        if (str != null && str.length() != 0 && !str.trim().equals("")
                && !str.trim().equals("null")) {
            result = str;
        }
        return result;
    }

    /**
     * 判断该str对象是否为空,并且返回空字符串或者不为空的结果
     * @param str
     * @return 返回字符串
     */
    public static String checkEmpty(Object obj) {
        return checkEmpty(String.valueOf(obj));
    }

    /**
     * 判断该str对象是否为空,并且返回空字符串或者不为空的结果
     * @param str
     * @return 返回字符串
     */
    public static String checkEmpty(Object obj, String defaultValue) {
        return checkEmpty(String.valueOf(obj), defaultValue);
    }

    /**
     * 正则匹配
     * @param str
     * @param regx
     * @return
     */
    public static String matcher(String str, String regx){
        return matcher(str, regx, 1);
    }

    /**
     * 正则匹配
     * @param str
     * @param regx
     * @return
     */
    public static String matcher(String str, String regx, int i){
       return matcher(str, regx, 0, i);
    }
    
    public static String matcher(String str, String regx, int row, int column){
        if(isEmpty(str) || isEmpty(regx)){
            return "";
        }
        
        Matcher m = Pattern.compile(regx).matcher(str);
        int index = 0;
        while(m.find()){
            if(index++ == row) {
                return m.group(column);
            }
        }
        return "";
    }
}
