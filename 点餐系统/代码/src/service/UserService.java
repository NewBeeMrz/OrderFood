package service;
/**
 * �û�ҵ���߼���
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
	
	//�����û����������ѯ�û���Ϣ
	public Map<String,String> getUserInfo(String un, String pw){
		String sql = "select * from user where username=? and password=?";
		String[] params = new String[] {un,pw};
		Map<String,String> user = db.getMap(sql,params);
		return user;
	}
	//����û���Ϣ
	public int addUser(String un,String pw,String ident,String tel,String addr) {
		String sql = "insert into user values(null,?,?,?,?,?)";
		String[] params = new String[] {un,pw,ident,tel,addr};
		int result  = db.update(sql,params);
		return result;
	}
	//����IDɾ���û���Ϣ
	public int deleteUser(String id) {
		String sql = "delete from user where id=?";
		String[] params =new String[] {id};
		int result  = db.update(sql,params);
		return result;
	}
	//��ѯ��ͨ�û���Ϣ
	public List<Map<String,String>> queryUser(){
		DBUtil db = new DBUtil();
		String sql="select * from user where ident='0'";
		List<Map<String,String>> user = db.getList(sql);
		return user;
	}
	
	//��ѯ��ͨ�û���Ϣ
		public List<Map<String,String>> queryAllUser(){
			DBUtil db = new DBUtil();
			String sql="select * from user";
			List<Map<String,String>> user = db.getList(sql);
			return user;
		}
	
	//�����û�id��ѯ�û���Ϣ
	public Map<String, String> getUerInfo(String id){
		String sql="select * from user where id=?";
		String[] params = new String[] {id};
		return db.getMap(sql,params);
	}
	
	//�����û�id�޸��û�����Ϣ
	public int UpdateUserInfo(String id,String pw,String tel,String addr) {
		String sql = "update user set password=?,telephone=?,address=? where id=?";
		String[] params =new String[] {pw,tel,addr,id}; 
		return db.update(sql,params);
	}
	
	//����Ա�����û�id�޸��û�����Ϣ
		public int UpdateUserInfo(String userid,String pw,String ident,String tel,String addr) {
			String sql = "update user set password=?,ident=?,telephone=?,address=? where id=?";
			String[] params =new String[] {pw,ident,tel,addr,userid}; 
			return db.update(sql,params);
		}
}
