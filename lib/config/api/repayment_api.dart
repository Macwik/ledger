class RepaymentApi{
  //新增还款
  static const String add_repayment = '/api/erp/v2/repayment/save';
  //查询还款详情
  static const String repayment_detail = '/api/erp/v2/repayment/detail';
  //还款record
  static const String repayment_record = '/api/erp/v2/repayment/page';
  //还款单选择
  static const String choose_repayment_order = '/api/erp/v2/repayment/credit/page';

  //还款单选择全量查询
  static const String choose_repayment_order_list = '/api/erp/v2/repayment/credit/list';

  //新增欠款
  static const String add_debt = '/api/erp/v2/repayment/credit';
  //删除还款单
  static const String debt_invalid = '/api/erp/v2/repayment/invalid';

}