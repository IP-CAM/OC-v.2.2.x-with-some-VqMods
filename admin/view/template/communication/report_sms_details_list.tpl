<?php echo $header; ?>
<style type="text/css">
.template_button {
	background:#C5521A !important;
}
</style>
<!--Load the AJAX API-->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">

      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['Send', <?php echo $total_send; ?>],
          ['Not Send',<?php echo $total_not_send; ?>]
        ]);

        // Set chart options
        var options = {'title':'SMS Send Report',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <form  method="post" enctype="multipart/form-data" id="form">
        <table>
          <tr>
            <td align="center"><div id="chart_div"></div></td>
          </tr>
        </table>
        <table class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $column_customer_name ?></td>
              <td class="left"><?php  echo $column_telephone; ?></td>
              <td class="left"><?php echo $column_status; ?></td>
              <td class="left"><?php echo $column_date_time; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if (isset($report_sms_details)) { ?>
            <?php foreach ($report_sms_details as $report_sms_details) { ?>
            <tr>
              <td class="left"><?php echo $report_sms_details['customer_id']; ?></td>
              <td class="left"><?php echo $report_sms_details['telephone']; ?></td>
              <td class="left"><?php echo ($report_sms_details['status'] == 1) ? '<strong style="color:#006600;font-weight:bold">Send</strong>' : '<strong style="color:#F00;font-weight:bold">Not Send</strong>'; ?></td>
              <td class="left"><?php echo $report_sms_details['date_added']; ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>