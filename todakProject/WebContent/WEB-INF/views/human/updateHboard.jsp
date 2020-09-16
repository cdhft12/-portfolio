<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.human.vo.MemberVO"  %>  
<%@ page import="java142.todak.human.vo.HboardVO"  %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>글수정</title>
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
			
			 $("#imgCancelButton").hide();
			 $("#fileCancelButton").hide();			
			 $("#insert_image").hide();
			 $("#older_image").hide();
			 $("#insert_file").hide();
			 $("#older_file").hide();
			 
			 if($("#imgDivFlag").val()!="null"){
				 $("#older_image").show();
			 }else{
				 $("#insert_image").show();
			 }
			 if($("#fileDivFlag").val()!="null"){
				 $("#older_file").show();
			 }else{
				 $("#insert_file").show();
			 }
			 
			 var fileFlag="";
			 
			 $("#deleteImage").click(function(){        
				 
				 $("#insert_image").show();
				 $("#older_image").hide();
				 $("#imgCancelButton").show();
				 $("#imgFlag").val("delete");
	          });
			 
			 $("#deleteFile").click(function(){          
				 $("#insert_file").show();
				 $("#older_file").hide();
				 $("#fileCancelButton").show();		
				 $("#fileFlag").val("delete");
	          });
			 $("#imgDeleteCancel").click(function(){          
				 $("#insert_image").hide();
				 $("#older_image").show();
				 $("#imgCancelButton").hide();
				 $("#imgFlag").val("");
	          });
			 
			 $("#fileDeleteCancel").click(function(){          
				 $("#insert_file").hide();
				 $("#older_file").show();
				 $("#fileCancelButton").hide();
				 $("#fileFlag").val("");
	          });
			 
			$("#fileDownload").click(function(){          
	             $("#updateForm")
	             .attr("action","/human/boardDownload.td")
	             .submit();
	          });
			$("#insert").click(function(){
				
				
				oEditors.getById["hb_content"].exec("UPDATE_CONTENTS_FIELD",[]);
				
				var image=$("#hb_image").val();
				
				var file=$("#hb_file").val();
				
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
				
				
				
				$("#updateForm").attr({
					"method":"POST",
					"action":"../human/updateHboard.td"
				});
				$("#updateForm").submit();
			
			});
		});
		</script>
	</head>
	<%
		Object obj=request.getAttribute("hvo");
		HboardVO hvo=(HboardVO)obj;
		
	    String hm_name=hvo.getHm_name();
		String hm_position=hvo.getHm_position();
		String hm_duty=hvo.getHm_duty();
		String hb_title=hvo.getHb_title();
		String hb_content=hvo.getHb_content();
		String hb_imgae=hvo.getHb_image();
		String hb_file=hvo.getHb_file();
		String hb_num=hvo.getHb_num();
		String fulladdr="/upload/human/";
		String img=hvo.getHb_image();
		fulladdr=fulladdr+hvo.getHb_image();
		String file=hvo.getHb_file();
	%>	
	<body>
		<header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
         </aside>
          <h3><b>게시판 수정</b></h3>
     	  <hr>     
         <div class="context-container">    
         	<table class ="hboard" align="center" border="1" >
         		<form id="updateForm" name="updateForm" enctype="multipart/form-data">
       
         				
         					<tr>
         						 <td>작성자</td>
         						 <td>
         							 <input type="text" name="hm_name" id="hm_name" value="<%=hm_name%>" readonly>
         						 </td>
         					</tr>
         				
         				
         					<tr>
         						 <td>제목</td>
         						 <td>
         							 <input type="text" name="hb_title" id="hb_title" size="80" value="<%=hb_title%>">
         						 </td>
         					</tr>
         			
         			
         					<tr>
         						 <td>내용</td>
         						 <td>
         							<textarea name="hb_content" id="hb_content" ><%=hb_content%></textarea>
         						 </td>
         					</tr>
         				
         		

						<tr id="older_image">
			 
			 					<td>첨부사진</td>
			 					<td height="150px" width="300px" style="table-layout:fixed;"><img src="<%=fulladdr %>" width="50%" height="100%" >	
			 					<input type="button" class="button" id="deleteImage" name="deleteImage" value="사진 삭제">	
								</td>
			 			
			 			 </tr>	

							 
						<tr id="insert_image">
         					
         						 <td>이미지</td>
         						 <td>
         							<input type="file" name="hb_image" id="hb_image">         							
         						 </td>
         					</td>
         				</tr>			
			
						<tr id="imgCancelButton">
								<td colspan="2" align="center">
         							<input type="button" class="button" id="imgDeleteCancel" name="imgDeleteCancel" value="사진 삭제 취소">
         						</td>	
         				</tr>		 
					 
						<tr id="older_file">
								
									<td>첨부파일</td>
									<td colspan="3">
										<%=file %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				                    	<input type="button" class="button" id="fileDownload" name="fileDownload" value="파일 다운로드">
										<input type="button" class="button" id="deleteFile" name="deleteFile" value="파일 삭제">	
									</td>				
								
						</t> 		
   
 				
 						<tr id="insert_file">
         					
         						 <td>첨부파일</td>
         						 <td>
         							<input type="file" name="hb_file" id="hb_file">
         						 </td>
         					
         				</tr>      			

					<tr id="fileCancelButton">
							<td colspan="2" align="center">
         						<input type="button" class="button" id="fileDeleteCancel" name="fileDeleteCancel" value="파일 삭제 취소">
         					</td>	
         			</tr>
         				
         				
         					<tr>
         						 <td>공지대상</td>
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
         				
         			
         			<input type="hidden" name="hb_num" id="hb_num" value="<%=hb_num%>">
         	
         			
         			<input type="hidden" name="imgDivFlag" id="imgDivFlag" value="<%=img%>">
         			<input type="hidden" name="fileDivFlag" id="fileDivFlag" value="<%=file%>" >
         			
         			<input type="hidden" name="imgFlag" id="imgFlag">
         			<input type="hidden" name="fileFlag" id="fileFlag">
         			<tr align = "center">
         				<td colspan="2">
		         			<input type="button" class="button" value="저장" id="insert" name="insert" />
							<input type="button" class="button" value="목록" id="back" name="back"/>
						</td>
					</tr>
         		</form>
         	</table>
         </div>
	</body>
	</html>