class OrderApi{
  //拉取货物采购销售详情
  static const String order_detail ='/api/erp/v2/sales/order/detail';
  //删除采购、销售单
  static const String order_invalid ='/api/erp/v2/sales/order/invalid';
  //采购、销售列表拉取数据
  static const String order_page ='/api/erp/v2/sales/order/page';
  //新增采购销售单
  static const String add_order_page ='/api/erp/v2/sales/order';
  //挂单开单
  static const String add_pending_order ='/api/erp/v2/draft/order/save';
  //拉取挂单列表
  static const String pending_order_list ='/api/erp/v2/draft/order/list';
  //挂单详情
  static const String pending_order_detail ='/api/erp/v2/draft/order/detail';
  //删除挂单详情
  static const String pending_order_delete ='/api/erp/v2/draft/order/delete';
  //挂单数量
  static const String pending_order_count ='/api/erp/v2/draft/order/count';
}