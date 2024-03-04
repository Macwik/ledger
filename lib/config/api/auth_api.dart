class AuthApi {
  static const String ledger_role_list = '/api/erp/v2/role/list';

  static const String add_role = '/api/erp/v2/role/save';

  //拉取特定员工详情
  static const String employee_detail = '/api/erp/v2/ledger/user/detail';

  //删除员工
  static const String employee_delete = '/api/erp/v2/ledger/user/remove';

  //员工详情更新
  static const String employee_upDate = '/api/erp/v2/ledger/user/update';

  static const String query_role_auth = '/api/erp/v2/authorization/role/tree';

  static const String list_role_auth = '/api/erp/v2/authorization/permission';

  static const String role_auth_update = '/api/erp/v2/authorization/permission/update';
}
