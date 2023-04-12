<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배낭챙겨</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/load.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/join.css">
  
    <script src="https://cdn.jsdelivr.net/gh/sonpulum/confirm-link@0.0.1/confirm-link.js"></script>
    
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
</head>
<body>
<script src="${pageContext.request.contextPath}/static/js/member-join.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/static/js/find-address.js"></script>

<form class="join-form" action="join" method="post" autocomplete="off">
<div class="container container-500">
    <div class="row center mt-30">
        <a href="${pageContext.request.contextPath}"><img class="logo" src="${pageContext.request.contextPath}/static/image/backpack.jpg"></a>
    </div>
    <div class="row">
        <label class="form-label w-100">아이디</label>
        <input type="text" name="memberId"
                    class="form-input w-100">
        <div class="valid-message">사용 가능한 아이디입니다</div>
        <div class="invalid-message">아이디는 영문소문자, 숫자 8~20자로 작성하세요</div>
        <div class="invalid-message2">이미 사용중인 아이디입니다</div>
    </div>
    <div class="row">
        <label class="form-label w-100">비밀번호</label>
        <input type="password" name="memberPw"
                    class="form-input w-100">
        <div class="valid-message">올바른 비밀번호 형식입니다</div>
        <div class="invalid-message">영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~16자로 작성하세요</div> 
    </div>
    <div class="row">
        <label class="form-label w-100">비밀번호 확인</label>
        <input type="password" id="passwordRe" 
            class="form-input w-100">
        <div class="valid-message">비밀번호가 일치합니다</div>
        <div class="invalid-message">비밀번호가 일치하지 않습니다</div>
        <div class="invalid-message2">비밀번호를 먼저 입력하세요</div>
    </div>
    <div class="row">
        <label class="form-label w-100">닉네임</label>
         <input type="text" name="memberNick" 
             class="form-input w-100">
         <div class="valid-message">사용 가능한 닉네임입니다</div>
         <div class="invalid-message">닉네임은 한글 2~10글자로 작성하세요</div>
         <div class="invalid-message2">이미 사용중인 닉네임입니다</div>
    </div>
    <div class="row">
        <label class="form-label w-100">생년월일</label>
        <input name="memberBirth" type="date" class="form-input w-100">
    </div>
    <div class="row">
        <label class="form-label w-100">이메일</label>
        <input name="memberEmail" type="text" class="form-input w-100">
        <div class="valid-message">사용 가능한 이메일입니다</div>
        <div class="invalid-message">잘못된 형식의 이메일입니다</div>
        <div class="invalid-message2">이미 사용중인 이메일입니다</div>
    </div>
    <div class="row">
        <label class="form-label w-100">휴대전화</label>
        <input name="memberTel" type="text" class="form-input w-100">
    </div>
    <div class="row">
        <label class="form-label w-100 mb-10">주소</label>
        <input type="text" name="memberPost"
            class="form-input w-40 me-50" placeholder="우편번호">
        <button type="button" class="form-btn neutral find-address-btn">우편번호 찾기</button>
        <button type="button" class="form-btn negative clear-address-btn"><i class="fa-solid fa-eraser"></i></button>
    </div>
    <div class="row">
        <input type="text" name="memberBasicAddr" 
                    class="form-input w-100" placeholder="기본주소">
    </div>
    <div class="row">
        <input type="text" name="memberDetailAddr"
           class="form-input w-100" placeholder="상세주소">
        <div class="invalid-message">주소는 비워두거나 모두 작성해야 합니다</div>
    </div>
    <div class="row mb-30">
        <button type="submit" class="form-btn positive w-100">회원가입</button>
    </div>
</div>
</form>
</body>
</html>
