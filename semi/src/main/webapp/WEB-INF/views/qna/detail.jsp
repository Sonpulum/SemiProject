<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>    

<c:if test="${sessionScope.memberId != null}">
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/qna-like.css">
   <script src="${pageContext.request.contextPath}/static/js/qna-like.js"></script>
</c:if>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/reply.css">

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
    .writer {
    display: flex;
    align-items: center;
	}
</style>

<script>
   var memberId = "${sessionScope.memberId}";
   var qnaWriter = "${qnaDto.qnaWriter}";
</script>

<script type="text/template" id="reply-template">
   <div class="reply-item">
      <div class="replyWriter">?</div>
      <div class="replyContent">?</div>
      <div class="replyTime">?</div>
   </div>
</script>

<form action="detail" method="post" enctype="multipart/form-data">
<div class="container-800">

   <div class="row">
      <h2>${qnaDto.qnaTitle}</h2>
   </div>
   
	<div class="row writer">
		<c:choose>
			<c:when test="${memberProfile.attachmentNo != null}">
				<img class="me-10" width="90" height="90" src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${memberProfile.attachmentNo}">
				${qnaWriterNick}
			</c:when>
			<c:otherwise>
				<img class="me-10" width="90" height="90" src="${pageContext.request.contextPath}/static/image/usericon.jpg">
				   ${qnaWriterNick}
			</c:otherwise>
		</c:choose>
	</div>
	
	<div class="row">
		<label>작성일 : </label>
		${qnaDto.qnaTime}
		<label>조회수 : </label>
		${qnaDto.qnaRead}
	</div>
	
	<hr>
	
	<div class="row"  style="min-height: 500px;">
		${qnaDto.qnaContent}
	</div>
	
	<hr>
	
	<div class="row right">
		<c:if test="${sessionScope.memberId != null}">
			<a href="${pageContext.request.contextPath}/qna/write" class="form-btn qna">글쓰기</a>
		</c:if>
		<c:if test="${admin}">
			<a href="${pageContext.request.contextPath}/qna/write?qnaParent=${qnaDto.qnaNo}" class="form-btn qna">답글쓰기</a>
		</c:if>
		<!--  내가 작성한 글이라면 수정과 삭제 메뉴를 출력 -->
		<c:if test="${owner}">
			<a href="${pageContext.request.contextPath}/qna/edit?qnaNo=${qnaDto.qnaNo}" class="form-btn qna">수정</a>
		</c:if>
		
		<c:if test="${owner || admin}">
			<a href="${pageContext.request.contextPath}/qna/delete?qnaNo=${qnaDto.qnaNo}" class="form-btn negative">삭제</a>
		</c:if>
		
		<a href="${pageContext.request.contextPath}/qna/list" class="form-btn neutral">목록보기</a>
	</div>
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>