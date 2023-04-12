<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.fa-thumbs-up {
	color:#5186f0;
	cursor: pointer;
	}
	
	.writer {
    display: flex;
    align-items: center;
	}
</style>

<c:if test="${sessionScope.memberId != null}">
<script src="${pageContext.request.contextPath}/static/js/review-like.js"></script>
</c:if>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/reply.css">

<script>
	var memberId = "${sessionScope.memberId}";
	var reviewWriter = "${reviewDto.reviewWriter}";
	var memberLevel = "${sessionScope.memberLevel}";
</script>

<script>
$(function(){
    $(".form-btn.negative").click(function(e){
        e.preventDefault(); // 링크 이동 중지
        var choice = window.confirm("정말 삭제하시겠습니까?");
        if (choice) {
            window.location.href = $(this).attr("href"); // 링크 이동
        }
    });
    $(".review-content").find("img").each(function(){
		var origin = $(this).attr("src");
		var begin = origin.indexOf('/rest');
		var path = contextPath + (origin.substr(begin));
		$(this).attr("src", path);
	});
});
</script>

<script src="${pageContext.request.contextPath}/static/js/review-reply.js"></script>

<script type="text/template" id="reply-template">
	<div class="reply-item">
		<div class="reviewReplyWriter">?</div>
		<div class="reviewReplyContent">?</div>
		<div class="reviewReplyTime">?</div>
	</div>

</script>

<div class="container-800">

	<div class="row">
		<h2>${reviewDto.reviewTitle}</h2>
	</div>
	
	<div class="row writer">
		<c:choose>
			<c:when test="${memberProfile.attachmentNo != null}">
				<img class="me-10" width="90" height="90" src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${memberProfile.attachmentNo}">
				${memberNick}
			</c:when>
			<c:otherwise>
       			<img class="me-10" width="90" height="90" src="${pageContext.request.contextPath}/static/image/usericon.jpg">
				${memberNick}
			</c:otherwise>
		</c:choose>
	</div>
	<div class="row">
		<label>작성일 : </label>
		${reviewDto.reviewTime} &nbsp;
		<label>조회수 : </label>
		${reviewDto.reviewRead} &nbsp;
		<label># ${reviewDto.reviewLocation} &nbsp;</label>
		<label># ${reviewDto.reviewSeason} &nbsp;</label>
		<label># ${reviewDto.reviewTheme}</label>
	</div>
	
	<hr>
	
	<div class="row review-content"  style="min-height: 400px;">
		${reviewDto.reviewContent}
	</div>
	<hr>
	
	<div class="row">
		좋아요
		<span class="thumbs-count">${reviewDto.reviewLike}</span>
		<c:if test="${sessionScope.memberId != null}">
		<i class="fa-regular fa-thumbs-up"></i>
		</c:if>
		&nbsp; 댓글
		<span class="reply-count">${reviewDto.reviewReply}</span>
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
		<a href="${pageContext.request.contextPath}/review/list" class="form-btn neutral">목록보기</a>
		
		<!-- 관리자 or 작성자만 삭제 -->
		<c:if test="${owner || admin}">	
			<a href="${pageContext.request.contextPath}/review/delete?reviewNo=${reviewDto.reviewNo}" class="form-btn negative">삭제</a>	
		</c:if>
		<!-- 작성자만 수정 -->
		<c:if test="${owner}">
			<a href="${pageContext.request.contextPath}/review/edit?reviewNo=${reviewDto.reviewNo}" class="form-btn bosung">수정</a>	
		</c:if>
	</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>