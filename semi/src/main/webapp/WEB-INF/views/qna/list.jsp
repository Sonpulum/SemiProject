<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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
    .thead-color{
    	background-color: rgba(64, 165, 187, 0.16);
    }
    .fa-trash,
    .fa-pen {
    	color: #40a5bb;
    }
    .fa-trash:hover,
    .fa-pen:hover {
    	color: #e05462;
    }
    
	.table.table-border,
	.table.table-border > thead > tr > th,
	.table.table-border > thead > tr > td,
	.table.table-border > tbody > tr > th,
	.table.table-border > tbody > tr > td,
	.table.table-border > tfoot > tr > th,
	.table.table-border > tfoot > tr > td
	{
	    border: 0px solid #636e72;
	}
	
	.table.table-border > thead {
		border-top : 2px solid rgb(64, 165, 187);
		border-bottom : 2px solid gray;
	}
	
	.table.table-border > tbody > tr:last-child {
		border-bottom : 2px solid rgb(64, 165, 187);
	}
	
	.table.table-border > tbody > tr:nth-child(3) {
		border-bottom : 2px solid gray;
	}
	 
	 .container-1000 {
	    width: 1050px;
	    height: 100%;
	    background-color: #ffffff;
	    border: 1px solid #ebebeb;
	    margin: 100px auto;
	    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	    border-radius: 5px;
	    padding : 10px 80px 80px 80px;
	    margin-top: 0px;
	}
	
	body {
    	background-color: #f6f6f6;
	}
</style>

<script type="text/javascript">
	$(function(){
		$("[name=secret]").click(function(e){
			var memberNick = "${sessionScope.memberNick}";
			var memberLevel = "${sessionScope.memberLevel}";
			
			var writer = $(this).parent().next().text();
			
			if(memberLevel == '관리자' || memberNick == writer){
				return true;
			}
			e.preventDefault();
			alert("읽을 권한이 없습니다.");
		});
		
		$("[name=search-form]").submit(function(e){
			var keyword = $("[name=search-form] [name=keyword]");
			keyword.val(keyword.val().trim());
			if (keyword.val() == ''){
				alert("검색어를 입력하세요");
				return false;	
			}
			else if (keyword.val().length >= 20){
				alert("검색어는 20글자 이하여야 합니다");
				return false;
			}
			return true;
		});
	});
</script>

	<div class="container-1000">
		<c:choose>
			<c:when test="${list.size() != 0}">
		<div class="center p-30">
			<h1>궁금한 점이 있으면 물어보세요</h1>
		</div>
	   
		<div class="row right">
			<a href="write" class="form-btn qna">글쓰기</a>
		</div>
	   
		<div class="row center">
			<table class="table">
				<thead>
					<tr>
						<th><a class="link" href="${pageContext.request.contextPath}/qna/list">#전체</a></th>
                        <th><a class="link" href="list?sort=공지">#공지</a></th>
                        <th><a class="link" href="list?sort=질문">#질문</a></th>
                        <th><a class="link" href="list?sort=회원">#회원</a></th>
                        <th><a class="link" href="list?sort=혜택/이벤트">#혜택/이벤트</a></th>
                        <th><a class="link" href="list?sort=제휴/서비스">#제휴/서비스</a></th>
                        <th><a class="link" href="list?sort=기타">#기타</a></th>
					</tr>
				</thead>
			</table>
		</div>

	   <div class="row">
	      <table class="table table-border">
	         <thead>
	            <tr>
	               <th>번호</th>
	               <th>상태</th>
	               <th>제목</th>
	               <th>작성자</th>
	               <th>날짜</th>
	               <th>조회수</th>
	               <c:if test="${sessionScope.memberLevel == '관리자'}">
						<th>관리</th>
	               </c:if>
	            </tr>
	         </thead>
	         
	         <tbody class="center">
	         	<!-- 공지사항을 출력 -->
				<c:forEach var="qnaDto" items="${noticeList}">
					<tr bgcolor="#ebf8fa">
						<td>${qnaDto.qnaNo}</td>
						<td></td>
						<td class="left">
							<a href="detail?qnaNo=${qnaDto.qnaNo}" class="link">
							<c:if test="${qnaDto.qnaHead != null}">
								<i class="me-10"></i>&nbsp;&nbsp;
								<!-- 말머리가 있으면 출력 -->
								[${qnaDto.qnaHead}]
							</c:if>
							${qnaDto.qnaTitle}
							</a>
						</td>
						<td>${qnaDto.memberNick}</td>
						<td>${qnaDto.qnaTimeAuto}</td>
						<td><i class="fa-regular fa-eye"></i>	${qnaDto.qnaRead}</td>
						<c:if test="${sessionScope.memberLevel == '관리자'}">
		                  <td>
		                  	<a href="${pageContext.request.contextPath}/qna/edit?qnaNo=${qnaDto.qnaNo}" class="edit-btn me-10"><i class="fa-sharp fa-solid fa-pen"></i></a>
		                    <a href="${pageContext.request.contextPath}/qna/delete?qnaNo=${qnaDto.qnaNo}" class="delete-btn"><i class="fa-sharp fa-solid fa-trash"></i></a>
		                  </td>
		              	</c:if>
					</tr>
				</c:forEach>
	            <c:forEach var="qnaDto" items="${list}">
	               <tr>
	                  <td>${qnaDto.qnaNo}</td> <!-- 번호 -->
	                  <td> <!-- 답변유무 -->
	                  	<c:choose>
		                  	<c:when test="${qnaDto.qnaAnswer == 0 && qnaDto.qnaParent == null && qnaDto.qnaHead != '공지'}">
		                  		<i class="fa-sharp fa-solid fa-square-xmark" style="color: #e05462"></i>
		                  	</c:when>
		                  	<c:when test="${qnaDto.qnaAnswer > 0 && qnaDto.qnaParent == null && qnaDto.qnaHead != '공지'}">
		                  		<i class="fa-sharp fa-solid fa-square-check" style="color: #40a5bb"></i>
		                  	</c:when>
	                  	</c:choose>
	                  </td>
	                  <td class="left"> <!-- 제목 -->
							<c:forEach var="i" begin="1" end="${qnaDto.qnaDepth}">
								&nbsp;&nbsp;
							</c:forEach>
							<c:choose>
								<c:when test="${qnaDto.qnaDepth > 0}">
									<i class="fa-solid fa-a me-10" style="color: #87abe2;"></i>
								</c:when>
								<c:when test="${qnaDto.qnaHead == '공지'}">
 									<i class="me-10"></i>&nbsp;&nbsp;
								</c:when>
								<c:otherwise>
									<i class="fa-solid fa-q me-10" style="color: #3878db;"></i>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${qnaDto.qnaSecret == true}">
									<a class="link" href="detail?qnaNo=${qnaDto.qnaNo}" name="secret">
										<c:if test="${qnaDto.qnaHead != null}">
											[${qnaDto.qnaHead}]
										</c:if>
										비밀글입니다.
									</a>
									<i class="fa-solid fa-lock" style="color: #40a5bb"></i>
								</c:when>
								<c:when test="${qnaDto.qnaDepth > 0}">
									<a class="link" href="detail?qnaNo=${qnaDto.qnaNo}">
										<c:if test="${qnaDto.qnaHead != null}">
											[${qnaDto.qnaHead}]
										</c:if>
										문의 답변드리겠습니다.
									</a>
								</c:when>
								<c:otherwise>
									<a class="link" href="detail?qnaNo=${qnaDto.qnaNo}">
										<c:if test="${qnaDto.qnaHead != null}">
											[${qnaDto.qnaHead}]
										</c:if>
										${qnaDto.qnaTitle}
									</a>
								</c:otherwise>
							</c:choose>
	                  </td>
	                  <td>${qnaDto.memberNick}</td>
	                  <td>${qnaDto.qnaTimeAuto}</td>
	                  <td><i class="fa-regular fa-eye"></i>		${qnaDto.qnaRead}</td>
	                  <c:if test="${sessionScope.memberLevel == '관리자'}">
		                  <td>
		                  	<a href="${pageContext.request.contextPath}/qna/edit?qnaNo=${qnaDto.qnaNo}" class="edit-btn me-10"><i class="fa-sharp fa-solid fa-pen"></i></a>
		                    <a href="${pageContext.request.contextPath}/qna/delete?qnaNo=${qnaDto.qnaNo}" class="delete-btn"><i class="fa-sharp fa-solid fa-trash"></i></a>
		                  </td>
		              </c:if>
	               </tr>
	            </c:forEach>
	         </tbody>
	      </table>
	   </div>
	
		<!-- 페이지 네비게이터 vo에 있는 데이터를 기반으로 구현 -->
		<div class="row pagination">
		   <!-- 처음 -->
		   <c:choose>
		      <c:when test="${vo.first}">
		         <a class="disabled"><i class="fa-solid fa-angles-left"></i></a>
		      </c:when>
		      <c:otherwise>
		         <a href="list?${vo.parameter}&page=1"><i class="fa-solid fa-angles-left"></i></a>
		      </c:otherwise>
		   </c:choose>
		   
		   <!-- 이전 -->
		   <c:choose>
		      <c:when test="${vo.prev}">
		         <a href="list?${vo.parameter}&page=${vo.prevPage}"><i class="fa-solid fa-angle-left"></i></a>
		      </c:when>
		      <c:otherwise>
		         <a class="disabled"><i class="fa-solid fa-angle-left"></i></a>
		      </c:otherwise>
		   </c:choose>
		   
		   <!-- 숫자 -->
		   <c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
		      <c:choose>
		         <c:when test="${vo.page == i}"><a class="on">${i}</a></c:when>
		         <c:otherwise>
		            <a href="list?${vo.parameter}&page=${i}">${i}</a>
		         </c:otherwise>
		      </c:choose>
		   </c:forEach>
		   
		   <!-- 다음 -->
		   <c:choose>
		      <c:when test="${vo.next}">
		         <a href="list?${vo.parameter}&page=${vo.nextPage}"><i class="fa-solid fa-angle-right"></i></a>
		      </c:when>
		      <c:otherwise>
		         <a class="disabled"><i class="fa-solid fa-angle-right"></i></a>
		      </c:otherwise>
		   </c:choose>
		   
		   <!-- 마지막 -->
		   <c:choose>
		      <c:when test="${vo.last}">
		         <a class="disabled"><i class="fa-solid fa-angles-right"></i></a>
		      </c:when>
		      <c:otherwise>
		         <a href="list?${vo.parameter}&page=${vo.totalPage}"><i class="fa-solid fa-angles-right"></i></a>
		      </c:otherwise>
		   </c:choose>
		</div>
	
		<!-- 페이징 숨김 -->
		<c:if test="${vo.totalPage <= 10}">
			<script>
				document.querySelectorAll('.pagination a.disabled').forEach(el => el.style.display = 'none');
			</script>
		</c:if>
		
		</c:when>
	
		<c:otherwise>
			<div class="row center mb-30">
				<img src="${pageContext.request.contextPath}/static/image/search.png" width=150px; height=150px;>
				<h2>' ${vo.keyword} '에 대한 검색결과가 없습니다.</h2>
				<h1>다른 검색어를 입력하시거나 철자와 띄어쓰기를 확인해 보세요.</h1>
			</div>
		</c:otherwise>
		
	</c:choose>
		
		<!-- 검색창 -->
		<div class="row center">
		   <form action="list" method="get" name="search-form">
		      <c:choose>
		         <c:when test="${vo.column == 'member_nick'}">
		            <select name="column" class="form-input">
		               <option value="qna_title">제목</option>
		               <option value="member_nick" selected>작성자</option>
		            </select>
		         </c:when>
		         <c:when test="${vo.column == 'qna_title'}">
		            <select name="column" class="form-input">
		               <option value="qna_title" selected>제목</option>
		               <option value="member_nick">작성자</option>
		            </select>
		         </c:when>
		         <c:otherwise>
		            <select name="column" class="form-input">
		               <option value="qna_title">제목</option>
		               <option value="member_nick">작성자</option>
		            </select>
		         </c:otherwise>
		      </c:choose>
				
		      <input type="search" name="keyword" placeholder="검색어" class="form-input" value="${vo.keyword}">

		      <button type="submit" class="form-btn qna">검색</button>
		   </form>
		</div>
			
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>