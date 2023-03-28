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
		var isValid = target.val().trim().length > 0;
		
		valid.recoTitleValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	
	$("[name=recoLocation]").change(function(){
		var target = $(this);
		var isValid = target.val().length > 0;
		
		valid.recoLocationValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	$("[name=recoSeason]").change(function(){
		var target = $(this);
		var isValid = target.val().length > 0;
		
		valid.recoSeasonValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	
	$("[name=recoTheme]").change(function(){
		var target = $(this);
		var isValid = target.val().length > 0;
		
		valid.recoThemeValid = isValid;
		$(this).removeClass("valid invalid")
					.addClass(isValid ? "valid" : "invalid");
	});
	
	$(".write-form").submit(function(e){
		valid.recoContentValid = $("[name=recoContent]").val().length > 0;
		if (valid.isAllValid() == false){
			confirm("모든 항목을 입력하세요")
			return false;
		}
		return true;
	});
});