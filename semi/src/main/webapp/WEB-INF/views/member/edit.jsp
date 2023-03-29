<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	h2 {
            font-size: 15px;
        }
	
	h3 {
            font-size: 10px;
        }

        .form-label {
            display: inline-block;
            margin-left: 13%;
        }
		
		.form-btn1{
            font-size: 18px;
            padding: 0.5em;
            border-width: 1px;
            border-style: solid;
            border-radius: 0.4em;
            cursor: pointer;
            background-color: #b1d5db;
            border-color: #b1d5db;
            display: inline-block;
            text-align: center;
            text-decoration: none;
            color: white;
        }
		
		
        .form-btn2{
            font-size: 18px;
            padding: 0.5em;
            border-width: 1px;
            border-style: solid;
            border-radius: 0.4em;
            cursor: pointer;
            background-color: rgb(64, 165, 187);
            border-color: rgb(64, 165, 187);
            display: inline-block;
            text-align: center;
            text-decoration: none;
            color: white;
        }
        .form-input{
            border-bottom-color: white;
            border-radius: 0.4em;
            border-color: #c8c8c8;
        }
        .form-label {
            display: block;
        }
	
	.fa-thumbs-up {
	color:red;
	cursor: pointer;
	}
	
	.writer {
    display: flex;
    align-items: center;
	}
</style>
<script>
	function previewImage(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		} else {
			$('#preview').attr('src', '/static/image/usericon.jpg');
		}
	}
	$(document).ready(function() {
		$("[name=attach]").change(function() {
			previewImage(this);
		});
	});
</script>

<form action="/member/edit" method="post" autocomplete="off">
<div class=container-500>
   <div class="row left mb-20">
      <h1>개인정보 변경</h1>
      <h3>양식에 맞게 작성하세요</h3>
   </div>
   <hr>
   
   <!-- 수정 사항 입력창 -->
   <div class="row center">
      <label class="form-label left">비밀번호 확인</label>
      <input type="password" name="memberPw" class="form-input w-75" required>   
   </div>
   <div class="row center">   
      <label class="form-label left">닉네임</label>
      <input type="text" name="memberNick" class="form-input w-75" value="${memberDto.memberNick}" required>
   </div>
   <div class="row center">
      <label class="form-label left">생년월일</label>
      <input type="date" name="memberBirth" class="form-input w-75" value="${memberDto.memberBirth}" required>
   </div>
   <div class="row center">
      <label class="form-label left">이메일</label>
      <input type="email" name="memberEmail" class="form-input w-75" value="${memberDto.memberEmail}">
   </div>
   <div class="row center">
   <label class="form-label left">휴대전화</label>
      <input type="tel" name="memberTel" class="form-input w-75" placeholder="대시(-)를 제외하고 작성" value="${memberDto.memberTel}" required>
   </div>
   <div class="row center">
      <label class="form-label left">주소</label>
      <input type="text" name="memberPost" class="form-input w-49" placeholder="우편번호" readonly value="${memberDto.memberPost}">
      <button type="button" class="form-btn1 find-address-btn">우편번호 찾기</button>
   </div>
   <div class="row center">
      <input type="text" name="memberBasicAddr" class="form-input w-75" placeholder="기본주소" readonly value="${memberDto.memberBasicAddr}">
   </div>
   <div class="row center">
      <input type="text" name="memberDetailAddr" class="form-input w-75" placeholder="상세주소" value="${memberDto.memberDetailAddr}">
   </div>
   
   <label class="form-label w-75">프로필 이미지</label>
   <div class="row writer">
   		<c:choose>
			<c:when test="${profile.attachmentNo != null}">
		   		<img id="preview" width="100" height="100" src="/attachment/download?attachmentNo=${profile.attachmentNo}" class="ms-50">
			</c:when>
			<c:otherwise>
       			<img id="preview" width="100" height="100" src="/static/image/usericon.jpg" class="ms-50">
			</c:otherwise>
		</c:choose>
		<input type="file" name="attach" class="form-input w-75" accept=".png, .gif, .jpg" style="border: 1px transparent solid;">
   </div>
   
   <!-- 버튼 -->
   <div class="row center mt-20 mb-20">
      <button type="submit" class="form-btn2 w-75">수정하기</button>
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