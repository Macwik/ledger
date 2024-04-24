import 'package:get/get.dart';
import 'package:ledger/config/api/repayment_api.dart';
import 'package:ledger/entity/repayment/repayment_bind_order_dto.dart';
import 'package:ledger/entity/repayment/repayment_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';

import 'repayment_detail_state.dart';

class RepaymentDetailController extends GetxController {
  final RepaymentDetailState state = RepaymentDetailState();

  Future<void> initState() async{
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['id'] != null) {
      state.id  = arguments['id'];
    }
    if ((arguments != null) && arguments['customType'] != null) {
      state.customType = arguments['customType'];
    }
    Http().network<RepaymentDetailDTO>(Method.get, RepaymentApi.repayment_detail,
        queryParameters: {'id': state.id}).then((result){
      if(result.success){
        state.repaymentDetailDTO = result.d;
        update(['repayment_order','repayment_title']);
      }else{
        Toast.show(result.m.toString());
      }
    });

  }

  String orderPayment() {
   var orderPaymentList = state.repaymentDetailDTO?.paymentDTOList;
    if (null == orderPaymentList || orderPaymentList.isEmpty) {
      return '0';
    }
    String result = '';
    for (var payment in orderPaymentList) {
      result = '$result${payment.paymentMethodName ?? ''}：¥${payment.paymentAmount}  ';
    }
    return result;
  }

  void toDeleteOrder() {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认作废此单吗？',
        onCancel: () {},
        onConfirm: () {
          Http().network(Method.put, RepaymentApi.debt_invalid, queryParameters: {
           'id': state.id,
          }).then((result) {
            if (result.success) {
              Toast.show('作废成功');
              Get.back(result: ProcessStatus.OK);
            } else {
              Toast.show(result.m.toString());
              //Get.back(result: ProcessStatus.FAIL);
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }

  void toOrderDetail(RepaymentBindOrderDTO repaymentBindOrder) {
    switch (repaymentBindOrder.creditType) {
      case 0://采购单
        Get.toNamed(RouteConfig.saleDetail, arguments: {'id': repaymentBindOrder.salesOrderId,'orderType':OrderType.PURCHASE});
      case 1://销售单
        Get.toNamed(RouteConfig.saleDetail, arguments: {'id': repaymentBindOrder.salesOrderId,'orderType':OrderType.SALE});
      case 2://销售退货单
        Get.toNamed(RouteConfig.saleDetail, arguments: {'id': repaymentBindOrder.salesOrderId,'orderType':OrderType.SALE_RETURN});
      case 3://采购退货单
        Get.toNamed(RouteConfig.saleDetail, arguments: {'id': repaymentBindOrder.salesOrderId,'orderType':OrderType.PURCHASE_RETURN});
      case 5://欠款单
        Toast.show('此单是录入欠款');
      case 10://欠款单
      Get.toNamed(RouteConfig.saleDetail, arguments: {'id': repaymentBindOrder.salesOrderId,'orderType':OrderType.REFUND});
      default:
        throw Exception('暂无详情');
    }
  }

  OrderType orderType(int? orderType) {
    switch (orderType) {
      case 0:
        return OrderType.PURCHASE;
      case  1:
        return OrderType.SALE;
      case  2:
        return OrderType.SALE_RETURN;
      case  3:
        return  OrderType.PURCHASE_RETURN;
      case  10:
        return  OrderType.REFUND;
      default:
        throw Exception('销售单');
    }
  }

  String creditType(int? type) {
    switch (type) {
      case 0:
        return '采购单';
      case 1:
        return '销售单';
      case 2:
        return '销售退货单';
      case 3:
        return '采购退货单';
      case 4:
        return '还款单';
      case 5:
        return '欠款单';
      case 10:
        return '仅退款';
      default:
        throw Exception('-');
    }
  }
}
