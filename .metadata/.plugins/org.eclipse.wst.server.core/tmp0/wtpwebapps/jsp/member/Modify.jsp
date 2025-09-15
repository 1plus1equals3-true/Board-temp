<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>       
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="lib.DB" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify</title>
<style>
td {
padding: 10px;
text-align: center;
}
</style>
</head>
<body>
<%
  Date today = new Date(); // 현재 날짜와 시간 객체 생성
  SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy"); // 년도 형식 지정
  String year = yearFormat.format(today); // 년도만 추출
  int intyear = Integer.parseInt(year);
%>
<h2>회원 정보 수정</h2>
<%
	String loginerr = request.getParameter("loginerr");
	if (loginerr != null) out.print("비밀번호가 일치하지 않습니다.");
%>

<%

String uid = request.getParameter("uid");


   Connection conn=null;
   Statement st = null;
   ResultSet rs = null;
    
   String sql = null;

  try{
    
    conn = DB.getConnection();
    //out.println("연결 성공");
    
   //쿼리문 작성
   sql = " select * from member where uid = '"+uid+"' ";
   
   //Connection객체로부터 Statement객체를 얻어내는 코드
   st = conn.createStatement();
   
   rs = st.executeQuery(sql);
    
  }catch(Exception e){ 
    e.printStackTrace();
    out.println(sql);
  }
%>


<%

String idx = "";
String upassword = "";
String upasscheck = "";
String name = "";
String sex = "";
String hobby = "";
String birth = "";
String upfile = "";

String [] str = null;
String [] hob = null;

if(rs != null){
   rs.next();
   
   idx = rs.getString("idx");
   upassword = rs.getString("upassword");
   upasscheck = rs.getString("upasscheck");
   name = rs.getString("name");
   sex = rs.getString("sex");
   hobby = rs.getString("hobby");
   birth = rs.getString("birth");
   str = birth.split("-");
   hob = hobby.split(",");
   upfile = rs.getString("originalfile");
   
   	
}
	String yyyyy = str[0];
		int yyyyyy = Integer.parseInt(yyyyy);
	String mmmmm = str[1];
		int mmmmmm = Integer.parseInt(mmmmm);
	String ddddd = str[2];
		int dddddd = Integer.parseInt(ddddd);
	boolean cnrrn = Arrays.stream(hob).anyMatch(h -> h.equals("football"));
	boolean shdrn = Arrays.stream(hob).anyMatch(h -> h.equals("basketball"));
	boolean qorn = Arrays.stream(hob).anyMatch(h -> h.equals("Volleyball"));
%>


<br>

<form name="Join_form" method="post" action="Modify_proc.jsp" enctype="multipart/form-data">

<input type="hidden" name="idx" value="<%= idx %>">

	<table>
			<tr>
			<td>아이디</td>
			<td><input type="text" name="uid" value="<%= uid %>" readonly></td>
			</tr>
			
			<tr>
			<td>비밀번호</td>
			<td><input type="password" name="upass1" value="<%= upassword %>"></td>
			</tr>
			
			<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="upass2" value="<%= upasscheck %>"></td>
			</tr>
			
			<tr>
			<td>이름</td>
			<td><input type="text" name="uname" value="<%= name %>"></td>
			</tr>
			
			<tr>
			<td>성별</td>
			<td><input type="radio" name="sex" value="M" <%=(sex.equals("M"))?"checked":""%>>남자
				<input type="radio" name="sex" value="F" <%=(sex.equals("F"))?"checked":""%>>여자</td>
			</tr>
			
			<tr>
			<td>생일</td>
			<td>
			<select name="yyyy">
			<% 
				for (int i=1950; i<=intyear; i++) {
					if (i==yyyyyy) {
			%>
						<option value="<%= i %>" selected="selected"><%= i %></option>
			<%
					}
					else {
			%>
					<option value="<%= i %>"><%= i %></option>
			<%
					}
				}
			%>
			</select>년
			
			<select name="mm">
			<%
				for (int i=1; i<=12; i++) {
					if (i==mmmmmm) {
			%>
					<option value="<%= i %>" selected="selected">
										<% if (i < 10) { %>
											0<%= i %>
										<% } else { %>
											<%= i %>
										<% } %>
					</option>
			<%
					}
					else {
			%>
					<option value="<%= i %>">
										<% if (i < 10) { %>
											0<%= i %>
										<% } else { %>
											<%= i %>
										<% } %>
					</option>
			<%
					}
				}
			%>
			</select>월
			
			<select name="dd">
			<% 
				for (int i=1; i<=31; i++) {
					if (i==dddddd) {
			%>
					<option value="<%= i %>" selected="selected">
										<% if (i < 10) { %>
											0<%= i %>
										<% } else { %>
											<%= i %>
										<% } %>
					</option>
			<%
					}
					else {
			%>
					<option value="<%= i %>">
										<% if (i < 10) { %>
											0<%= i %>
										<% } else { %>
											<%= i %>
										<% } %>
					</option>
			<%
					}
				}
			%>
			
			</select>일
			
			<tr>
			<td>취미</td>
			<td><input type="checkbox" name="hobby" value="football" <%=(cnrrn==true)?"checked":""%>>축구
				<input type="checkbox" name="hobby" value="basketball" <%=(shdrn==true)?"checked":""%>>농구
				<input type="checkbox" name="hobby" value="Volleyball" <%=(qorn==true)?"checked":""%>>배구</td>
			</tr>
			
			<tr>
			<td>사진</td>
			<td>
			<input type="checkbox" name="filecheck" id="myCheckbox" value="on" onchange="toggleContent()">
			<label for="myCheckbox">새로운 파일 업로드</label>

			<div id="additionalContent" style="display: none;">
			    <input type="file" name="upfile" accept=".gif, .jpg, .png"><br>
			</div>
			<script>
			function toggleContent() {
			    var checkbox = document.getElementById('myCheckbox');
			    var content = document.getElementById('additionalContent');
			
			    if (checkbox.checked) {
			        content.style.display = 'block'; 
			    } else {
			        content.style.display = 'none';
			    }
			}
			</script>
			
			<%
				if (upfile != null) {
			%>
					<br>기존 파일 : <%= upfile %>
			<%
				}
			%>
			</td>
			</tr>
			
			<tr>
			<td></td>
			<td><button type="submit">수정</button>
				<button type="reset">리셋</button>
			<a href="List.jsp"><button type="button">리스트</button></a>
			</td>
			</tr>
	</table>
</form>

</body>
</html>