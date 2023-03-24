<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-800">

	<div class="row">
		<h2>${reviewDto.reviewTitle}</h2>
	</div>
	
	<div class="row">
		${reviewDto.reviewWriter}
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
		<span class="heart-count">${reviewDto.reviewLike}</span>
		
		<c:if test="${sessionScope.memberId != null}">
		<i class="fa-heart"></i>
		댓글 
		<span class="reply-count">${reviewDto.reviewRead}</span>
		</c:if>
	</div>
	
	<div class="row right">
		<a href="/review/write" class="form-btn positive">글쓰기</a>	
		<a href="/review/list" class="form-btn neutral">목록보기</a>	
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>