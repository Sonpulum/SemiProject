<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">

window.addEventListener("load", function(){
    var checkExit = document.querySelector(".exit");
    
	checkExit.addEventListener("click",function(){
		confirm("정말 삭제하시겠습니까?");
	});
});

</script>

<div class="container-800">
	<div class="row center">
	<h1>회원 목록</h1>
	</div>
	
	<div class="center">
	
	<table class="table table-hover table-slit">
		<thead>
			<tr>
				<th>아이디</th>
				<th>닉네임</th>
				<th>전화번호</th>
				<th>생년월일</th>
				<th>등급</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="memberDto" items="${list}">
			<tr>
				<td>${memberDto.memberId}</td>
				<td>${memberDto.memberNick}</td>
				<td>${memberDto.memberTel}</td>
				<td>${memberDto.memberBirth}</td>
				<td>${memberDto.memberLevel}</td>
				<td><a href="detail?memberId=${memberDto.memberId}" class="link">상세</a>			
					<a href="edit?memberId=${memberDto.memberId}" class="link">수정</a>			
					<a href="exit?memberId=${memberDto.memberId}" class="link exit">탈퇴</a>
					
					</td>			
			</tr>
		</c:forEach>
		</tbody>			
	</table>
	
	
</div>

<!-- 페이지 네이게이터 - vo에 있는 데이터를 기반으로 구현 -->
<div class="row">

	<div class="pagination">
	<c:choose>
	<c:when test="${vo.first}">
	<a class="disabled">&laquo;</a>
	</c:when>
	<c:otherwise>
	<a href="list?${vo.parameter}&page=1">&laquo;</a>	
	</c:otherwise>
	</c:choose>
	
	<c:choose>
		<c:when test="${vo.prev}">
	<a href="list?${vo.parameter}&page=${vo.prevPage}">&lt;</a>
		</c:when>
	<c:otherwise>
		<a class="disabled">&lt;</a>
	</c:otherwise>
	</c:choose>
 		
 	<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
 		<c:choose>
 		<c:when test="${vo.page == i }"><a class="on">${i}</a></c:when>
 		<c:otherwise>
 		<a href="list?${vo.parameter}&page=${i}">${i}</a>
 		</c:otherwise>
 		</c:choose>
 	</c:forEach>	
 		
 	<c:choose>
 		<c:when test="${vo.next}">
 			<a href="list?${vo.parameter}&page=${vo.nextPage}">&gt;</a> 		
 		</c:when>
 		<c:otherwise>
 			<a class="disabled">&gt;</a>
 		</c:otherwise>
 	</c:choose>	
 	
 	<c:choose>
 		<c:when test="${vo.last }">
 		<a class="disabled">&raquo;</a>
 		</c:when>
 	<c:otherwise>
 	<a href="list?${vo.parameter}&page=${vo.totalPage}">&raquo;</a>
 	</c:otherwise>
 	</c:choose>
	</div>
</div>
</div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>