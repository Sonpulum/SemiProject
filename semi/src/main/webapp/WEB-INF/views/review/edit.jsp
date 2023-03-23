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

<form action="edit" method="post" autocomplete="off">
<input type="hidden" name="reviewNo" value="${reviewDto.reviewNo}">

<div class="container-800">

	<!-- 말머리 -->
	<div class="row">
		<label class="form-label">지역</label>
		<select class="form-input" name="reviewLocation">
			<option value="">없음</option>
			<option>수도권</option>
			<option>강원도</option>
			<option>충청도</option>
			<option>경상도</option>
			<option>전라도</option>
			<option>제주도</option>
		</select>
		
		<label class="form-label">계절</label>
		<select class="form-input" name="reviewSeason">
			<option value="">없음</option>
			<option>봄</option>
			<option>여름</option>
			<option>가을</option>
			<option>겨울</option>
		</select>

		<label class="form-label">테마</label>
		<select class="form-input" name="reviewTheme">
			<option value="">없음</option>
			<option>레저</option>
			<option>관광</option>
			<option>식도락</option>
		</select>
	</div>
	
	<!-- 제목 -->
	<div class="row">
		<label class="form-label w-100">제목</label>
		<input class="form-input w-100" type="text" name="reviewTitle" value="${reviewDto.reviewTitle}" required>
	</div>
	
	<div class="row">
		<label class="form-label w-100">내용</label>
		<textarea class="form-input w-100" name="reviewContent" style=min-height:20em; required>${reviewDto.reviewContent}</textarea>
	</div>
	
	<div class="row right">
		<button type="submit" class="form-btn positive">수정하기</button>
	</div>
</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>