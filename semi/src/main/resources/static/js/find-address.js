/**
 * 우편번호 찾기 주소 구현
 * 만든 날짜 : 20230310
 */
    
    //화면이 로드되면 .find-address-btn을 찾아서 이벤트를 설정하도록 구현
    window.addEventListener("load", function(){

        //괄호를 사용하면 내가 부르는 것
        // document.querySelector(".find-address-btn")
        //         .addEventListener("click", function(){
        //     findAddress();
        // });

        //괄호를 사용하지 않으면 너가 부르는 것
        document.querySelector(".find-address-btn")
                .addEventListener("click", findAddress);

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
    
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.querySelector('[name=memberPost]').value = data.zonecode;
                    document.querySelector("[name=memberBasicAddr]").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.querySelector("[name=memberDetailAddr]").focus();
                }
            }).open();
        }
    });