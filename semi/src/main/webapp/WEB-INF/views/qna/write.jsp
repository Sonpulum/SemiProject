<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

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
</style>

<script type="text/javascript">
    $(function(){
        $('[name=qnaContent]').summernote({
            placeholder: '내용을 작성하세요',
            tabsize: 4,//탭키를 누르면 띄어쓰기 몇 번 할지
            height: 300,//최초 표시될 높이(px)
            toolbar: [//메뉴 설정
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture', /*'video'*/]],
                //['view', ['fullscreen', 'codeview', 'help']]
            ],
         callbacks: {
            onImageUpload: function(files) {
               // upload image to server and create imgNode...
               //$summernote.summernote('insertNode', imgNode);
               if(files.length != 1) return;
               
               //console.log("비동기 파일 업로드 시작")
               //1. FormData 2. processdata 3.contentType
               var fd = new FormData();
               fd.append("attach", files[0]);
               
               $.ajax({
                  url:"${pageContext.request.contextPath}/rest/attachment/upload",
                  method:"post",
                  data:fd,
                  processData:false,
                  contentType:false,
                  success:function(response){
                     //서버로 전송할 이미지 번호 정보 생성
                     var input = $("<input>").attr("type", "hidden")
                                       .attr("name", "attachmentNo")
                                       .val(response.attachmentNo);
                     
                     $("form").prepend(input);
                     
                     //에디터에 추가할 이미지 생성
                     var imgNode = $("<img>").attr("src", "${pageContext.request.contextPath}/rest/attachment/download/" + response.attachmentNo);
                     //var imgNode = $("<img>").attr("src", "/rest/attachment/download?attachmentNo" + response.attachmentNo);
                     $("[name=qnaContent]").summernote("insertNode", imgNode.get(0));
                  },
                  error:function(){
                     window.alert("통신 오류 발생");
                  }
               });
            }
         }
        });
        $(".write-form").submit(function(e){
        	var titleValid = $("[name=qnaTitle]").val().length > 0;
    		var contentValid = $("[name=qnaContent]").val().length > 0;
    		var isAllValid = titleValid && contentValid;
    		
    		if (isAllValid == false){
    			alert("모든 항목을 입력하세요")
    			return false;
    		}
    		
    		if ($("[name=qnaTitle]").val().length >100){
    			alert("제목은 100글자 이하로 작성하세요");
    			return false;
    		}
    		return true;
    	});
    });
</script>
    
<form action="write" class="write-form" method="post" name="content">
	<c:if test="${qnaParent != null}">
		<input type="hidden" name="qnaParent" value="${qnaParent}">
	</c:if>
	<div class="container-800">
		<div class="row center mb-30">
			<c:choose>
				<c:when test="${qnaParent == null}">
					<h1>Q&A 게시글 작성</h1>
					<h5>양식에 맞게 작성해주세요</h5>
				</c:when>
				<c:otherwise>
					<h1>Q&A 답글 작성</h1>
					<h5>양식에 맞게 작성해주세요</h5>
				</c:otherwise>
			</c:choose>
		</div>
		
		<div class="row right">
			
		</div>
		
		<div class="row">
			<label class="form-label w-100">카테고리</label>
			<select name="qnaHead" class="form-input">
				<option value="">없음</option>
				<c:if test="${memberLevel == '관리자'}">
					<option>공지</option>
				</c:if>
				<option>질문</option>
				<option>회원</option>
				<option>혜택/이벤트</option>
				<option>제휴/서비스</option>
				<option>기타</option>
			</select>
			<input type="checkbox" name="qnaSecret">비밀글
		</div>
		
		<div class="row">
			<c:choose>
				<c:when test="${qnaParent == null}">
					<input type="text" name="qnaTitle" placeholder="제목을 입력하세요" autocomplete="off" class="form-input w-100">
				</c:when>
				<c:otherwise>
					<input type="text" name="qnaTitle" placeholder="제목을 입력하세요" autocomplete="off" class="form-input w-100">
				</c:otherwise>
			</c:choose>
		</div>

		<div class="row">
			<textarea name="qnaContent" class="form-input w-100"></textarea>
		</div>
		<div class="row right">
			<a type="submit" href="${pageContext.request.contextPath}/qna/list" class="form-btn neutral me-10">목록으로</a>
			<button type="submit" class="form-btn qna">등록</button>
		</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>