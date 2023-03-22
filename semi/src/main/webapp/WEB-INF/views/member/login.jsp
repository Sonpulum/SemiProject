<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
        body {
            background-color: #f6f6f6;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .container {
            width: 350px;
            background-color: #ffffff;
            border: 1px solid #ebebeb;
            margin: 100px auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        .logo {
            text-align: center;
            margin-top: 50px;
        }

        .logo img {
            width: 100px;
            height: 100px;
        }

        .form {
            padding: 20px;
        }

        .form input {
            width: 100%;
            border: none;
            border-bottom: 1px solid #d9d9d9;
            padding: 10px 0;
            margin: 10px 0;
            font-size: 16px;
        }

        .form button {
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: rgb(64, 165, 187);
            color: #ffffff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .form p {
            text-align: center;
            margin-top: 20px;
        }

        .form a {
            color: rgb(64, 165, 187);
            text-decoration: none;
        }

        .form a:hover {
            text-decoration: underline;
        }
    </style>
    <body>
<div class="container">
    <div class="logo">
        <img src="/static/image/backpack.jpg" alt="배낭 챙겨">
    </div>
    <form class="form" action="/member/login" method="post" autocomplete="off">
        <input type="text" placeholder="아이디">
        <input type="password" placeholder="비밀번호">
        <button type="submit">로그인</button>
        <p><a href="#">아이디/비밀번호 찾기</a></p>
        <p><a href="/member/join">회원가입</a></p>
        <c:if test="${param.mode == 'error'}">
      <div class="row center" style="color:red;">
         <h4>아이디(로그인 전용 아이디) 또는 비밀번호를 잘못 입력했습니다.입력하신 내용을 다시 확인해주세요.</h4>
      </div>
   </c:if>
    </form>
</div>
</body>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>