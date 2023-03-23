<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>

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
		제목 : <input type="text" name="qnaTitle" value="${qnaDto.qnaTitle}" class="form-input w-100"><br><br>
		<!-- textarea는 value가 없다 -->
		<textarea name="qnaContent" required style="min-height: 500px;" class="form-input w-100">${qnaDto.qnaContent}</textarea>
		<br><br>
		<button class="form-btn neutral">수정</button>
	</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>