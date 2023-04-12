<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/list.css">

<style>

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
	     
	      .container-600 { 
             width: 700px; 
             height: 100%; 
             background-color: #ffffff; 
             border: 1px solid #ebebeb; 
             margin: 100px auto; 
             box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); 
             border-radius: 5px; 
             padding : 10px 80px 80px 80px;  
             margin-top: 0px; 
             margin-bottom: 0px
         } 
	 
	 	.table.table-border > tbody {
			border-bottom : 2px solid gray;
			border-top : 2px solid gray;
		}    
	 
		/* 
		    마지막 줄은 제외하고 하려면 :not(선택자)를 붙인다
		*/
	
	</style>

<div class="container-600">
	<div class="row center">
		<h1>My Page</h1>
	</div>
	
	
        <div class="row center mt-20">
            <table class="table table-border">
                <tbody>
               <tr>
                	<td colspan="2">
			        <c:choose>
						<c:when test="${profile.attachmentNo != null}">
					   		<img class="image image-circle" width="200" height="200" src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${profile.attachmentNo}">
						</c:when>
						<c:otherwise>
			       			<img  width="200" height="200" src="${pageContext.request.contextPath}/static/image/usericon.jpg" >
						</c:otherwise>
					</c:choose>
					</td>
              </tr>
                    
                    <tr>
                        <th>아이디</th>
                        <td>${memberDto.memberId}</td>
                    </tr>
                    <tr>
                        <th>닉네임</th>
                        <td>${memberDto.memberNick}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td>${memberDto.memberTel}</td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td>${memberDto.memberBirth}</td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>${memberDto.memberEmail}</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>[${memberDto.memberPost}]
                            ${memberDto.memberBasicAddr}
                            ${memberDto.memberDetailAddr}
                        </td>
                    </tr>
                    <tr>
                        <th>회원등급</th>
                        <td>${memberDto.memberLevel}</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="row center mt-20">
            <a href="${pageContext.request.contextPath}/member/password" class="form-btn2">비밀번호 변경</a>
            <a href="${pageContext.request.contextPath}/member/edit" class="form-btn2">개인정보 변경</a>
        </div>
        
        <div class="row center">
            <a href="${pageContext.request.contextPath}/member/exit" class="form-btn negative">회원 탈퇴</a>
        </div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
