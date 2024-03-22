class CustomApi{
  static const String addCustom = '/api/erp/v2/custom/add';
  //拉取客户详情
  static const String getCustomDetail = '/api/erp/v2/custom/detail';
  //拉取客户详情列表
  static const String getCustomList = '/api/erp/v2/custom/list';
  //批量导入客户--从其他账本
  static const String batchImportCustom = '/api/erp/v2/custom/list/for-import';
  //修改客户详情
  static const String updateCustom = '/api/erp/v2/custom/update';
  //supplierDetail拉取详情下面部分
  static const String supplier_detail = '/api/erp/v2/statistics/custom/order/page';
  //supplierDetail拉取详情上面部分
  static const String supplier_detail_title = '/api/erp/v2/custom/detail';
  //删除客户
  static const String deleteCustom = '/api/erp/v2/custom/remove';
  //停用客户
  static const String customInvalid = '/api/erp/v2/custom/invalid';
  //启用客户
  static const String customEnable = '/api/erp/v2/custom/enable';

  // static const String getCustomList = '/custom/getCustomList';
  // static const String getCustomDetail = '/custom/getCustomDetail';
  // static const String updateCustom = '/custom/updateCustom';
  // static const String deleteCustom = '/custom/deleteCustom';
}