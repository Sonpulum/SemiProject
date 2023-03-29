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
    <link rel="stylesheet" type="text/css" href="/static/css/load.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    
    <link rel="stylesheet" type="text/css" href="/static/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/static/css/layout.css">
    <link rel="stylesheet" type="text/css" href="/static/css/commons.css">
    <link rel="stylesheet" type="text/css" href="/static/css/test.css">
  
    <script src="https://cdn.jsdelivr.net/gh/sonpulum/confirm-link@0.0.1/confirm-link.js"></script>
    
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
    <style>
   
    </style>
</head>
<body>
    <!--
        홈페이지를 만들 때 시맨틱 태그(semantic tag)를 사용하여 의미있게 구현
    -->
    <main>
        <header>
            <div class="flex-box">
                <div class="row w-10 center">
                   <a href="/">
                    <img src="/static/image/backpack.png" alt="배낭 챙겨" width="80px" height="80px" class="pb-10">
                   </a>
                </div>
                <div class="row w-15 center">
                    <h1 class="mt-5 me-20">배낭챙겨</h1>
                </div>
                <div class="row center">
                   <input type="search" class="form-input" placeholder="검색">
                </div>
              <nav class="mt-10">
                 <!-- 메뉴를 상태에 따라 다르게 나오도록 처리 -->
                  <ul class="menu">
                      <li class="center"><a>추천</a>
                         <ul style="border: 1px solid black;  border-radius: 20px;">
                            <li style="border-radius: 20px;"><a href="/recommend/list?column=reco_location&keyword=수도권">지역</a></li>
                            <li><a href="/recommend/list?column=reco_season&keyword=봄">계절</a></li>
                            <li style="border-radius: 20px;"><a href="/recommend/list?column=reco_theme&keyword=관광">테마</a></li>
                         </ul>
                         </li>
                      <li class="center"><a href="/review/list">후기</a></li>
                      <li class="center"><a href="/qna/list">Q&A</a></li>
                      
                  <li class="center"><a>회원메뉴</a>
                    <ul style="border: 1px solid black; width:100px; border-radius: 20px;">
                       <!-- 로그아웃 상태 -->
                       <c:if test="${memberId == null }">
                        <li class="center" style="border-radius: 20px;"><a href="/member/login">로그인</a></li>
                        <li class="center" style="border-radius: 20px; width:100px;"><a href="/member/join">회원가입</a></li>
                       <!-- 로그인 상태 -->
                       </c:if>
                       <c:if test="${memberId !=null }">
                        <li class="center" style="border-radius: 20px; width:100px;"><a href="/member/logout">로그아웃</a></li>
                        <li class="center" style="border-radius: 20px;"><a href="/member/mypage">내정보</a></li>
                       </c:if>
                    </ul>
                </li>
             </ul>
          </nav>
            </div>
        </header>
        <section>
            <article>