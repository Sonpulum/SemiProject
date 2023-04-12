<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원탈퇴</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    
    
    
    <!-- 링크 확인창 출력을 위한 CDN -->
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/confirm-link@latest/confirm-link.min.js"></script>
    
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
</head>

<body>
	<form>
		<div class="container600">
			<div class="row center">
				<h2>회원 탈퇴가 완료되었습니다</h2>
				<h4>그동안 이용해주셔서 감사합니다</h4>
			</div>
			<div class="row center">
				<h2><a href="${pageContext.request.contextPath}" class="form-btn">메인페이지</a></h2>
			</div>
		</div>
	</form>
</body>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
