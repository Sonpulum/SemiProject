<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>    

<c:if test="${sessionScope.memberId != null}">
   <link rel="stylesheet" type="text/css" href="/static/css/qna-like.css">
   <script src="/static/js/qna-like.js"></script>
</c:if>

<link rel="stylesheet" type="text/css" href="/static/css/reply.css">

<style>
    .form-input {
        font-size: 18px;
        padding: 0.5em;
        outline: none;/*선택 시 강조 효과 제거*/
        border: 1px solid #636e72;
        border-radius: 0.5em;
    }
    .form-btn{
        font-size: 20px;
        border-radius:0.5em;
    }
    .form-btn.qna{
        background-color: rgb(64, 165, 187);
           border-color: rgb(64, 165, 187);
           color: white;
    }
    .writer {
    display: flex;
    align-items: center;
	}
</style>

<script>
   var memberId = "${sessionScope.memberId}";
   var qnaWriter = "${qnaDto.qnaWriter}";
</script>

<script type="text/template" id="reply-template">
   <div class="reply-item">
      <div class="replyWriter">?</div>
      <div class="replyContent">?</div>
      <div class="replyTime">?</div>
   </div>
</script>

<form action="detail" method="post" enctype="multipart/form-data">
<div class="container-800">

   <div class="row center">
      <h1>${qnaDto.qnaNo}번 게시글</h1>
   </div>

	<table class="table table-slit">
	   <tbody>
	      <tr>
	         <td>
	            <h2>${qnaDto.qnaTitle}</h2>
	         </td>
	      </tr>
	      <tr>
	         <td class="writer">
				<c:choose>
					<c:when test="${memberProfile.attachmentNo != null}">
						<img class="me-10" width="90" height="90" src="/attachment/download?attachmentNo=${memberProfile.attachmentNo}">
						${qnaDto.qnaWriter}
					</c:when>
					<c:otherwise>
		       			<img class="me-10" width="90" height="90" src="/static/image/usericon.jpg">
			            ${qnaDto.qnaWriter}
					</c:otherwise>
				</c:choose>
	         </td>
	      </tr>
	      <tr>
	         <td>
	            <fmt:formatDate value="${qnaDto.qnaTime}"
	                        pattern = "y년 M월 d일 H시 m분 s초"/>
	            <i class="fa-regular fa-eye"></i>	${qnaDto.qnaRead}
	         </td>
	      </tr>
	      <tr height="150" valign="top">
	         <td>${qnaDto.qnaContent}</td>
	      </tr>
	   </tbody>
	</table>
	
	<div class="row right">
		<a href="/qna/write" class="form-btn qna">글쓰기</a>
		
		<c:if test="${admin}">
			<a href="/qna/write?qnaParent=${qnaDto.qnaNo}" class="form-btn qna">답글쓰기</a>
		</c:if>
		<!--  내가 작성한 글이라면 수정과 삭제 메뉴를 출력 -->
		<c:if test="${owner}">
			<a href="/qna/edit?qnaNo=${qnaDto.qnaNo}" class="form-btn qna">수정</a>
		</c:if>
		
		<c:if test="${owner || admin}">
			<a href="/qna/delete?qnaNo=${qnaDto.qnaNo}" class="form-btn negative">삭제</a>
		</c:if>
		
		<a href="/qna/list" class="form-btn neutral">목록보기</a>
	</div>
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>