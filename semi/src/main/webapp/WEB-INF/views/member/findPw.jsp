<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-500">
   <div class="row center">
      <h1>비밀번호 찾기</h1>
    </div>
    
   <div class="row center">
      <form action="findPw" method="post">
      
         <input type ="text" name="memberId" required 
         placeholder="아이디를 입력하세요" class="form-input w-100"><br><br>
         
         <input type ="email" name="memberEmail" required 
         placeholder="이메일을 입력하세요" class="form-input w-100"><br><br>

         <button type="submit" class="form-btn positive w-100">확인</button><br><br>
         
         <a href="login" class="form-btn neutral w-100">로그인 페이지로 이동</a>
      </form>
   </div>
   
   <!-- 오류가 발생한 경우 보여줄 메세지 -->
   <div class="row center">
      <c:if test="${param.mode == 'error'}">
         <h3 style=color:red>일치하는 정보가 존재하지 않습니다</h3>
      </c:if>
   </div>
   
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>