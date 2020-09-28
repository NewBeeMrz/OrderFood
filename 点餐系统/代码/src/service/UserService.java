package service;
/**
 * 用户业务逻辑类
 * @author MuffinMrz
 *
 */


import java.util.List;
import java.util.Map;

import util.DBUtil;

public class UserService {
	
	private DBUtil db;
	
	public UserService(){
		db = new DBUtil();
	}
	
	//根据用户名和密码查询用户信息
	public Map<String,String> getUserInfo(String un, String pw){
		String sql = "select * from user where username=? and password=?";
		String[] params = new String[] {un,pw};
		Map<String,String> user = db.getMap(sql,params);
		return user;
	}
	//添加用户信息
	public int addUser(String un,String pw,String ident,String tel,String addr) {
		String sql = "insert into user values(null,?,?,?,?,?)";
		String[] params = new String[] {un,pw,ident,tel,addr};
		int result  = db.update(sql,params);
		return result;
	}
	//根据ID删除用户信息
	public int deleteUser(String id) {
		String sql = "delete from user where id=?";
		String[] params =new String[] {id};
		int result  = db.update(sql,params);
		return result;
	}
	//查询普通用户信息
	public List<Map<String,String>> queryUser(){
		DBUtil db = new DBUtil();
		String sql="select * from user where ident='0'";
		List<Map<String,String>> user = db.getList(sql);
		return user;
	}
	
	//查询普通用户信息
		public List<Map<String,String>> queryAllUser(){
			DBUtil db = new DBUtil();
			String sql="select * from user";
			List<Map<String,String>> user = db.getList(sql);
			return user;
		}
	
	//根据用户id查询用户信息
	public Map<String, String> getUerInfo(String id){
		String sql="select * from user where id=?";
		String[] params = new String[] {id};
		return db.getMap(sql,params);
	}
	
	//根据用户id修改用户的信息
	public int UpdateUserInfo(String id,String pw,String tel,String addr) {
		String sql = "update user set password=?,telephone=?,address=? where id=?";
		String[] params =new String[] {pw,tel,addr,id}; 
		return db.update(sql,params);
	}
	
	//管理员根据用户id修改用户的信息
		public int UpdateUserInfo(String userid,String pw,String ident,String tel,String addr) {
			String sql = "update user set password=?,ident=?,telephone=?,address=? where id=?";
			String[] params =new String[] {pw,ident,tel,addr,userid}; 
			return db.update(sql,params);
		}
}
