<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/static/js/recommend-write.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/static/js/recommend-find-address.js"></script>

<script type="text/javascript">
    $(function(){
        $('[name=recoContent]').summernote({
            placeholder: '내용을 입력해주세요',
            tabsize: 4,
            height: 600,
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture']]
            ],
            callbacks: {
				onImageUpload: function(files) {
					if(files.length != 1) return;
					
					//console.log("비동기 파일 업로드 시작");
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
							var input = $("<input>").attr("type", "hidden")
																.attr("name", "attachmentNo")
																.val(response.attachmentNo);
							$("form").prepend(input);

							var imgNode = $("<img>").attr("src", "/rest/attachment/download/"+response.attachmentNo);
							$("[name=recoContent]").summernote('insertNode', imgNode.get(0));
						},
						error:function(){}
					});
					
				}
			}
        });
    });
</script>


<form action="edit" method="post" autocomplete="off">
<input type="hidden" name="recoNo" value="${recoDto.recoNo}">
<div class="container-800">
    <div class="row mb-40">      
        <input name="recoTitle" value="${recoDto.recoTitle}" class="form-input w-50 me-10" type="text">
        <c:choose>
        	<c:when test="${recoDto.recoLocation == '수도권'}">
		        <select name="recoLocation" class="form-input w-15">
		            <option value="">지역</option>
		            <option value="수도권" selected>수도권</option>
		            <option value="강원도">강원도</option>
		            <option value="충청도">충청도</option>
		            <option value="전라도">전라도</option>
		            <option value="경상도">경상도</option>
		            <option value="제주">제주</option>
		        </select>
        	</c:when>
        	<c:when test="${recoDto.recoLocation == '강원도'}">
		        <select name="recoLocation" class="form-input w-15">
		            <option value="">지역</option>
		            <option value="수도권">수도권</option>
		            <option value="강원도" selected>강원도</option>
		            <option value="충청도">충청도</option>
		            <option value="전라도">전라도</option>
		            <option value="경상도">경상도</option>
		            <option value="제주">제주</option>
		        </select>
        	</c:when>
        	<c:when test="${recoDto.recoLocation == '충청도'}">
		        <select name="recoLocation" class="form-input w-15">
		            <option value="">지역</option>
		            <option value="수도권">수도권</option>
		            <option value="강원도">강원도</option>
		            <option value="충청도" selected>충청도</option>
		            <option value="전라도">전라도</option>
		            <option value="경상도">경상도</option>
		            <option value="제주">제주</option>
		        </select>
        	</c:when>
        	<c:when test="${recoDto.recoLocation == '전라도'}">
		        <select name="recoLocation" class="form-input w-15">
		            <option value="">지역</option>
		            <option value="수도권">수도권</option>
		            <option value="강원도">강원도</option>
		            <option value="충청도">충청도</option>
		            <option value="전라도" selected>전라도</option>
		            <option value="경상도">경상도</option>
		            <option value="제주">제주</option>
		        </select>
        	</c:when>
        	<c:when test="${recoDto.recoLocation == '경상도'}">
		        <select name="recoLocation" class="form-input w-15">
		            <option value="">지역</option>
		            <option value="수도권">수도권</option>
		            <option value="강원도">강원도</option>
		            <option value="충청도">충청도</option>
		            <option value="전라도">전라도</option>
		            <option value="경상도" selected>경상도</option>
		            <option value="제주">제주</option>
		        </select>
        	</c:when>
        	<c:when test="${recoDto.recoLocation == '제주'}">
		        <select name="recoLocation" class="form-input w-15">
		            <option value="">지역</option>
		            <option value="수도권">수도권</option>
		            <option value="강원도">강원도</option>
		            <option value="충청도">충청도</option>
		            <option value="전라도">전라도</option>
		            <option value="경상도">경상도</option>
		            <option value="제주" selected>제주</option>
		        </select>
        	</c:when>
        </c:choose>
        <c:choose>
        	<c:when test="${recoDto.recoSeason == '봄'}">
		        <select name="recoSeason" class="form-input w-15">
		            <option value="">계절</option>
		            <option value="봄" selected>봄</option>
		            <option value="여름">여름</option>
		            <option value="가을">가을</option>
		            <option value="겨울">겨울</option>
		        </select>
	        </c:when>
	        <c:when test="${recoDto.recoSeason == '여름'}">
		        <select name="recoSeason" class="form-input w-15">
		            <option value="">계절</option>
		            <option value="봄">봄</option>
		            <option value="여름" selected>여름</option>
		            <option value="가을">가을</option>
		            <option value="겨울">겨울</option>
		        </select>
	        </c:when>
	        <c:when test="${recoDto.recoSeason == '가을'}">
		        <select name="recoSeason" class="form-input w-15">
		            <option value="">계절</option>
		            <option value="봄">봄</option>
		            <option value="여름">여름</option>
		            <option value="가을" selected>가을</option>
		            <option value="겨울">겨울</option>
		        </select>
	        </c:when>
	        <c:when test="${recoDto.recoSeason == '겨울'}">
		        <select name="recoSeason" class="form-input w-15">
		            <option value="">계절</option>
		            <option value="봄">봄</option>
		            <option value="여름">여름</option>
		            <option value="가을">가을</option>
		            <option value="겨울" selected>겨울</option>
		        </select>
	        </c:when>
        </c:choose>
        <c:choose>
        	<c:when test="${recoDto.recoTheme == '레저'}">
		        <select name="recoTheme" class="form-input w-15">
		            <option value="">테마</option>
		            <option value="레저" selected>레저</option>
		            <option value="관광">관광</option>
		            <option value="식도락">식도락</option>
		        </select>
        	</c:when>
        </c:choose>
        <c:choose>
        	<c:when test="${recoDto.recoTheme == '관광'}">
		        <select name="recoTheme" class="form-input w-15">
		            <option value="">테마</option>
		            <option value="레저">레저</option>
		            <option value="관광" selected>관광</option>
		            <option value="식도락">식도락</option>
		        </select>
        	</c:when>
        </c:choose>
        <c:choose>
        	<c:when test="${recoDto.recoTheme == '식도락'}">
		        <select name="recoTheme" class="form-input w-15">
		            <option value="">테마</option>
		            <option value="레저">레저</option>
		            <option value="관광">관광</option>
		            <option value="식도락" selected>식도락</option>
		        </select>
        	</c:when>
        </c:choose>
    </div>
    <div class="row">
        <input type="text" name="recoAddr"
            class="form-input w-75 me-30" value="${recoDto.recoAddr}" placeholder="주소를 검색하세요" readonly>
        <button type="button" class="form-btn positive find-address-btn">주소 찾기</button>
        <button type="button" class="form-btn negative clear-address-btn"><i class="fa-solid fa-eraser"></i></button>
    </div>
    <div class="row">
        <textarea name="recoContent">${recoDto.recoContent}</textarea>
    </div>
    <div class="row right">
        <a href="list" class="form-btn neutral me-10">목록으로</a>
        <button type="submit" class="form-btn positive">수정하기</button>
    </div>
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>