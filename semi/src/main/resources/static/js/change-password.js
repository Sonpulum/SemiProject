$(function(){
	var valid = {
		memberPwValid:false,		//비밀번호 (형식)
		memberPwReValid:false,	//비밀번호 확인 (일치)
		isAllValid:function(){
			return this.memberPwValid && this.memberPwReValid;
		}
	};
	
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
		
		var isEmpty = memberPwRe.length == 0;
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
		
		if(!memberPw.equals(memberPwRe)) { // 새 비밀번호와 비밀번호 확인이 일치하지 않을 경우
	    attr.addAttribute("mode", "error");
	    return "redirect:/changePw";
	}
	});
});