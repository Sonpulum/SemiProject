<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=95c82dc1c1149f6ed680ecae0d9ba566&libraries=services"></script>
 <style>
.wrapper {

  height: 400px; /* 이미지 높이 + 여백 */
  background: #f6f5ef;
  position: relative;
}
.wrapper .swiper-container {
  width: calc(600px * 3 + 20px); /* 이미지 너비 * 보여줄 개수 + 여백의 합 */
  height: 400px;
  position: absolute;
  left: 50%;
  margin-left: calc((600px * 3 + 20px) / -2); /* 전체 너비의 반의 음수 값 */
  overflow:hidden;
  
}
.wrapper :not(.swiper-slide-active).swiper-slide {
  opacity: 0.5;
  transition: opacity 1s;
  position: relative;
}
.wrapper .swiper-slide .btn {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
}
.wrapper .swiper-slide img{
   width : 100%;
   height : 100%;
}
.wrapper .swiper-container .swiper-slide img:hover{
   transform: scale(1.025);
   transition: all 0.5s;
}
.wrapper .swiper-pagination {
  bottom: 10px;
  left: 0;
  right: 0;
}
.wrapper .swiper-pagination .swiper-pagination-bullet {
  background: transparent;
  background-image: url('./image/slide_pager.png');
  width: 12px;
  height: 12px;
  outline: none;
}

.wrapper .swiper-pagination .swiper-pagination-bullet:not(:last-child) {
  margin-right: 6px;
}
.wrapper .swiper-pagination .swiper-pagination-bullet-active {
  background-image: url('./image/slide_pager_on.png');
}
.wrapper .swiper-prev,
.wrapper .swiper-next {
  width: 42px;
  height: 42px;
  border: 2px solid #333;
  border-radius: 50%;
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  z-index: 1;
  cursor: pointer;
  outline: none;
  display: flex;
  justify-content: center;
  align-items: center;
  transition: 0.4s;
}
.wrapper .swiper-prev {
  left: 50%;
  margin-left: -380px; /* 이미지 너비 + 간격 */
}
.wrapper .swiper-next {
  right: 50%;
  margin-right: -380px; /* 이미지 너비 + 간격 */
}
.wrapper .swiper-prev:hover,
.wrapper .swiper-next:hover {
  background: #333;
  color: #fff;
}

#mp {
  border: 2px solid #9999;
  border-radius: 20px;
}
 .area {
    position: absolute;
    background: #fff;
    border: 1px solid #888;
    border-radius: 3px;
    font-size: 12px;
    top: -5px;
    left: 15px;
    padding:2px;
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



.main-box-shadow {
         transition: transform .2s ease, padding .2s ease
      }

.main-box-shadow:hover {
         transform: translate(0,-5px);
      }
   

.hash-tag {
         top: 50px;
         left: 20px;
            border: none;
          font-size: 15px;
          padding: 0.5em 1em 0.5em 1em;
          display: inline-block;
          text-align: center;
          text-decoration: none;
          border-radius: 10px;
          color: #373A3C;
          background-color: #EEEEEE;
      }
      
      .d1 {
   border: 1px solid #c1ced1;
   box-shadow: 0px 0px 20px 10px #c1ced1;
}

.map {
   width: 100%;  
  height: 100%;
  background: #FF7777;
  -webkit-font-smoothing: antialiased;
  display: flex;
  justify-content: center;
  align-items: center;
}

.image_text {
   font-size: 20px;
   color: white;
   padding: 5px 10px;
   text-align: center;
   position: absolute;
   bottom: 10px;
}

</style>
<div class="row center">
<h1 class="home-title">${now} SNS 인기 여행지 Top 5</h1>
</div>
<div class="wrapper">
  <div class="swiper-container">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=143"><img src="${pageContext.request.contextPath}/static/image/hotel.jpg">
           <div class="row">
              <strong class="image_text">고급스러운 인테리어와 최상의 서비스가 어우러진 메이필드호텔</strong>
           </div>
        </a>
      </div>
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=123"><img src="${pageContext.request.contextPath}/static/image/sakura.jpg">
           <div class="row">
              <strong class="image_text">강원도의 아름다운 자연과 벚꽃이 만나는 경포 벚꽃축제, 봄의 아름다움을 만끽할 수 있는 멋진 장소입니다.</strong>
           </div>
        </a>
      </div>
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=103"><img src="${pageContext.request.contextPath}/static/image/bosan.jpg">
           <div class="row">
              <strong class="image_text">역사적인 가치와 아름다운 해변 경관이 어우러져 있는 부산의 아름다운 사찰, 해동용궁사</strong>
           </div>
        </a>
      </div>
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=144"><img src="${pageContext.request.contextPath}/static/image/gyeongju.jpg">
           <div class="row">
              <strong class="image_text">한국 고대 역사와 문화 유산을 담은 경주 대릉원, 아름다운 조경과 함께하는 역사 여행의 즐거움을 선사합니다.</strong>
           </div>
        </a>
      </div>
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=108"><img src="${pageContext.request.contextPath}/static/image/gangneung.jpg">
           <div class="row">
              <strong class="image_text">한국의 전통 아름다움과 우아함이 고스란히 담겨있는 아름다운 건축물, 오죽헌</strong>
           </div>
        </a>
      </div>
       <div class="swiper-slide">
        <a href="recommend/detail?recoNo=103"><img src="${pageContext.request.contextPath}/static/image/bosan.jpg">
           <div class="row">
              <strong class="image_text">역사적인 가치와 아름다운 해변 경관이 어우러져 있는 부산의 아름다운 사찰, 해동용궁사</strong>
           </div>
        </a>
      </div>
    </div>
  </div>
  <div class="swiper-pagination"></div>
  <div class="swiper-prev">
    <div class="material-icons">◀</div>
  </div>
  <div class="swiper-next">
    <div class="material-icons">▶</div>
  </div>

</div>

<div style="width:100%;background-color: #f0f2f7;"> 
<div class="flex-box " style="height:430px">

   <div class="mt-30 mb-30 p-10 ms-10 main-box-shadow d1" id="mp" style="background-color:white; border:none 'box-shadow:2px 3px 5px 0px' gray">
      <h1 class="mb-10 center"><i class="fa-solid fa-earth-americas" style="color: #2798a0;"></i>
     가보고 싶은 지역을 선택하세요
      </h1>
      <div Class="mt-10 mb-50 ms-10 me-10" id="map" style="width:500px;height:300px; border-radius: 20px;"></div> 
   </div>
   
   <div style = "padding:0px 30px 0px 0px"></div>
   
   <div class="mt-30 mb-30 p-10 ms-10 main-box-shadow d1" style="width:500px; background-color:white; border-radius: 20px; border:none" id="mp">
      <table class="table table-border mt-10 mb-10">
         <thead>
            <tr >
               <th colspan='3' class="center"><img style = "display:inline" width="25px" height="20px" src="${pageContext.request.contextPath}/static/image/medal.png">추천 인기 게시글</th>
            </tr>      
         </thead>
         <tbody>
         <c:forEach var="recoDto" items="${recoTop}" varStatus="status">
            <tr>
               <td>${status.index+1}</td>
               <td class="w-90">
               <a class="link" href="recommend/detail?recoNo=${recoDto.recoNo}">
               ${recoDto.recoTitle}</a>
            
         
               </td>
            </tr>
               
         </c:forEach>
         </tbody>
      </table>
   </div>
   
   <div style = "padding:0px 30px 0px 0px"></div>
   
   <div class="mt-30 mb-30 p-10 ms-10 main-box-shadow d1" style="width:500px; background-color:white; border-radius: 20px; border:none" id="mp">
      <table class="table table-border mt-10 mb-10">
         <thead>
            <tr >
               <th colspan='3' class="center"><img  style = "display:inline" width="25px" height="20px" src="${pageContext.request.contextPath}/static/image/medal.png">후기 인기 게시글</th>
            </tr>      
         </thead>
         <tbody>
         <c:forEach var="reviewDto" items="${reviewTop}" varStatus="status">
            <tr>
               <td>${status.index+1}</td>
               <td class="w-90"><a class="link" href="review/detail?reviewNo=${reviewDto.reviewNo}">
               ${reviewDto.reviewTitle}</a>
               </td>
            </tr>
         </c:forEach>
         </tbody>
      </table>
   </div>
   
   
</div>

</div>


<script>
new Swiper('.swiper-container',{
     slidesPerView: 3, // 한 번에 보여줄 슬라이드 개수
     spaceBetween: 10, // 슬라이드 사이 여백
     centeredSlides: true, // 1번 슬라이드가 가운데 보이기
     loop: true, // 반복 재생 여부
     autoplay: { // 자동 재생 여부
       delay: 3000 // 3초마다 슬라이드 바뀜
     },
     pagination:{ // 페이지 번호 사용 여부
       el: '.swiper-pagination', // 페이지 번호 요소 선택자
       clickable: true, // 사용자의 페이지 번호 요소 제어 가능 여부
     },
     navigation:{ // 슬라이드 이전/다음 버튼 사용 여부
       prevEl:'.swiper-prev', // 이전 버튼 선택자
       nextEl:'.swiper-next' // 다음 버튼 선택자
     }
     
   });
</script>
<script>
         (function(){
            var map ="";
               
            var kkoMap = {            
               initKko : function(data){
                  areaId = data.mapId;
                  option = data.option;
                  
                  mapContainer = document.getElementById(areaId); // 지도를 표시할 div 
                  mapOption = $.extend({
                     draggable: false,
                     center: new kakao.maps.LatLng(35.9628205, 127.7251621)
                     ,level : 14
                  },option);

                  map = new kakao.maps.Map(mapContainer, mapOption),
                  customOverlay = new kakao.maps.CustomOverlay({}),
                  infowindow = new kakao.maps.InfoWindow({removable: true});
                  
                  $.getJSON("static/json/all.json",function(jData){
                  $jData = $(jData.features);
                     $jData.each(function(){
                        kkoMap.getPolycode($(this)[0],)
                        ;
                     });
                  });
               }
               ,getPolycode : function(Feature){
                  var geometry = Feature.geometry
                  var polygonBox = [];                  
                  var polygon=[];
                  var MultiPolygon=[];
                  
                  
                  if("Polygon" == geometry.type){
                     var coordinate = geometry.coordinates[0];
                     polygonArr = {"name":Feature.properties.loc_nm, "path":[]}
                     
                     for(var c in coordinate){                  
                        polygonArr.path.push(new kakao.maps.LatLng(coordinate[c][1], coordinate[c][0]));
                     }
                     
                     kkoMap.setPolygon(polygonArr)
                  }else if("MultiPolygon" == geometry.type){
                     arrP = []
                     for(var c in geometry.coordinates){
                        var multiCoordinates = geometry.coordinates[c];
                        polygonArr = {"name":Feature.properties.loc_nm, "path":[]}
                        
                        for(var z in multiCoordinates[0]){
                           polygonArr.path.push(new kakao.maps.LatLng(multiCoordinates[0][z][1], multiCoordinates[0][z][0]));
                           
                        }
                        kkoMap.setPolygon(polygonArr)
                     }
                     
                  }
               
               }
               ,setPolygon : function(data,option){
                                                      
                  polygonOption = $.extend({
                     strokeWeight: 2,
                     strokeColor: '#004c80',
                     strokeOpacity: 0.8,
                     fillColor: '#fff',
                     fillOpacity: 0.7
                  },option);
                  
                  var polygon = new kakao.maps.Polygon({
                     name: data.name
                     ,path : data.path,
                     strokeWeight: 2,
                  strokeColor: '#004c80',
                  strokeOpacity: 0.8,
                  fillColor: '#fff',
                  fillOpacity: 0.7 
                  });
                  
                  
                  
                  kakao.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) { 
                     polygon.setOptions({fillColor: 'rgb(64, 165, 187)'});
                     customOverlay.setContent('<div class="area">' + data.name + '</div>');
                     customOverlay.setPosition(mouseEvent.latLng); 
                     customOverlay.setMap(map);
                  });
                  
         
                  
                  kakao.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
                     customOverlay.setPosition(mouseEvent.latLng); 
                  });
                  
                  kakao.maps.event.addListener(polygon, 'mouseout', function() {
                     polygon.setOptions({fillColor: '#fff'});
                     customOverlay.setMap(null);
                  }); 
                  
                  
                  kakao.maps.event.addListener(polygon, 'click', function(mouseEvent) {
                               window.location.href = '${pageContext.request.contextPath}/recommend/list?column=reco_location&keyword='+data.name ;
                           });
                  
                  polygon.setMap(map);
               }
            }
            
            window.kkoMap = kkoMap;
         })();
         
         
         
         $(function(){
            kkoMap.initKko({
               mapId :"map"
               ,option :""
            });
         });
      </script>
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>