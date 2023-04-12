<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/static/js/member-join.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/static/js/find-address.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/memberEdit.css">

<script>
	$(function(){
		$("[name=attach]").change(function() {
			if (uploadFile()){
				previewImage(this);
			}
			else {
				$(this).val("");
				previewImage(this);
			}
		});
		
		$(".clear-attach-btn").on("click",function(){
			$("[name=attach]").val("");
			previewImage($("[name=attach]"));
		});
		
		function previewImage(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#preview').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			} else {
				$('#preview').attr('src', '${pageContext.request.contextPath}/static/image/usericon.jpg');
			}
		}
		
		function uploadFile(){
			var fileVal = $("[name=attach]").val();
			if (fileVal !=""){
				var ext = fileVal.split('.').pop().toLowerCase();
				if($.inArray(ext, ['jpg','jpeg','gif','png']) == -1){
					alert("이미지 파일만 업로드 할 수 있습니다");
					return false;
				}
				else return true;
			}
			else return true;
		}
	});
	
</script>
<style>
	input[type="file"]{
		position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 0;
	}
</style>

<form action="${pageContext.request.contextPath}/member/edit" method="post" autocomplete="off" enctype="multipart/form-data">
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
      <input type="text" name="memberPost" class="form-input w-38" placeholder="우편번호" readonly value="${memberDto.memberPost}">
      <button type="button" class="form-btn1 find-address-btn">우편번호 찾기</button>
   	  <button type="button" class="form-btn negative clear-address-btn"><i class="fa-solid fa-eraser"></i></button>
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
		   		<img id="preview" width="100" height="100" src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${profile.attachmentNo}" class="ms-70">
			</c:when>
			<c:otherwise>
       			<img id="preview" width="100" height="100" src="${pageContext.request.contextPath}/static/image/usericon.jpg" class="ms-70">
			</c:otherwise>
		</c:choose>
		<label class="center form-btn neutral w-40 ms-20 me-10"> 사진 업로드
			<input type="file" name="attach" accept=".png, .gif, .jpg, .jpeg">
		</label>
        <button type="button" class="form-btn negative clear-attach-btn"><i class="fa-solid fa-eraser"></i></button>
   </div>
   
   <!-- 버튼 -->
   <div class="row center mb-20">
      <button type="submit" class="form-btn2 w-75">수정하기</button>
   </div>
   <!-- 비멀번호 에러 시 -->
   <c:if test="${param.mode == 'error'}">
   <div class="row center">
      <h2 style="color: #c23616;">비밀번호가 일치하지 않습니다.</h2>
   </div>
   </c:if>

</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>