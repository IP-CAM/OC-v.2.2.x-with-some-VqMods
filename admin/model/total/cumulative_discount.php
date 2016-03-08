<?php
class ModelTotalCumulativeDiscount extends Model {

	public function uninstall() {
		$this->db->query("DROP TABLE `" . DB_PREFIX . "cumulative_discount`");
	}

	public function install() {
		$query = $this->db->query("CREATE TABLE `" . DB_PREFIX . "cumulative_discount` (`customer_id` int(11) NOT NULL,
																						`cumulative_discount_count` int(11) NOT NULL,
																						PRIMARY KEY (`customer_id`)
																						)");
	}

}
?>