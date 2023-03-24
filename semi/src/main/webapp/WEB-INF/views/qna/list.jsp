<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<style>
    .form-input {
        font-size: 18px;
        padding: 0.5em;
        outline: none;/*선택 시 강조 효과 제거*/
        border: 1px solid #636e72;
        border-radius: 0.5em;
    }
    .form-btn{
        font-size: 20px;
        border-radius:0.5em;
    }
    .form-btn.qna{
        background-color: rgb(64, 165, 187);
           border-color: rgb(64, 165, 187);
           color: white;
    }
    .thead-color{
    	background-color: rgba(64, 165, 187, 0.16);
    }
    .fa-trash,
    .fa-pen {
    	color: #40a5bb;
    }
    .fa-trash:hover,
    .fa-pen:hover {
    	color: #e05462;
    }
</style>

	<div class="container-1000">
	   <div class="center">
	      <h1>Q&A</h1>
	   </div>
	   
	   <div class="row right">
	      <a href="write" class="form-btn qna">글쓰기</a>
	   </div>
	   
	   <div class="row">
	      <table class="table table-slit table-hover">
	         <thead class="thead-color">
	            <tr>
	               <th>번호</th>
	               <th>제목</th>
	               <th>작성자</th>
	               <th>작성일</th>
	               <th>답변유무</th>
	               <c:if test="${sessionScope.memberLevel == '관리자'}">
						<th>관리</th>
	               </c:if>
	            </tr>
	         </thead>
	         <tbody class="center">
	            <c:forEach var="qnaDto" items="${list}">
	               <tr>
	                  <td>${qnaDto.qnaNo}</td>
	                  <td class="left">
						<c:forEach var="i" begin="1" end="${qnaDto.qnaDepth}">
							&nbsp;&nbsp;
						</c:forEach>
						<c:choose>
							<c:when test="${qnaDto.qnaDepth > 0}">
								<i class="fa-solid fa-a me-10" style="color: #87abe2;"></i>
							</c:when>
							<c:otherwise>
								<i class="fa-solid fa-q me-10" style="color: #3878db;"></i>
							</c:otherwise>
						</c:choose>
	                     	<a href="detail?qnaNo=${qnaDto.qnaNo}">
	                     ${qnaDto.qnaTitle}</a>
	                  </td>
	                  <td>${qnaDto.qnaWriter}</td>
	                  <td>${qnaDto.qnaTimeAuto}</td>
	                  <td>
	                  	<c:choose>
		                  	<c:when test="${qnaDto.qnaDepth > 0}">
		                  		<i class="fa-sharp fa-solid fa-square-check" style="color: #40a5bb;"></i>
		                  	</c:when>
		                  	<c:otherwise>
		                  		<i class="fa-solid fa-square-xmark" style="color: #e05462"></i>
		                  	</c:otherwise>
	                  	</c:choose>
	                  </td>
	                  <c:if test="${sessionScope.memberLevel == '관리자'}">
		                  <td>
		                  	<a href="/qna/edit?qnaNo=${qnaDto.qnaNo}" class="edit-btn me-10"><i class="fa-sharp fa-solid fa-pen"></i></a>
		                    <a href="/qna/delete?qnaNo=${qnaDto.qnaNo}" class="delete-btn"><i class="fa-sharp fa-solid fa-trash"></i></a>
		                  </td>
		              </c:if>
	               </tr>
	            </c:forEach>
	         </tbody>
	      </table>
	   </div>
	</div>

   <!-- 페이지 네비게이터 vo에 있는 데이터를 기반으로 구현 -->
   <div class="row pagination">
      <!-- 처음 -->
      <c:choose>
         <c:when test="${vo.first}">
            <a class="disabled">&laquo;</a>
         </c:when>
         <c:otherwise>
            <a href="list?${vo.parameter}&page=1">&laquo;</a>
         </c:otherwise>
      </c:choose>
      
      <!-- 이전 -->
      <c:choose>
         <c:when test="${vo.prev}">
            <a href="list?${vo.parameter}&page=${vo.prevPage}">&lt;</a>
         </c:when>
         <c:otherwise>
            <a class="disabled">&lt;</a>
         </c:otherwise>
      </c:choose>
      
      <!-- 숫자 -->
      <c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
         <c:choose>
            <c:when test="${vo.page == i}"><a class="on">${i}</a></c:when>
            <c:otherwise>
               <a href="list?${vo.parameter}&page=${i}">${i}</a>
            </c:otherwise>
         </c:choose>
      </c:forEach>
      
      <!-- 다음 -->
      <c:choose>
         <c:when test="${vo.next}">
            <a href="list?${vo.parameter}&page=${vo.nextPage}">&gt;</a>
         </c:when>
         <c:otherwise>
            <a class="disabled">&gt;</a>
         </c:otherwise>
      </c:choose>
      
      <!-- 마지막 -->
      <c:choose>
         <c:when test="${vo.last}">
            <a class="disabled">&raquo;</a>
         </c:when>
         <c:otherwise>
            <a href="list?${vo.parameter}&page=${vo.totalPage}">&raquo;</a>
         </c:otherwise>
      </c:choose>
   </div>

   <!-- 검색창 -->
   <div class="row center">
      <form action="list" method="get">

         <c:choose>
            <c:when test="${vo.column == 'qna_writer'}">
               <select name="column" class="form-input">
                  <option value="qna_title">제목</option>
                  <option value="qna_writer" selected>작성자</option>
               </select>
            </c:when>
            <c:when test="${vo.column == 'qna_head'}">
               <select name="column" class="form-input">
                  <option value="qna_title">제목</option>
                  <option value="qna_writer">작성자</option>
               </select>
            </c:when>
            <c:otherwise>
               <select name="column" class="form-input">
                  <option value="qna_title" selected>제목</option>
                  <option value="qna_writer">작성자</option>
               </select>
            </c:otherwise>
         </c:choose>

         <input type="search" name="keyword" placeholder="검색어" required
            class="form-input" value="${vo.keyword}">

         <button type="submit" class="form-btn qna">검색</button>
      </form>
   </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>