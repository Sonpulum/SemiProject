<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배낭챙겨</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/load.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/layout.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/commons.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css">
  
    <script src="https://cdn.jsdelivr.net/gh/sonpulum/confirm-link@0.0.1/confirm-link.js"></script>
    
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
    
    <!-- favicon 설정 -->
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/static/favicon.ico">
    <script>
    	$(function(){
    		$(".search-icon").on("click",function(){
    			$("[name=total-search-form]").submit();
    		});
    		
    		$("[name=total-search-form]").submit(function(e){
    			var keyword = $("[name=total-search-form] [name=keyword]");
    			keyword.val(keyword.val().trim());
    			if (keyword.val() == ''){
    				alert("검색어를 입력하세요");
    				return false;	
    			}
    			else if (keyword.val().length >= 20){
    				alert("검색어는 20글자 이하여야 합니다");
    				return false;
    			}
    			return true;
    		});
    	});
    </script>
    
</head>
<body>
    <!--
        홈페이지를 만들 때 시맨틱 태그(semantic tag)를 사용하여 의미있게 구현
    -->
    <main>
        <header>
            <div class="flex-box" style="margin:0 auto;">
                <div class="row w-10 center">
                   <a href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/static/image/backpack.png" alt="배낭 챙겨" width="90px" height="80px"style="position:relative; top:-15px;">
                   </a>
                </div>
                <div class="row w-15 center">
                    <h1 class="me-20"><a href="${pageContext.request.contextPath}/" class="link" style="color:#2d3436">배낭챙겨</a></h1>
                </div>
                <div class="row center w-30">
                	<form action="${pageContext.request.contextPath}/search" method="post" name="total-search-form">
	                  	<input name="keyword" type="text" class="form-input search w-100"placeholder="검색어를 입력하세요" autocomplete="off">
	               		<img src="${pageContext.request.contextPath}/static/image/search.png" class="search-icon" width="30px" height="30px">
                  	</form>
                </div>
              <nav class="mt-10 ms-20">
                 <!-- 메뉴를 상태에 따라 다르게 나오도록 처리 -->
                  <ul class="menu">
                      <li class="center"><a href="${pageContext.request.contextPath}/recommend/list">추천</a>
                         <ul style="border: 1px solid black;  border-radius: 20px;">
                            <li style="border-radius: 20px;"><a href="${pageContext.request.contextPath}/recommend/list?column=reco_location&keyword=수도권">지역</a></li>
                            <li><a href="${pageContext.request.contextPath}/recommend/list?column=reco_season&keyword=봄">계절</a></li>
                            <li style="border-radius: 20px;"><a href="${pageContext.request.contextPath}/recommend/list?column=reco_theme&keyword=관광">테마</a></li>
                         </ul>
                         </li>
                      <li class="center"><a href="${pageContext.request.contextPath}/review/list">후기</a></li>
                      <li class="center"><a href="${pageContext.request.contextPath}/qna/list">Q&A</a></li>
                      
                  <li class="center"><a>회원메뉴</a>
                    <ul style="border: 1px solid black; width:100px; border-radius: 20px;">
                       <!-- 로그아웃 상태 -->
                       <c:if test="${memberId == null }">
                        <li class="center" style="border-radius: 20px;"><a href="${pageContext.request.contextPath}/member/login">로그인</a></li>
                        <li class="center" style="border-radius: 20px; width:100px;"><a href="${pageContext.request.contextPath}/member/join">회원가입</a></li>
                       <!-- 로그인 상태 -->
                       </c:if>
                       <c:if test="${memberId !=null }">
                        <li class="center" style="border-radius: 20px; width:100px;"><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
                        <li class="center" style="border-radius: 20px;"><a href="${pageContext.request.contextPath}/member/mypage">내정보</a></li>
                        <c:if test="${sessionScope.memberLevel == '관리자'}">
                        <li class="center" style="border-radius: 20px;"><a href="${pageContext.request.contextPath}/admin/member/list">회원관리</a></li>
                        </c:if>
                       </c:if>
                    </ul>
                </li>
             </ul>
          </nav>
            </div>
        </header>
        <section>
            <article style="padding-left:0px; padding-right:0px;">