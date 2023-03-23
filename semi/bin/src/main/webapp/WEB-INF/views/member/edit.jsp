<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 다음 우편 API 사용을 위한 CDN -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/static/js/find-address.js"></script>

<form action="/member/edit" method="post" autocomplete="off">
<div class=container-400>
   <div class="row center mb-20">
      <h2>개인정보 변경</h2>
   </div>
   
   <!-- 수정 사항 입력창 -->
   <div class="row">
      <label class="form-label w-100">비밀번호 확인</label>
      <input type="password" name="memberPw" class="form-input w-100" required>   
   </div>
   <div class="row">   
      <label class="form-label w-100">닉네임</label>
      <input type="text" name="memberNick" class="form-input w-100" value="${memberDto.memberNick}" required>
   </div>
   <div class="row">
      <label class="form-label w-100">생년월일</label>
      <input type="date" name="memberBirth" class="form-input w-100" value="${memberDto.memberBirth}" required>
   </div>
   <div class="row">
      <label class="form-label w-100">이메일</label>
      <input type="email" name="memberEmail" class="form-input w-100" value="${memberDto.memberEmail}">
   </div>
   <div>
   <label class="form-label w-100">휴대전화</label>
      <input type="tel" name="memberTel" class="form-input w-100" placeholder="대시(-)를 제외하고 작성" value="${memberDto.memberTel}" required>
   </div>
   <div class="row">
      <label class="form-label w-100">주소</label>
      <input type="text" name="memberPost" class="form-input w-40" placeholder="우편번호" readonly value="${memberDto.memberPost}">
      <button type="button" class="form-btn neutral find-address-btn">우편번호 찾기</button>
   </div>
   <div class="row">
      <input type="text" name="memberBasicAddr" class="form-input w-100" placeholder="기본주소" readonly value="${memberDto.memberBasicAddr}">
   </div>
   <div class="row">
      <input type="text" name="memberDetailAddr" class="form-input w-100" placeholder="상세주소" value="${memberDto.memberDetailAddr}">
   </div>
   
   <!-- 버튼 -->
   <div class="row mt-20 mb-20">
      <button type="submit" class="form-btn positive w-100">수정하기</button>
   </div>
   <!-- 비멀번호 에러 시 -->
   <c:if test="${param.mode == 'error'}">
   <div class="row center">
      <h3 style="color: #c23616;">비밀번호가 일치하지 않습니다.</h3>
   </div>
   </c:if>

</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   