<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	Object obj=request.getAttribute("flag");
	
	boolean flag=(boolean)obj;
	
%>
<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
	var flag="<%=flag %>";
	if(flag=="true"){
		alert("회원 가입을 수락했습니다.");
	}
	if(flag=="false"){
		alert("회원 가입을 거부했습니다 .");
	}
	opener.document.location.reload();
	self.close();

</script>
<body>
	
</body>
</html>