<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
 <style>
.wrapper {
  height: 450px; /* 이미지 높이 + 여백 */
  background: #f6f5ef;
  position: relative;
}
.wrapper .swiper-container {
  width: calc(600px * 3 + 20px); /* 이미지 너비 * 보여줄 개수 + 여백의 합 */
  height: min-content;
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
</style>

<div class="wrapper">
  <div class="swiper-container">
    <div class="swiper-wrapper">
      <div class="swiper-slide">
        <img src="/static/image/hotel.jpg" alt="" />
      </div>
      <div class="swiper-slide">
        <img src="/static/image/sakura.jpg" alt="" />
      </div>
      <div class="swiper-slide">
        <img src="/static/image/bosan.jpg" alt="" />
      </div>
      <div class="swiper-slide">
        <img src="/static/image/gimpo.jpg" alt="" />
      </div>
      <div class="swiper-slide">
        <img src="/static/image/gangneung.jpg" alt="" />
      </div>
    </div>
  </div>
  <div class="swiper-pagination"></div>
  <div class="swiper-prev">
    <div class="material-icons">arrow_back</div>
  </div>
  <div class="swiper-next">
    <div class="material-icons">arrow_forward</div>
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
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>