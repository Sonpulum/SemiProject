$(function(){
	var valid = {
		recoTitleValid : false,
		recoContentValid : false,
		recoLocationValid : false,
		recoSeasonValid : false,
		recoThemeValid : false,
		isAllValid : function(){
			return this.recoTitleValid && this.recoContentValid && this.recoLocationValid && this.recoSeasonValid && this.recoThemeValid;
		}
		
	};
	
	$("[name=recoTitle]").blur(function(){
		var target = $(this);
		var isValid = target.val().length() != 0;
		
		valid.recoTitleValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	$("[name=recoContentValid]").blur(function(){
		var target = $(this);
		var isValid = target.val().length() != 0;
		
		valid.recoTitleValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	$("[name=recoLocationValid]").blur(function(){
		var target = $(this);
		var isValid = target.val().length() != 0;
		
		valid.recoTitleValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	$("[name=recoSeasonValid]").blur(function(){
		var target = $(this);
		var isValid = target.val().length() != 0;
		
		valid.recoTitleValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	
	$("[name=recoThemeValid]").blur(function(){
		var target = $(this);
		var isValid = target.val().length() != 0;
		
		valid.recoTitleValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	$(".join-form").submit(function(e){
		if(!valid.isAllValid){
			e.preventDefault();
		}
	});
});