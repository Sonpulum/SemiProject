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
                <div class="row w-10">
                    <img src="https://via.placeholder.com/70x70?text=LOGO" alt="로고">
                </div>
                <div class="row w-15">
                    <h1>배낭챙겨</h1>
                </div>
                <div class="row">
                	<input type="search" class="form-input" placeholder="검색">
                </div>
		        <nav>
		        	<!-- 메뉴를 상태에 따라 다르게 나오도록 처리 -->
		            <ul class="menu">
		                <li><a href="#">추천</a>
		                	<ul>
		                		<li><a href="#">지역</a></li>
		                		<li><a href="#">계절</a></li>
		                		<li><a href="#">테마</a></li>
		                	</ul>
		                	</li>
		                <li><a href="#">후기</a></li>
		                <li><a href="#">Q&A</a></li>
		            </ul>
		        </nav>
		        <div class="row">
	            	<a href="#" class="form-btn neutral">로그인</a>
            	</div>
            </div>
        </header>
        <section>
            <article>