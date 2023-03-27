<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <style>
      .container-900 {
            width: 1000px;
            background-color: #ffffff;
            border: 1px solid #ebebeb;
            margin: 100px auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            padding : 20px;
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
            font-size: 16px;
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

body {
  background-color: #f6f6f6;
}
.post {
    display: flex;
    align-items: center;
    padding: 10px;
    
}

.post img {
    width: 128px;
    height: 128px;
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
        font-size: 40px;
        display: inline;
      }
    </style>
<!-- 제목 -->
    <div class="container-900">
        <div class="row center">
            <h1><i class="fa-solid fa-map" style="color: #40a5bb;"></i> 지역별 추천</h1>
        </div>
    
        <div class="row">
            <table class="table table-border table-hover">
                <thead>
                    <tr>
                        <th>수도권</th>
                        <th>강원도</th>
                        <th>충청도</th>
                        <th>전라도</th>
                        <th>경상도</th>
                        <th>제주</th>
                    </tr>
                </thead>
            </table>
         </div>
   <div class="wrapper">
          <h2 class="left">#수도권</h2>
          <a href="write" class="write-btn center">글쓰기</a>
        </div>
        <hr>
        
        <c:forEach var="recoDto" items="${list}">
        	<div class="post">
      			<a href="detail?recoNo=${recoDto.recoNo}">
      				<img src="/static/image/hotel.jpg" alt="게시글 사진">
      			</a>
      			<div class="post-content">
          			<div class="post-header">
          				<a class="link" href="detail?recoNo=${recoDto.recoNo}">
              				<span class="titleName">${recoDto.recoTitle}</span>
              			</a>
          			</div>
          			<a class="link" href="detail?recoNo=${recoDto.recoNo}">
          				<p class="post-caption">내용</p>
          			</a>
         			<div class="post-footer">
              			<span class="likes"><i class="fa-regular fa-thumbs-up">좋아요</i>${recoDto.recoLike}</span>
                        <span class="comments"><i class="fa-regular fa-eye">조회수</i>${recoDto.recoRead}</span>
          			</div>
      			</div>
			</div>
      		
    	</c:forEach>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>