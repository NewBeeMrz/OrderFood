<%@ page language="java" contentType="text/html; charset=utf-8"%>
<h2>操作提示页面</h2><hr>
<h3 style="color:#FF0000">
	${requestScope.msg }<br>
	3秒后自动跳转..........
	<%
	String href = "3;URL="+request.getAttribute("href");
	response.setHeader("Refresh", href); %>
	<a href="${href }">返回</a>
</h3>