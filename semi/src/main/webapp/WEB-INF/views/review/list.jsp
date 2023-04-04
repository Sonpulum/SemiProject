<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
 .container-1000 { 
             width: 1100px; 
             height: 100%; 
             background-color: #ffffff; 
             border: 1px solid #ebebeb; 
             margin: 100px auto; 
             box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); 
             border-radius: 5px; 
             padding : 10px 80px 80px 80px;  
             margin-top: 0px; 
             margin-bottom: 0px
         } 
        
 body { 
   background-color: #f6f6f6; 
 } 


.table.table-border,
.table.table-border > thead > tr > th,
.table.table-border > thead > tr > td,
.table.table-border > tbody > tr > th,
.table.table-border > tbody > tr > td,
.table.table-border > tfoot > tr > th,
.table.table-border > tfoot > tr > td
{
    border: 0px solid #636e72;
}

.table.table-border > thead { 
	border-top : 2px solid rgb(64, 165, 187);
	border-bottom : 2px solid gray;
}

.table.table-border > tbody > tr:last-child {
	border-bottom : 2px solid gray;
}

 .table.table-border > tfoot > tr:last-child { 
 	border-bottom : 2px solid rgb(64, 165, 187); 
 } 

.table.table-hover > tbody > tr:hover,
.table.table-hover > tfoot > tr:hover {
    background-color: black;
    color: white;
}
</style>

<script>
$(function(){
	$("[name=search-form]").submit(function(e){
		var keyword = $("[name=search-form] [name=keyword]");
		keyword.val(keyword.val().trim());
		if (keyword.val() == ''){
			confirm("검색어를 입력하세요");
			return false;	
		}
		else if (keyword.val().length >= 20){
			confirm("검색어는 20글자 이하여야 합니다");
			return false;
		}
		return true;
	});
});
</script>
 <div class="container-1000">
 		<c:choose>
		<c:when test="${list.size() != 0}">
        <div class="row center mt-30">
            <h1>나만의 여행지를 공유해보세요</h1>
        </div>
		
        <div class="row right">
        	<a href="/review/write" class="form-btn bosung">글쓰기</a>
        </div>
        
        <div class="row">
		    <a href="list?sort=latest" class="link">최신순 |</a>
		    <a href="list?sort=read" class="link">조회수순 |</a>
		    <a href="list?sort=like" class="link">좋아요순</a>
		</div>
        
        <table class="table table-border center">
            <thead>
            	
                <tr>
                    <th></th>
                    <th>테마</th>
                    <th>지역</th>
                    <th class="w-40">제목</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                    <th>작성일</th>
                </tr>
                  
            </thead>
			
            <tbody>
			<c:forEach var="reviewDto" items="${topList}">
            <!-- 인기 게시글만 출력 -->
			<tr bgcolor="#ebf8fa">
				<td>인기</td>
				<td>${reviewDto.reviewTheme}</td>
                <td>${reviewDto.reviewLocation }</td>
           		<td class="w-40 left">
           			<a class="link" href="detail?reviewNo=${reviewDto.reviewNo}">
           				${reviewDto.reviewTitle}</a>
           			<c:if test="${reviewDto.reviewReply > 0}">
           				<span style="color: rgb(50, 138, 157);">
            				[${reviewDto.reviewReply}]
        				</span>
           			</c:if>
           		</td>
                <td><i class="fa-regular fa-eye"></i>    ${reviewDto.reviewRead }</td>
                <td><i class="fa-regular fa-thumbs-up"></i>    ${reviewDto.reviewLike }</td>
                <td>${reviewDto.reviewTimeAuto}</td>
			</tr>
           </c:forEach> 
            </tbody>
           
            <!-- 모든 게시글 출력 -->
				<tfoot>
			<c:forEach var="reviewDto" items="${list}">
                <tr>
                	<td>${reviewDto.reviewNo }</td>
                	<td>${reviewDto.reviewTheme}</td>
                	<td>${reviewDto.reviewLocation }</td>
                    <td class="w-40 left">
                    <a class="link" href="detail?reviewNo=${reviewDto.reviewNo}">
           					${reviewDto.reviewTitle}</a>
           				<c:if test="${reviewDto.reviewReply > 0}">
           					<span style="color: rgb(50, 138, 157);">
            				[${reviewDto.reviewReply}]
        				</span>
           				</c:if>
                    </td>
                    <td><i class="fa-regular fa-eye"></i>    ${reviewDto.reviewRead }</td>
               		<td><i class="fa-regular fa-thumbs-up"></i>    ${reviewDto.reviewLike }</td>
               		<td>${reviewDto.reviewTimeAuto}</td>
                </tr>
        	</c:forEach>
				</tfoot>
        </table>
        
<!-- 페이지 네이게이터 - vo에 있는 데이터를 기반으로 구현 -->
<div class="row">

	<div class="pagination">
	<c:choose>
	<c:when test="${vo.first}">
	<a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
	</c:when>
	<c:otherwise>
	<a href="list?${vo.parameter}&page=1"><i class="fa-solid fa-angles-left"></i></a>	
	</c:otherwise>
	</c:choose>
	
	<c:choose>
		<c:when test="${vo.prev}">
	<a href="list?${vo.parameter}&page=${vo.prevPage}"><i class="fa-solid fa-angle-left"></i></a>
		</c:when>
	<c:otherwise>
		<a class="disabled"><i class="fa-solid fa-angle-left"></i></a>
	</c:otherwise>
	</c:choose>
 		
 	<c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
 		<c:choose>
 		<c:when test="${vo.page == i }"><a class="on">${i}</a></c:when>
 		<c:otherwise>
 		<a href="list?${vo.parameter}&page=${i}">${i}</a>
 		</c:otherwise>
 		</c:choose>
 	</c:forEach>	
 		
 	<c:choose>
 		<c:when test="${vo.next}">
 			<a href="list?${vo.parameter}&page=${vo.nextPage}"><i class="fa-solid fa-angle-right"></i></a> 		
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
 	<a href="list?${vo.parameter}&page=${vo.totalPage}"><i class="fa-solid fa-angles-right"></i></a>
 	</c:otherwise>
 	</c:choose>
 	
 	<!-- 페이징 숨김 -->
	<c:if test="${vo.totalPage <= 5}">
		<script>
			document.querySelectorAll('.pagination a.disabled').forEach(el => el.style.display = 'none');
		</script>
	</c:if>
 	
	</div>
</div>
</c:when>

	<c:otherwise>
	<div class="row center mt-30 mb-30">
	<img src="/static/image/search.png" width="90px" height="80px">
	<h2>' ${vo.keyword} '에 대한 검색 결과가 없습니다.</h2>
	<h1>다른 검색어를 입력하시거나 철자와 띄어쓰기를 확인해 보세요.</h1>
	</div>
	</c:otherwise>
	</c:choose>

<div class="row center mt-10">
	<form action="list" method="get" name="search-form">
		<c:choose>
			<c:when test="${vo.column == 'review_content'}">
				<select name="column" class="form-input">
   					<option value="review_title">제목</option>
   					<option value="review_content" selected>내용</option>
   					<option value="review_location">지역</option>
			   		<option value="review_season">계절</option>
			   		<option value="review_theme">테마</option>
   					<option value="review_writer">작성자</option>
				</select>
			</c:when>
			<c:when test="${vo.column == 'review_writer'}">
				<select name="column" class="form-input">
			   		<option value="review_title">제목</option>
			   		<option value="review_content">내용</option>
			   		<option value="review_location">지역</option>
			   		<option value="review_season">계절</option>
			   		<option value="review_theme">테마</option>
			   		<option value="review_writer" selected>작성자</option>
				</select>
			</c:when>
			<c:when test="${vo.column == 'review_location'}">
				<select name="column" class="form-input">
			   		<option value="review_title">제목</option>
			   		<option value="review_content">내용</option>
			   		<option value="review_location" selected>지역</option>
			   		<option value="review_season">계절</option>
			   		<option value="review_theme">테마</option>
			   		<option value="review_writer">작성자</option>
				</select>
			</c:when>  
			<c:when test="${vo.column == 'review_season'}">
				<select name="column" class="form-input">
			   		<option value="review_title">제목</option>
			   		<option value="review_content">내용</option>
			   		<option value="review_location">지역</option>
			   		<option value="review_season" selected>계절</option>
			   		<option value="review_theme">테마</option>
			   		<option value="review_writer">작성자</option>
				</select>
			</c:when>  
			<c:when test="${vo.column == 'review_theme'}">
				<select name="column" class="form-input">
			   		<option value="review_title">제목</option>
			   		<option value="review_content">내용</option>
			   		<option value="review_location">지역</option>
			   		<option value="review_season">계절</option>
			   		<option value="review_theme" selected>테마</option>
			   		<option value="review_writer">작성자</option>
				</select>
			</c:when>  

			<c:otherwise>
				<select name="column" class="form-input">
			   		<option value="review_title" selected>제목</option>
			   		<option value="review_content">내용</option>
			   		<option value="review_location">지역</option>
			   		<option value="review_season">계절</option>
			   		<option value="review_theme">테마</option>
			   		<option value="review_writer">작성자</option>
				</select>
			</c:otherwise>
		</c:choose>

		<input type="search" name="keyword" class="form-input" style="width:350px;" value="${vo.keyword}" placeholder="여행지 검색">
    	<button type="submit" class="form-btn neutral bosung">검색</button>
   </form>
</div>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
