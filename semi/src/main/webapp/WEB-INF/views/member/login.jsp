<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/load.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/commons.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/layout.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/login.css">
    
	<script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
    
    <title>배낭챙겨 로그인</title>

    <!-- 카카오 스크립트 -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    
    <script>
    Kakao.init('30793f867a8e7d238c5db229c3254f87'); //발급받은 키 중 javascript키를 사용해준다.
    console.log(Kakao.isInitialized()); // sdk초기화여부판단
    //카카오로그인
    function kakaoLogin() {
		  Kakao.Auth.login({
		    success: function(authObj) {
		      console.log(authObj);
		      // 사용자 인증 정보가 담긴 authObj를 이용하여 사용자 정보를 요청합니다.
		      Kakao.API.request({
		        url: '/v2/user/me',
		        success: function(response) {
		          console.log(response);
		          window.location.href = "http://localhost:8080";
		        },
		        fail: function(error) {
		          console.log(error);
		        }
		      });
		    },
		    fail: function(error) {
		      console.log(error);
		    }
		  });
		}
    </script>

       <script>
       
       //기존 로그인 상태를 가져오기 위해 Facebook에 대한 호출
       function statusChangeCallback(res){
           statusChangeCallback(response);
       }
       
       function fnFbCustomLogin(){
           FB.login(function(response) {
               if (response.status === 'connected') {
                   FB.api('/me', 'get', {fields: 'name,email'}, function(r) {
                       console.log(r);
                   })
               } else if (response.status === 'not_authorized') {
                   // 사람은 Facebook에 로그인했지만 앱에는 로그인하지 않았습니다.
                   alert('앱에 로그인해야 이용가능한 기능입니다.');
               } else {
                   // 그 사람은 Facebook에 로그인하지 않았으므로이 앱에 로그인했는지 여부는 확실하지 않습니다.
                   alert('페이스북에 로그인해야 이용가능한 기능입니다.');
               }
           }, {scope: 'public_profile,email'});
       }
       
       window.fbAsyncInit = function() {
           FB.init({
               appId      : '1588150011384568', // 내 앱 ID를 입력한다.
               cookie     : true,
               xfbml      : true,
               version    : 'v10.0'
           });
           FB.AppEvents.logPageView();   
       };
       </script>
       
       <!--반드시 중간에 본인의 앱아이디를 입력하셔야 합니다.-->
       <script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v10.0&appId=941166163991367" nonce="SiOBIhLG"></script>

<script>

    //처음 실행하는 함수
    function init() {
        gapi.load('auth2', function() {
            gapi.auth2.init();
            options = new gapi.auth2.SigninOptionsBuilder();
            options.setPrompt('select_account');
            // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
            options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
            // 인스턴스의 함수 호출 - element에 로그인 기능 추가
            // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
            gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
        })
    }
    //구글
    function onSignIn(googleUser) {
        var access_token = googleUser.getAuthResponse().access_token
        $.ajax({
            // people api를 이용하여 프로필 및 생년월일에 대한 선택동의후 가져온다.
            url: 'https://people.googleapis.com/v1/people/me'
            // key에 자신의 API 키를 넣습니다.
            , data: {personFields:'birthdays', key:'AIzaSyAYMpUnMM2iuHIVoPiXw3-DT6OuweXGTJQ', 'access_token': access_token}
            , method:'GET'
        })
        .done(function(e){
            //프로필을 가져온다.
            var profile = googleUser.getBasicProfile();
            console.log(profile)
        })
        .fail(function(e){
            console.log(e);
        })
    }
    function onSignInFailure(t){      
        console.log(t);
    }
    </script>
    <!-- 구글 api 사용을 위한 스크립트 -->
    <script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
    <meta name ="google-signin-client_id" content="382732998478-uf7a6jkl2hakvbtcfbksepjqgp98n0j1.apps.googleusercontent.com">
</head>
<body>
<div class="container pt-30">
    <div class="logo">
        <a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/static/image/backpack.png" alt="배낭 챙겨"></a>
    </div>
    <form class="form center" style="padding: 0px;">
        <div class="line row center">
            <p1>SNS 간편 로그인</p1>
        </div>
    </form>
    <div style="display: flex; justify-content: center; align-items: center; display: flex; flex-direction: row;">
<!--     <div onclick="kakaoLogin();" class="p-10"> -->
    <div class="p-10">
        <a href="javascript:void(0)">
                <img src="${pageContext.request.contextPath}/static/image/kakao.png" alt="카카오 로그인">
        </a>
      </div>
<!--       <div onclick="fnFbCustomLogin();" class="p-10"> -->
      <div class="p-10">
        <a href="javascript:void(0)">
               <img src="${pageContext.request.contextPath}/static/image/facebook.png" alt="페이스북 로그인">    
        </a>
       </div>
<!--         <div id="GgCustomLogin" class="p-10"> -->
        <div class="p-10">
         <a href="javascript:void(0)">
            <img src="${pageContext.request.contextPath}/static/image/google.png" alt="구글 로그인">
         </a>
        </div>
       </div>
       <form class="form center"style="padding: 0px;" >
        <div class="line row center">
            <p1>이메일 주소로 로그인</p1>
        </div>
    </form>
    <form class="form" action="login" method="post">
        <input type="text" name="memberId" placeholder="아이디">
        <input type="password" name="memberPw" placeholder="비밀번호">
      <c:if test="${param.mode == 'error'}">
         <h5 class="row center" style=color:red>아이디 또는 비밀번호를 잘못 입력했습니다. 
         입력하신 내용을 다시 확인해주세요.</h5>
      </c:if>
        <button type="submit">로그인</button>
        <p><a href="find">아이디</a><span style = "color :rgb(64, 165, 187);"> / </span><a href="findPw">비밀번호 찾기</a></p>
        <p><a href="join">회원가입</a></p>
    </form>
</div>
</body>
</html>