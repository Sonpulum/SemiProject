<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.container-900 {
	width: 1050px;
    background-color: #ffffff;
    border: 1px solid #ebebeb;
    margin: 100px auto;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    padding : 10px 80px 80px 80px;
    margin-top: 0px;
}
/* 스타일 코드를 작성합니다. */
.form {
    padding: 20px;

}

.form input {
    width: 100%;
    border: none;
    border-bottom: 1px solid #d9d9d9;
    padding: 10px 0;
    margin: 10px 0;
    font-size: 16px;
}

.wrapper {
    display: flex;
    justify-content: space-between;
    width: 100%;
}

.left {
  width: 50%;
}

.write-btn {
    
    width: 10%;
    padding: 10px;
    margin-top: 20px;
    margin-left: 90%;
    background-color: rgb(64, 165, 187);
    color: #ffffff;
    border: none;
    border-radius: 5px;
    font-size: 18px;
    cursor: pointer;
    text-decoration: none;
    
}

.form p {
    text-align: center;
    margin-top: 20px;
}

.form a {
    color: rgb(64, 165, 187);
    text-decoration: none;
}

.form p1 {
    color: rgb(64, 165, 187);
    text-decoration: none;
    font-weight: bolder;
    
}

.form a:hover {
    text-decoration: none;
}
.post {
	display: flex;
	align-items: center;
	gap: 16px;
	  
}
.table .link{
	font-size:18px;
  }
body {
  background-color: #f6f6f6;
}
.post {
    display: flex;
    align-items: center;
    padding: 10px;
    
}

.post img {
    width: 230px;
    height: 170px;
    margin-right: 10px;
    margin: 20px;
}

.post-content {
    flex: 1;
}

.post-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 20px;
}

.post-header .titleName {
    margin-bottom: 30px;
}

.post-caption {
    margin: 10px;
}

.post-footer {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    font-size: 15px;
}

.post-footer span {
    margin-left: 10px;
}
      h2{
        font-size: 30px;
        display: inline;
        margin-top: 25px;
      }
.boseng{
	height:1px;
	background-color:#40a5bb;
}
</style>

<div class="container-900">
	<div class="row center" style="padding: 30px; font-size: 30px;">
		<h1>
       		<i class="fa-solid fa-magnifying-glass" style="color: #40a5bb;"></i>
         		추천 게시판 검색결과
      	</h1>
	</div>
         
   <div class="wrapper">
       <c:if test="${sessionScope.memberLevel eq '관리자'}">
       		<a href="write" class="write-btn center">글쓰기</a>
       </c:if>
     </div>
     <br>
     <hr>
     <div class="row">
     <c:forEach var="recoDto" items="${list}">
     	<div class="post">
   			<a href="detail?recoNo=${recoDto.recoNo}">
   				<img src=/rest/attachment/download/${recoDto.attachNo}>
   			</a>
   			<div class="post-content">
       			<div class="post-header">
       				<a class="link" href="detail?recoNo=${recoDto.recoNo}">
           				<span class="titleName">${recoDto.recoTitle}</span>
           			</a>
       			</div>
       			<a class="link" href="detail?recoNo=${recoDto.recoNo}">
       				<span>#${recoDto.recoLocation}</span>
       				<span>#${recoDto.recoSeason}</span>
       				<span>#${recoDto.recoTheme}</span>
       			</a>
      			<div class="post-footer">
                     <span class="comments">
                     	<i class="fa-regular fa-eye"></i>
                     	<span>조회수</span>
                     	<span>${recoDto.recoRead}</span>
                   	</span>
                     <span class="likes">
                     	<i class="fa-regular fa-thumbs-up"></i>
                     	<span>좋아요</span>
                     	<span>${recoDto.recoLike}</span>
                   	</span>
       			</div>
   			</div>
		</div>
	</c:forEach>
	</div>
	<!-- 페이지 네이게이터 - vo에 있는 데이터를 기반으로 구현 -->
	<div class="row">
	
		<div class="pagination">
		<c:choose>
		<c:when test="${vo.first}">
		<a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
		</c:when>
		<c:otherwise>
		<a href="listTotal?${vo.parameter}&page=1"><i class="fa-solid fa-angles-left"></i></a>	
		</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${vo.prev}">
		<a href="listTotal?${vo.parameter}&page=${vo.prevPage}"><i class="fa-solid fa-angle-left"></i></a>
			</c:when>
		<c:otherwise>
			<a class="disabled"><i class="fa-solid fa-angle-left"></i></a>
		</c:otherwise>
		</c:choose>
	 		
	 	<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
	 		<c:choose>
	 		<c:when test="${vo.page == i }"><a class="on">${i}</a></c:when>
	 		<c:otherwise>
	 		<a href="listTotal?${vo.parameter}&page=${i}">${i}</a>
	 		</c:otherwise>
	 		</c:choose>
	 	</c:forEach>	
	 		
	 	<c:choose>
	 		<c:when test="${vo.next}">
	 			<a href="listTotal?${vo.parameter}&page=${vo.nextPage}"><i class="fa-solid fa-angle-right"></i></a> 		
	 		</c:when>
	 		<c:otherwise>
	 			<a class="disabled"><i class="fa-solid fa-angle-right"></i></a>
	 		</c:otherwise>
	 	</c:choose>	
	 	
	 	<c:choose>
	 		<c:when test="${vo.last}">
	 		<a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
	 		</c:when>
	 	<c:otherwise>
	 	<a href="listTotal?${vo.parameter}&page=${vo.totalPage}"><i class="fa-solid fa-angles-right"></i></a>
	 	</c:otherwise>
	 	</c:choose>
	 	
	 	<!-- 페이징 숨김 -->
		<c:if test="${vo.totalPage <= 10}">
			<script>
				document.querySelectorAll('.pagination a.disabled').forEach(el => el.style.display = 'none');
			</script>
		</c:if>
	 	
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>