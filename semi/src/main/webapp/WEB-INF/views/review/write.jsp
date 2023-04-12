<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
    $(function(){
        $('[name=reviewContent]').summernote({
            placeholder: '내용을 입력해주세요',
            tabsize: 4,
            height: 600,
            toolbar: [
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
					
					var fd = new FormData();
					fd.append("attach", files[0]);
					
					$.ajax({
						url:"${pageContext.request.contextPath}/rest/attachment/upload",
						method:"post",
						data:fd,
						processData:false,
						contentType:false,
						success:function(response){
							var input = $("<input>").attr("type", "hidden")
																.attr("name", "attachmentNo")
																.val(response.attachmentNo);
							$("form").prepend(input);

							var imgNode = $("<img>").attr("src", "${pageContext.request.contextPath}/rest/attachment/download/"+response.attachmentNo);
							$("[name=reviewContent]").summernote('insertNode', imgNode.get(0));
						},
						error:function(){}
					});
					
				}
			}
        });
        
        $(".write-form").submit(function(e){
        	var titleValid = $("[name=reviewTitle]").val().length > 0;
    		var contentValid = $("[name=reviewContent]").val().length > 0;
    		var locationValid = $("[name=reviewLocation]").val().length > 0;
    		var seasonValid = $("[name=reviewSeason]").val().length > 0;
    		var themetValid = $("[name=reviewTheme]").val().length > 0;
    		var isAllValid = titleValid && contentValid && locationValid && seasonValid && themetValid;
    		
    		if (isAllValid == false){
    			alert("모든 항목을 입력하세요")
    			return false;
    		}
    		
    		if ($("[name=reviewTitle]").val().length >100){
    			alert("제목은 100글자 이하로 작성하세요");
    			return false;
    		}
    		return true;
    	});
    });
</script>


<form class="write-form" action="write" method="post" autocomplete="off">
<div class="container-800">
    <div class="row mb-40">
<!--         <label class="form-label w-100">제목</label> -->
        
        <input name="reviewTitle" class="form-input w-50 me-10" type="text" placeholder="제목을 입력해주세요">
        <select name="reviewLocation" class="form-input w-15">
            <option value="">지역</option>
            <option value="수도권">수도권</option>
            <option value="강원도">강원도</option>
            <option value="충청도">충청도</option>
            <option value="전라도">전라도</option>
            <option value="경상도">경상도</option>
            <option value="제주">제주</option>
        </select>
        <select name="reviewSeason" class="form-input w-15">
            <option value="">계절</option>
            <option value="봄">봄</option>
            <option value="여름">여름</option>
            <option value="가을">가을</option>
            <option value="겨울">겨울</option>
        </select>
        <select name="reviewTheme" class="form-input w-15">
            <option value="">테마</option>
            <option value="레저">레저</option>
            <option value="관광">관광</option>
            <option value="식도락">식도락</option>
        </select>
    </div>
    <div class="row">
<!--         <label class="form-label w-100">내용</label> -->
        <textarea name="reviewContent"></textarea>
    </div>
    <div class="row right">
        <a href="/review/list" class="form-btn neutral me-10">목록으로</a>
        <button type="submit" class="form-btn bosung">등록하기</button>
    </div>
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>