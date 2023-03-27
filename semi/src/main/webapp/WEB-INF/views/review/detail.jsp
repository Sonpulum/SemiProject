<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:if test="${sessionScope.memberId != null}">
<script src="/static/js/review-like.js"></script>
</c:if>

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

<div class="container-800">

	<div class="row">
		<h2>${reviewDto.reviewTitle}</h2>
	</div>
	
	<!-- 이미지 첨부 코드 내일 수정 예정!! -->
	<div class="row writer">
		<c:choose>
			<c:when test="${profile != null}">
				<img width="70" height="70" src="/attachment/download?attachmentNo=${profile.attachmentNo}">
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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>