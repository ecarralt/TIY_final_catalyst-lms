


$(document).ready(function() {
	$('.lesson_content').on({
		click: function() {
			var link = $(this).find('h3 a').attr('href');
			console.log(link);
			// window.location.href = link;
		}
	})
});
