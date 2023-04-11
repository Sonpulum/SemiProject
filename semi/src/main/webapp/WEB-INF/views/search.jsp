<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
.search-detail{
	font-size:20px;
	font-weight:bold;
}
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
    .thead-color{
    	background-color: rgba(64, 165, 187, 0.16);
    }
    .fa-trash,
    .fa-pen {
    	color: #40a5bb;
    }
    .fa-trash:hover,
    .fa-pen:hover {
    	color: #e05462;
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
</style>
<div class="container-1000">
	<div class="row">
		<c:choose>
			<c:when test="${recoList.size() != 0}">
				<div class="row">
					<h3>추천 게시판 검색결과 : ${recoList.size()}건</h3>
				</div>
				<div class="row">
					<table class="table table-hover table-border center">
			            <thead>
			                <tr>
			                    <th>지역</th>
			                    <th>계절</th>
			                    <th>테마</th>
			                    <th class="w-40">제목</th>
			                    <th>조회수</th>
			                    <th>좋아요</th>
			                    <th>작성일</th>
			                </tr>	                  
			            </thead>
			            <tbody>
			            	<c:choose>
			            		<c:when test="${recoList.size() <= 5}">
			            			<c:forEach var="recoDto" items="${recoList}">
										<tr>
						                	<td>${recoDto.recoLocation}</td>
						                	<td>${recoDto.recoSeason}</td>
						                	<td>${recoDto.recoTheme}</td>
						                    <td class="w-40 left">
						                    <a class="link" href="${pageContext.request.contextPath}/recommend/detail?recoNo=${recoDto.recoNo}">
						           					${recoDto.recoTitle}</a>
						                    </td>
						                    <td><i class="fa-regular fa-eye"></i>    ${recoDto.recoRead}</td>
						               		<td><i class="fa-regular fa-thumbs-up"></i>    ${recoDto.recoLike}</td>
						               		<td>${recoDto.recoTime}</td>
					                	</tr>
									</c:forEach>
								</tbody>
							</table>
			            		</c:when>
			            		<c:otherwise>
			            			<c:forEach var="i" begin="0" end="4">
			            				<tr>
						                	<td>${recoList[i].recoLocation}</td>
						                	<td>${recoList[i].recoSeason}</td>
						                	<td>${recoList[i].recoTheme}</td>
						                    <td class="w-40 left">
						                    <a class="link" href="${pageContext.request.contextPath}/recommend/detail?recoNo=${recoList[i].recoNo}">
						           					${recoList[i].recoTitle}</a>
						                    </td>
						                    <td><i class="fa-regular fa-eye"></i>    ${recoList[i].recoRead}</td>
						               		<td><i class="fa-regular fa-thumbs-up"></i>    ${recoList[i].recoLike}</td>
						               		<td>${recoList[i].recoTime}</td>
					                	</tr>
			            			</c:forEach>
			                	</tbody>
		                	</table>
			            			<div class="row right">
			            				<a class="link search-detail" href="${pageContext.request.contextPath}/recommend/listTotal?keyword=${keyword}">검색결과 상세보기 <i class="fa-solid fa-arrow-right"></i></a>
		            				</div>
			            		</c:otherwise>
	            			</c:choose>
	            </div>
			</c:when>
			<c:otherwise>
				<div class="row">
					<h2>추천 게시판 관련 게시글이 없습니다</h2>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	<br>
	<hr>
	<br>
	<div class="row">
		<c:choose>
			<c:when test="${reviewList.size() != 0}">
				<div class="row">
					<h3>후기 게시판 검색결과 : ${reviewList.size()}건</h3>
				</div>
				<div class="row">
					<table class="table table-hover table-border center">
			            <thead>
			                <tr>
			                    <th>지역</th>
			                    <th>계절</th>
			                    <th>테마</th>
			                    <th class="w-40">제목</th>
			                    <th>조회수</th>
			                    <th>좋아요</th>
			                    <th>작성일</th>
			                </tr>
			            </thead>
			            <tbody>
			            	<c:choose>
			            		<c:when test="${reviewList.size() <= 5}">
			            			<c:forEach var="reviewDto" items="${reviewList}">
										<tr>
						                	<td>${reviewDto.reviewLocation}</td>
						                	<td>${reviewDto.reviewSeason}</td>
						                	<td>${reviewDto.reviewTheme}</td>
						                    <td class="w-40 left">
						                    <a class="link" href="${pageContext.request.contextPath}/review/detail?reviewNo=${reviewDto.reviewNo}">
						           					${reviewDto.reviewTitle}</a>
						           				<c:if test="${reviewDto.reviewReply > 0}">
						           					[${reviewDto.reviewReply}]
						           				</c:if>
						                    </td>
						                    <td><i class="fa-regular fa-eye"></i>    ${reviewDto.reviewRead }</td>
						               		<td><i class="fa-regular fa-thumbs-up"></i>    ${reviewDto.reviewLike }</td>
						               		<td>${reviewDto.reviewTime }</td>
					                	</tr>
									</c:forEach>
									</tbody>
									</table>
			            		</c:when>
			            		<c:otherwise>
			            			<c:forEach var="i" begin="0" end="4">
										<tr>
						                	<td>${reviewList[i].reviewLocation}</td>
						                	<td>${reviewList[i].reviewSeason}</td>
						                	<td>${reviewList[i].reviewTheme}</td>
						                    <td class="w-40 left">
						                    <a class="link" href="${pageContext.request.contextPath}/review/detail?reviewNo=${reviewList[i].reviewNo}">
						           					${reviewList[i].reviewTitle}</a>
						           				<c:if test="${reviewList[i].reviewReply > 0}">
						           					[${reviewList[i].reviewReply}]
						           				</c:if>
						                    </td>
						                    <td><i class="fa-regular fa-eye"></i>    ${reviewList[i].reviewRead}</td>
						               		<td><i class="fa-regular fa-thumbs-up"></i>    ${reviewList[i].reviewLike}</td>
						               		<td>${reviewList[i].reviewTime}</td>
					                	</tr>
									</c:forEach>
									</tbody>
									</table>
									<div class="row right">
										<a class="link search-detail" href="${pageContext.request.contextPath}/review/listTotal?keyword=${keyword}">검색결과 상세보기<i class="fa-solid fa-arrow-right"></i></a>
									</div>
			            		</c:otherwise>
			            	</c:choose>
	            </div>
			</c:when>
			<c:otherwise>
				<div class="row">
					<h2>후기 게시판 관련 게시글이 없습니다</h2>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>