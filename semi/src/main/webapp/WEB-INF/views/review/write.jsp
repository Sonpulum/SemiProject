<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
    $(function(){
        $('[name=reviewContent]').summernote({
            placeholder: '내용 작성',
            tabsize: 4,
            height: 350,
            toolbar: [//메뉴 설정
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture']]
           	],
	        callbacks: {
				onImageUpload: function(files) {
					if(files.length != 1) return;
					
					//[1] FormData [2] processData [3] contentType
					var fd = new FormData();
					fd.append("attach", files[0]);
					
					$.ajax({
						url:"/rest/attachment/upload",
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
	            			var imgNode = $("<img>").attr("src", "/rest/attachment/download/"+response.attachmentNo);
	            			//이미지 추가 명령
	            			$("[name=reviewContent]").summernote('insertNode', imgNode.get(0));
						},
	            		error:function(){}
	            	});
	            	
	            }
	       	}
        });
    });
</script>


<form action="write" method="post" autocomplete="off">
<div class="container-800">
	<div class="row">
		<label class="form-label w-100">제목</label>
		<input class="form-input w-100" type="text" name="reviewTitle" required>
	</div>
	
	<div class="row">
		<label class="form-label w-100">내용</label>
		<textarea class="form-input w-100" name="reviewContent" style=min-height:20em; required></textarea>
	</div>
	
	<div class="row right">
		<button type="submit" class="form-btn neutral">목록으로</button>
		<button type="submit" class="form-btn positive">등록하기</button>
	</div>
</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>