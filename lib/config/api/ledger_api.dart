class LedgerApi {
  static const String ledger_list = '/api/erp/v2/ledger/list';

  static const String ledger_user_list = '/api/erp/v2/ledger/users';

  static const String ledger_invite = '/api/erp/v2/invite/save';

  //账本切换
  static const String ledger_change = '/api/erp/v2/ledger/switch/active';

  //账本删除
  static const String ledger_delete = '/api/erp/v2/ledger/remove';

  static const String ledger_name = '/api/erp/v2/ledger/name';

//创建账本
  static const String add_ledger = '/api/erp/v2/ledger/create';

//拉取账本详情
  static const String ledger_detail = '/api/erp/v2/ledger/detail';

//更新账本详情
  static const String update_ledger = '/api/erp/v2/ledger/update';
}
