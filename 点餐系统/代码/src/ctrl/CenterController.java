package ctrl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import service.DCService;
import service.FoodService;
import service.FoodTypeService;
import service.UserService;

/**
 * Servlet implementation class CenterController
 */
@WebServlet("*.cc")
public class CenterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CenterController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String path = request.getServletPath();
		
		path = path.substring(path.lastIndexOf("/")+1,path.indexOf(".cc"));
		System.out.println(path);
		if(path.equals("login")) {
			String un = request.getParameter("un");
			String pw = request.getParameter("pw");
			UserService userService = new UserService();
			Map<String,String> user = userService.getUserInfo(un, pw);
			if(user != null) {
				request.getSession().setAttribute("登录用户名", un);
				request.getSession().setAttribute("登录用户ID", user.get("id"));
				request.getSession().setAttribute("header", "欢迎"+un+",进入管理系统");
				if(user.get("ident").equals("0")) {
					response.sendRedirect("user/user_index.cc");
				}else {
					response.sendRedirect("admin/admin_index.cc");
				}
			}else {
				request.setAttribute("msg", "用户名或密码错误！");
				request.setAttribute("href", request.getContextPath()+"/login.html");
				request.getRequestDispatcher("/result.jsp").forward(request, response);
			}	
		}else if(path.equals("register")) {
			String un = request.getParameter("un");
			String pw = request.getParameter("pw");
			String ident = request.getParameter("ident");
			String tel = request.getParameter("tel");
			String addr = request.getParameter("addr");
			UserService userService = new UserService();
			int result  = userService.addUser(un, pw, ident, tel, addr);
			if(result > 0) {
				request.setAttribute("msg", "注册成功,返回登录界面");
				request.setAttribute("href", request.getContextPath()+"/login.html");
			}else {
				request.setAttribute("msg", "注册失败,请重新注册");
				request.setAttribute("href", request.getContextPath()+"/register.html");
			}
				request.getRequestDispatcher("/result.jsp").forward(request, response);
		}else if(path.equals("homepage")) {
			FoodService foodService = new FoodService();
			request.setAttribute("hot", foodService.getHotFood());
			request.setAttribute("cheap", foodService.getCheapFood());
			request.setAttribute("recomm", foodService.getChiefRecommFood());
			request.getRequestDispatcher("/homepage.jsp").forward(request, response);
		}else if(path.equals("show_detail")){
			String id = request.getParameter("id");
			FoodService foodService = new FoodService();
			request.setAttribute("food", foodService.getFoodById(id));
			request.getRequestDispatcher("/show_detail.jsp").forward(request, response);
		}else if(path.equals("user_index")) {
			FoodService foodService = new FoodService();
			FoodTypeService foodTypeService = new FoodTypeService();
			String type = request.getParameter("type");
			String sn = request.getParameter("sn");
			if(type !=null && !type.equals("")) {
				if(sn!=null && !sn.equals("")) {
					//按照分类和名称查找
					request.setAttribute("allfood", foodService.getAllFood(type,sn));
				}else {
					//只按照分类查找
					request.setAttribute("allfood", foodService.getAllFood(Integer.parseInt(type)));
				}
			}else {
				if(sn!=null && !sn.equals("")) {
					//按照分类和名称查找
					request.setAttribute("allfood", foodService.getAllFood(sn));
				}else {
					//查找全部
					request.setAttribute("allfood", foodService.getAllFood());
				}
			}
			request.setAttribute("types", foodTypeService.getAllTypes());
			request.getRequestDispatcher("/user/user_index.jsp").forward(request, response);
		}else if(path.equals("user_add_dc")) {
			//用户点餐车
			String[] fids = request.getParameterValues("fids");
			String userid = (String) request.getSession().getAttribute("登录用户ID");
			int r = new DCService().addToDC(userid, fids);
			request.setAttribute("msg", "成功将"+r+"个菜品加入点餐车");
			request.setAttribute("href", request.getContextPath()+"/user_show_dc.cc");
			request.getRequestDispatcher("/result.jsp").forward(request, response);
		}else if(path.equals("user_show_dc")) {
			//用户查看点餐车
			FoodTypeService foodTypeService = new FoodTypeService();
			String type = request.getParameter("type");
			String userid = (String) request.getSession().getAttribute("登录用户ID");
			request.setAttribute("dc", new DCService().getUserDC(userid));
			request.setAttribute("types", foodTypeService.getAllTypes());
			request.getRequestDispatcher("/user/user_show_dc.jsp").forward(request, response);
		}else if(path.equals("user_del_dc")) {
			String[] dcids = request.getParameterValues("dcids");
			int r = new DCService().delFromDC(dcids);
			request.setAttribute("msg", "成功将"+r+"个菜品从点餐车删除");
			request.setAttribute("href", request.getContextPath()+"/user_show_dc.cc");
			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("user_edit")) {
 			String userid = (String) request.getSession().getAttribute("登录用户ID");
 			request.setAttribute("user", new UserService().getUerInfo(userid));
 			request.getRequestDispatcher("/user/user_edit.jsp").forward(request, response);
 		}else if(path.equals("user_update")) {
 			int r = 0;
 			String userid = (String) request.getSession().getAttribute("登录用户ID");
 			String pw = request.getParameter("pw");
 			String tel = request.getParameter("tel");
 			String addr = request.getParameter("addr");
 			r += new UserService().UpdateUserInfo(userid, pw, tel, addr) ;
 			if(r>0) {
 				request.setAttribute("msg", "用户信息修改成功");
 			}else {
 				request.setAttribute("msg", "用户信息修改失败，请重试");
 			}
 			request.setAttribute("href", request.getContextPath()+"/user/user_edit.cc");
 			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("user_DC_index")) {
 			DCService dcService = new DCService();
			FoodTypeService foodTypeService = new FoodTypeService();
			String userid = (String) request.getSession().getAttribute("登录用户ID");
			String type = request.getParameter("type");
			String sn = request.getParameter("sn");
			if(type !=null && !type.equals("")) {
				if(sn!=null && !sn.equals("")) {
					//按照分类和名称查找
					request.setAttribute("dc", dcService.getAllFood(type,sn,Integer.parseInt(userid)));
				}else {
					//只按照分类查找
					request.setAttribute("dc", dcService.getAllFood(Integer.parseInt(type),Integer.parseInt(userid)));
				}
			}else {
				if(sn!=null && !sn.equals("")) {
					//按照名称查找
					request.setAttribute("dc", dcService.getAllFood(sn,Integer.parseInt(userid)));
				}else {
					//查找全部
					request.setAttribute("dc", dcService.getAllFood(Integer.parseInt(userid)));
				}
			}
			request.setAttribute("types", foodTypeService.getAllTypes());
			request.getRequestDispatcher("/user/user_show_dc.jsp").forward(request, response);
 		}else if(path.equals("logout")) {
 			request.getSession().removeAttribute("登录用户ID");
 			request.getSession().removeAttribute("登录用户名");
 			request.getSession().removeAttribute("header");
 			request.setAttribute("msg", "退出系统成功，返回系统首界面");
			request.setAttribute("href", request.getContextPath()+"/homepage.cc");
			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_index")) {
 			request.getRequestDispatcher("/admin/admin_index.jsp").forward(request, response);
 		}else if(path.equals("admin_userlist")) {
 			request.getSession().setAttribute("header", "用户管理界面");
 			UserService userService = new UserService();
 			request.setAttribute("users", userService.queryAllUser());
 			request.getRequestDispatcher("/admin/admin_userlist.jsp").forward(request, response);
 		}else if(path.equals("admin_adduser")) {
 			String un = request.getParameter("un");
			String pw = request.getParameter("pw");
			String ident = request.getParameter("ident");
			String tel = request.getParameter("tel");
			String addr = request.getParameter("addr");
			UserService userService = new UserService();
			int result  = userService.addUser(un, pw, ident, tel, addr);
			if(result > 0) {
				request.setAttribute("msg", "添加成功,返回用户管理界面");
				request.setAttribute("href", request.getContextPath()+"/admin/admin_userlist.cc");
			}else {
				request.setAttribute("msg", "添加失败,请确认信息无误且唯一,返回用户添加界面");
				request.setAttribute("href", request.getContextPath()+"/admin/admin_adduser.jsp");
			}
				request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_deleteuser")) {
 			String id = request.getParameter("id");
 			UserService userService = new UserService();
 			int result  = userService.deleteUser(id);
 			if(result > 0) {
 				request.setAttribute("msg", "删除成功,返回用户管理界面");
 			}else {
 				request.setAttribute("msg", "删除失败,返回用户管理界面");
 			}
 			request.setAttribute("href", request.getContextPath()+"/admin/admin_userlist.cc");
 			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_edituser")) {
 			String id = request.getParameter("id");
 			UserService userService = new UserService();
 			request.setAttribute("user", userService.getUerInfo(id));
 			request.getRequestDispatcher("/admin/admin_edituser.jsp").forward(request, response);
 		}else if(path.equals("admin_updateuser")) {
 			int r = 0;
 			String userid = (String) request.getSession().getAttribute("登录用户ID");
 			String pw = request.getParameter("pw");
 			String ident = request.getParameter("ident");
 			String tel = request.getParameter("tel");
 			String addr = request.getParameter("addr");
 			r += new UserService().UpdateUserInfo(userid,pw,ident,tel, addr) ;
 			if(r>0) {
 				request.setAttribute("msg", "用户信息修改成功");
 			}else {
 				request.setAttribute("msg", "用户信息修改失败，请重试");
 			}
 			request.setAttribute("href", request.getContextPath()+"/admin/admin_userlist.cc");
 			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_foodtype")) {
 			request.getSession().setAttribute("header", "菜品分类管理界面");
 			request.setAttribute("foodtypes", new FoodTypeService().getAllTypes());
 			request.getRequestDispatcher("/admin/admin_foodtype.jsp").forward(request, response);
 		}else if(path.equals("admin_addfoodtype")) {
 			String ftn = request.getParameter("ftn");
 			int r = 0;
 			r+=new FoodTypeService().addtype(ftn);
 			if(r>0) {
 				request.setAttribute("msg", "菜品分类添加成功,返回主界面");
 			}else {
 				request.setAttribute("msg", "菜品分类添加失败，请重试");
 			}
 			request.setAttribute("href", request.getContextPath()+"/admin/admin_foodtype.cc");
 			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_edittype")) {
 			String id = request.getParameter("id");
 			request.setAttribute("type", new FoodTypeService().getType(id));
 			request.getRequestDispatcher("/admin/admin_edittype.jsp").forward(request, response);
 		}else if(path.equals("admin_updatetype")) {
 			String id = request.getParameter("ftid");
 			String typename = request.getParameter("ftn");
 			int r = 0;
 			r+=new FoodTypeService().Updatetype(id, typename);
 			if(r>0) {
 				request.setAttribute("msg", "菜品分类修改成功,返回主界面");
 			}else {
 				request.setAttribute("msg", "菜品分类修改失败，请重试");
 			}
 			request.setAttribute("href", request.getContextPath()+"/admin/admin_foodtype.cc");
 			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_deletetype")) {
 			String id = request.getParameter("id");
 			int r =0;
 			r+=new FoodTypeService().Deletetype(id);
 			if(r>0) {
 				request.setAttribute("msg", "菜品分类删除成功,返回主界面");
 			}else {
 				request.setAttribute("msg", "菜品分类删除失败，请重试");
 			}
 			request.setAttribute("href", request.getContextPath()+"/admin/admin_foodtype.cc");
 			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_food")) {
 			request.getSession().setAttribute("header", "菜品管理界面");
 			FoodService foodService = new FoodService();
			FoodTypeService foodTypeService = new FoodTypeService();
			String type = request.getParameter("type");
			String sn = request.getParameter("sn");
			if(type !=null && !type.equals("")) {
				if(sn!=null && !sn.equals("")) {
					//按照分类和名称查找
					request.setAttribute("allfood", foodService.getAllFood(type,sn));
				}else {
					//只按照分类查找
					request.setAttribute("allfood", foodService.getAllFood(Integer.parseInt(type)));
				}
			}else {
				if(sn!=null && !sn.equals("")) {
					//按照分类和名称查找
					request.setAttribute("allfood", foodService.getAllFood(sn));
				}else {
					//查找全部
					request.setAttribute("allfood", foodService.getAllFood());
				}
			}
			request.setAttribute("types", foodTypeService.getAllTypes());
			request.getRequestDispatcher("/admin/admin_food.jsp").forward(request, response);
 		}else if(path.equals("admin_addfood_")) {
 			request.setAttribute("types", new FoodTypeService().getAllTypes());
 			request.getRequestDispatcher("/admin/admin_addfood.jsp").forward(request, response);
 		}else if(path.equals("admin_addfood")) {
 			String fieldName="";
 			String foodname="";
 			String feature="";
 			String material="";
 			String price="";
 			String type="";
 			String picture="";
 			String comment="";

 			//文件上传的三部曲
 	        //创建工厂
 	        DiskFileItemFactory factoy=new DiskFileItemFactory();
 	        //创建解析器
 	        ServletFileUpload sfu=new ServletFileUpload(factoy);
 	        //设置上传文件的大小
 	        sfu.setFileSizeMax(50*1024*1024);
 	        FileItem item=null;
 	        //解析request
 	        try {
 	        	Iterator<FileItem> iterator = sfu.parseRequest(request).iterator();
 	            while(iterator.hasNext()){
 	                item = iterator.next();
 	                if(item.isFormField()){
 	                    fieldName = item.getFieldName();//得到表单中name的值
 	                    if(fieldName.equals("foodname")) {
 	                    	foodname = item.getString("UTF-8");
 	                    }
 	                    else if(fieldName.equals("feature")) {
 	                    	feature = item.getString("UTF-8");
 	                    }
 	                    else if(fieldName.equals("material")) {
 	                    	material = item.getString("UTF-8");
 	                    }
 	                    else if(fieldName.equals("price")) {
 	                    	price = item.getString("UTF-8");
 	                    }
 	                    else if(fieldName.equals("type")) {
 	                    	type = item.getString("UTF-8");
 	                    }
 	                    else if(fieldName.equals("comment")) {
 	                    	comment = item.getString("UTF-8");
 	                    }

 	                } else {
 	                    //上传路径
 	                    String contextRealPath = getServletContext().getRealPath("/images");
 	                    System.out.println(contextRealPath);
 	                    String fileName = item.getName();//得到文件名
 	                    //检查当前路径下的文件夹是否存在，不存在则新建
 	                    File file = new File(contextRealPath);
 	                    if(!file.exists()) {
 	                    	file.mkdir();
 	                    }
 	                    String temp = "null";
 	    				switch (type) {
 	    				case "1":
 	    					temp="jiachang";
 	    					break;
 	    				case "2":
 	    					temp="liangcai";
 	    					break;
 	    				case "3":
 	    					temp="zhushi";
 	    					break;
 	    				case "4":
 	    					temp="yinpin";
 	    					break;
 	    				}
 	                    //创建需要下载的文件
 	                    File f1 = new File(contextRealPath+File.separator+temp+"/"+File.separator+fileName);
 	                    if(!f1.exists()) {
 	                    	f1.createNewFile();
 	                    }
 	                  //创建需要下载的文件
 	                    File f2 = new File("C:\\Users\\MuffinMrz\\eclipse-workspace\\Myproject621\\WebContent\\images\\"+temp+"\\"+fileName);
 	                    if(!f2.exists()) {
 	                    	f2.createNewFile();
 	                    }
 	                    //向服务器端的文件夹写入数据
 	                    FileOutputStream outputStream = new FileOutputStream(f1);//创建一个文件输出流对象
 	                    InputStream inputStream = item.getInputStream();//创建一个输入流
 	                    byte pool[] = new byte[1024];
 	                    int len = -1;
 	                    while((len = inputStream.read(pool, 0, pool.length)) != -1){
 	                        outputStream.write(pool, 0, len);
 	                    }
 	                    outputStream.flush();
 	                    outputStream.close();
 	                    inputStream.close();
 	                    
 	                    //向本地文件写入图片数据
 	                    FileOutputStream outputStream1 = new FileOutputStream(f2);//创建一个文件输出流对象
 	                    InputStream inputStream1 = item.getInputStream();//创建一个输入流
 	                    byte pool1[] = new byte[1024];
 	                    int len1 = -1;
 	                    while((len1 = inputStream1.read(pool1, 0, pool1.length)) != -1){
 	                        outputStream1.write(pool1, 0, len1);
 	                    }
 	                    outputStream1.flush();
 	                    outputStream1.close();
 	                    inputStream1.close();
 	                    picture="images/"+temp+"/"+fileName;//数据库存储的相对路径
 	                }
 	            }
 	        } catch (FileUploadException e) {
 	            e.printStackTrace();
 	        } catch (Exception e) {
 	            // TODO Auto-generated catch block
 	            e.printStackTrace();
 	        }
 	        
 	        int r=0;
 	        r+= new FoodService().addFood(foodname, feature, material, price, type, picture, comment);
 	        if(r>0) {
 	        	request.setAttribute("msg", "菜品添加成功,返回主界面");
 	        	request.setAttribute("href", request.getContextPath()+"/admin/admin_food.cc");
 	        }else {
 	        	request.setAttribute("msg", "菜品添加失败,请重试");
 	        	request.setAttribute("href", request.getContextPath()+"/admin/admin_addfood_.cc");
 	        }
 	       request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_deletefood")) {
 			String id = request.getParameter("id");
 			int r = 0;
 			r+=new FoodService().deleteFood(id);
 			if(r>0) {
 	        	request.setAttribute("msg", "菜品删除成功,返回主界面");
 	        }else {
 	        	request.setAttribute("msg", "菜品删除失败,请重试");
 	        }
 			request.setAttribute("href", request.getContextPath()+"/admin/admin_food.cc");
 			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_editfood")) {
 			String id = request.getParameter("id");
 			request.setAttribute("types", new FoodTypeService().getAllTypes());
 			request.setAttribute("food", new FoodService().getFoodById(id));
 			request.getRequestDispatcher("/admin/admin_editfood.jsp").forward(request, response);
 		}else if(path.equals("admin_updatefood")) {
 			String id = request.getParameter("id");
 			String feature = request.getParameter("feature");
 			String material = request.getParameter("material");
 			String price = request.getParameter("price");
 			String type = request.getParameter("type");
 			String comment = request.getParameter("comment");
 			if(comment.equals("厨师推荐")) {
 				comment = 0+"";
 			}else if(Integer.parseInt(comment) > 0) {
 				return;
 			}else {
 				comment = null;
 			}
 			System.out.println(type+" "+comment);
 			int r=0;
 			r+=new FoodService().updateFood(id, feature, material, price, type, comment);
 			if(r>0) {
 	        	request.setAttribute("msg", "菜品信息修改成功,返回主界面");
 	        }else {
 	        	request.setAttribute("msg", "菜品修改失败,请重试");
 	        }
 			request.setAttribute("href", request.getContextPath()+"/admin/admin_food.cc");
 			request.getRequestDispatcher("/result.jsp").forward(request, response);
 		}else if(path.equals("admin_diningcar")) {
 			request.getSession().setAttribute("header", "用户点餐情况列表");
 			request.setAttribute("dcs", new DCService().showDC());
 			request.getRequestDispatcher("/admin/admin_show_dc.jsp").forward(request, response);
 		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
