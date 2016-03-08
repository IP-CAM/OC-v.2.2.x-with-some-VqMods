<div id="ordersWrapper<?php echo $store['store_id']; ?>"></div>
<script>
$(document).ready(function(){
	$.ajax({
		url: "index.php?route=module/preorder/getcustomers&store_id=<?php echo $store['store_id']; ?>&token=<?php echo $_SESSION['token']; ?>&page=1",
		type: 'get',
		dataType: 'html',
		success: function(data) {		
			$("#ordersWrapper<?php echo $store['store_id']; ?>").html(data);
		}
	});
});
</script>
