$(function(){

	var params = new URLSearchParams(location.search);
	var recoNo = params.get("recoNo");
	
	$.ajax({
		url:contextPath+"/rest/recommend/check",
		method:"post",
		data:{
			recoNo : recoNo
		},
		success:function(response){
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
	
	$(".fa-thumbs-up").click(function(){
		$.ajax({
			url:contextPath+"/rest/recommend/like",
			method:"post",
			data:{
				recoNo:recoNo
			},
			success:function(response){
				if(response.result) {
					$(".fa-thumbs-up").removeClass("fa-solid fa-regular")
										.addClass("fa-solid fa-beat");
		      			setTimeout(function(){
						$(".fa-thumbs-up").removeClass("fa-beat");
					}, 900);
					$(".like-count").text(response.count);
				}
				else {//좋아요 풀린것
					$(".fa-thumbs-up").removeClass("fa-solid fa-regular")
										.addClass("fa-regular fa-fade");
					setTimeout(function(){
						$(".fa-thumbs-up").removeClass("fa-fade");
					}, 900);
					$(".like-count").text(response.count);
				}
			},
			error:function(){}
		});
	});
});