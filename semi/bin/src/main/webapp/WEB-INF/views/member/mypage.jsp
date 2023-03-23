<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-600">
        <div class="row center">
            <h1>마이페이지</h1>
        </div>

        <div class="center">
            <img width="200" height="200" src="/static/image/usericon.jpg/">
        </div>

        <div class="row center">
            <table class="table table-border">
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

        <div class="row">
            <a href="#" class="form-btn neutral">비밀번호 변경</a>
            <a href="/member/edit" class="form-btn neutral">개인정보 변경</a>
            <a href="/member/exit" class="form-btn negative">회원 탈퇴</a>
        </div>

    </div>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
