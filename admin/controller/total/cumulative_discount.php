<?php
class ControllerTotalCumulativeDiscount extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('total/cumulative_discount');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('cumulative_discount', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_help'] = $this->language->get('text_help');

		$this->data['entry_start_date'] = $this->language->get('entry_start_date');
		$this->data['entry_end_date'] = $this->language->get('entry_end_date');
		$this->data['entry_total'] = $this->language->get('entry_total');
		$this->data['entry_min_prod'] = $this->language->get('entry_min_prod');
		$this->data['entry_discount'] = $this->language->get('entry_discount');
		$this->data['entry_discount_item'] = $this->language->get('entry_discount_item');
		$this->data['entry_order_status'] = $this->language->get('entry_order_status');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_total'),
			'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('total/cumulative_discount', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('total/cumulative_discount', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['cumulative_discount_start_date'])) {
			$this->data['cumulative_discount_start_date'] = $this->request->post['cumulative_discount_start_date'];
		} else {
			$this->data['cumulative_discount_start_date'] = $this->config->get('cumulative_discount_start_date');
		}

		if (isset($this->request->post['cumulative_discount_end_date'])) {
			$this->data['cumulative_discount_end_date'] = $this->request->post['cumulative_discount_end_date'];
		} else {
			$this->data['cumulative_discount_end_date'] = $this->config->get('cumulative_discount_end_date');
		}

		if (isset($this->request->post['cumulative_discount_total'])) {
			$this->data['cumulative_discount_total'] = $this->request->post['cumulative_discount_total'];
		} else {
			$this->data['cumulative_discount_total'] = $this->config->get('cumulative_discount_total');
		}

		if (isset($this->request->post['cumulative_discount_min_prod'])) {
			$this->data['cumulative_discount_min_prod'] = $this->request->post['cumulative_discount_min_prod'];
		} else {
			$this->data['cumulative_discount_min_prod'] = $this->config->get('cumulative_discount_min_prod');
		}

		if (isset($this->request->post['cumulative_discount_discount'])) {
			$this->data['cumulative_discount_discount'] = $this->request->post['cumulative_discount_discount'];
		} else {
			$this->data['cumulative_discount_discount'] = $this->config->get('cumulative_discount_discount');
		}

		if (isset($this->request->post['cumulative_discount_discount_item'])) {
			$this->data['cumulative_discount_discount_item'] = $this->request->post['cumulative_discount_discount_item'];
		} else {
			$this->data['cumulative_discount_discount_item'] = $this->config->get('cumulative_discount_discount_item');
		}

		$this->data['discount_items'][] = array("item_id" => 0, "name" => $this->language->get('text_order'));
		$this->data['discount_items'][] = array("item_id" => 1, "name" => $this->language->get('text_min_product'));
		$this->data['discount_items'][] = array("item_id" => 2, "name" => $this->language->get('text_max_product'));

		if (isset($this->request->post['cumulative_discount_order_status_id'])) {
			$this->data['cumulative_discount_order_status_id'] = $this->request->post['cumulative_discount_order_status_id'];
		} else {
			$this->data['cumulative_discount_order_status_id'] = $this->config->get('cumulative_discount_order_status_id');
		}

		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		if (isset($this->request->post['cumulative_discount_status'])) {
			$this->data['cumulative_discount_status'] = $this->request->post['cumulative_discount_status'];
		} else {
			$this->data['cumulative_discount_status'] = $this->config->get('cumulative_discount_status');
		}

		if (isset($this->request->post['cumulative_discount_sort_order'])) {
			$this->data['cumulative_discount_sort_order'] = $this->request->post['cumulative_discount_sort_order'];
		} else {
			$this->data['cumulative_discount_sort_order'] = $this->config->get('cumulative_discount_sort_order');
		}


		$this->template = 'total/cumulative_discount.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'total/cumulative_discount')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function install(){
		$this->load->model('total/cumulative_discount');
		$this->model_total_cumulative_discount->install();
	}

	public function uninstall(){
		$this->load->model('total/cumulative_discount');
		$this->model_total_cumulative_discount->uninstall();
	}

}
?>