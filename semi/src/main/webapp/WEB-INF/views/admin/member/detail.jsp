<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>

.right-flex {
  margin-left: auto;
  margin-right:300px;
}
</style>

    <div class="container-800">
    <div class="row center">
    <h1>회원 정보</h1>
    </div>
   
   <div class="row">
   <table class="table table-slit">
   	<tbody>
   		<tr>
   			<th width = "25%">아이디</th>
   			<td>${memberDto.memberId}</td>	   			
   		</tr>
   		<tr>
   			<th width = "25%">비밀번호</th>
   			<td>${memberDto.memberPw}</td>	   			
   		</tr>
   		<tr>
   			<th width = "25%">닉네임</th>
   			<td>${memberDto.memberNick}</td>	   			
   		</tr>
   		<tr>
   			<th width = "25%">전화번호</th>
   			<td>${memberDto.memberTel}</td>	   			
   		</tr>
   		<tr>
   			<th width = "25%">생년월일</th>
   			<td>${memberDto.memberBirth}</td>	   			
   		</tr>
   		<tr>
   			<th width = "25%">이메일</th>
   			<td>${memberDto.memberEmail}</td>	   			
   		</tr>
   		<tr>
   			<th width = "25%">주소</th>
   			<td>[${memberDto.memberPost}]   			
   			${memberDto.memberBasicAddr}	   			
   			${memberDto.memberDetailAddr}</td>	   			
   		</tr>
   		<tr>
   			<th width = "25%">등급</th>
   			<td>${memberDto.memberLevel}</td>	   			
   		</tr>
   	</tbody>
   </table>
   </div>
  
  
  <div class="flex-box">
  <div>
  <a href="edit?memberId=${memberDto.memberId}" class="link">개인정보 변경</a> <br>
  <a href="list" class="link">목록으로 돌아가기</a>
  </div>
  <div class="right-flex">
  <a href="exit?memberId=${memberDto.memberId}&page=${page}" class="form-btn negative">회원 탈퇴</a>
  </div>
  </div>
  
</div>
    



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>