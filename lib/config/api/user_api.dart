class UserApi{
  //登录
  static const String login = '/api/erp/v2/user/login';

  //退出登录
  static const String logout = '/api/erp/v2/user/logout';

  static const String verify_code = '/api/erp/v2/msg/verify';

  static const String user_status = '/api/erp/v2/verify/check';

  //注册
  static const String register = '/api/erp/v2/user/register';

  //获取用户信息
  static const String user_detail = '/api/erp/v2/user/detail';

  //获取用户列表信息
  static const String user_info = '/api/erp/v2/user/user/info';

  //获取库存列表信息
  static const String product_list = '/api/erp/v2/product/list';

  //分页获取商品
  static const String product_page = '/api/erp/v2/product/page';


  //修改昵称
  static const String edit_nickname = '/api/erp/v2/user/username/update';

  //修改密码
  static const String edit_password = '/api/erp/v2/user/psd/update';

  //注销账号
  static const String logout_forever = '/api/erp/v2/user/account/close';
}