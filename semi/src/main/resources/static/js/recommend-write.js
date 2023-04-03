$(function(){
	var valid = {
		recoTitleValid : false,
		recoContentValid : false,
		recoLocationValid : false,
		recoSeasonValid : false,
		recoThemeValid : false,
		recoAddrValid : false,
		isAllValid : function(){
			return this.recoTitleValid && this.recoContentValid && this.recoLocationValid && this.recoSeasonValid && this.recoThemeValid && this.recoAddrValid;
		}
		
	};
	
	$(".find-address-btn").click(function(){
		findAddress();
	});

	$(".clear-address-btn").click(function(){
		$("[name=recoAddr]").val("");
	});
	
    function findAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                document.querySelector("[name=recoAddr]").value = addr;
            }
        }).open();
    }
    
	$("[name=recoTitle]").blur(function(){
		var target = $(this);
		var isValid = target.val().trim().length > 0;
		
		valid.recoTitleValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	
	$("[name=recoLocation]").change(function(){
		var target = $(this);
		var isValid = target.val().length > 0;
		
		valid.recoLocationValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	$("[name=recoSeason]").change(function(){
		var target = $(this);
		var isValid = target.val().length > 0;
		
		valid.recoSeasonValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	
	$("[name=recoTheme]").change(function(){
		var target = $(this);
		var isValid = target.val().length > 0;
		
		valid.recoThemeValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	$(".write-form").submit(function(e){
		valid.recoContentValid = $("[name=recoContent]").val().length > 0;
		valid.recoAddrValid = $("[name=recoAddr]").val().length > 0;
		console.log(valid.recoAddrValid);
		if (valid.isAllValid() == false){
			confirm("모든 항목을 입력하세요")
			return false;
		}
		return true;
	});
});