package service;

import java.util.List;
import java.util.Map;

import util.DBUtil;

public class FoodTypeService {
	
private DBUtil db;
	
	public  FoodTypeService(){
		db = new DBUtil();
	}
	
	//��ѯ���еĲ�Ʒ������Ϣ
		public List<Map<String,String>> getAllTypes(){
			String sql="select * from foodtype order by id";
			List<Map<String,String>> foodtypes = db.getList(sql);
			return foodtypes;
		}
		
		//��ӷ�����Ϣ
		public int addtype(String name) {
			String sql = "insert into foodtype values(null,?)";
			String[] params = new String[] {name};
			return db.update(sql, params);
		}
		
		//���ݲ�Ʒ����id���Ҳ�Ʒ������Ϣ
		public Map<String, String> getType(String id){
			String sql = "select * from foodtype where id=?";
			String[] params = new String[] {id};
			return db.getMap(sql, params);
		}
		
		//����id�޸ķ�����Ϣ
		public int Updatetype(String id,String typename) {
			String sql = "update foodtype set typename=? where id=?";
			String[] params = new String[] {typename,id};
			return db.update(sql, params);
		}
		
		//����idɾ������
		public int Deletetype(String id) {
			String sql = "delete from foodtype where id=?";
			String[] params = new String[] {id};
			return db.update(sql, params);
		}
}
