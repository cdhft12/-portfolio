<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java142.todak.human.vo.HboardVO"  %>
<%@ page import="java142.todak.human.vo.MemberVO"  %>
<%@ page import="java142.todak.human.vo.PagingVO"%>     
<%@ page import="java.util.ArrayList"  %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<%
		Object obj=request.getAttribute("bList");
		ArrayList<HboardVO> bList=(ArrayList<HboardVO>)obj;		
		
		Object userObj=request.getAttribute("userInfo");
		MemberVO userVO=(MemberVO)userObj;	
		
		//유저 인포메이션 정보를 보드디테일로 넘겨서 자기가 쓴글이면 수정 삭제 되도록 할것.

		
		String key=userVO.getKeyword();
		String ser=userVO.getSearch();
		int Size=userVO.getPageSize();
		
		int pageSize = userVO.getPageSize();
		int groupSize = userVO.getGroupSize();
		int curPage = userVO.getCurPage();
		int totalCount = userVO.getTotalCount();
		
		if(request.getParameter("curPage") != null)
		{
			curPage = Integer.parseInt(request.getParameter("curPage"));
		}
	%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인사공지 게시판</title>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="/include/css/commons/humanBoard.css">
	<script type="text/javascript">
		$(document).ready(function(){
			var flag=false
			
			if('<%=key %>' != 'null'){
				$("#keyword").val('<%=key %>');
				$("#search").val('<%=ser %>');
			}
			if('<%=Size %>' > 0){
				$("#pageCtrl").val('<%=Size %>');
			}
			$("#search").change(function(){
				if($("#search").val()=="all"){
					$("#keyword").val("전체목록을 조회");
				}else if($("#search").val()!="all"){
					$("#keyword").val("");
					$("#keyword").focus();
				}
			});
			$("#selectData").click(function(){
				if($("#search").val()!="all"){
					if(!chkSubmit($('#keyword'),"검색어를"))return;
				}
				goPage(1);
			});
			
			$("#pageCtrl").change(function(){
				goPage(1);
			});
			
			 $("#input").click(function(){
				 $.ajax({
		               url:"/human/Authority.td",
		               type:"POST",
		               error:function(){
		                  alert('시스템 오류 입니다. 관리자에게 문의 하세요');
		               },
		               success:function(resultData){
		                  if(resultData==false){
		                     alert("권한이 불충분합니다!");
		                  }
		                  if(resultData==true){
		                     location.href="/human/moveInsert.td";
		                  }
		               }
		            });
		     });
			 $(".boadDetail").click(function(){
				 
				 var hb_num=$(this).parents("tr").attr("data");
				 $.ajax({
		               url:"/human/boardAuthority.td",
		               type:"POST",
		               data:{hb_num:hb_num},
		               error:function(){
		                  alert('시스템 오류 입니다. 관리자에게 문의 하세요');
		               },
		               success:function(resultData){
		                  if(resultData==false){
		                     alert("아직 수락되지 않은 게시글입니다!");
		                  }
		                  if(resultData==true){
		                
		                	  $("#hb_num").val(hb_num);
		                	  godetail();	  	  
		                  }
		               }
		            });
			
		     });
		});
		function godetail(){
			document.boardNum.action="/human/boardDetail.td";
			document.boardNum.method="POST";
			document.boardNum.submit();
		}
		function goPage(page){
			if($("#search").val()=="all"){
				$("#keyword").val("");
			}
			
			$("#page").val(page);
			$("#PageSearch").attr({
				"method":"GET",
				"action":"/human/humanBoard.td"
			});
			$("#PageSearch").submit();
		}
		function chkSubmit(v_item,v_msg){
			if(v_item.val().replace(/\s/g,"")==""){
				alert(v_msg+"확인해 주세요.");
				v_item.val("");
				v_item.focus();
				return false;
			}else{
				return true;
			}
		}
	</script>
</head>
<body>
  <header class="header"> 
       <%@ include file="/WEB-INF/views/commons/header.jsp" %>
  </header>

  <aside class="sidebar">
       <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
  </aside>
   <div class="context-container">
    <h3><b>인사 게시판</b></h3>
     <hr>
     <div class="StatusSearch" >
			<form id="PageSearch" name="PageSearch">
				<input type="hidden" id="page" name="page" value="1"/>
				<table summary="검색">
				<colgroup>
						<col width="70%"></col>
						<col width="30%"></col>
					</colgroup>
				<tr>
					<td id="std1">
						<label>검색조건</label>
						<select id="search" name="search">
							<option value="all">전체</option>
							<option value="hm_name">이름</option>
							<option value="hb_title">제목</option>
						</select>
						<input type="text" name="keyword"
							id="keyword" value="검색어를 입력하세요"/>
						<input type="button" value="검색" class="button" id="selectData"/>	
					</td>
					<td id="std1">
						<select id="pageCtrl" name="pageCtrl">
							<option value="5">5줄</option>
							<option value="10">10줄</option>
							<option value="20">20줄</option>
							<option value="30">30줄</option>
						</select>
					</td>	
				</tr>
				</table>
			</form>
		</div>
	<div class="table_size" id="hBoardList" align="center">
		<table class="table" summary ="게시판리스트">
			 <colgroup> 
                        <col width="10%" />
                        <col width="40%"/>          
                        <col width="7%"/>
                        <col width="13%"/>
                        <col width="7%"/>
                        <col width="7%"/>
                     </colgroup>
                     <thead>
                        <tr>
                           <th>글번호</th>
                           <th>글제목</th>
                           <th>조회수</th>
                           <th>작성일</th>
                           <th>작성자</th>
                           <th>수락여부</th>
                        </tr>
                     </thead>
                     <tbody>
                      <%
         if(bList.size() == 0 ){
         %>
                           <tr>
                              <td colspan="7" align="center">
                                	등록된 게시글이 존재하지 않습니다.
                              </td>
                           </tr>
         <%
               }else{
                  for(int i = 0 ; i < bList.size() ; i ++){
                  HboardVO hvo = bList.get(i);   
         %>
                          <tr data="<%=hvo.getHb_num() %>">
                            <td align = "center" ><%= hvo.getHb_num() %></td>               
                            <td align = "left"><span class="boadDetail"><%= hvo.getHb_title() %></td>
                            <td align = "center"><%= hvo.getHb_hitnum() %> </td>
                            <td align = "center"><%= hvo.getHb_insertdate() %></td>
                            <td align = "center"><%= hvo.getHm_name() %></td>
                            <td align = "center"><%= hvo.getHb_accepte()%></td>
                          </tr>
         <%
                  }
               }   
         %>
                 </tbody>
			</table>
		</div>
		<div class="insert" align="right">
			<form name="insertBoard"
		          id="insertBoard"
		          method="POST">
		       <input type="button" value="글쓰기" name="input" id="input" class="button">   
		   </form>
		</div>
		<div class="boardnum">
		 	<form name="boardNum">
				<input type="hidden" name="hb_num" id="hb_num">
			</form>	
		</div>
		
		
		<jsp:include page="paging.jsp" flush="true">
			<jsp:param name="url" value="/human/humanBoard.td"/>
			<jsp:param name="str" value=""/>
			<jsp:param name="pageSize" value="<%=pageSize%>"/>
			<jsp:param name="groupSize" value="<%=groupSize%>"/>
			<jsp:param name="curPage" value="<%=curPage%>"/>
			<jsp:param name="totalCount" value="<%=totalCount%>"/>
			<jsp:param name="key" value="<%=key%>"/>
			<jsp:param name="ser" value="<%=ser%>"/>
		</jsp:include>
	</div>
	</div>
</body>
</html>