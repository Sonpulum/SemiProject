<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>비밀번호 확인</h1>
<h2>탈퇴하시려면 비밀번호를 입력하세요</h2>

<form action="exit" method="post">
	<input type="password" name="memberPw" placeholder="현재 비밀번호" required>
	<button>탈퇴</button>
</form>

<c:if test="${param.mode == 'error'}">
	<h2>비밀번호가 일치하지 않습니다</h2>
</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>