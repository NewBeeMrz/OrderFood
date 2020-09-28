package service;


import java.util.*;


import util.DBUtil;

public class DCService {
	
	private DBUtil db;	
	public DCService() {
		// TODO Auto-generated constructor stub
		db = new DBUtil();
	}
	
	//添加点餐车
	public int addToDC(String userid,String[] fids) {
		int r = 0;
		String sql = "insert into diningcar values(null,?,?)";
		if(fids != null) {
			for(String foodid:fids) {
				String[] params = new String[] {userid,foodid};
				r+=db.update(sql, params);
			}
		}
			//更新点餐率
		sql = "update food set hits=hits+1 where id=?";
			for(String foodid:fids) {
				String[] params = new String[] {foodid};
				db.update(sql, params);
			}
		return r;
	}
	
	//读取用户点餐信息
	public List<Map<String, String>> getUserDC(String userid){
		String sql = "select dc.id dcid,f.*,ft.typename\r\n" + 
				"from diningcar dc join food f on dc.foodid = f.id \r\n" + 
				"join foodtype ft on f.type = ft.id where dc.userid=?";
		String[] params = new String[] {userid};
		return db.getList(sql,params);
	}
	
	//删除用户点餐信息
	public int delFromDC(String[] dcids) {
		int r = 0;
		//更新点餐率
		String sql = "update food set hits=hits-1 where id=(select foodid from diningcar where id=?)";
		if(dcids!=null) {
			for (String dcid : dcids) {
				String[] params = new String[] {dcid};
				db.update(sql,params);
			}
		}
		//从点餐车删除
		sql = "delete from diningcar where id=?";
		if(dcids!=null) {
			for (String dcid : dcids) {
				String[] params = new String[] {dcid};
				r+=db.update(sql,params);
			}
		}
		return r;
	}
	
		//查询全部菜品信息
		public List<Map<String,String>> getAllFood(int userid){
			String sql="select dc.id dcid,food.*,foodtype.typename from diningcar dc join food on dc.foodid = food.id join foodtype on food.type=foodtype.id where userid=? order by id";
			String[] params = new String[] {userid+""};
			List<Map<String,String>> foods = db.getList(sql,params);
			return foods;
		}
		
		//按分类查询菜品信息
		public List<Map<String,String>> getAllFood(int type,int userid){
			String sql="select dc.id dcid,food.*,foodtype.typename from diningcar dc join food on dc.foodid = food.id join foodtype on food.type=foodtype.id where userid=? and food.type=? order by id";
			String[] params = new String[] {userid+"",type+""};
			List<Map<String,String>> foods = db.getList(sql,params);
			return foods;
		}
		//按分类名称查询
		public List<Map<String,String>> getAllFood(String type,String sn,int userid){
			String sql="select dc.id dcid,food.*,foodtype.typename from diningcar dc join food on dc.foodid = food.id join foodtype on food.type=foodtype.id where userid=? and food.type=? and food.foodname like ? order by id";
			String[] params = new String[] {userid+"",type,"%"+sn+"%"};
			List<Map<String,String>> foods = db.getList(sql,params);
			return foods;
		}
		//按名称查找
		public List<Map<String,String>> getAllFood(String sn,int userid){
			String sql="select dc.id dcid,food.*,foodtype.typename from diningcar dc join food on dc.foodid = food.id join foodtype on food.type=foodtype.id where userid=? and food.foodname like ? order by id";
			String[] params = new String[] {userid+"","%"+sn+"%"};
			List<Map<String,String>> foods = db.getList(sql,params);
			return foods;
		}
		
		//管理员查看购物车
		public Map<String, List<Map<String, String>>> showDC(){
			String sql = "select distinct u.id,u.username from user u join diningcar dc on u.id = dc.userid";
			Map<String, List<Map<String, String>>> dcs=null;
			List<Map<String, String>> users = db.getList(sql);
			if(users!=null) {
				dcs = new HashMap<String, List<Map<String,String>>>();
				for(Map<String, String> user:users) {
					dcs.put(user.get("username"), getAllFood(Integer.parseInt(user.get("id"))));
				}
			}
			return dcs;
		}
}
