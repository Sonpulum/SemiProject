<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.fa-thumbs-up {
	color:red;
	cursor: pointer;
	}
	
	.writer {
    display: flex;
    align-items: center;
	}
</style>

<c:if test="${sessionScope.memberId != null}">
<script src="/static/js/review-like.js"></script>
</c:if>

<link rel="stylesheet" type="text/css" href="/static/css/reply.css">
<script>
	var memberId = "${sessionScope.memberId}";
	var reviewWriter = "${reviewDto.reviewWriter}";
</script>
<script src="/static/js/review-reply.js"></script>

<script type="text/template" id="reply-template">
	<div class="reply-item">
		<div class="reviewReplyWriter">?</div>
		<div class="reviewReplyContent">?</div>
		<div class="reviewReplyTime">?</div>
	</div>
</script>

<form action="detail" method="post" enctype="multipart/form-data">
<div class="container-800">

	<div class="row">
		<h2>${reviewDto.reviewTitle}</h2>
	</div>
	
	<div class="row writer">
		<c:choose>
			<c:when test="${memberProfile.attachmentNo != null}">
				<img class="me-10" width="80" height="80" src="/attachment/download?attachmentNo=${memberProfile.attachmentNo}">
				${reviewDto.reviewWriter}
			</c:when>
			<c:otherwise>
       			<img class="me-10" width="70" height="70" src="/static/image/usericon.jpg">
				${reviewDto.reviewWriter}
			</c:otherwise>
		</c:choose>
	</div>
	<div class="row">
		<label>작성일 : </label>
		${reviewDto.reviewTime}
		<label>조회수 : </label>
		${reviewDto.reviewRead}
	</div>
	
	<hr>
	
	<div class="row"  style="min-height: 400px;">
		${reviewDto.reviewContent}
	</div>
	<hr>
	
	<div class="row">
		좋아요
		<span class="thumbs-count">${reviewDto.reviewLike}</span>
				 
		<c:if test="${sessionScope.memberId != null}">
		<i class="fa-regular fa-thumbs-up"></i>
		댓글
		<span class="reply-count">${reviewDto.reviewReply}</span>
		</c:if>
	</div>
	
	<div class="row reply-list">
		댓글목록 위치
	</div>
	
	
	
	<!-- 댓글 작성란 -->
	<div class="row">
		
		<div class="row">
			<c:choose>
				<c:when test="${sessionScope.memberId != null}">
					<textarea name="reviewReplyContent" class="form-input w-100"
							placeholder="댓글 내용을 작성하세요"></textarea>	
				</c:when>
				<c:otherwise>
					<textarea name="reviewReplyContent" class="form-input w-100"
							placeholder="로그인 후에 댓글 작성이 가능합니다" disabled></textarea>	
				</c:otherwise>
			</c:choose>
			
		</div>
		<c:if test="${sessionScope.memberId != null}">		
		<div class="row right">
			<button type="button" class="form-btn bosung reply-insert-btn">댓글 작성</button>
		</div>
		</c:if>

	<div class="row right">
		<a href="/review/list" class="form-btn neutral">목록보기</a>
		
		<!-- 관리자 or 작성자만 삭제 -->
		<c:if test="${owner || admin}">	
			<a href="/review/delete?reviewNo=${reviewDto.reviewNo}" class="form-btn negative">삭제</a>	
		</c:if>
		<!-- 작성자만 수정 -->
		<c:if test="${owner}">
			<a href="/review/edit?reviewNo=${reviewDto.reviewNo}" class="form-btn bosung">수정</a>	
		</c:if>
	</div>
	</div>
	
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>