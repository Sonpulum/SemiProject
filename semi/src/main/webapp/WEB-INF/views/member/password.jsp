<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/find.css">
<script src="${pageContext.request.contextPath}/static/js/change-password.js"></script>

<style>
	h2 {
            font-size: 15px;
        }	
</style>

<div class="container-500">
	<div class="row left">
		<h1>비밀번호 변경</h1>
		<h3>안전한 비밀번호로 내정보를 보호하세요</h3>
	</div>
	<hr>
	<form action="password" method="post">
		<div class="row">
			<input type="password" name="currentPw"
			class="form-input w-100" placeholder="현재 비밀번호">
			<div class="valid-message">비밀번호가 일치합니다</div>
			<div class="invalid-message">비밀번호가 일치하지 않습니다</div>
		</div>
		
		<div class="row">
			<input type ="password" name="newPw"
			class="form-input w-100" placeholder="새 비밀번호">
			<div class="valid-message">올바른 비밀번호 형식입니다</div>
        	<div class="invalid-message">영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~16자로 작성하세요</div>
		</div>
		
		<div class="row">
			<input type ="password" name="newPwRe"
			class="form-input w-100" placeholder="새 비밀번호 확인">
			<div class="valid-message">비밀번호가 일치합니다</div>
	        <div class="invalid-message">비밀번호가 일치하지 않습니다</div>
	        <div class="invalid-message2">비밀번호를 먼저 입력하세요</div>
		</div>
		
		<div class="row">
			<button type="submit" class="form-btn2 w-100">변경</button>
		</div>
		
		<div class="row">
			<a type="submit" href="${pageContext.request.contextPath}/member/mypage?memberId=${memberDto.memberId}" 
			class="form-btn1 w-100">취소</a>
        </div>
	</form>
	
	<!-- 오류가 발생한 경우 보여줄 메세지 -->
	<c:if test="${param.mode == 'error'}">
		<h3 style=color:red>비밀번호가 일치하지 않습니다</h3>
	</c:if>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>