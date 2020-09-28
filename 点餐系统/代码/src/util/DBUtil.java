package util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DBUtil {
	private String driver;
	private String url;
	private String username;
	private String password;
	private Connection con;
	private PreparedStatement pstmt;
	public static final long PAGE_REC_NUM = 4;	 
	 
	public void setDriver(String driver) {
		this.driver = driver;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	//���췽���������������������û�����������Ϣ
    public DBUtil(){
	  driver="com.mysql.cj.jdbc.Driver";
	  url="jdbc:mysql://localhost:3306/mealsystem?characterEncoding=utf-8&serverTimezone=UTC&useSSL=false";
	  username="root";
	  password="root";
    }
    
	//�����������򣬵õ����Ӷ���
	private void init(){
		try {
			Class.forName(driver);
			con=DriverManager.getConnection(url,username,password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//�رղ���
	public void close(){
		if(pstmt!=null){
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(con!=null){
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
    //��sql������ò���
    private void setParams(String[] params){
    	if(params!=null){
    		for(int i=0;i<params.length;i++){
    			try {
					pstmt.setString(i+1, params[i]);
				} catch (SQLException e) {
					e.printStackTrace();
				}
    		}
    	}
    }
    
    //ִ�и���
    public int update(String sql,String[] params){
    	int result=0;
    	init();
    	try {
			pstmt=con.prepareStatement(sql);
			setParams(params);
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close();
		}
    	return result;
    }
    
    public int update(String sql){
    	return update(sql, null);
    }
    
   //��ѯ��ȡList����
 	public List<Map<String,String>> getList(String sql, String[] params) {
 		List<Map<String,String>> list = null;// ���屣���ѯ����ļ��϶���
 		init();
 		try {
 			pstmt=con.prepareStatement(sql);
 			setParams(params);
 			ResultSet rs = pstmt.executeQuery();
 			list = getListFromRS(rs);// ����RS�õ�list
 			rs.close();
 		} catch (Exception e) {
 			e.printStackTrace();
 		} finally {
 			close();
 		}
 		return list;
 	}
 	
 	//û�в�����SQL���
 	public List<Map<String,String>> getList(String sql){
 		return getList(sql, null);
 	}
 	
 	//��ѯ��ȡMap����
 	public Map<String,String> getMap(String sql, String[] params) {
 		Map<String,String> m = null;
 		List<Map<String,String>> l = getList(sql, params);
 		if (l != null && l.size() != 0){
 			m = (Map<String,String>) (l.get(0));
 		}
 		return m;
 	}
   
 	public Map<String,String> getMap(String sql){
 		return getMap(sql, null);
 	}
 	
 	//���������װ��һ��List
	private List<Map<String,String>> getListFromRS(ResultSet rs) throws SQLException {
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		// ��ȡԪ����
		ResultSetMetaData rsmd = rs.getMetaData();
		while (rs.next()) {
			Map<String,String> m = new HashMap<String,String>();
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
				// ��ȡ��ǰ�е�i�е�����
				String colName = rsmd.getColumnLabel(i);
				String s = rs.getString(colName);
				if (s != null) {
						m.put(colName, s);
				}
			}
			list.add(m);
		}
		return list;
	}
 	
	//��Map����ת��ΪObject����
	public Object[] getObjectArrayFromMap(Map map, String key) {
		String[] keys = key.split(",");
		Object[] tmp = new Object[keys.length];
		for (int i = 0; i < keys.length; i++) {
			tmp[i] = map.get(keys[i].trim());
		}
		return tmp;
	}
	
	// ��ҳ��ʾ����ȡҳ��ΪcurPage�ı�ҳ���м�¼
	// ���ص�Map�����д������Ԫ�أ�
	// key="list"��Ԫ���Ǵ���˱�ҳ���м�¼��List����
	// key="totalPage"��Ԫ���Ǵ�����ҳ����Integer����
	// key="recNum"��Ԫ���Ǵ���ÿҳ��¼��
	public Map<String,Object> getPage(String sql, String[] params, String curPage) {
		Map<String,Object> page = new HashMap<String,Object>();
		String newSql = sql + " limit " + (Long.parseLong(curPage) - 1)
				* PAGE_REC_NUM + "," + PAGE_REC_NUM;
		List<Map<String,String>> pageList = getList(newSql, params);// ����getList�����õ�list
		// ������ҳ��
		sql = sql.toLowerCase();
		String countSql = "";
		if(sql.indexOf("group")>=0){
			countSql = "select count(*) from ("+sql+") as tempNum";
		}else{
			countSql = "select count(*) as tempNum "+ sql.substring(sql.indexOf("from"));
		}	
		// count�д���ܼ�¼��
		String count_s = (String)getMap(countSql,params).get("tempNum");
		long count = Long.parseLong(count_s); // ����getLong�����õ���¼��
		// �����ܼ�¼����count����ÿҳ��¼������PAGE_REC_NUM��������ҳ��
		long totalPage = 0;
		if (count % PAGE_REC_NUM == 0)
			totalPage = count / PAGE_REC_NUM;
		else
			totalPage = count / PAGE_REC_NUM + 1;
		// ���ص�Map����page�У���ŵ�ǰ��ҳ���м�¼��List����pageList
		page.put("list", pageList);
		page.put("totalPage", totalPage);
		page.put("recNum", PAGE_REC_NUM);
		return page;
	}

	public Map<String,Object> getPage(String sql, String curPage) {
		return getPage(sql, null, curPage);
	}
}