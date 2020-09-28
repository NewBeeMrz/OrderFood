<%@ page language="java" pageEncoding="utf-8"%>
<h1 style="text-align:center;color:#F00">欢迎${登录用户名 }，进入点餐系统</h1>
	<div style="text-align:right">
		<a href="${pageContext.request.contextPath }/user/user_index.cc">用户首页</a>&nbsp;
		<a href="${pageContext.request.contextPath }/user/user_show_dc.cc">查看点餐车</a> &nbsp;
		<a href="${pageContext.request.contextPath }/user/user_edit.cc">修改用户资料</a> &nbsp;
		<a href="${pageContext.request.contextPath }/logout.cc" onclick="return confirm('确定要退出当前系统吗?')">退出点餐系统</a>
	</div>
	<hr style="border:1px solid #0F0"><br>