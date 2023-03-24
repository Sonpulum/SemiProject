// 회원 가입 페이지 유효성 검사 모듈
// - jQuery가 반드시 필요

$(function(){
	var valid = {
		memberPwValid:false,		//비밀번호 (형식)
		memberPwReValid:false,	//비밀번호 확인 (일치)
		isAllValid:function(){
			return this.memberPwValid && this.memberPwReValid;
		}
	};
	
	//현재 비밀번호 검사
	$("[name=currentPw]").blur(function(){
		var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_-])[A-Za-z0-9!@#$%^&*()_-]{8,16}$/;
		var isValid = regex.test($(this).val());
		valid.memberPwValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	//새 비밀번호 검사
	$("[name=newPw]").blur(function(){
		var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_-])[A-Za-z0-9!@#$%^&*()_-]{8,16}$/;
		var isValid = regex.test($(this).val());
		valid.memberPwValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	//비밀번호 확인 검사
	$("[name=newPwRe]").blur(function(){
		var memberPw = $("[name=newPw]").val();
		var memberPwRe = $(this).val();
		
		var isEmpty = memberPw.length == 0;
		var isValid = memberPw == memberPwRe;
		
		valid.memberPwReValid = !isEmpty && isValid;
		
		$(this).removeClass("valid invalid invalid2");
		if(isEmpty){
			$(this).addClass("invalid2");
		}
		else if(isValid){
			$(this).addClass("valid");
		}
		else{
			$(this).addClass("invalid");
		}
	});
	
});