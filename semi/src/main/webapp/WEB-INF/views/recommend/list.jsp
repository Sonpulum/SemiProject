<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <style>
      .container-900 {
            width: 1050px;
            background-color: #ffffff;
            border: 1px solid #ebebeb;
            margin: 100px auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            padding : 10px 80px 80px 80px;
            margin-top: 0px;
        }
      /* 스타일 코드를 작성합니다. */
      .form {
            padding: 20px;
        
        }

        .form input {
            width: 100%;
            border: none;
            border-bottom: 1px solid #d9d9d9;
            padding: 10px 0;
            margin: 10px 0;
            font-size: 16px;
        }

        .wrapper {
            display: flex;
            justify-content: space-between;
            width: 100%;
          }

          .left {
            width: 50%;
          }

          .write-btn {
            margin-left: 10px;
          }
        .write-btn {
            
            width: 10%;
            padding: 10px;
            margin-top: 20px;
            background-color: rgb(64, 165, 187);
            color: #ffffff;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            text-decoration: none;
            
        }

        .form p {
            text-align: center;
            margin-top: 20px;
        }

        .form a {
            color: rgb(64, 165, 187);
            text-decoration: none;
        }

        .form p1 {
            color: rgb(64, 165, 187);
            text-decoration: none;
            font-weight: bolder;
            
        }

        .form a:hover {
            text-decoration: none;
        }
        .post {
  display: flex;
  align-items: center;
  gap: 16px;

  /* 기존 스타일 유지 */
  
  
}
.table .link{
	font-size:18px;
  }
body {
  background-color: #f6f6f6;
}
.post {
    display: flex;
    align-items: center;
    padding: 10px;
    
}

.post img {
    width: 230px;
    height: 170px;
    margin-right: 10px;
    margin: 20px;
}

.post-content {
    flex: 1;
}

.post-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 20px;
}

.post-header .titleName {
    margin-bottom: 30px;
}

.post-caption {
    margin: 10px;
}

.post-footer {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    font-size: 15px;
}

.post-footer span {
    margin-left: 10px;
}
      h2{
        font-size: 30px;
        display: inline;
        margin-top: 25px;
      }
.boseng{
	height:1px;
	background-color:#40a5bb;
}
    </style>
<!-- 제목 -->
    <div class="container-900">
    <c:choose>
    	<c:when test="${column == 'reco_location'}">
        <div class="row center" style="padding: 30px; font-size: 30px;">
            <h1>
            	<i class="fa-solid fa-map" style="color: #40a5bb;"></i>
            	지역별 추천
           	</h1>
        </div>
    
        <div class="row">
            <table class="table">
                <thead>
                    <tr>
                        <th><a class="link" href="?column=reco_location&keyword=수도권">수도권</a></th>
                        <th><a class="link" href="?column=reco_location&keyword=강원도">강원도</a></th>
                        <th><a class="link" href="?column=reco_location&keyword=충청도">충청도</a></th>
                        <th><a class="link" href="?column=reco_location&keyword=전라도">전라도</a></th>
                        <th><a class="link" href="?column=reco_location&keyword=경상도">경상도</a></th>
                        <th><a class="link" href="?column=reco_location&keyword=제주">제주</a></th>
                    </tr>
                </thead>
            </table>
         </div>
    	</c:when>
    	
    	<c:when test="${column == 'reco_season'}">
        <div class="row center" style="padding: 30px; font-size: 30px;">
            <h1>
            	<i class="fa-solid fa-cloud-sun" style="color: #40a5bb;"></i>
            	계절별 추천
           	</h1>
        </div>
    
        <div class="row">
            <table class="table">
                <thead>
                    <tr>
                        <th><a class="link" href="?column=reco_season&keyword=봄">봄</a></th>
                        <th><a class="link" href="?column=reco_season&keyword=여름">여름</a></th>
                        <th><a class="link" href="?column=reco_season&keyword=가을">가을</a></th>
                        <th><a class="link" href="?column=reco_season&keyword=겨울">겨울</a></th>
                    </tr>
                </thead>
            </table>
         </div>
    	</c:when>
    	<c:when test="${column == 'reco_theme'}">
        <div class="row center" style="padding: 30px; font-size: 30px;">
            <h1>
            	<i class="fa-solid fa-person-swimming" style="color: #40a5bb;"></i>
            	테마별 추천
           	</h1>
        </div>
    
        <div class="row">
            <table class="table">
                <thead>
                    <tr>
                        <th><a class="link" href="?column=reco_theme&keyword=관광">관광</a></th>
                        <th><a class="link" href="?column=reco_theme&keyword=레저">레저</a></th>
                        <th><a class="link" href="?column=reco_theme&keyword=식도락">식도락</a></th>
                    </tr>
                </thead>
            </table>
         </div>
    	</c:when>
    </c:choose>
         
   <div class="wrapper">
          <h2>${keyword}</h2>
          <a href="write" class="write-btn center">글쓰기</a>
        </div>
        <br>
        <hr class="boseng">
        
        <c:forEach var="recoDto" items="${list}">
        	<div class="post">
      			<a href="detail?recoNo=${recoDto.recoNo}">
<!--       				<img src="/static/image/hotel.jpg" alt="게시글 사진"> -->
      				<img src=/rest/attachment/download/${recoDto.attachNo}>
      			</a>
      			<div class="post-content">
          			<div class="post-header">
          				<a class="link" href="detail?recoNo=${recoDto.recoNo}">
              				<span class="titleName">${recoDto.recoTitle}</span>
              			</a>
          			</div>
          			<a class="link" href="detail?recoNo=${recoDto.recoNo}">
          				<span>#${recoDto.recoLocation}</span>
          				<span>#${recoDto.recoSeason}</span>
          				<span>#${recoDto.recoTheme}</span>
          			</a>
         			<div class="post-footer">
                        <span class="comments">
                        	<i class="fa-regular fa-eye"></i>
                        	<span>조회수</span>
                        	<span>${recoDto.recoRead}</span>
                       	</span>
                        <span class="likes">
                        	<i class="fa-regular fa-thumbs-up"></i>
                        	<span>좋아요</span>
                        	<span>${recoDto.recoLike}</span>
                       	</span>
          			</div>
      			</div>
			</div>
      		
    	</c:forEach>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>