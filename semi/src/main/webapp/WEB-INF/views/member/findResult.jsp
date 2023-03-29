<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
        h3 {
            font-size: 10px;
        }

        .form-label {
            display: inline-block;
            margin-left: 13%;
        }

        .form-btn2{
            font-size: 15px;
            padding: 0.5em;
            border-width: 1px;
            border-style: solid;
            border-radius: 0.4em;
            cursor: pointer;
            background-color: rgb(64, 165, 187);
            border-color: rgb(64, 165, 187);
            display: inline-block;
            text-align: center;
            text-decoration: none;
            color: white;
        }
        .form-input{
            border-bottom-color: white;
            border-radius: 0.4em;
            border-color: #c8c8c8;
        }
        .form-label {
            display: block;
        }

    </style>

<body>
    <div class="container-500">
        <div class="empty"></div>
        <div class="row center">
           <h1>아이디 찾기 결과</h1>
        </div>
        <hr>
        <div class="row center">
            <h2>찾으시는 아이디는 ${findId} 입니다.</h2><br><br>
        </div>
        
        <div class="row center">
           <a href="login" class="form-btn2 w-75">로그인</a>
        </div>
     
     </div>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>