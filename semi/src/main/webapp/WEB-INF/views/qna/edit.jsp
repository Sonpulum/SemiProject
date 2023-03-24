<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
            ]
        });
    });
</script>

<div class="container-800">
	<div class="row center">
		<h1>${qnaDto.qnaNo}번 게시글 수정</h1>
	</div>

	<form action="edit" method="post"><br><br>
		<input type="text" name="qnaTitle" value="${qnaDto.qnaTitle}" class="form-input w-100"><br><br>
		<!-- textarea는 value가 없다 -->
		<textarea name="qnaContent" required style="min-height: 500px;" class="form-input w-100">${qnaDto.qnaContent}</textarea>
		<br><br>
		<div class="row right">
			<a type="submit" href="/qna/detail?qnaNo=${qnaDto.qnaNo}" class="form-btn neutral me-10">취소</a>
			<button type="submit" class="form-btn qna">등록</button>
		</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>