// 회원 가입 페이지 유효성 검사 모듈
// - jQuery가 반드시 필요

$(function(){
	// 검사 결과 저장 객체
	var valid = {
		memberIdValid:false, 	//아이디 (형식+중복)
		memberPwValid:false,		//비밀번호 (형식)
		memberPwReValid:false,	//비밀번호 확인 (일치)
		memberNickValid:false,		//닉네임 (형식 + 중복)
		memberTelValid:false,		//전화번호 (형식)
		memberEmailValid:false,		//이메일(형식 + 중복)
		memberBirthValid:false, 	//생년월일 (형식)
		memberAddressValid:true,		//주소 (애매한 입력)
		isAllValid:function(){
			return this.memberIdValid && this.memberPwValid && this.memberPwReValid && this.memberNickValid
						&& this.memberTelValid && this.memberBirthValid &&this.memberEmailValid && this.memberAddressValid;
		}
	};
	
	$("[name=memberId]").blur(function(){
		var regex = /^[a-z0-9]{8,20}$/;
		var memberId = $(this).val();
		var isValid = regex.test(memberId);
		
		valid.memberIdValid = isValid;
		
		if(isValid) {
			$.ajax({
				url:contextPath+"/rest/member/memberId/"+memberId,
				method:"get",
				success:function(response){ //성공시 Y,N
					if(response=="Y"){
						valid.memberIdValid =true;
						$("[name=memberId]").removeClass("valid invalid invalid2")
									.addClass("valid");
					}
					else{
						valid.memberIdValid=false;
						$("[name=memberId]").removeClass("valid invalid invalid2")
									.addClass("invalid2");
					}
				},
				error:function(){
					alert("오류가 발생했습니다 \n 잠시 후 다시 시도하세요");
					valid.memberIdValid = false;
				},
			});
		}
		
		else{
			$("[name=memberId]").removeClass("valid invalid invalid2")
						.addClass("invalid");
		}
	});
	
	//비밀번호 검사
	$("[name=memberPw]").blur(function(){
		var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_-])[A-Za-z0-9!@#$%^&*()_-]{8,16}$/;
		var isValid = regex.test($(this).val());
		valid.memberPwValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	//비밀번호 확인 검사
	$("#passwordRe").blur(function(){
		var memberPw = $("[name=memberPw]").val();
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
	
	//닉네임 검사
	$("[name=memberNick]").blur(function(){
		var regex = /^[가-힣]{2,10}$/;
		var target = $(this);
		var memberNick = target.val();
		var isValid = regex.test(memberNick);
		
		valid.memberNickValid = isValid;
		
		if (!isValid){
			target.removeClass("valid invalid invalid2")
						.addClass("invalid");
			return
		}
		
		$.ajax({
			url:contextPath+"/rest/member/memberNick/"+memberNick,
			method:"get",
			success:function(response){
				if(response == "Y"){
					target.removeClass("valid invalid invalid2")
								.addClass("valid");
				}
				else{
					target.removeClass("valid invalid invalid2")
								.addClass("invalid2");
				}
			},
			error:function(){
				alert("통신 오류");
			}
		});
		
		
	});
	
	//이메일 검사
	$("[name=memberEmail]").blur(function(){
		var regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		var target = $(this);
		var memberEmail = target.val();
		var isValid = regex.test(memberEmail);
		
		valid.memberEmailValid = isValid;
		
		if (!isValid){
			target.removeClass("valid invalid invalid2")
						.addClass("invalid");
			return
		}
		
		$.ajax({
			url:contextPath+"/rest/member/memberEmail/"+memberEmail,
			method:"get",
			success:function(response){
				if(response == "Y"){
					target.removeClass("valid invalid invalid2")
								.addClass("valid");
				}
				else{
					target.removeClass("valid invalid invalid2")
								.addClass("invalid2");
				}
			},
			error:function(){
				alert("통신 오류");
			}
		});
		
		
	});
	
	//전화번호 검사
	$("[name=memberTel]").blur(function(){
		var regex =/^01[016789][1-9][0-9]{6,7}$/;
		var isValid = regex.test($(this).val());
		
		valid.memberTelValid = isValid;
		
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	//생년월일 검사
	$("[name=memberBirth]").on("input",function(){
		var regex = /^(19[0-9]{2}|20[0-9]{2})-((02)-(0[1-9]|[1-2][0-9])|((0[469]|11)-(0[1-9]|[1-2][0-9]|30))|((0[13578]|1[02])-(0[1-9]|[1-2][0-9]|3[01])))$/;
		var isValid = regex.test($(this).val());
		
		valid.memberBirthValid = isValid;
		
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	//주소 검사
	$("[name=memberDetailAddr]").blur(function(){
		var memberPost = $("[name=memberPost]").val();
		var memberBasicAddr = $("[name=memberBasicAddr]").val();
		var memberDetailAddr = $(this).val();
		
		var isAllEmpty = memberPost.length == 0 
										 && memberBasicAddr.length == 0
										 && memberDetailAddr.length == 0;
		var isAllWriten = memberPost.length > 0 
										 && memberBasicAddr.length > 0
										 && memberDetailAddr.length > 0;
		
		var isValid = isAllEmpty||isAllWriten;
		
		valid.memberAddressValid = isValid;
		
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
										 
	});
	
	//주소 지우기 버튼
	$(".clear-address-btn").click(function(){
		$("[name=memberPost]").val("");
		$("[name=memberBasicAddr]").val("");
		$("[name=memberDetailAddr]").val("").removeClass("valid invalid");
	});
	
	//폼 검사
	$(".join-form").submit(function(e){
		if(!valid.isAllValid){
			e.preventDefault();
		}
	});
	
});