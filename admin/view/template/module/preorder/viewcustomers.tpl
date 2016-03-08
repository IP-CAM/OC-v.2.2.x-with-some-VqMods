<table id="ordersWrapper<?php echo $store_id; ?>" class="table table-bordered table-hover" width="100%">
    <thead>
        <tr class="table-header">
            <th width="20%"><?php echo $text_customer_email; ?></th>
            <th width="15%"><?php echo $text_customer_name; ?></th>
            <th width="25%"><?php echo $text_product; ?></th>
            <th width="10%"><?php echo $text_date; ?></th>
            <th width="5%"><?php echo $text_language; ?></th>
            <th width="5%"><?php echo $text_actions; ?></th>
        </tr>
    </thead>
    <tbody>
    
        <?php foreach($sources as $source) { ?>
            <tr>
                <td><?php echo $source['email']; ?></td>
                <td><?php echo $source['firstname'].' '.$source['lastname']; ?></td>
                <td> 
                    <a href="<?php echo '../index.php?route=product/product&product_id='.$source['product_id']; ?>" target="_blank"><strong><?php echo $source['product_name']; ?></strong></a>
                    <br />
                </td>
                <td><?php echo $source['date_created']; ?></td>
                <td><?php echo $source['language']; ?></td>
                <td><a onclick="removeCustomer('<?php echo $source['preorder_id']; ?>')" class="btn btn-sm btn-danger"><i class="fa fa-times"></i> <?php echo $text_remove; ?></a></td>
            </tr>
        <?php } ?>
	</tbody>
	<tfoot>
    	<tr><td colspan="6">        	
              <div class="pagination"><?php echo $pagination; ?></div>
		</td></tr>
    </tfoot>
</table>
<div style="float:right;padding: 5px;">
	<a onclick="removeAll();" class="btn btn-small btn-info"><i class="fa fa-trash"></i>&nbsp;&nbsp;<?php echo $text_remove_all; ?></a>
</div>
<script>
function removeCustomer(preorderID) {      
	var r=confirm("Are you sure you want to remove the customer?");
	if (r==true) {
		$.ajax({
			url: 'index.php?route=module/preorder/removecustomer&token=<?php echo $token; ?>',
			type: 'post',
			data: {'preorder_id': preorderID},
			success: function(response) {
				location.reload();
			}
		});
	}
}
function removeAll() {      
	var r=confirm("Are you sure you want to remove all records?");
	if (r==true) {
		$.ajax({
			url: 'index.php?route=module/preorder/removeallcustomers&token=<?php echo $token; ?>',
			type: 'post',
			data: {'remove': r},
			success: function(response) {
				location.reload();
			}
		});
	}
}
$(document).ready(function(){
	$('#ordersWrapper<?php echo $store_id; ?> .pagination a').click(function(e){
		e.preventDefault();
		$.ajax({
			url: this.href,
			type: 'get',
			dataType: 'html',
			success: function(data) {				
				$("#ordersWrapper<?php echo $store_id; ?>").html(data);
			}
		});
	});		 
});
</script>