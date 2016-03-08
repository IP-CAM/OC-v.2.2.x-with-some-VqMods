//preorder
var clickedButtons;
var lastProductId = null;
var lastQuantity = null;

function nwaAddToCart(product_id, quantity) {
	quantity = typeof(quantity) != 'undefined' ? quantity : 1;
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: 'product_id=' + product_id + '&quantity=' + quantity,
		dataType: 'json',
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('#cart > button').button('reset');

			/*if (json['NWA']) {
				$('#preorder_popup').detach().appendTo('body');
				var btn = clickedButtons;

				offset = $(btn).offset();
				var leftOffset = offset.left + (parseInt($(btn).width()/2));
				$('div#preorder_popup').css({
					top: offset.top,
					left: ((offset.left-$('div#preorder_popup').width()/2) + $(btn).width()/2)
				});

				//$('div#preorder_popup').fadeIn('slow');
				//$(".NWA_popover-content").load("index.php?route=module/preorder/showpreorderform&product_id="+product_id);
			} else {
				if (json['redirect']) {
					location = json['redirect'];
				}
				
				if (json['success']) {
					$('#content').parent().before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

					$('#cart-total').html(json['total']);

					$('html, body').animate({ scrollTop: 0 }, 'slow');

					$('#cart > ul').load('index.php?route=common/cart/info ul li');
				}
			}*/	
		}
	});
}

function nwa(e, product_id, quantity) {
	e.preventDefault();
	e.stopPropagation();
	clickedButtons = e.target;
	nwaAddToCart(product_id, quantity);
}

$(document).ready(function() {
	$('[onclick^="cart.add"]').each(function(i,e){
		var params = $(this).attr('onclick').match(/\d+/);
		var func_call = 'nwa(event, ';
		if (params) {
			if (params[0]) {
				func_call += params[0];
				if (params[1]) {
					func_call += ', ' + params[1];
				} else {
					func_call += ', 1';
				}
			}
		}
		func_call += ');';
		$(this).attr('onclick', func_call);
	});
});