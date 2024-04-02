class PermissionCode{

  //公共权限
  static const String common_permission = 'COMMON_PERMISSION';

  //营业员管理
  static const String employee_manage_permission = 'PAGE_EMPLOYEE_MANAGE';

  //首页销售权限
  static const String sales_page_permission = 'PAGE_SALES';
  //首页采购权限
  static const String purchase_page_permission = 'PAGE_PURCHASE';
  //首页库存权限
  static const String stock_page_permission = 'PAGE_STOCK';
  //首页资金权限
  static const String funds_page_permission = 'PAGE_FUNDS';
  //首页还款权限
  static const String repayment_page_permission = 'PAGE_REPAYMENT';
  //首页账目权限
  static const String account_page_permission = 'PAGE_ACCOUNT';

  //销售开单
  static const String sales_sale_order_permission = 'WIDGET_SALES_SALE_ORDER';
  //销售退货开单
  static const String sales_sale_return_permission = 'WIDGET_SALES_SALE_RETURN';
  //销售退款开单   TODO new
  static const String sales_sale_refund_permission = 'WIDGET_SALES_SALE_REFUND';
  //销售开单时间修改
  static const String sales_bill_time_permission = 'WIDGET_SALES_BILL_TIME';
  //分享销售单
  static const String sales_detail_share_permission = 'WIDGET_SALES_DETAIL_SHARE';
  //查看销售记录--销售页
  static const String sales_sale_record_permission = 'WIDGET_SALES_SALE_RECORD';
  //查看销售退货记录  TODO new
  static const String sales_return_sale_record_permission = 'WIDGET_SALES_RETURN_SALE_RECORD';
  //查看销售退款记录  TODO new
  static const String sales_refund_sale_record_permission = 'WIDGET_SALES_REFUND_SALE_RECORD';
  //作废销售单
  static const String sales_detail_delete_permission = 'WIDGET_SALES_DETAIL_DELETE';

  //采购开单
  static const String purchase_purchase_order_permission = 'WIDGET_PURCHASE_PURCHASE_ORDER';
  //采购退货开单  ToDO change name
  static const String purchase_purchase_return_order_permission = 'WIDGET_PURCHASE_PURCHASE_RETURN_ORDER';
  //直接入库开单   TODO new
  static const String purchase_add_stock_order_permission = 'WIDGET_PURCHASE_ADD_STOCK_ORDER_RETURN';
  //采购开单修改日期
  static const String purchase_bill_time_permission = 'WIDGET_PURCHASE_BILL_TIME';
  //分享采购单
  static const String purchase_detail_share_permission = 'WIDGET_PURCHASE_DETAIL_SHARE';
  //查看采购记录
  static const String purchase_purchase_record_permission = 'WIDGET_PURCHASE_PURCHASE_RECORD';
  //查看采购退货记录  TODO new
  static const String purchase_purchase_return_record_permission = 'WIDGET_PURCHASE_PURCHASE_RETURN_RECORD';
  //查看直接入库记录  TODO new
  static const String purchase_add_stock_record_permission = 'WIDGET_PURCHASE_ADD_STOCK_PURCHASE_RECORD';
  //作废采购单
  static const String purchase_detail_delete_permission = 'WIDGET_PURCHASE_DETAIL_DELETE';

  //汇款开单
  static const String purchase_remittance_order_permission = 'WIDGET_PURCHASE_REMITTANCE_ORDER';
  //汇款开单修改日期
  static const String remittance_bill_time_permission = 'WIDGET_REMITTANCE_BILL_TIME';
  //看汇款记录
  static const String remittance_remittance_record_permission = 'WIDGET_REMITTANCE_REMITTANCE_RECORD';
  //分享汇款单
  static const String remittance_detail_share_permission = 'WIDGET_REMITTANCE_DETAIL_SHARE';
  //作废汇款单
  static const String remittance_detail_delete_permission = 'WIDGET_REMITTANCE_DETAIL_DELETE';

  //录入欠款
  static const String funds_add_debt_permission = 'WIDGET_FUNDS_ADD_DEBT';
  //录入欠款修改日期
  static const String add_debt_time_permission = 'WIDGET_ADD_DEBT_TIME';
  //还款修改日期
  static const String repayment_bill_time_permission = 'WIDGET_REPAYMENT_BILL_TIME';
  //还款开单--客户还款
  static const String supplier_detail_repayment_order_permission = 'WIDGET_SUPPLIER_DETAIL_REPAYMENT_ORDER';//TODO 最好改名字
  //看还款记录--客户还款
  static const String funds_repayment_record_permission = 'WIDGET_FUNDS_REPAYMENT_RECORD';
  //作废还款记录--客户还款
  static const String repayment_detail_delete_permission = 'WIDGET_REPAYMENT_DETAIL_DELETE';
  //停用客户
  static const String custom_record_invalid_permission = 'WIDGET_CUSTOM_RECORD_INVALID';
  //新增客户
  static const String custom_record_add_custom_permission = 'WIDGET_CUSTOM_RECORD_ADD_CUSTOM';
  //看客户对账单
  static const String supplier_detail_check_bill_permission = 'WIDGET_SUPPLIER_DETAIL_CHECK_BILL';//TODO 最好改名字
  //修改客户资料
  static const String custom_detail_update_permission = 'WIDGET_CUSTOM_DETAIL_UPDATE';


  //供应商还款开单 TODO new
  static const String  supplier_repayment_order_permission = 'WIDGET_SUPPLIER_REPAYMENT_ORDER';
  //供应商看还款记录  TODO new
  static const String supplier_custom_repayment_record_permission = 'WIDGET_SUPPLIER_CUSTOM_REPAYMENT_RECORD';
  //作废供应商还款记录 TODO new
  static const String supplier_custom_repayment_detail_delete_permission = 'WIDGET_SUPPLIER_CUSTOM_REPAYMENT_DETAIL_DELETE';
  //停用供应商  TODO new
  static const String supplier_custom_record_invalid_permission = 'WIDGET_SUPPLIER_CUSTOM_RECORD_INVALID';
  //新增供应商  TODO new
  static const String supplier_custom_record_add_custom_permission = 'WIDGET_SUPPLIER_CUSTOM_RECORD_ADD_CUSTOM';
  //看供应商对账单  TODO new
  static const String supplier_supplier_detail_check_bill_permission = 'WIDGET_SUPPLIER_SUPPLIER_DETAIL_CHECK_BILL';
  //修改供应商资料  TODO new
  static const String supplier_custom_detail_update_permission = 'WIDGET_SUPPLIER_CUSTOM_DETAIL_UPDATE';

  //新增货物
  static const String stock_list_add_product_permission = 'WIDGET_STOCK_LIST_ADD_PRODUCT';
  //停用货物
  static const String stock_list_invalid_product_permission = 'WIDGET_STOCK_LIST_INVALID_PRODUCT';
  //调整库存
  static const String stock_stock_change_permission = 'WIDGET_STOCK_STOCK_CHANGE';
  //查看调整库存记录
  static const String stock_stock_change_record_permission = 'WIDGET_STOCK_STOCK_CHANGE_RECORD';
  //查看货物详情
  static const String goods_detail_check_detail_permission = 'WIDGET_GOODS_DETAIL_CHECK_DETAIL';
  //修改货物资料
  static const String product_detail_product_detail_permission = 'WIDGET_PRODUCT_DETAIL_PRODUCT_DETAIL';

  //新增费用开单
  static const String funds_cost_order_permission = 'WIDGET_FUNDS_COST_ORDER';
  //新增收入开单
  static const String funds_income_order_permission = 'WIDGET_FUNDS_INCOME_ORDER';
  //费用收入开单修改日期
  static const String cost_bill_time_permission = 'WIDGET_COST_BILL_TIME';
  //查看费用收入单
  static const String funds_cost_record_permission = 'WIDGET_FUNDS_COST_RECORD';
  //作废费用收入单
  static const String cost_detail_delete_permission = 'WIDGET_COST_DETAIL_DELETE';
  //分享费用收入单
  static const String cost_detail_share_permission = 'WIDGET_COST_DETAIL_SHARE';


}