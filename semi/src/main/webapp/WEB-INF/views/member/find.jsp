<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/find.css">

<style>
h2 {
            font-size: 15px;
        }
</style>

<body>
    <div class="container-500">
        <div class="row left">
           <h1>아이디 찾기</h1>
           <h3>알맞은 정보를 입력해주세요.</h3>
         </div>
         <hr>
        <div class="row center">
           <form action="find" method="post">
                <div class="row">
                    <label class="form-label left">닉네임</label>
                    <input type ="text" name="memberNick" required class="form-input w-75"><br>
                </div>
                <div class="row">
                    <label class="form-label left">전화번호</label>
                    <input type ="tel" name="memberTel" required class="form-input w-75"><br>
                </div>
                <div class="row">
                    <label class="form-label left">생년월일</label>
                    <input type ="date" name="memberBirth" required class="form-input w-75"><br><br>
                </div>
              
                <div class="row center">
                    <button type="submit" class="form-btn2 w-75">아이디 찾기</button>
                 </div>
                 <div class="row center">
                    <a href="login" class="form-btn1 w-75">로그인 페이지로 이동</a>
                 </div>
                 
           </form>
        </div>
        <!-- 오류가 발생한 경우 보여줄 메세지 -->
   <div class="row center">
      <c:if test="${param.mode == 'error'}">
         <h2 style=color:red>일치하는 정보가 존재하지 않습니다</h2>
      </c:if>
   </div>
   </div>
</body>
</html>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>