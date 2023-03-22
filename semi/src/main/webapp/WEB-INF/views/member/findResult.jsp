<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-500">
	<div class="row center">
		<h1>아이디 찾기 결과</h1>
	</div>

	<h2>찾으시는 아이디는 ${findId} 입니다.</h2>
	
	<h2><a href="login">로그인하기</a></h2>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>