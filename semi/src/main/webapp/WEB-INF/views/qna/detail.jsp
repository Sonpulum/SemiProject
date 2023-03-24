<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>    

<c:if test="${sessionScope.memberId != null}">
   <link rel="stylesheet" type="text/css" href="/static/css/qna-like.css">
   <script src="/static/js/qna-like.js"></script>
</c:if>

<link rel="stylesheet" type="text/css" href="/static/css/reply.css">
<script>
   var memberId = "${sessionScope.memberId}";
   var qnaWriter = "${qnaDto.qnaWriter}";
</script>
<script src="/static/js/reply.js"></script>
<script type="text/template" id="reply-template">
   <div class="reply-item">
      <div class="replyWriter">?</div>
      <div class="replyContent">?</div>
      <div class="replyTime">?</div>
   </div>
</script>

<div class="container-800">
   <div class="row center">
      <h1>${qnaDto.qnaNo}번 게시글</h1>
   </div>

<table class="table table-slit">
   <tbody>
      <tr>
         <td>
            <h2>${qnaDto.qnaTitle}</h2>
         </td>
      </tr>
      <tr>
         <td>
            ${qnaDto.qnaWriter}
         </td>
      </tr>
      <tr>
         <td>
            <fmt:formatDate value="${qnaDto.qnaTime}"
                        pattern = "y년 M월 d일 H시 m분 s초"/>
            조회 ${qnaDto.qnaRead}
         </td>
      </tr>
      <tr height="150" valign="top">
         <td>${qnaDto.qnaContent}</td>
      </tr>
      <tr>
         <td>
            좋아요
            <span class="heart-count">${qnaDto.qnaLike}</span>
            <c:if test="${sessionScope.memberId != null}">
               <!-- 하트 자리 -->
               <i class="fa-heart fa-beat"></i>
            </c:if>
         </td>
      </tr>
      <tr>
         <td>
            <div class="row reply-list">
               
            </div>
         </td>
      </tr>
      <tr>
         <td>
            <!-- 댓글창 -->
            <div class="row">
               <c:choose>
                  <c:when test="${sessionScope.memberId != null}">
                     <textarea name="replyContent" class="form-input w-100" 
                     placeholder="댓글 내용을 작성하세요"></textarea>
                  </c:when>
                  <c:otherwise>
                     <textarea name="replyContent" class="form-input w-100"
                     placeholder="로그인 후 댓글 작성이 가능합니다"></textarea>
                  </c:otherwise>
               </c:choose>
            </div>
            <c:if test="${sessionScope.memberId != null}">
               <div class="row right">
                  <button type="submit" class="form-btn positive reply-insert-btn">댓글 작성</button>
               </div>
            </c:if>
         </td>
      </tr>
   </tbody>
</table>
   <div class="row right">
            <a href="/qna/write" class="form-btn positive">글쓰기</a>
            <a href="/qna/write?qnaParent=${qnaDto.qnaNo}" class="form-btn positive">답글쓰기</a>
            
            <!--  내가 작성한 글이라면 수정과 삭제 메뉴를 출력 -->
            <c:if test="${owner}">
            	<a href="/qna/edit?qnaNo=${qnaDto.qnaNo}" class="form-btn neutral">수정</a>
            </c:if>
            
            <!-- 파라미터 방식일 경우의 링크 -->
            <c:if test="${owner || admin}">
            	<a href="/qna/delete?qnaNo=${qnaDto.qnaNo}" class="form-btn negative">삭제</a>
            </c:if>
            
            <a href="/qna/list" class="form-btn neutral">목록보기</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>