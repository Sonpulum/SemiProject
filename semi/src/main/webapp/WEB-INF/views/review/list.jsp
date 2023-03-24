<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
 <div class="container-1000">
        <div class="row center">
            <h1>나만의 여행지를 공유해보세요</h1>
        </div>

        <div class="row center">
        <form action="list" method="get">
        	<c:choose>
            <c:when test="${vo.column == 'review_content'}">
               <select name="column" class="form-input">
                  <option value="review_title">제목</option>
                  <option value="review_content" selected>내용</option>
                  <option value="review_writer">작성자</option>
               </select>
            </c:when>
            <c:when test="${vo.column == 'review_writer'}">
               <select name="column" class="form-input">
                  <option value="review_title">제목</option>
                  <option value="review_content">내용</option>
                  <option value="review_writer" selected>작성자</option>
               </select>
            </c:when>  
            
            <c:otherwise>
               <select name="column" class="form-input">
                  <option value="review_title" selected>제목</option>
                  <option value="review_content">내용</option>
                  <option value="review_writer">작성자</option>
               </select>
            </c:otherwise>
         </c:choose>
        
            <input type="search" name="keyword" class="form-input" value="${vo.keyword}" placeholder="여행지 검색">
            <button type="submit" class="form-btn neutral">검색</button>
           </form>
        </div>
        <div class="row right">
        	<a href="/review/write" class="form-btn positive">글쓰기</a>
        </div>
        
        <table class="table table-hover table-border">
            <thead>
            	
                <tr>
                    <th style="width: 10%;"></th>
                    <th style="width: 60%;">제목</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                    <th>댓글</th>
                </tr>
                  
            </thead>
            <tbody>
			<c:forEach var="reviewDto" items="${topList}">
			<tr>
				<td style="width: 10%;">인기</td>
           		<td style="width: 60%;">${reviewDto.reviewTitle }</td>
                <td>조회수 : ${reviewDto.reviewRead }</td>
                <td>좋아요 : ${reviewDto.reviewLike }</td>
                <td>댓글 : ${reviewDto.reviewReply }</td>
			</tr>
           </c:forEach> 
			<c:forEach var="reviewDto" items="${list}">
                <tr>
                	<td style="width: 10%;">${reviewDto.reviewNo }</td>
                    <td style="width: 60%;">${reviewDto.reviewTitle }</td>
                    <td>조회수 : ${reviewDto.reviewRead }</td>
                    <td>좋아요 : ${reviewDto.reviewLike }</td>
                    <td>댓글 : ${reviewDto.reviewReply }</td>
                </tr>
        	</c:forEach>
            </tbody>
        </table>
        
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
