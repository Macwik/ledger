class ProductApi{
  static const String product_type_list = '/api/erp/v2/product/item/list';
//新增货物
  static String addProduct = '/api/erp/v2/product/add';
//货物列表
  static String stockList = '/api/erp/v2/product/list';
//货物详情页
  static String productDetail = '/api/erp/v2/product/detail';
  //更新商品详情
  static const String product_detail_update = '/api/erp/v2/product/update';
  //新增库存调整
  static String addStockChange = '/api/erp/v2/stock/adjust/save';
  //库存调整详情
  static String stockChangeRecord = '/api/erp/v2/stock/adjust/page';
  //删除商品
  static const String product_remove = '/api/erp/v2/product/remove';
  //停用商品
  static const String product_invalid = '/api/erp/v2/product/invalid';
  //启用商品
  static const String product_enable = '/api/erp/v2/product/enable';
  //查询商品采购销售情况
  static const String product_statistics= '/api/erp/v2/statistics/product/order';
  //查询商品采购销售赊账情况
  static const String product_credit_statistics = '/api/erp/v2/statistics/product/credit';

  //搜索商品种类
  static const String product_type_search='/api/erp/v2/product/item/search';
  //货物分组管理
  static const String product_classify_manage= '/api/erp/v2/product/classify/list';
  //货物分组删除
  static const String product_classify_delete= '/api/erp/v2/product/classify/delete';
  //更新货物分组
  static const String product_classify_edit= '/api/erp/v2/product/classify/update';
  //新增货物分组
  static const String product_classify_add= '/api/erp/v2/product/classify/add';
}