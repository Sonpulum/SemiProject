<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

</style>

<div class="row center">
<h1>4월 SNS 인기 여행지 Top 5</h1>
</div>
<div class="wrapper">
  <div class="swiper-container">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=143"><img src="/static/image/hotel.jpg"></a>
      </div>
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=123"><img src="/static/image/sakura.jpg"></a>
      </div>
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=103"><img src="/static/image/bosan.jpg"></a>
      </div>
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=144"><img src="/static/image/gyeongju.jpg"></a>
      </div>
      <div class="swiper-slide">
        <a href="recommend/detail?recoNo=108"><img src="/static/image/gangneung.jpg"></a>
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
<div class="flex-box" style="height:400px">
<div class="mt-30 p-10" id="mp">
<h1 class="mb-10 center">가고 싶은 지역을 클릭해보세요!</h1>
<div id="map" style="width:500px;height:300px; border-radius: 20px;"></div> 
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
	                            window.location.href = '/recommend/list?column=reco_location&keyword='+data.name ;
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