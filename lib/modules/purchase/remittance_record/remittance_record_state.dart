import 'package:decimal/decimal.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/remittance/remittance_dto.dart';

class RemittanceRecordState {
  final refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  int currentPage = 1;

  bool? hasMore;

  List<RemittanceDTO>? items;

  String? dateRange;

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  List<PaymentMethodDTO>? paymentMethodList;

  Decimal? totalRemittanceAmount = Decimal.zero;

  List<int>? selectPaymentMethodIdList;

  ProductDTO? productDTO;

  int get itemCount => paymentMethodList?.length ?? 0; //筛选里chip的数量

  var isSwitchedOn = false;

  String? searchContent ='';

  //已作废单据选择
  int? invalid =0 ;
}
