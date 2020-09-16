<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.human.vo.MemberVO"  %>  
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>글작성</title>
		<link rel="stylesheet" href="/include/css/commons/default.css">
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
		<script type="text/javascript" src="../webedit/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>
		<script type="text/javascript">
		var oEditors = [];
		$(function(){
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "hb_content",  
				sSkinURI : "../webedit/dist/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true,
					bUseVerticalResizer : true,
					bUseModeChanger : true,
					fOnBeforeUnload : function() {
					}
				},
				fOnAppLoad : function() {
					var contents="본문:"
					oEditors.getById["bn_content"].exec("PASTE_HTML", [contents]);
				},
				fCreator : "createSEditor2"
			});
			$("#insert").click(function(){
				
				oEditors.getById["hb_content"].exec("UPDATE_CONTENTS_FIELD",[]);
				var contents= $("#hb_content").val();
				var imgFile=$("#hb_image").val().split('.').pop().toLowerCase();
				var etcFile=$("#hb_file").val().split('.').pop().toLowerCase();
	
				//본문 여백 유효성검사가 이걸로는 완벽하게 되지 않는다. 방법찾아볼것!
				
				if(contents == "<p>&nbsp;</p>" || contents == '&nbsp;' || contents == '<p><br></p>' || contents == '<p></p>' || contents == '<br>' || contents == '<p><br></p><p><br></p>'){
					alert("내용을 입력하세요");
					oEditors.getById["hb_content"].exec('FOCUS');
					return false;
				}
				if(!$("#hb_title").val()) {
					alert("제목을 입력하세요");
					$("#hb_title").focus();
					return false;
				}
				if(imgFile){
					if(jQuery.inArray(imgFile,['gif','png','jpg','jpeg']) == -1 ) {
                        alert('gif,png,jpg,jpeg 사진만 업로드 할 수 있습니다');
						return false;
					}
				}
				if(etcFile){
					if(jQuery.inArray(etcFile,['hwp','pdf','doc','xlsx','xls','xml']) == -1 ) {
                        alert('hwp,pdf,doc,xlsx,xls,xml 파일만 업로드 할 수 있습니다');
						return false;
					}
				}
				$("#insertForm").attr({
					"method":"POST",
					"action":"../human/insertHboard.td"
				});
				
				$("#insertForm").submit();
			});
			$("#back").click(function(){
				location.href="../human/humanBoard.td";
			});
		});
		</script>
	</head>
	<%
		Object obj=request.getAttribute("mvo");
	    MemberVO mvo=(MemberVO)obj;
	    String hm_name=mvo.getHm_name();
		String hm_position=mvo.getHm_position();
		String hm_duty=mvo.getHm_duty();
		
	%>	
	<body>
		<header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
         </aside>
          <h3><b>인사 게시판 글쓰기</b></h3>
     	  <hr>         
         <div class="context-container">   
         	<div id="hboard">
         		<form id="insertForm" name="insertForm" enctype="multipart/form-data">
         			<table class="insertHboard" border="1" align="center">
         				<tbody>
         					<tr>
         						 <td align="center">작성자 </td>
         						 <td><%=hm_name%></td>				  
         					</tr>
         				
         					<tr>
         						 <td align="center">제목</td>
         						 <td>
         							 <input type="text" name="hb_title" id="hb_title" size="62">
         						 </td>
         					</tr>
         				
         					<tr>
         						 <td align="center">내용</td>
         						 <td height="200" width="500">
         							<textarea name="hb_content" id="hb_content"></textarea>
         						 </td>
         					</tr>
         			
         					<tr>
         						 <td align="center">이미지</td>
         						 <td>
         							<input type="file" name="hb_image" id="hb_image">
         						 </td>
         					</tr>
         				
         					<tr>
         						 <td align="center">첨부파일</td>
         						 <td>
         							<input type="file" name="hb_file" id="hb_file">
         						 </td>
         					</tr>
         				
         				
         					<tr>
         						 <td align="center">공지대상</td>
         						<td>
	         						<select id="hb_deptnum" name="hb_deptnum">
										<option value="98">전체공지</option>
										<option value="00" style="font-weight:bold">경영지원본부</option>
										<option value="04">인재경영팀</option>
										<option value="05">재무팀</option>
										<option value="06">관리팀</option>
										<option value="01" style="font-weight:bold">전략기획본부</option>
										<option value="07">기획팀</option>
										<option value="08">소통협력팀</option>
										<option value="09">IT팀</option>
										<option value="02" style="font-weight:bold">마케팅본부</option>
										<option value="10">홍보팀</option>
										<option value="03" style="font-weight:bold">나눔사업본부</option>
										<option value="11">배분팀</option>
										<option value="12">혁신사업팀</option>
									</select>
								</td>

         				</tr>
        
				
         				</tbody>
         				<tr align = "center">
	         				<td colspan="2">
		         				<input align = "right" type="button" value="저장" id="insert" name="insert">
								<input align = "right" type="button" value="목록" id="back" name="back">
							</td>	
         				<tr>
         			</div>
         		</table>
         			<input type="hidden" name="hm_position" id="hm_position" value="<%=hm_position%>">
         			<input type="hidden" name="hm_duty" id="hm_duty" value="<%=hm_duty%>">
         			<input type="hidden" name="hm_name" id="hm_name" value="<%=hm_name%>">
         			
         		
         	</form>
         </div>
	</body>
	</html>