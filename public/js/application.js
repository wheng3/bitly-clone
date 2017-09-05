$(document).ready(function() {
	console.log("jQuery ready!");
	let form = $("form");
	form.on('submit', function(event) {
		event.preventDefault();
		/* Act on the event */
		console.log("Prevented default action!");
		$.ajax({
			url: form.attr("action"),
			type: form.attr("method"),
			dataType: 'json',
			data: form.serialize(),
		})
		.done(function(response) {
			console.log("success");
			let base_url = window.location.origin;
			$('tbody').prepend('\
				<tr>\
					<td> ' + response.id + '</td>\
					<td> ' + response.long_url+ '</td>\
					<td> <a href='+"'/"+response.shortened_url+"'>"+base_url+'/'+response.shortened_url+'</a></td>\
					<td> ' + response.click_count + '</td>\
				</tr>');
		})
		.fail(function() {
			console.log("error");
		})
		.always(function() {
			console.log("complete");
		});
		
	});
});
