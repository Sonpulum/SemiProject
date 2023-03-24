<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:if test="${sessionScope.memberId != null}">
<script src="/static/js/recommend-like.js"></script>
</c:if>

<style>
main section article h1 {
        font-size: 2em;
}
.fa-thumbs-up{
	color:#5186f0;
}
.fa-thumbs-up:hover{
	cursor:pointer;
}
</style>

<div class="container-800">
        <div class="row">
            <h1 class="mb-50">${recoDto.recoTitle}</h1>
        </div>
        <div class="row">
            <span >#${recoDto.recoLocation}</span>
            <span>#${recoDto.recoSeason}</span>
            <span>#${recoDto.recoTheme}</span>
        </div>
        <hr>
        <div class="row">
            ${recoDto.recoContent}
        </div>
        <hr>
        <div class="row">
            <span class="me-10">
            	<fmt:formatDate value="${recoDto.recoTime}" pattern="y년 M월 d일 HH:mm"/>
           	</span>
            <span>${recoDto.recoRead}</span>
            <c:if test="${sessionScope.memberId != null}">
			<!-- 조회수자리 -->
			<i class="fa-regular fa-eye"></i>
			</c:if> 
            <span class="like-count ms-10">${recoDto.recoLike}</span>
            <c:if test="${sessionScope.memberId != null}">
			<!-- 좋아요자리 -->
			<i class="fa-thumbs-up"></i>
			</c:if>
        </div>
        <hr>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>