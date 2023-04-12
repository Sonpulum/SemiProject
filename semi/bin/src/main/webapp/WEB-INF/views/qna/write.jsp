<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
<script>
	const contextPath = "${pageContext.request.contextPath}";
</script>
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
                  url:contextPath+"/rest/attachment/upload",
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
                     var imgNode = $("<img>").attr("src", "/rest/attachment/download/" + response.attachmentNo);
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
    });
</script>
    
<form action="write" method="post" name="content">
   <%-- 이미지를 첨부하면 첨부한 이미지의 번호를 hidden으로 추가 --%>
   
   <%-- 답글일 때는 정보가 한 개 더 전송되어야 한다(qnaParent) --%>
   <c:if test="${qnaParent != null}">
      <input type="hidden" name="qnaParent" value="${qnaParent}">
   </c:if>
   <div class="container-700 mt-50">
      <div class="row center">
         <c:choose>
            <c:when test="${qnaParent == null}">
               <h2>새글 작성</h2>
            </c:when>
            <c:otherwise>
               <h2>답글 작성</h2>
            </c:otherwise>
         </c:choose>
      </div>

      <div class="row">
         <c:choose>
            <c:when test="${qnaParent == null}">
               <label>제목</label>
               <input type="text" name="qnaTitle" required
                  placeholder="제목을 입력하세요" autocomplete="off"
                  class="form-input w-100">
            </c:when>
            <c:otherwise>
               <label>제목</label>
               <input type="text" name="qnaTitle" required
                  placeholder="제목을 입력하세요" autocomplete="off" value="RE : "
                  class="form-input w-100">
            </c:otherwise>
         </c:choose>
      </div>

      <div class="row">
         <label>내용</label>
         <!-- textarea 디자인 시 cols는 width와 충돌이 발생하므로 하나만 사용
             rows 역시 줄이는 것이 가능하므로 디자인 적인 가치가 별로 없다
          -->
         <textarea name="qnaContent" required class="form-input w-100"></textarea>
      </div>
      <div class="row">
         <button class="form-btn positive w-100">등록</button>
      </div>
   </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>