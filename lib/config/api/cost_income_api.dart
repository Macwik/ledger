class CostIncomeApi{
  //添加费用收入类型
  static const String add_cost_type ='/api/erp/v2/cost-income-type/add';
  //拉取费用收入类型
  static const String get_cost_type ='/api/erp/v2/cost-income-type/list';
  //删除费用收入类型
  static const String delete_cost_type ='/api/erp/v2/cost-income-type/remove';
  //删除费用单
  static const String cost_order_invalid ='/api/erp/v2/external/order/invalid';
  //添加费用单
  static const String add_cost_order ='/api/erp/v2/external/order/save';
  //查询费用单列表
  static const String cost_order_list ='/api/erp/v2/external/order/page';
  //查询费用单详情
  static const String cost_order_detail ='/api/erp/v2/external/order/detail';
  //费用统计查询
  static const String product_cost_statistic ='/api/erp/v2/external/order/statistic/page';
  //费用收入统计
  static const String cost_record_statistic = '/api/erp/v2/external/order/count';
}