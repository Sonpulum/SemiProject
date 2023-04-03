<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-800">
<div class="row center">
	<h1>회원 정보 수정</h1>
</div>
<form action="edit" method="post">
<input type="hidden" name="memberId" value="${memberDto.memberId}">
<div class="row"> 
<table class="table table slit">
	<tbody>
		
		<tr>
			<th>닉네임</th>
			<td>
				<input type="text" name="memberNick" class="form-input w-100" required value="${memberDto.memberNick}">
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<input type="tel" name="memberTel" class="form-input w-100" required value="${memberDto.memberTel}">
			</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>
				<input type="date" name="memberBirth" class="form-input w-100" required value="${memberDto.memberBirth}">
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>
				<input type="email" name="memberEmail" class="form-input w-100" value="${memberDto.memberEmail}">
			</td>
		</tr>
		<tr>
			<th rowspan="3">주소</th>
			<td>
				<input type="text" name="memberPost" class="form-input w-100" size="6" maxlength="6"
					value="${memberDto.memberPost}" placeholder="우편번호">
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="memberBasicAddr" class="form-input w-100"
					value="${memberDto.memberBasicAddr}" placeholder="기본주소">
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="memberDetailAddr" class="form-input w-100"
					value="${memberDto.memberDetailAddr}" placeholder="상세주소">
			</td>
		</tr>
		
		<tr>
			<th>등급</th>
			<td>
			<c:choose>
				<c:when test="${memberDto.memberLevel == '일반회원' }">
				<select name="memberLevel" class="form-input w-100">
					<option selected>일반회원</option>
					<option>관리자</option></select></c:when>
				<c:when test="${memberDto.memberLevel == '관리자' }">
				<select name="memberLevel" class="form-input w-100">
					<option>일반회원</option>
					<option selected>관리자</option></select></c:when>
			</c:choose>
				(기존:${memberDto.memberLevel})
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit" class="form-btn w-30 bosung">수정하기</button>
			</td>
		</tr>
	</tbody>
</table>
</div>
</form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
