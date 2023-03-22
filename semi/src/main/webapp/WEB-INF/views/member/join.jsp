<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-300">
    <div class="row center">
        <h1>배낭챙겨</h1>
    </div>
    <form form action="join" method="post" autocomplete="off">
    <div class="row">
        <label class="form-label w-100">아이디</label>
        <input name="memberId" type="text" class="form-input w-100">
    </div>
    <div class="row">
        <label class="form-label w-100">비밀번호</label>
        <input name="memberPw" type="password" class="form-input w-100">
    </div>
    <div class="row">
        <label class="form-label w-100">닉네임</label>
        <input name="memberNick" type="text" class="form-input w-100">
    </div>
    <div class="row">
        <label class="form-label w-100">생년월일</label>
        <input name="memberBirth" type="date" class="form-input w-100">
    </div>
    <div class="row">
        <label class="form-label w-100">이메일</label>
        <input name="memberEmail" type="text" class="form-input w-100">
    </div>
    <div class="row">
        <label class="form-label w-100">휴대전화</label>
        <input name="memberTel" type="text" class="form-input w-100">
    </div>
    <div class="row">
        <label class="form-label w-100">주소</label>
        <input name="memberPost" type="text" class="form-input w-40">
        <a href="#" class="form-btn neutral">우편번호 찾기</a>
    </div>
    <div class="row">
        <input name="memberBasicAddr" type="text" class="form-input w-100">
    </div>
    <div class="row">
        <input name="memberDetailAddr" type="text" class="form-input w-100">
    </div>
    <div class="row">
        <button type="submit" class="form-btn positive w-100">회원가입</button>
    </div>
    </form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>