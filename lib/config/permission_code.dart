class PermissionCode{
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
  //首页账目权限
  static const String account_page_permission = 'PAGE_ACCOUNT';

  //销售开单--首页
 // static const String home_sale_order_permission = 'WIDGET_HOME_SALE_ORDER';
  //销售开单
  static const String sales_sale_order_permission = 'WIDGET_SALES_SALE_ORDER';
  //销售开单--销售记录页
  //static const String sales_record_sale_order_permission = 'WIDGET_SALES_RECORD_SALE_ORDER';
  //销售退货开单
  static const String sales_sale_return_permission = 'WIDGET_SALES_SALE_RETURN';
  //销售开单时间修改
  static const String sales_bill_time_permission = 'WIDGET_SALES_BILL_TIME';
  //分享销售单
  static const String sales_detail_share_permission = 'WIDGET_SALES_DETAIL_SHARE';
  //查看销售记录--首页
  //static const String home_sale_record_permission = 'WIDGET_HOME_SALE_RECORD';
  //查看销售记录--销售页
  static const String sales_sale_record_permission = 'WIDGET_SALES_SALE_RECORD';
  //作废销售单
  static const String sales_detail_delete_permission = 'WIDGET_SALES_DETAIL_DELETE';

  //采购开单
  static const String purchase_purchase_order_permission = 'WIDGET_PURCHASE_PURCHASE_ORDER';
  //采购开单--采购记录
  //static const String purchase_record_purchase_order_permission = 'WIDGET_PURCHASE_RECORD_PURCHASE_ORDER';
  //采购退货开单
  static const String purchase_purchase_return_permission = 'WIDGET_PURCHASE_PURCHASE_RETURN';
  //采购开单修改日期
  static const String purchase_bill_time_permission = 'WIDGET_PURCHASE_BILL_TIME';
  //分享采购单
  static const String purchase_detail_share_permission = 'WIDGET_PURCHASE_DETAIL_SHARE';
  //查看采购列表
  static const String purchase_purchase_record_permission = 'WIDGET_PURCHASE_PURCHASE_RECORD';
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
  //录入欠款--客户列表页
 // static const String custom_record_add_debt_permission = 'WIDGET_CUSTOM_RECORD_ADD_DEBT';
  //录入欠款修改日期
  static const String add_debt_time_permission = 'WIDGET_ADD_DEBT_TIME';
  //还款修改日期
  static const String repayment_bill_time_permission = 'WIDGET_REPAYMENT_BILL_TIME';
  //还款开单
  //static const String funds_repayment_order_permission = 'WIDGET_FUNDS_REPAYMENT_ORDER';
  //还款开单--还款记录页
 // static const String repayment_record_repayment_order_permission = 'WIDGET_REPAYMENT_RECORD_REPAYMENT_ORDER';
  //还款开单--客户列表页
 // static const String custom_record_repayment_order_permission = 'WIDGET_CUSTOM_RECORD_REPAYMENT_ORDER';
  //还款开单
  static const String supplier_detail_repayment_order_permission = 'WIDGET_SUPPLIER_DETAIL_REPAYMENT_ORDER';
  //看还款记录
  static const String funds_repayment_record_permission = 'WIDGET_FUNDS_REPAYMENT_RECORD';
  //作废还款记录
  static const String repayment_detail_delete_permission = 'WIDGET_REPAYMENT_DETAIL_DELETE';
  //停用客户
  static const String custom_record_invalid_permission = 'WIDGET_CUSTOM_RECORD_INVALID';
  //新增客户
  static const String custom_record_add_custom_permission = 'WIDGET_CUSTOM_RECORD_ADD_CUSTOM';
  //看客户对账单
  static const String supplier_detail_check_bill_permission = 'WIDGET_SUPPLIER_DETAIL_CHECK_BILL';
  //修改客户资料
  static const String custom_detail_update_permission = 'WIDGET_CUSTOM_DETAIL_UPDATE';
  //看客户列表--首页中间
  //static const String home_centre_custom_list_permission = 'WIDGET_HOME_CENTRE_CUSTOM_LIST';
  //看客户列表--首页下面
 // static const String home_bottom_custom_list_permission = 'WIDGET_HOME_BOTTOM_CUSTOM_LIST';
  //看客户列表--销售页
  //static const String sales_custom_list_permission = 'WIDGET_SALES_CUSTOM_LIST';

  //新增货物
  static const String stock_list_add_product_permission = 'WIDGET_STOCK_LIST_ADD_PRODUCT';
  //新增货物--ShoppingCar
  //static const String shopping_car_add_product_permission = 'WIDGET_SHOPPING_CAR_ADD_PRODUCT';
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
  //新增费用开单--费用记录
 // static const String cost_record_cost_order_permission = 'WIDGET_COST_RECORD_COST_ORDER';
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