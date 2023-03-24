$(function(){

	//Javascript에서 파라미터 읽기
	var params = new URLSearchParams(location.search);
	console.log(params);
	var recoNo = params.get("recoNo");
	
	//[1]
	$.ajax({
		url:"/rest/recommend/check",
		method:"post",
		data:{
			recoNo : recoNo
		},
		success:function(response){
			//console.log(response);
			//console.log(typeof response);
			if(response) {
				$(".fa-thumbs-up").addClass("fa-solid");
			}
			else {
				$(".fa-thumbs-up").addClass("fa-regular");
			}
		},
		error:function(){
			$(".fa-thumbs-up").remove();
		}
	});
	
	//[2]
	$(".fa-thumbs-up").click(function(){
		$.ajax({
			url:"/rest/recommend/like",
			method:"post",
			data:{
				recoNo:recoNo
			},
			success:function(response){
				//response에는 result와 count가 들어있다
				if(response.result) {//좋아요 된것
					$(".fa-thumbs-up").removeClass("fa-solid fa-regular")
										.addClass("fa-solid fa-shake");
					//1초뒤에 .fa-shake를 제거(setTimeout 함수)
					//- setTimeout(함수, 시간); 지정한 시간 이후에 함수 실행
					//- setInterval(함수, 시간); 지정한 시간 간격으로 함수 실행
					setTimeout(function(){
						$(".fa-thumbs-up").removeClass("fa-shake");
					}, 800);
				
					$(".like-count").text(response.count);
				}
				else {//좋아요 풀린것
					$(".fa-thumbs-up").removeClass("fa-solid fa-regular")
										.addClass("fa-regular");
					$(".like-count").text(response.count);
				}
			},
			error:function(){}
		});
	});
	
	//[3] mouseenter/mouseleave
	$(".fa-thumbs-up").mouseenter(function(){
		$(this).addClass("fa-beat");
	})
	.mouseleave(function(){
		$(this).removeClass("fa-beat");
	});
	
});