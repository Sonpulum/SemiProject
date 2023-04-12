/**
 * 2023-03-24
 * 후기 게시글 좋아요 기능
 */

 $(function(){
	 
	 var params = new URLSearchParams(location.search);
	 var reviewNo = params.get("reviewNo");
	 
	 $.ajax({
		 
		 url:contextPath+"/rest/review/check",
		 method:"post",
		 data:{
			 reviewNo : reviewNo
		 },
		 success:function(response) {
			 if(response) {
				 $(".fa-thumbs-up").addClass("fa-solid");
			 }
			 else {
				 $(".fa-thumbs-up").addClass("fa-regular");
			 }
		 },
		 error:function() {
			 $(".fa-thumbs-up").remove();
		 }
	 });
	 
	 $(".fa-thumbs-up").click(function(){
		 $.ajax({
			 
			 url:contextPath+"/rest/review/like",
			 method:"post",
			 data:{
				 reviewNo : reviewNo
			 },
			 success:function(response) {
				 if(response.result) {
					 $(".fa-thumbs-up").removeClass("fa-solid fa-regular")
					 					.addClass("fa-solid fa-shake");
				 	 setTimeout(function(){
						  $(".fa-thumbs-up").removeClass("fa-shake");
						  
					 }, 900);
					 
					 $(".thumbs-count").text(response.count);
				 }
				 else {
					 $(".fa-thumbs-up").removeClass("fa-solid fa-regular")
										.addClass("fa-regular");
					 $(".thumbs-count").text(response.count);
				 }
			 },
			 error:function(){}
		 });
	 });
	 $(".fa-thumbs-up").mouseenter(function(){
		 $(this).addClass("fa-beat");
	 }) 
	 .mouseleave(function(){
		 $(this).removeClass("fa-beat");
	 });
	 
 });