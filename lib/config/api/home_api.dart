class HomeApi {
  //首页还款情况
  static const String repayment_home = '/api/erp/v2/index/income-repayment';
//首页情况汇总
  static const String statistics_home ='/api/erp/v2/index/income-repayment-v2';
  //拉取今日销售情况
  static const String product_statistics = '/api/erp/v2/index/today/sales';
  //拉取今日还款情况
  static const String repayment_statistics = '/api/erp/v2/index/today/repayment';
  //拉取今日收款情况
  static const String payment_statistics = '/api/erp/v2/index/today/payment';
  //拉取今日客户赊账情况
  static const String credit_statistics = '/api/erp/v2/index/today/credit';
}