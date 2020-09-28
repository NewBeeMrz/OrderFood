package service;

import java.util.List;
import java.util.Map;

import util.DBUtil;

public class FoodService {
	
	private DBUtil db;
	
	public  FoodService(){
		db = new DBUtil();
	}
	
	//查询所有的菜品信息
	public List<Map<String,String>> queryFoods(){
		String sql="select * from food join foodtype on food.type = foodtype.id";
		List<Map<String,String>> foods = db.getList(sql);
		return foods;
	}
	//查询点击率前三的菜
	public List<Map<String,String>> getHotFood(){
		String sql="select * from food order by hits desc limit 0,3";
		List<Map<String,String>> foods = db.getList(sql);
		return foods;
	}
	//前三的特价菜品
	public List<Map<String,String>> getCheapFood(){
		String sql="select * from food where comment >0  order by hits desc limit 0,3";
		List<Map<String,String>> foods = db.getList(sql);
		return foods;
	}
	//读取点餐率前三的厨师推荐菜品信息
	public List<Map<String,String>> getChiefRecommFood(){
		String sql="select * from food where comment =0  order by hits desc limit 0,3";
		List<Map<String,String>> foods = db.getList(sql);
		return foods;
	}
	//根据id查询菜品详细信息
	public Map<String,String> getFoodById(String id){
		String sql="select food.*,foodtype.typename from food join foodtype on food.type=foodtype.id WHERE food.id=?";
		String[] params = new String[] {id};
		Map<String,String> foods = db.getMap(sql,params);
		return foods;
	}
	//查询全部菜品信息
	public List<Map<String,String>> getAllFood(){
		String sql="select food.*,foodtype.typename from food join foodtype on food.type=foodtype.id order by id";
		List<Map<String,String>> foods = db.getList(sql);
		return foods;
	}
	
	//按分类查询菜品信息
	public List<Map<String,String>> getAllFood(int type){
		String sql="select food.*,foodtype.typename from food join foodtype on food.type=foodtype.id WHERE food.type=? order by id";
		String[] params = new String[] {type+""};
		List<Map<String,String>> foods = db.getList(sql,params);
		return foods;
	}
	//按分类名称查询
	public List<Map<String,String>> getAllFood(String type,String sn){
		String sql="select food.*,foodtype.typename from food join foodtype on food.type=foodtype.id WHERE food.type=? and food.foodname like ? order by id";
		String[] params = new String[] {type,"%"+sn+"%"};
		List<Map<String,String>> foods = db.getList(sql,params);
		return foods;
	}
	//按名称查找
	public List<Map<String,String>> getAllFood(String sn){
		String sql="select food.*,foodtype.typename from food join foodtype on food.type=foodtype.id WHERE food.foodname like ? order by id";
		String[] params = new String[] {"%"+sn+"%"};
		List<Map<String,String>> foods = db.getList(sql,params);
		return foods;
	}
	
	//添加菜品
	public int addFood(String foodname,String feature,String material,String price,String type,String picture,String comment) {
		String sql = "insert into food values(null,?,?,?,?,?,?,0,?)";
		String[] params = new String[] {foodname,feature,material,price,type,picture,comment};
		return db.update(sql, params);
	}
	//根据id删除菜品
	public int deleteFood(String id) {
		String sql = "delete from food where id=?";
		String[] params = new String[] {id};
		return db.update(sql, params);
	}
	
	//根据id修改菜品信息
	public int updateFood(String id,String feature,String material,String price,String type,String comment) {
		String sql = "update food set feature=?,material=?,price=?,type=?,comment=? where id=?";
		String[] params = new String[] {feature,material,price,type,comment,id};
		return db.update(sql, params);
	}
	
}
