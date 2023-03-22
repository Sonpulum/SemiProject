<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-500">
	<div class="row center">
		<h1>아이디 찾기</h1>
    </div>
    
	<div class="row center">
		<form action="find" method="post">
			<input type ="text" name="memberNick" required 
			placeholder="아이디를 입력하세요" class="form-input"><br><br>
			
			<input type ="tel" name="memberTel" required 
			placeholder="닉네임을 입력하세요" class="form-input"><br><br>
			
			생년월일 : <input type ="date" name="memberBirth" required class="form-input"><br><br>
			
			<button class="submit form-btn neutral">아이디 찾기</button>
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