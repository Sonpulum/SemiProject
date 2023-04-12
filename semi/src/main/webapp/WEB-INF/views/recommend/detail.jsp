<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:if test="${sessionScope.memberId != null}">
<script src="${pageContext.request.contextPath}/static/js/recommend-like.js"></script>
</c:if>

<style>
main section article h1 {
        font-size: 2em;
}
.fa-thumbs-up{
	color:#5186f0;
}
.fa-thumbs-up:hover{
	cursor:pointer;
}

.non-click:hover{
	cursor:default;
}
.tag {
	font-size : 22px;
	font-weight : bold;
}
</style>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=95c82dc1c1149f6ed680ecae0d9ba566&libraries=services"></script>
<script>
$(function(){
    $(".form-btn.negative").click(function(e){
        e.preventDefault(); // 링크 이동 중지
        var choice = window.confirm("정말 삭제하시겠습니까?");
        if (choice) {
            window.location.href = $(this).attr("href"); // 링크 이동
        }
    });
    
    var mapContainer = document.querySelector('.map');
    
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	map.setDraggable(false);
	map.setZoomable(false);
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch($("[name=recoAddr]").val(), function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
			
	    	var lat = result[0].y;
	    	var lng = result[0].x;
	        coords = new kakao.maps.LatLng(lat, lng);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            clickable:true
	        });
			
	        var mLabel = new kakao.maps.InfoWindow({
	            map: map,
	            position: coords,
	            content: '마커 클릭하여 길찾기'
	        });
	        
	        mLabel.open(map, marker);
	        
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	        
	        kakao.maps.event.addListener(marker, 'click', function(mouseEvent){
	    		window.open("https://map.kakao.com/link/to/"+"도착지,"+lat+","+lng);
	    	});
	        
	    } 
	});
	
	
	//class=reco-content 에 있는 img를 찾아서 img 내부에 있는 src에 절대경로를 추가
	$(".reco-content").find("img").each(function(){
		var origin = $(this).attr("src");
		var begin = origin.indexOf('/rest');
		var path = contextPath + (origin.substr(begin));
		$(this).attr("src", path);
	});
  	
});
</script>

<div class="container-800">
        <div class="row">
            <h1 class="mb-30">${recoDto.recoTitle}</h1>
        </div>
        <div class="row">
            <span class="tag">#${recoDto.recoLocation}</span>
            <span class="tag">#${recoDto.recoSeason}</span>
            <span class="tag">#${recoDto.recoTheme}</span>
        </div>
        <hr>
        <div class="row reco-content">
            ${recoDto.recoContent}
        </div>
        
        <input type="hidden" name="recoAddr" value="${recoDto.recoAddr}">
        <div class="row">
        	<div class="map" style="width:100%;height:350px;"></div>
        </div>
        
        <hr>
        <div class="row">
            <span class="me-10">
            	<fmt:formatDate value="${recoDto.recoTime}" pattern="y년 M월 d일 HH:mm"/>
           	</span>
            <span>조회수</span>
            <span>${recoDto.recoRead}</span>
			<i class="fa-regular fa-eye me-10"></i>
			
			<span>좋아요</span>
            <span class="like-count">${recoDto.recoLike}</span>
            <c:choose>
            	<c:when test="${sessionScope.memberId != null}">
            		<i class="fa-thumbs-up"></i>
            	</c:when>
            	<c:otherwise>
            		<i class="fa-regular fa-thumbs-up non-click"></i>
            	</c:otherwise>
            </c:choose>
        </div>
        <hr>
        
        <div class = "row right">
<!--         	<a href="list" class="form-btn neutral">목록으로</a> -->
        	<c:if test="${sessionScope.memberLevel eq '관리자'}">
		       	<a href="delete?recoNo=${recoDto.recoNo}" class="form-btn negative">삭제하기</a>
		       	<a href="edit?recoNo=${recoDto.recoNo}" class="form-btn bosung">수정하기</a>
        	</c:if>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>