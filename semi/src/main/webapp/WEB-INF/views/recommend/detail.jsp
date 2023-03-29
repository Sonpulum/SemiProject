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

.non-click:hover{
	cursor:default;
}
.tag {
	font-size : 22px;
	font-weight : bold;
}
</style>
<script>
$(function(){
    $(".form-btn.negative").click(function(e){
        e.preventDefault(); // 링크 이동 중지
        var choice = window.confirm("정말 삭제하시겠습니까?");
        if (choice) {
            window.location.href = $(this).attr("href"); // 링크 이동
        }
    });
});
</script>

<div class="container-800">
        <div class="row">
            <h1 class="mb-30">${recoDto.recoTitle}</h1>
        </div>
        <div class="row">
            <span class="tag">#${recoDto.recoLocation}</span>
            <span class="tag">#${recoDto.recoSeason}</span>
            <span class="tag">#${recoDto.recoTheme}</span>
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
            <span>조회수</span>
            <span>${recoDto.recoRead}</span>
			<i class="fa-regular fa-eye me-10"></i>
			
			<span>좋아요</span>
            <span class="like-count">${recoDto.recoLike}</span>
            <c:choose>
            	<c:when test="${sessionScope.memberId != null}">
            		<i class="fa-thumbs-up"></i>
            	</c:when>
            	<c:otherwise>
            		<i class="fa-regular fa-thumbs-up non-click"></i>
            	</c:otherwise>
            </c:choose>
        </div>
        <hr>
        
        <div class = "row right">
<%--         	<a href="list?column=${column}&keyword=${keyword}" class="form-btn neutral">목록으로</a> --%>
        	<c:if test="${sessionScope.memberId == recoDto.recoWriter}">
		       	<a href="delete?recoNo=${recoDto.recoNo}" class="form-btn negative">삭제하기</a>
		       	<a href="edit?recoNo=${recoDto.recoNo}" class="form-btn bosung">수정하기</a>
        	</c:if>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>