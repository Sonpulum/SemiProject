<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/recoList.css">

<style>
	.write-btn{
		margin-left:90%;
	}
</style>
<div class="container-900">
	<div class="row center" style="padding: 30px; font-size: 30px;">
		<h1>
       		<i class="fa-solid fa-magnifying-glass" style="color: #40a5bb;"></i>
         		추천 게시판 검색결과
      	</h1>
	</div>
         
   <div class="wrapper">
       <c:if test="${sessionScope.memberLevel eq '관리자'}">
       		<a href="write" class="write-btn center">글쓰기</a>
       </c:if>
     </div>
     <br>
     <hr>
     <div class="row">
     <c:forEach var="recoDto" items="${list}">
     	<div class="post">
   			<a href="detail?recoNo=${recoDto.recoNo}">
   				<img src=${pageContext.request.contextPath}/rest/attachment/download/${recoDto.attachNo}>
   			</a>
   			<div class="post-content">
       			<div class="post-header">
       				<a class="link" href="detail?recoNo=${recoDto.recoNo}">
           				<span class="titleName">${recoDto.recoTitle}</span>
           			</a>
       			</div>
       			<a class="link" href="detail?recoNo=${recoDto.recoNo}">
       				<span>#${recoDto.recoLocation}</span>
       				<span>#${recoDto.recoSeason}</span>
       				<span>#${recoDto.recoTheme}</span>
       			</a>
      			<div class="post-footer">
                     <span class="comments">
                     	<i class="fa-regular fa-eye"></i>
                     	<span>조회수</span>
                     	<span>${recoDto.recoRead}</span>
                   	</span>
                     <span class="likes">
                     	<i class="fa-regular fa-thumbs-up"></i>
                     	<span>좋아요</span>
                     	<span>${recoDto.recoLike}</span>
                   	</span>
       			</div>
   			</div>
		</div>
	</c:forEach>
	</div>
	<!-- 페이지 네이게이터 - vo에 있는 데이터를 기반으로 구현 -->
	<div class="row">
	
		<div class="pagination">
		<c:choose>
		<c:when test="${vo.first}">
		<a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
		</c:when>
		<c:otherwise>
		<a href="listTotal?${vo.parameter}&page=1"><i class="fa-solid fa-angles-left"></i></a>	
		</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${vo.prev}">
		<a href="listTotal?${vo.parameter}&page=${vo.prevPage}"><i class="fa-solid fa-angle-left"></i></a>
			</c:when>
		<c:otherwise>
			<a class="disabled"><i class="fa-solid fa-angle-left"></i></a>
		</c:otherwise>
		</c:choose>
	 		
	 	<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
	 		<c:choose>
	 		<c:when test="${vo.page == i }"><a class="on">${i}</a></c:when>
	 		<c:otherwise>
	 		<a href="listTotal?${vo.parameter}&page=${i}">${i}</a>
	 		</c:otherwise>
	 		</c:choose>
	 	</c:forEach>	
	 		
	 	<c:choose>
	 		<c:when test="${vo.next}">
	 			<a href="listTotal?${vo.parameter}&page=${vo.nextPage}"><i class="fa-solid fa-angle-right"></i></a> 		
	 		</c:when>
	 		<c:otherwise>
	 			<a class="disabled"><i class="fa-solid fa-angle-right"></i></a>
	 		</c:otherwise>
	 	</c:choose>	
	 	
	 	<c:choose>
	 		<c:when test="${vo.last}">
	 		<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
	 		</c:when>
	 	<c:otherwise>
	 	<a href="listTotal?${vo.parameter}&page=${vo.totalPage}"><i class="fa-solid fa-angles-right"></i></a>
	 	</c:otherwise>
	 	</c:choose>
	 	
	 	<!-- 페이징 숨김 -->
		<c:if test="${vo.totalPage <= 10}">
			<script>
				document.querySelectorAll('.pagination a.disabled').forEach(el => el.style.display = 'none');
			</script>
		</c:if>
	 	
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>