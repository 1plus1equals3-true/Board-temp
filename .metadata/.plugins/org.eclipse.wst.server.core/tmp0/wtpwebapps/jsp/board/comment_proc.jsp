<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.IOException"%>
<%@ page import="java.nio.file.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="lib.DB" %>
    
<%
request.setCharacterEncoding("utf-8");
String login_id = "";
login_id = (String)session.getAttribute("ss_check");
String ip = java.net.Inet4Address.getLocalHost().getHostAddress();
//out.print(ip);

	Date today = new Date(); // 현재 날짜와 시간 객체 생성
	SimpleDateFormat yearFormat = new SimpleDateFormat("yyyyMMdd"); // 년도 형식 지정
	String ymd = yearFormat.format(today); // 년도만 추출
	int intymd = Integer.parseInt(ymd);
	
	SimpleDateFormat filetimeFormat = new SimpleDateFormat("yyyyMMddHHmmss");
	String filetime = filetimeFormat.format(today);


String bidx = request.getParameter("bidx");
String commenttext = request.getParameter("commenttext");

String sql = "";
Connection conn=null;
Statement st = null;
ResultSet rs = null;
PreparedStatement ps = null;

try {
	conn = DB.getConnection();
	
	sql = "insert into comment(bidx,uid,ment,regdate) " +
			   " values(?,?,?,now())";
	
	ps = conn.prepareStatement(sql);
	

	ps.setString(1, bidx);
	ps.setString(2, login_id);
	ps.setString(3, commenttext);
	
	ps.executeUpdate();
	
	response.sendRedirect("view.jsp?idx=" + bidx);
	 
	 
}catch(Exception e){ 
	  out.println(e.toString());
	  out.println(sql);
}finally {
  	if (ps != null){
		   ps.close();
		}
  	if(rs != null){
		   rs.close();
		}
	if (st != null){
		   st.close();
		}
	if (conn != null){
		   conn.close();
		}
}

%>