<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	     
	     .table.table-slit {
		    border-collapse: collapse;
		    border-top: 4px black double;
		    border-bottom: 4px black double;
		}
		.table.table-slit > thead {
		    border-bottom: 4px black double;
		}
		.table.table-slit > tfoot {
		    border-top: 4px black double;
		}
		/* 
		    마지막 줄은 제외하고 하려면 :not(선택자)를 붙인다
		*/
		.table.table-slit > tbody > tr:not(:last-child) {
		    border-bottom: 1px black dotted;
		}
	</style>

<div class="container-600">
	<div class="empty"></div>
	<div class="row center">
		<h1>My Page</h1>
	</div>
	
	<hr>
	
	<div class="row center">
        <c:choose>
			<c:when test="${profile.attachmentNo != null}">
		   		<img width="200" height="200" src="/attachment/download?attachmentNo=${profile.attachmentNo}">
			</c:when>
			<c:otherwise>
       			<img width="200" height="200" src="/static/image/usericon.jpg">
			</c:otherwise>
		</c:choose>
	</div>
	
        <div class="row center">
            <table class="table table-slit">
                <tbody>
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

        <div class="row center">
            <a href="/member/password" class="form-btn2">비밀번호 변경</a>
            <a href="/member/edit" class="form-btn2">개인정보 변경</a>
        </div>
        
        <div class="row center">
            <a href="/member/exit" class="form-btn negative">회원 탈퇴</a>
        </div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
