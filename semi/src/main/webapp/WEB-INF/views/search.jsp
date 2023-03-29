<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container-1000">
	<div class="row">
		<h3>검색어 : ${keyword}</h3>
		<h2>추천 게시판 검색결과 : ${recoList.size()}건</h2>
		<c:choose>
			<c:when test="${recoList != null}">
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
						<c:forEach var="recoDto" items="${recoList}">
							<tr>
			                	<td>${recoDto.recoLocation}</td>
			                	<td>${recoDto.recoSeason}</td>
			                	<td>${recoDto.recoTheme}</td>
			                    <td class="w-40 left">
			                    <a class="link" href="/recommend/detail?recoNo=${recoDto.recoNo}">
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
				<h1>관련 게시글이 없습니다</h1>
			</c:otherwise>
		</c:choose>
	</div>
	<br>
	<hr>
	<br>
	<div class="row">
		<h2>후기 게시판 검색결과 : ${reviewList.size()}건</h2>
		<c:choose>
			<c:when test="${reviewList != null}">
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
						<c:forEach var="reviewDto" items="${reviewList}">
							<tr>
			                	<td>${reviewDto.reviewLocation}</td>
			                	<td>${reviewDto.reviewSeason}</td>
			                	<td>${reviewDto.reviewTheme}</td>
			                    <td class="w-40 left">
			                    <a class="link" href="/review/detail?reviewNo=${reviewDto.reviewNo}">
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
				<h1>관련 게시글이 없습니다</h1>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>