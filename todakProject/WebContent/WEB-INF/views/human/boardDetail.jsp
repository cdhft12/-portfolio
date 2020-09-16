<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.human.vo.HboardVO"  %>
<%@ page import="java142.todak.human.vo.MemberVO"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 상세보기</title>
	<link rel="stylesheet" href="/include/css/commons/hBoardDetail.css">
	
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript">
	 $(document).ready(function(){
         $("#fileDownload").click(function(){          
             $("#detailBoard")
             .attr("action","/human/boardDownload.td")
             .submit();
          });
         $("#delete").click(function(){ 
        	 var choice = confirm("게시글을 삭제 하시겠습니까?");
        	 if(choice){
	        	 $("#updateForm").attr({
	                 "method":"post",
	                 "action":"/human/deleteHboard.td"
	              });
	        	 $("#updateForm").submit();
        	 }else{
        		 return false;
        	 }
          });
         $("#update").click(function(){ 
        	 var choice = confirm("게시글을 수정 하시겠습니까?");
        	 if(choice){
	        	 $("#updateForm").attr({
	                 "method":"post",
	                 "action":"/human/moveUpdate.td"
	              });
	        	 $("#updateForm").submit();
        	 }else{
        		 return false;
        	 }
          });
         $("#accept").click(function(){          
             var userResult = confirm("내용을 확인 하셨습니까?");
             $("#hb_accepte").val("Y");
             if(userResult){
            	 $("#acceptYN").attr({
                     "method":"post",
                     "action":"/human/boardAccept.td"
                  });
            	 $("#acceptYN").submit();
             }else{
            	return false;
             }
          });
         $("#acceptN").click(function(){          
             var userResult = confirm("내용확인을 취소하시겠습니까?");
             $("#hb_accepte").val("N");
             if(userResult){
            	 $("#acceptYN").attr({
                     "method":"post",
                     "action":"/human/boardAccept.td"
                  });
            	 $("#acceptYN").submit();
             }else{
            	return false;
             }
          });
	 });
	</script>
</head>
<%
	Object board=request.getAttribute("boardList");
	Object user=request.getAttribute("userInfo");
	
	ArrayList<HboardVO> bList=(ArrayList<HboardVO>)board;
	
	HboardVO hvo=bList.get(0);
	MemberVO mvo=(MemberVO)user;
	
	String fulladdr="/upload/human/";
	fulladdr=fulladdr+hvo.getHb_image();
%>
<body>
  <header class="header"> 
       <%@ include file="/WEB-INF/views/commons/header.jsp" %>
  </header>

  <aside class="sidebar">
       <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
  </aside>
    	
    <h3><b>인사 게시판</b></h3>
     <hr>
  <div class="context-container">
	<form name="detailBoard" id="detailBoard">
		<div class="board_div" align="center">
			<table class="detail_table" >
				 
                <tbody>
                  <tr>
                  	<td align=center width="20%" style="border-right:1px solid #000000;">제목</td>
                  	<td align=center colspan="3" ><%=hvo.getHb_title() %></td>
                  	          
                  </tr>
                  <tr>
                  	<td align=center style="border-right:1px solid #000000;">작성자</td>
                  	<td align=center style="border-right:1px solid #000000;"><%=hvo.getHm_name() %></td>
                  	<td align=center style="border-right:1px solid #000000;">조회수   <%=hvo.getHb_hitnum() %></td>    
                  
<%
  	if(hvo.getHb_insertdate().equals(hvo.getHb_updatedate())){
%>  			
					<td align=center >작성일 <%=hvo.getHb_insertdate() %></td>
				</tr>	
					
 <% 		
  	}else{
 %>
  					<td align=center >수정일 <%=hvo.getHb_updatedate() %> </td>
  				</tr>						
 <% 			
  	}
 %>    
 				<tr>
                 	<td align=center style="border-right:1px solid #000000;">내용</td>
                 	<td align=left valign=top colspan="3" height="350px" width="800px" style="word-break:break-all;">
                 		<%=hvo.getHb_content() %>
                 	</td>
                </tr>          

 				
 <%
 	String image=hvo.getHb_image();
 	if(image!=null&&image.length()!=0){
 %> 				
 				<tr>
 					<td align=center style="border-right:1px solid #000000;">첨부사진</td>
 					<td height="150px" width="300px" style="table-layout:fixed;"><img src="<%=fulladdr %>" width="100%" height="100%" ></td>		
 				</tr>
 <%		
 	}
 %>
  <%
 	String file=hvo.getHb_file();
 	if(file!=null&&file.length()!=0){
%>
				<tr>
					<td align=center style="border-right:1px solid #000000;">첨부파일</td>
					<td colspan="3">
						<%=file %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    	<input type="button" class="button" id="fileDownload" name="fileDownload" value="파일 다운로드">
					</td>				
				</tr>
<%		
 	}
 %>
                
                
              </tbody>   
			</table>			
		</div>
		<div class="accept_div">
<%
		String aceept=hvo.getHb_accepte();
		String position=mvo.getHm_position();
		String teamnum=mvo.getHm_teamnum();
		String deptnum=hvo.getHb_deptnum();
		if(aceept.equals("N")&&position.equals("14")&&teamnum.equals(deptnum))
		{
%>
					<td colspan="3">
						<input type="button" class="button" id="accept" name="accept" value="수락">
					</td>		
<%			
		}
		
%>		
<%
		if(aceept.equals("Y")&&position.equals("14")&&teamnum.equals(deptnum))
		{
%>
					
					<td colspan="3">
						<input type="button" class="button" id="acceptN" name="acceptN" value="수락취소">
					</td>	
<%			
		}
		
%>			
<%
	String readUser=mvo.getHm_empnum();
	String boardUser=hvo.getHm_empnum();
	if(readUser.equals(boardUser)){
%>

					<td colspan="3">
						<input type="button" class="button" id="update" name="update" value="수정">
					</td>	
					<td colspan="3">
						<input type="button" class="button" id="delete" name="delete" value="삭제">
					</td>	
<%
	}
%>
		</div>
		<input type="hidden" id="hb_file" name="hb_file" value="<%=hvo.getHb_file() %>">
		
	</form>
	<form name="acceptYN" id="acceptYN">
		<input type="hidden" id="hb_num" name="hb_num" value="<%=hvo.getHb_num() %>">
		<input type="hidden" id="hb_accepte" name="hb_accepte" value="<%=hvo.getHb_accepte() %>">
	</form>
	<form name="updateForm" id="updateForm">
		<input type="hidden" id="hb_num" name="hb_num" value="<%=hvo.getHb_num() %>">
		<input type="hidden" id="hm_empnum" name="hm_empnum" value="<%=hvo.getHm_empnum() %>">
		<input type="hidden" id="hm_name" name="hm_name" value="<%=hvo.getHm_name() %>">
		<input type="hidden" id="hm_duty" name="hm_duty" value="<%=hvo.getHm_duty() %>">
		<input type="hidden" id="hb_deptnum" name="hb_deptnum" value="<%=hvo.getHb_deptnum() %>">
		<input type="hidden" id="hm_position" name="hm_position" value="<%=hvo.getHm_position() %>">
		<input type="hidden" id="hb_title" name="hb_title" value="<%=hvo.getHb_title() %>">
		<input type="hidden" id="hb_image" name="hb_image" value="<%=hvo.getHb_image() %>">
		<input type="hidden" id="hb_file" name="hb_file" value="<%=hvo.getHb_file() %>">
		<input type="hidden" id="hb_content" name="hb_content" value="<%=hvo.getHb_content() %>">
		<input type="hidden" id="hb_hitnum" name="hb_hitnum" value="<%=hvo.getHb_hitnum() %>">
		<input type="hidden" id="hb_accepte" name="hb_accepte" value="<%=hvo.getHb_accepte() %>">
		<input type="hidden" id="hb_insertdate" name="hb_insertdate" value="<%=hvo.getHb_insertdate() %>">
		<input type="hidden" id="hb_updatedate" name="hb_updatedate" value="<%=hvo.getHb_updatedate() %>">
	</form>
</div>	
</body>
</html>