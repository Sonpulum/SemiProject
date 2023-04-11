<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원탈퇴</title>

    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

    <!-- 링크 확인창 출력을 위한 CDN -->
    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/confirm-link@latest/confirm-link.min.js"></script>
    
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
    
   <script type="text/javascript">
        $(function(){
            $(".next-btn").prop("disabled", true);
            
            $(".check-unit").change(function(){
                var isValid = $(".check-unit").length == $(".check-unit:checked").length;
            });
            
            $(".check-unit").change(function(){
                var isValid = $(".check-unit").length == $(".check-unit:checked").length;
                $(".next-btn").prop("disabled", !isValid);
            });
            
            var valid = {
            		memberPwValid:false,		//비밀번호 (형식)
            		memberPwReValid:false,	//비밀번호 확인 (일치)
            		isAllValid:function(){
            			return this.memberPwValid && this.memberPwReValid;
            		}
            	};
            
          //현재 비밀번호 검사
        	$("[name=memberPw]").blur(function(){
        		var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_-])[A-Za-z0-9!@#$%^&*()_-]{8,16}$/;
        		var isValid = regex.test($(this).val());
        		valid.memberPwValid = isValid;
        		$(this).removeClass("valid invalid")
        					.addClass(isValid ? "valid" : "invalid");
        	});

        });
    </script>
    
</head>

<body>
	<form action="exit" method="post">
			<div class="container-800">
					<div class="row center">
						<img src="${pageContext.request.contextPath}/static/image/backpack.png"  width="70px" height="70px">
						<h1>비밀번호 확인</h1>
				</div>
				<div class="row center">
					<h4>탈퇴하시려면 비밀번호를 입력하세요</h4>
				</div>
				<div class="row center">
					<input type="password" class = "form-input w-50" name="memberPw" placeholder="현재 비밀번호" required></input>
<!-- 					<div class="valid-message">비밀번호가 일치합니다</div> -->
					<div class="invalid-message">비밀번호가 일치하지 않습니다</div>
				</div>
				<div class="row center">
		            <label>
		                <input type="checkbox" name="agree" value="1" class="check-unit"
		                    onchange="checkUnit();" required>
		                회원 탈퇴 시 주의사항에 대해 확인하였으면 회원탈퇴에 동의합니다
		            </label>
		        </div>
				<div class="row center">
					<button type="submit"  class="form-btn w-50 negative next-btn">회원 탈퇴</button>
				</div>				
			</div>
	</form>
	<div class="row center">
		<c:if test="${param.mode == 'error'}">
		<h2>비밀번호가 일치하지 않습니다</h2>
		</c:if>
	</div>
</body>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>