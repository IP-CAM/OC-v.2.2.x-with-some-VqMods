<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>  

    <?php if ($error_warning) { ?><div class="alert alert-danger" > <i class="icon-exclamation-sign"></i>&nbsp;<?php echo $error_warning; ?></div><?php } ?>

    <!-- Notify when available error -->
    <?php if (isset($notifywhenavailable) && isset($notifywhenavailable['notifywhenavailable']) && $notifywhenavailable['notifywhenavailable']['Enabled'] == 'yes') { ?>
		<div class="alert alert-danger"><i class="icon-exclamation-sign"></i> <?php echo $notifywhenavailable_enabled; ?></div>
	<?php } ?>

	<?php if (!empty($this->session->data['success'])) { ?>
        <div class="alert alert-success autoSlideUp"> <i class="fa fa-info"></i>&nbsp;&nbsp;<?php echo $this->session->data['success']; ?> </div>
        <script> $('.autoSlideUp').delay(3000).fadeOut(600, function(){ $(this).show().css({'visibility':'hidden'}); }).slideUp(600);</script>
    <?php $this->session->data['success'] = null; } ?>

    <div class="panel panel-default">
      <div class="panel-heading">
            <div class="storeSwitcherWidget">
                <div class="form-group">
                           <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown"><?php echo $store['name']; if($store['store_id'] == 0) echo ' <strong>'.$text_default.'</strong>'; ?>&nbsp;<span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button>
                            <ul class="dropdown-menu" role="menu">
                                <?php foreach ($stores as $st) { ?> <li> <a href="index.php?route=module/preorder&store_id=<?php echo $st['store_id'];?>&token=<?php echo $token; ?>"><?php echo $st['name']; ?></a></li><?php } ?> 
                            </ul>
                </div>
            </div>
            <h3 class="panel-title"><i class="fa fa-list"></i>&nbsp;<span style="vertical-align:middle;font-weight:bold;"><?php echo $heading_title; ?></span></h3>
        </div>
        <div class="panel-body">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form"> 
                <input type="hidden" name="preorder_status" value="1" />
                <input type="hidden" name="store_id" value="<?php echo $store['store_id']; ?>" />
                <div class="tabbable">
                    <div class="tab-navigation form-inline">
                        <ul class="nav nav-tabs mainMenuTabs" id="mainTabs">
                            <li class="active"><a href="#orders" data-toggle="tab"><i class="fa fa-bell"></i>&nbsp;Pre-Orders</a></li>                            
                            <li><a href="#statistics" data-toggle="tab"><i class="fa fa-bar-chart"></i>&nbsp;Statistics</a></li>
                            <li><a href="#controlpanel" data-toggle="tab"><i class="fa fa-power-off"></i>&nbsp;Control Panel</a></li>
                            <li><a href="#settings" data-toggle="tab"><i class="fa fa-cog"></i>&nbsp;Settings</a></li>
                        </ul>
                        <div class="tab-buttons">
                            <button type="submit" class="btn btn-success save-changes"><i class="fa fa-check"></i>&nbsp;Save Changes</button>
                            <a onclick="location = '<?php echo $cancel; ?>'" class="btn btn-warning"><i class="fa fa-times"></i>&nbsp;<?php echo $button_cancel?></a>
                        </div> 
                    </div><!-- /.tab-navigation --> 
                    <div class="tab-content">
                       
                        <div id="orders" class="tab-pane active">
                            <?php require_once (DIR_APPLICATION.'view/template/module/preorder/tab_viewcustomers.php'); ?>                        </div>
                        <div id="controlpanel" class="tab-pane">
                            <?php require_once (DIR_APPLICATION.'view/template/module/preorder/tab_controlpanel.php'); ?>                        </div>
                        <div id="settings" class="tab-pane">
                            <?php require_once (DIR_APPLICATION.'view/template/module/preorder/tab_settings.php'); ?>                        </div>
                        <div id="statistics" class="tab-pane">
                            <div style="overflow:hidden;">  
                            <?php $sum = 0; ?>
                                <?php if (sizeof($products)>0) { ?>
									 <script type="text/javascript" src="https://www.google.com/jsapi"></script>
                                     <script type="text/javascript">
                                        google.load("visualization", "1", {packages:["corechart"]});
                                        function drawChart() {
																						
                                            var data = google.visualization.arrayToDataTable([['Product', 'Pre-Orders', { role: 'annotation' } ],
                                        <?php foreach($products as $pid => $notified) {if (isset($notified[0])){if (isset($notified[1])){$sum=$notified[0]+$notified[1];}else{$sum=$notified[0];}}else {if (isset($notified[1])){$sum = $notified[1];}}; $productInfo = $product_info->getProduct($pid); echo "['".htmlspecialchars($productInfo['name'], ENT_QUOTES)."', ".$sum.", ''],"; } $sum = 0 ?>]);
                                            var options = { title: 'Products Performance', isStacked: true, legend: { position: 'top', maxLines: 3 }, height: 400 };
                                            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
                                            chart.draw(data, options);
                                        }
                                      </script>
                                    <?php } else { echo "<center>There is no data yet for a chart.</center>"; }?>
                                <div id='chart_div'></div>
                            </div>                      
                        </div>
                                 
                    </div><!-- /.tab-content -->
                </div><!-- /.tabbable -->
            </form>            
        </div>
    </div>
  </div>
</div>
<script>
if (window.localStorage && window.localStorage['currentTab']) {
  $('.mainMenuTabs a[href='+window.localStorage['currentTab']+']').trigger('click');  
}
$('.fadeInOnLoad').css('visibility','visible');
$('.mainMenuTabs a[data-toggle="tab"]').click(function() {
  if (window.localStorage) {
    window.localStorage['currentTab'] = $(this).attr('href');
  }
});
if (typeof drawChart == 'function') { 
    google.setOnLoadCallback(drawChart);
}
$('a[href=#statistics]').on('click', function() {
	if (typeof drawChart == 'function') { 
		setTimeout(function() { drawChart(); }, 250);
	}
});
</script>
<?php echo $footer; ?>