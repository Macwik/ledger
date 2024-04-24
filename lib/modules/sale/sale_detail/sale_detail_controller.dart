import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/order_api.dart';
import 'package:ledger/entity/order/order_detail_dto.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';
import 'package:ledger/entity/order/order_product_detail_dto.dart';
import 'package:ledger/enum/order_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';
import 'sale_detail_state.dart';

class SaleDetailController extends GetxController {
  final SaleDetailState state = SaleDetailState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['id'] != null) {
      state.id = arguments['id'];
    }
    if ((arguments != null) && arguments['orderType'] != null) {
      state.orderType = arguments['orderType'];
    }
    await Http().network<OrderDetailDTO>(Method.get, OrderApi.order_detail,
        queryParameters: {'id': state.id}).then((result) {
      if (result.success) {
        state.orderDetailDTO = result.d;
        update([
          'order_detail',
          'product_detail',
          'order_payment',
          'sale_detail_delete',
         // 'sale_detail_title',
          'order_cost'
        ]);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  void toDeleteOrder() {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认作废此单吗？',
        onCancel: () {},
        onConfirm: () {
          Http().network(Method.put, OrderApi.order_invalid, queryParameters: {
            'orderId': state.id,
          }).then((result) {
            if (result.success) {
              Toast.show('作废成功');
              Get.back(result: ProcessStatus.OK);
            } else {
              //Get.back(result: ProcessStatus.FAIL);
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }

  String judgeUnit(OrderProductDetail? orderProductDetail) {
    if (null == orderProductDetail) {
      return '-';
    }
    if (orderProductDetail.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalNumber(orderProductDetail.price)} 元/ ${orderProductDetail.unitName} *  ${DecimalUtil.formatDecimalNumber(orderProductDetail.number)} ${orderProductDetail.unitName}';
    } else {
      if (orderProductDetail.selectMasterUnit == 0) {
        return '${DecimalUtil.formatDecimalNumber(orderProductDetail.slavePrice)} 元/ ${orderProductDetail.slaveUnitName} *  ${DecimalUtil.formatDecimalNumber(orderProductDetail.slaveNumber)} ${orderProductDetail.slaveUnitName}';
      }
      return '${DecimalUtil.formatDecimalNumber(orderProductDetail.masterPrice)} 元/ ${orderProductDetail.masterUnitName} *  ${DecimalUtil.formatDecimalNumber(orderProductDetail.masterNumber)} ${orderProductDetail.masterUnitName} | ${DecimalUtil.formatDecimalNumber(orderProductDetail.slaveNumber)}${orderProductDetail.slaveUnitName}';
    }
  }

  String orderPayment(List<OrderPaymentDTO>? orderPaymentList) {
    if (null == orderPaymentList || orderPaymentList.isEmpty) {
      return '0';
    }
    String result = '';
    for (var payment in orderPaymentList) {
      if (state.orderType == OrderType.SALE_RETURN || state.orderType == OrderType.PURCHASE_RETURN|| state.orderType == OrderType.REFUND) {
        payment.paymentAmount = Decimal.fromInt(-1) * payment.paymentAmount!;
      }
      result = '$result${payment.paymentMethodName ?? ''}：¥${payment.paymentAmount}  ';
    }
    return result;
  }

  String title() {
    var type = state.orderType;
    switch (type) {
      case OrderType.PURCHASE:
        return '采购单';
      case OrderType.SALE:
        return '销售单';
      case OrderType.SALE_RETURN:
        return '销售退货单';
      case OrderType.PURCHASE_RETURN:
        return '采购退货单';
      case OrderType.REFUND:
        return '仅退款';
      case OrderType.ADD_STOCK:
        return '直接入库1';
      default:
        throw Exception('销售单');
    }
  }

  String orderTotalAmount() {
    if ((state.orderDetailDTO?.orderType == OrderType.SALE_RETURN.value) ||
        (state.orderDetailDTO?.orderType == OrderType.PURCHASE_RETURN.value)||
        (state.orderDetailDTO?.orderType == OrderType.REFUND.value)) {
      return DecimalUtil.formatNegativeAmount((state.orderDetailDTO?.totalAmount??Decimal.zero)-(state.orderDetailDTO?.discountAmount??Decimal.zero));
    } else {
      return DecimalUtil.formatAmount((state.orderDetailDTO?.totalAmount??Decimal.zero)-(state.orderDetailDTO?.discountAmount??Decimal.zero));
    }
  }

  String productAmount(OrderProductDetail? orderProductDetail) {
    if ((state.orderDetailDTO?.orderType == OrderType.SALE_RETURN.value) ||
        (state.orderDetailDTO?.orderType == OrderType.PURCHASE_RETURN.value)||
        (state.orderDetailDTO?.orderType == OrderType.REFUND.value)) {
      return '¥- ${orderProductDetail?.totalAmount}';
    } else {
      return DecimalUtil.formatAmount(orderProductDetail?.totalAmount);
    }
  }

  String totalCostAmount() {
    if (state.orderDetailDTO?.externalOrderBaseDTOList?.isEmpty ?? true) {
      return '0';
    }
    var totalCostAmount = state.orderDetailDTO!.externalOrderBaseDTOList!
        .map((e) => (e.totalAmount ?? Decimal.zero))
        .reduce((value, element) => value + element);
    return DecimalUtil.formatAmount(totalCostAmount);
  }

  String countChange() {
    return (state.orderDetailDTO?.orderType ==OrderType.SALE_RETURN.value) ||
        (state.orderDetailDTO?.orderType ==OrderType.PURCHASE_RETURN.value)||
        (state.orderDetailDTO?.orderType ==OrderType.REFUND.value)
        ?'(应付总额${DecimalUtil.formatNegativeAmount(state.orderDetailDTO?.totalAmount)}-抹零${DecimalUtil.formatNegativeAmount(state.orderDetailDTO?.discountAmount)})'
        :'(应付总额${DecimalUtil.formatAmount(state.orderDetailDTO?.totalAmount)}-抹零${DecimalUtil.formatAmount(state.orderDetailDTO?.discountAmount)})';
  }
}
