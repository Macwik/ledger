import 'package:ledger/middlewares/router_auth.dart';
import 'package:ledger/modules/account/account/account_binding.dart';
import 'package:ledger/modules/account/account/account_view.dart';
import 'package:ledger/modules/account/business_condition/business_condition_binding.dart';
import 'package:ledger/modules/account/business_condition/business_condition_view.dart';
import 'package:ledger/modules/account/daily_account/daily_account_binding.dart';
import 'package:ledger/modules/account/daily_account/daily_account_view.dart';
import 'package:ledger/modules/account/daily_account_cost_detail/daily_account_cost_detail_binding.dart';
import 'package:ledger/modules/account/daily_account_cost_detail/daily_account_cost_detail_view.dart';
import 'package:ledger/modules/account/more/more_binding.dart';
import 'package:ledger/modules/account/more/more_view.dart';
import 'package:ledger/modules/funds/add_debt/add_debt_binding.dart';
import 'package:ledger/modules/funds/add_debt/add_debt_view.dart';
import 'package:ledger/modules/funds/binding_sale_bill/binding_sale_bill_binding.dart';
import 'package:ledger/modules/funds/binding_sale_bill/binding_sale_bill_view.dart';
import 'package:ledger/modules/funds/cost_bill/cost_bill_binding.dart';
import 'package:ledger/modules/funds/cost_bill/cost_bill_view.dart';
import 'package:ledger/modules/funds/cost_detail/cost_detail_binding.dart';
import 'package:ledger/modules/funds/cost_detail/cost_detail_view.dart';
import 'package:ledger/modules/funds/cost_record/cost_record_binding.dart';
import 'package:ledger/modules/funds/cost_record/cost_record_view.dart';
import 'package:ledger/modules/funds/cost_type/cost_type_binding.dart';
import 'package:ledger/modules/funds/cost_type/cost_type_view.dart';
import 'package:ledger/modules/funds/funds/funds_binding.dart';
import 'package:ledger/modules/funds/funds/funds_view.dart';
import 'package:ledger/modules/home/home_binding.dart';
import 'package:ledger/modules/home/home_view.dart';
import 'package:ledger/modules/login/login_index/login_index_binding.dart';
import 'package:ledger/modules/login/login_index/login_index_view.dart';
import 'package:get/get.dart';
import 'package:ledger/modules/login/login_verify/login_verify_binding.dart';
import 'package:ledger/modules/login/login_verify/login_verify_view.dart';

import 'package:ledger/modules/login/register/register_binding.dart';
import 'package:ledger/modules/login/register/register_view.dart';
import 'package:ledger/modules/main/main_binding.dart';
import 'package:ledger/modules/main/main_view.dart';

import 'package:ledger/modules/login/forget_password/forget_password_binding.dart';
import 'package:ledger/modules/login/forget_password/forget_password_view.dart';
import 'package:ledger/modules/purchase/add_product/add_product_binding.dart';
import 'package:ledger/modules/purchase/add_product/add_product_view.dart';
import 'package:ledger/modules/purchase/multi_unit_num/multi_unit_num_binding.dart';
import 'package:ledger/modules/purchase/multi_unit_num/multi_unit_num_view.dart';
import 'package:ledger/modules/purchase/purchase/purchase_binding.dart';
import 'package:ledger/modules/purchase/purchase/purchase_view.dart';
import 'package:ledger/modules/purchase/purchase_record/purchase_record_binding.dart';
import 'package:ledger/modules/purchase/purchase_record/purchase_record_view.dart';
import 'package:ledger/modules/purchase/remittance/remittance_binding.dart';
import 'package:ledger/modules/purchase/remittance/remittance_view.dart';
import 'package:ledger/modules/purchase/remittance_detail/remittance_detail_binding.dart';
import 'package:ledger/modules/purchase/remittance_detail/remittance_detail_view.dart';
import 'package:ledger/modules/purchase/remittance_record/remittance_record_binding.dart';
import 'package:ledger/modules/purchase/remittance_record/remittance_record_view.dart';
import 'package:ledger/modules/purchase/stock_list/stock_list_binding.dart';
import 'package:ledger/modules/purchase/stock_list/stock_list_view.dart';
import 'package:ledger/modules/purchase/unit/unit_binding.dart';
import 'package:ledger/modules/purchase/unit/unit_view.dart';
import 'package:ledger/modules/sale/add_custom/add_custom_binding.dart';
import 'package:ledger/modules/sale/add_custom/add_custom_view.dart';
import 'package:ledger/modules/sale/custom_detail/custom_detail_binding.dart';
import 'package:ledger/modules/sale/custom_detail/custom_detail_view.dart';
import 'package:ledger/modules/sale/custom_list/custom_list_binding.dart';
import 'package:ledger/modules/sale/custom_list/custom_list_view.dart';
import 'package:ledger/modules/sale/custom_record/custom_record_binding.dart';
import 'package:ledger/modules/sale/custom_record/custom_record_view.dart';
import 'package:ledger/modules/sale/choose_repayment_order/choose_repayment_order_binding.dart';
import 'package:ledger/modules/sale/choose_repayment_order/choose_repayment_order_view.dart';
import 'package:ledger/modules/sale/pending_order/pending_order_binding.dart';
import 'package:ledger/modules/sale/pending_order/pending_order_view.dart';
import 'package:ledger/modules/sale/pending_retail_bill/pending_retail_bill_binding.dart';
import 'package:ledger/modules/sale/pending_retail_bill/pending_retail_bill_view.dart';
import 'package:ledger/modules/sale/repayment_bill/repayment_bill_binding.dart';
import 'package:ledger/modules/sale/repayment_bill/repayment_bill_view.dart';
import 'package:ledger/modules/sale/repayment_detail/repayment_detail_binding.dart';
import 'package:ledger/modules/sale/repayment_detail/repayment_detail_view.dart';
import 'package:ledger/modules/sale/repayment_record/repayment_record_binding.dart';
import 'package:ledger/modules/sale/repayment_record/repayment_record_view.dart';
import 'package:ledger/modules/sale/retail_bill/retail_bill_binding.dart';
import 'package:ledger/modules/sale/retail_bill/retail_bill_view.dart';
import 'package:ledger/modules/sale/sale/sale_binding.dart';
import 'package:ledger/modules/sale/sale/sale_view.dart';
import 'package:ledger/modules/sale/sale_bill/sale_bill_binding.dart';
import 'package:ledger/modules/sale/sale_bill/sale_bill_view.dart';
import 'package:ledger/modules/sale/sale_detail/sale_detail_binding.dart';
import 'package:ledger/modules/sale/sale_detail/sale_detail_view.dart';
import 'package:ledger/modules/sale/sale_record/sale_record_binding.dart';
import 'package:ledger/modules/sale/sale_record/sale_record_view.dart';
import 'package:ledger/modules/sale/shopping_car/shopping_car_binding.dart';
import 'package:ledger/modules/sale/shopping_car/shopping_car_view.dart';
import 'package:ledger/modules/sale/shopping_car_list/shopping_car_list_binding.dart';
import 'package:ledger/modules/sale/shopping_car_list/shopping_car_list_view.dart';
import 'package:ledger/modules/sale/supplier_detail/supplier_detail_binding.dart';
import 'package:ledger/modules/sale/supplier_detail/supplier_detail_view.dart';
import 'package:ledger/modules/setting/about_us/about_us_binding.dart';
import 'package:ledger/modules/setting/about_us/about_us_view.dart';
import 'package:ledger/modules/setting/account_manage/account_manage_binding.dart';
import 'package:ledger/modules/setting/account_manage/account_manage_view.dart';
import 'package:ledger/modules/setting/account_setting/account_setting_binding.dart';
import 'package:ledger/modules/setting/account_setting/account_setting_view.dart';
import 'package:ledger/modules/setting/add_account/add_account_binding.dart';
import 'package:ledger/modules/setting/add_account/add_account_view.dart';
import 'package:ledger/modules/setting/add_role/add_role_binding.dart';
import 'package:ledger/modules/setting/add_role/add_role_view.dart';
import 'package:ledger/modules/setting/auth/auth_update_binding.dart';
import 'package:ledger/modules/setting/auth/auth_update_view.dart';
import 'package:ledger/modules/setting/employee/employee_binding.dart';
import 'package:ledger/modules/setting/employee/employee_view.dart';
import 'package:ledger/modules/setting/employee_manage/employee_manage_binding.dart';
import 'package:ledger/modules/setting/employee_manage/employee_manage_view.dart';
import 'package:ledger/modules/setting/empty/empty_binding.dart';
import 'package:ledger/modules/setting/empty/empty_view.dart';
import 'package:ledger/modules/setting/first_index/first_index_binding.dart';
import 'package:ledger/modules/setting/first_index/first_index_view.dart';
import 'package:ledger/modules/setting/invite_employee/invite_employee_binding.dart';
import 'package:ledger/modules/setting/invite_employee/invite_employee_view.dart';
import 'package:ledger/modules/setting/logout_app/logout_app_binding.dart';
import 'package:ledger/modules/setting/logout_app/logout_app_view.dart';
import 'package:ledger/modules/setting/mine/mine_binding.dart';
import 'package:ledger/modules/setting/mine/mine_view.dart';
import 'package:ledger/modules/setting/mine_detail/mine_detail_binding.dart';
import 'package:ledger/modules/setting/mine_detail/mine_detail_view.dart';
import 'package:ledger/modules/setting/my_account/my_account_binding.dart';
import 'package:ledger/modules/setting/my_account/my_account_view.dart';
import 'package:ledger/modules/setting/payment_manage/payment_manage_binding.dart';
import 'package:ledger/modules/setting/payment_manage/payment_manage_view.dart';
import 'package:ledger/modules/setting/repayment_time_manage/repayment_time_manage_binding.dart';
import 'package:ledger/modules/setting/repayment_time_manage/repayment_time_manage_view.dart';
import 'package:ledger/modules/setting/permission_manage/permission_manage_binding.dart';
import 'package:ledger/modules/setting/permission_manage/permission_manage_view.dart';
import 'package:ledger/modules/stock/add_stock_detail/add_stock_detail_binding.dart';
import 'package:ledger/modules/stock/add_stock_detail/add_stock_detail_view.dart';
import 'package:ledger/modules/stock/goods_detail/goods_detail_binding.dart';
import 'package:ledger/modules/stock/goods_detail/goods_detail_view.dart';
import 'package:ledger/modules/stock/product_credit/product_credit_binding.dart';
import 'package:ledger/modules/stock/product_credit/product_credit_view.dart';
import 'package:ledger/modules/stock/product_detail/product_detail_binding.dart';
import 'package:ledger/modules/stock/product_detail/product_detail_view.dart';
import 'package:ledger/modules/stock/product_type_manage/product_type_manage_binding.dart';
import 'package:ledger/modules/stock/product_type_manage/product_type_manage_view.dart';
import 'package:ledger/modules/stock/stock/stock_binding.dart';
import 'package:ledger/modules/stock/stock/stock_view.dart';
import 'package:ledger/modules/stock/stock_change_bill/stock_change_bill_binding.dart';
import 'package:ledger/modules/stock/stock_change_bill/stock_change_bill_view.dart';
import 'package:ledger/modules/stock/stock_change_detail/stock_change_detail_binding.dart';
import 'package:ledger/modules/stock/stock_change_detail/stock_change_detail_view.dart';
import 'package:ledger/modules/stock/stock_change_record/stock_change_record_binding.dart';
import 'package:ledger/modules/stock/stock_change_record/stock_change_record_view.dart';

class RouteConfig {
  static const String home = '/page/home';
  static const String empty = '/page/setting/empty';
  static const String main = '/page/main';
  static const String register = '/page/register';
  static const String login = '/page/login';
  static const String loginIndex = '/page/login/index';
  static const String loginVerify = '/page/login/verify';
  static const String forgetPassword = '/page/forget/password';
  static const String mine = '/page/setting/mine';
  static const String mineDetail = '/page/setting/mine/detail';
  static const String aboutUs = '/page/setting/about/us';
  static const String employeeManage = '/page/setting/employee/manage';
  static const String inviteEmployee = '/page/setting/invite/employee';
  static const String permissionManage = '/page/permission/manage';
  static const String employee = '/page/employee';
  static const String addRole = '/page/add/role';
  static const String myAccount = '/page/my/account';
  static const String addAccount = '/page/add/account';
  static const String accountManage = '/page/account/manage';
  static const String dataExport = '/page/data/export';
  static const String purchase = '/page/purchase';
  static const String sale = '/page/sale';
  static const String stock = '/page/stock';
  static const String funds = '/page/funds';
  static const String account = '/page/account';
  static const String addProduct = '/page/add/product';
  static const String remittance = '/page/remittance';
  static const String stockChangeRecord = '/page/stock/change/record';
  static const String customDetail = '/page/custom/detail';
  static const String addDebt = '/page/add/debt';
  static const String saleRecord = '/page/sale/record';
  static const String saleBill = '/page/sale/bill';
  static const String goodsDetail = '/page/goods/detail';
  static const String remittanceRecord = '/page/remittance/record';
  static const String costRecord = '/page/cost/record';
  static const String saleDetail = '/page/sale/detail';
  static const String purchaseDetail = '/page/purchase/detail';
  static const String costBill = '/page/cost/bill';
  static const String customRecord = '/page/custom/record';
  static const String supplierDetail = '/page/supplier/detail';
  static const String chooseRepaymentOrder = '/page/choose/repayment/order';
  static const String unit = '/page/unit';
  static const String repaymentDetail = '/page/repayment/detail';
  static const String costType = '/page/cost/type';
  static const String multiUnitNum = '/page/multi/unit/num';
  static const String bindingSaleBill = '/page/binding/sale/bill';
  static const String businessCondition = '/page/business/condition';
  static const String dailyAccount = '/page/daily/account';
  static const String addCustom = '/page/add/custom';
  static const String stockList = '/page/stock/list';
  static const String remittanceDetail = '/page/remittance/detail';
  static const String costDetail = '/page/cost/detail';
  static const String productDetail = '/page/product/detail';
  static const String shoppingCar = '/page/shopping/car';
  static const String paymentManage = '/page/payment/manage';
  static const String accountSetting = '/page/account/setting';
  static const String repaymentBill = '/page/repayment/bill';
  static const String repaymentRecord = '/page/repayment/record';
  static const String stockChangeBill = '/page/stock/change/bill';
  static const String stockChangeDetail = '/page/stock/change/detail';
  static const String decimalSetting = '/page/decimal/setting';
  static const String customList = '/page/custom/list';
  static const String productCredit = '/page/product/credit';
  static const String logoutApp = '/page/logout/app';
  static const String authUpdate = '/page/auth/update';
  static const String dailyAccountCostDetail = '/page/daily/account/cost/detail';
  static const String productTypeManage = '/page/product/type/manage';
  static const String pendingOrder = '/page/pending/order';
   static const String more = '/page/more';
  static const String addStockDetail= '/page/add/stock/detail';
  static const String retailBill = '/page/retail/bill';
  static const String shoppingCarList = '/page/shopping/car/list';
  static const String pendingRetailBill = '/page/pending/retail/bill';
  static const String purchaseRecord = '/page/purchase/record';
  static const String repaymentTimeManage = '/page/repayment/time/manage';
  static const String firstIndex = '/page/first/index';

  static final List<GetPage> getPages = [
    GetPage(name: home, page: () => HomeView(), binding: HomeBinding()),
    GetPage(name: empty, page: () => EmptyView(), binding: EmptyBinding()),
    GetPage(
        name: loginIndex,
        page: () => LoginIndexView(),
        binding: LoginIndexBinding()),
    GetPage(
        name: loginVerify,
        page: () => LoginVerifyView(),
        binding: LoginVerifyBinding()),
    GetPage(
        name: register, page: () => RegisterView(), binding: RegisterBinding()),
    GetPage(
        name: forgetPassword,
        page: () => ForgetPasswordView(),
        binding: ForgetPasswordBinding()),
    GetPage(
      name: main,
      page: () => MainView(),
      binding: MainBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 0),
      ],
    ),
    GetPage(name: mine, page: () => MineView(), binding: MineBinding()),
    GetPage(
        name: mineDetail,
        page: () => MineDetailView(),
        binding: MineDetailBinding()),
    GetPage(
        name: aboutUs, page: () => AboutUsView(), binding: AboutUsBinding()),
    GetPage(
        name: employeeManage,
        page: () => EmployeeManageView(),
        binding: EmployeeManageBinding()),
    GetPage(
        name: inviteEmployee,
        page: () => InviteEmployeeView(),
        binding: InviteEmployeeBinding()),
    GetPage(
        name: permissionManage,
        page: () => PermissionManageView(),
        binding: PermissionManageBinding()),
    GetPage(
        name: employee, page: () => EmployeeView(), binding: EmployeeBinding()),
    GetPage(
        name: addRole, page: () => AddRoleView(), binding: AddRoleBinding()),
    GetPage(
        name: myAccount,
        page: () => MyAccountView(),
        binding: MyAccountBinding()),
    GetPage(
        name: addAccount,
        page: () => AddAccountView(),
        binding: AddAccountBinding()),
    GetPage(
        name: accountManage,
        page: () => AccountManageView(),
        binding: AccountManageBinding()),
    GetPage(
        name: purchase, page: () => PurchaseView(), binding: PurchaseBinding()),
    GetPage(name: sale, page: () => SaleView(), binding: SaleBinding()),
    GetPage(name: stock, page: () => StockView(), binding: StockBinding()),
    GetPage(name: funds, page: () => FundsView(), binding: FundsBinding()),
    GetPage(
        name: account, page: () => AccountView(), binding: AccountBinding()),
    GetPage(
        name: addProduct,
        page: () => AddProductView(),
        binding: AddProductBinding()),
    GetPage(
        name: remittance,
        page: () => RemittanceView(),
        binding: RemittanceBinding()),
    GetPage(
        name: stockChangeRecord,
        page: () => StockChangeRecordView(),
        binding: StockChangeRecordBinding()),
    GetPage(
        name: addCustom,
        page: () => AddCustomView(),
        binding: AddCustomBinding()),
    GetPage(
        name: addDebt, page: () => AddDebtView(), binding: AddDebtBinding()),
    GetPage(
        name: saleRecord,
        page: () => SaleRecordView(),
        binding: SaleRecordBinding()),
    GetPage(
        name: saleBill, page: () => SaleBillView(), binding: SaleBillBinding()),
    GetPage(
        name: goodsDetail,
        page: () => GoodsDetailView(),
        binding: GoodsDetailBinding()),
    GetPage(
        name: remittanceRecord,
        page: () => RemittanceRecordView(),
        binding: RemittanceRecordBinding()),
    GetPage(
        name: costRecord,
        page: () => CostRecordView(),
        binding: CostRecordBinding()),
    GetPage(
        name: saleDetail,
        page: () => SaleDetailView(),
        binding: SaleDetailBinding()),
    GetPage(
        name: costBill, page: () => CostBillView(), binding: CostBillBinding()),
    GetPage(
        name: customRecord,
        page: () => CustomRecordView(),
        binding: CustomRecordBinding()),
    GetPage(
        name: supplierDetail,
        page: () => SupplierDetailView(),
        binding: SupplierDetailBinding()),
    GetPage(
        name: chooseRepaymentOrder,
        page: () => ChooseRepaymentOrderView(),
        binding: ChooseRepaymentOrderBinding()),
    GetPage(name: unit, page: () => UnitView(), binding: UnitBinding()),
    GetPage(
        name: repaymentDetail,
        page: () => RepaymentDetailView(),
        binding: RepaymentDetailBinding()),
    GetPage(
        name: costType, page: () => CostTypeView(), binding: CostTypeBinding()),
    GetPage(
        name: multiUnitNum,
        page: () => MultiUnitNumView(),
        binding: MultiUnitNumBinding()),
    GetPage(
        name: bindingSaleBill,
        page: () => BindingSaleBillView(),
        binding: BindingSaleBillBinding()),
    GetPage(
        name: businessCondition,
        page: () => BusinessConditionView(),
        binding: BusinessConditionBinding()),
    GetPage(
        name: dailyAccount,
        page: () => DailyAccountView(),
        binding: DailyAccountBinding()),
    GetPage(
        name: customDetail,
        page: () => CustomDetailView(),
        binding: CustomDetailBinding()),
    GetPage(
        name: stockList,
        page: () => StockListView(),
        binding: StockListBinding()),
    GetPage(
        name: remittanceDetail,
        page: () => RemittanceDetailView(),
        binding: RemittanceDetailBinding()),
    GetPage(
        name: costDetail,
        page: () => CostDetailView(),
        binding: CostDetailBinding()),
    GetPage(
        name: productDetail,
        page: () => ProductDetailView(),
        binding: ProductDetailBinding()),
    GetPage(
        name: shoppingCar,
        page: () => ShoppingCarView(),
        binding: ShoppingCarBinding()),
    GetPage(
        name: paymentManage,
        page: () => PaymentManageView(),
        binding: PaymentManageBinding()),
    GetPage(
        name: accountSetting,
        page: () => AccountSettingView(),
        binding: AccountSettingBinding()),
    GetPage(
        name: repaymentBill,
        page: () => RepaymentBillView(),
        binding: RepaymentBillBinding()),
    GetPage(
        name: repaymentRecord,
        page: () => RepaymentRecordView(),
        binding: RepaymentRecordBinding()),
    GetPage(
        name: stockChangeBill,
        page: () => StockChangeBillView(),
        binding: StockChangeBillBinding()),
    GetPage(
        name: stockChangeDetail,
        page: () => StockChangeDetailView(),
        binding: StockChangeDetailBinding()),
    GetPage(
        name: customList,
        page: () => CustomListView(),
        binding: CustomListBinding()),
    GetPage(
        name: productCredit,
        page: () => ProductCreditView(),
        binding: ProductCreditBinding()),
    GetPage(
        name: logoutApp,
        page: () => LogoutAppView(),
        binding: LogoutAppBinding()),
    GetPage(
        name: authUpdate,
        page: () => AuthUpdateView(),
        binding: AuthUpdateBinding()),
    GetPage(
        name: dailyAccountCostDetail,
        page: () => DailyAccountCostDetailView(),
        binding: DailyAccountCostDetailBinding()),
    GetPage(
        name: productTypeManage,
        page: () => ProductTypeManageView(),
        binding: ProductTypeManageBinding()),
    GetPage(
        name: pendingOrder,
        page: () => PendingOrderView(),
        binding: PendingOrderBinding()),
    GetPage(
        name: more,
        page: () => MoreView(),
        binding: MoreBinding()),
    GetPage(
        name: addStockDetail,
        page: () => AddStockDetailView(),
        binding: AddStockDetailBinding()),
    GetPage(
        name: retailBill,
        page: () => RetailBillView(),
        binding: RetailBillBinding()),
    GetPage(
        name: shoppingCarList,
        page: () => ShoppingCarListView(),
        binding: ShoppingCarListBinding()),
    GetPage(
        name: pendingRetailBill,
        page: () => PendingRetailBillView(),
        binding: PendingRetailBillBinding()),
    GetPage(
        name: purchaseRecord,
        page: () => PurchaseRecordView(),
        binding: PurchaseRecordBinding()),
    GetPage(
        name: repaymentTimeManage,
        page: () => RepaymentTimeManageView(),
        binding: RepaymentTimeManageBinding()),
    GetPage(
        name: firstIndex,
        page: () => FirstIndexView(),
        binding: FirstIndexBinding()),
  ];
}
