$(function(){
	$(".find-address-btn").click(function(){
		findAddress();
	});

	$(".clear-address-btn").click(function(){
		$("[name=recoAddr]").val("");
	});
	
    function findAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                document.querySelector("[name=recoAddr]").value = addr;
            }
        }).open();
    }
	
	 $(".write-form").submit(function(e){
        	var titleValid = $("[name=recoTitle]").val().length > 0;
    		var contentValid = $("[name=recoContent]").val().length > 0;
    		var locationValid = $("[name=recoLocation]").val().length > 0;
    		var seasonValid = $("[name=recoSeason]").val().length > 0;
    		var themeValid = $("[name=recoTheme]").val().length > 0;
    		var addrValid = $("[name=recoAddr]").val().length > 0;
    		var isAllValid = titleValid && contentValid && locationValid && seasonValid && themeValid && addrValid;
    		
    		if (isAllValid == false){
    			alert("모든 항목을 입력하세요")
    			return false;
    		}
    		
    		if ($("[name=reviewTitle]").val().length >100){
    			alert("제목은 100글자 이하로 작성하세요");
    			return false;
    		}
    		return true;
    	});
});