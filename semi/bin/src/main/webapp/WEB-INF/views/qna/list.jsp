<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-1000">
   <div class="center">
      <h1>Q&A 게시판</h1>
   </div>
   
   <div class="row-left">
      <a href="write" class="form-btn neutral">글쓰기</a>
   </div>
   
   <div class="row">
      <table class="table table-border table-hover">
         <thead>
            <tr>
               <th>번호</th>
               <th>제목</th>
               <th>작성자</th>
               <th>작성일</th>
               <th>조회수</th>
               <th>좋아요</th>
            </tr>
         </thead>
         <tbody class="center">
            <c:forEach var="qnaDto" items="${list}">
               <tr>
                  <td>${qnaDto.qnaNo}</td>
                  <td>
                     <a href="detail?qnaNo=${qnaDto.qnaNo}">
                     ${qnaDto.qnaTitle}</a>
                  </td>
                  <td>${qnaDto.qnaWriter}</td>
                  <td>${qnaDto.qnaTimeAuto}</td>
                  <td>${qnaDto.qnaRead}</td>
                  <td>${qnaDto.qnaLike}</td>
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
            <c:when test="${vo.column == 'qna_content'}">
               <select name="column" class="form-input">
                  <option value="qna_title">제목</option>
                  <option value="qna_content" selected>내용</option>
                  <option value="qna_writer">작성자</option>
               </select>
            </c:when>
            <c:when test="${vo.column == 'qna_writer'}">
               <select name="column" class="form-input">
                  <option value="qna_title">제목</option>
                  <option value="qna_content">내용</option>
                  <option value="qna_writer" selected>작성자</option>
               </select>
            </c:when>
            <c:when test="${vo.column == 'qna_head'}">
               <select name="column" class="form-input">
                  <option value="qna_title">제목</option>
                  <option value="qna_content">내용</option>
                  <option value="qna_writer">작성자</option>
               </select>
            </c:when>
            <c:otherwise>
               <select name="column" class="form-input">
                  <option value="qna_title" selected>제목</option>
                  <option value="qna_content">내용</option>
                  <option value="qna_writer">작성자</option>
               </select>
            </c:otherwise>
         </c:choose>

         <input type="search" name="keyword" placeholder="검색어" required
            class="form-input" value="${vo.keyword}">

         <button type="submit" class="form-btn positive">검색</button>
      </form>
   </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>