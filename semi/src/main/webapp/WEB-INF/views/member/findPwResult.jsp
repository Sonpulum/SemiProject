<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/find.css">
    
<div class="container-500">
   <div class="row center">
      <h1>비밀번호 찾기 결과</h1>
   </div>
   <hr>
   <div class="row center">
      <h2>일회용 비밀 번호를 발급하였습니다.</h2> <br><br>
   </div>
   
   <div class="row center">
      <a href="login" class="form-btn2 w-75">로그인</a>
   </div>
   
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>