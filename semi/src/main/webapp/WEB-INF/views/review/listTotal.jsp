<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/list.css">
 
 <div class="container-1000">
        <div class="row center">
            <h2>후기 게시판 검색결과</h2>
        </div>

        <div class="row right">
        	<a href="${pageContext.request.contextPath}/review/write" class="form-btn bosung">글쓰기</a>
        </div>
        
        <table class="table table-hover table-border center">
            <thead>
            	
                <tr>
                    <th></th>
                    <th>테마</th>
                    <th>지역</th>
                    <th class="w-40">제목</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                    <th>작성일</th>
                </tr>
                  
            </thead>

				<tbody>
			<c:forEach var="reviewDto" items="${list}">
                <tr>
                	<td>${reviewDto.reviewNo }</td>
                	<td>${reviewDto.reviewTheme}</td>
                	<td>${reviewDto.reviewLocation }</td>
                    <td class="w-40 left">
                    <a class="link" href="detail?reviewNo=${reviewDto.reviewNo}">
           					${reviewDto.reviewTitle}</a>
           				<c:if test="${reviewDto.reviewReply > 0}">
           					[${reviewDto.reviewReply}]
           				</c:if>
                    </td>
                    <td><i class="fa-regular fa-eye"></i>    ${reviewDto.reviewRead }</td>
               		<td><i class="fa-regular fa-thumbs-up"></i>    ${reviewDto.reviewLike }</td>
               		<td>${reviewDto.reviewTime }</td>
                </tr>
        	</c:forEach>
				</tbody>
        </table>
        
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
