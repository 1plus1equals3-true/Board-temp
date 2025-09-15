<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>    
<%@ page import="lib.DB" %>
<%@page import="java.io.File"%>
<%
String uid = request.getParameter("uid");

String sql = "";

  Connection conn=null;

  try{
    
    conn = DB.getConnection();
    //out.println("연결 성공");
    			PreparedStatement ps = null;
			 	ResultSet rs = null;
			  	String upfile = "";
			  	String originaldir = "";
    {
    	sql = "select * from member where uid=?";
		 ps = conn.prepareStatement(sql);
		 
		 ps.setString(1, uid);
		 rs = ps.executeQuery();
		 rs.next();
		 upfile = rs.getString("upfile");
		 originaldir = rs.getString("originaldir");
		 if (upfile != null) {
			 String del_file = originaldir+"\\"+upfile;
			 System.out.println(del_file+" del");
			 File file = new File(del_file);
			 
			 if( file.exists() ){
		    		if(file.delete()){
		    			//System.out.println("파일삭제 성공");
		    		}else{
		    			//System.out.println("파일삭제 실패");
		    		}
		 		}
			 }
    }
    
    
    
   //쿼리문 작성
   sql = " delete from member where uid ='"+uid+"' ";
   
   //Connection객체로부터 Statement객체를 얻어내는 코드
   Statement st = conn.createStatement();
   
   //쿼리문을 DB에 실행하는 코드
   st.executeUpdate(sql);

   out.println("삭제 성공");
   
   response.sendRedirect("List.jsp");
    
  }catch(Exception e){ 
    e.printStackTrace();
    out.println(sql);
  }
%>