import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/product_api.dart';
import 'package:ledger/entity/product/product_sales_statistics_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';

import 'goods_detail_state.dart';

class GoodsDetailController extends GetxController {
  final GoodsDetailState state = GoodsDetailState();

Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['productDTO'] != null) {
      state.productDTO = arguments['productDTO'];
    }
    _queryData();
  }

  _queryData(){
    Http().network<ProductSalesStatisticsDTO>(
        Method.post, ProductApi.product_statistics,
        data: {
          'productId': state.productDTO?.id,
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate)
        }).then((result) {
      if (result.success) {
        state.productSalesStatisticsDTO = result.d;
        update(['goods_detail_product_sales_statistics']);
      } else {
        Toast.show(result.m.toString());
      }
    });
  }

  String judgeUnit() {
  var productSalesStatistics =state.productSalesStatisticsDTO;
    if (null == productSalesStatistics) {
      return '-';
    }
    if (productSalesStatistics.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalNumber(productSalesStatistics.salesNumber)} | ${productSalesStatistics.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalNumber(productSalesStatistics.salesMasterNumber)} ${productSalesStatistics.masterUnitName} | ${DecimalUtil.formatDecimalNumber(productSalesStatistics.salesSlaveNumber)} ${productSalesStatistics.slaveUnitName}';
    }
  }

  String judgePurchaseUnit() {
    var productSalesStatistics =state.productSalesStatisticsDTO;
    if (null == productSalesStatistics) {
      return '-';
    }
    if (productSalesStatistics.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalNumber(productSalesStatistics.purchaseNumber)} | ${productSalesStatistics.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalNumber(productSalesStatistics.purchaseMasterNumber)} ${productSalesStatistics.masterUnitName} | ${DecimalUtil.formatDecimalNumber(productSalesStatistics.purchaseSlaveNumber)} ${productSalesStatistics.slaveUnitName}';
    }
  }

  void toProductDetail() {
    Get.toNamed(RouteConfig.productDetail,arguments: {'id':state.productDTO?.id})?.then((value){
      if (ProcessStatus.OK == value) {
        //成功后再拉一次数据，目前后台没接口，就不写了
      }
    });
  }

  void explainSalesAmount() {
    Get.dialog(AlertDialog(
        title: Text('销售实收'),
        content: Text('销售实收是销售货物实际收款金额之和，不包含赊账金额',
            style: TextStyle(
              color: Colours.text_333,
              fontSize: 32.sp,
            )),
        actions: [
          TextButton(
            child: Text('了解了'),
            onPressed: () {
              Get.back();
            },
          ),
        ]));
  }

  void explainPurchaseAmount() {
    Get.dialog(AlertDialog(
        title: Text('采购实付'),
        content:
            Text('采购实付是采购货物实际付款金额之和，不包含赊账金额',
                style: TextStyle(
                  color: Colours.text_333,
                  fontSize: 32.sp,
                )),
        actions: [
          TextButton(
            child: Text('了解了'),
            onPressed: () {
              Get.back();
            },
          ),
        ]));
  }

  String saleDiscountAmount() {
  var saleDiscountAmount = (state.productSalesStatisticsDTO?.salesDiscountAmount??Decimal.zero)
      + (state.productSalesStatisticsDTO?.salesRepaymentDiscountAmount??Decimal.zero);
   return DecimalUtil.formatAmount(saleDiscountAmount);
  }

  String purchaseDiscountAmount() {
    var purchaseDiscountAmount = (state.productSalesStatisticsDTO?.purchaseDiscountAmount??Decimal.zero)
        + (state.productSalesStatisticsDTO?.purchaseRepaymentDiscountAmount??Decimal.zero);
    return DecimalUtil.formatAmount(purchaseDiscountAmount);
  }

  String profitAmount() {
    var saleAmount = ((state.productSalesStatisticsDTO?.salesTotalAmount??Decimal.zero)
    -(state.productSalesStatisticsDTO?.salesRepaymentDiscountAmount??Decimal.zero)
    - (state.productSalesStatisticsDTO?.salesDiscountAmount??Decimal.zero)
    - (state.productSalesStatisticsDTO?.salesCreditAmount??Decimal.zero));
    var purchaseAmount  = ((state.productSalesStatisticsDTO?.purchaseTotalAmount??Decimal.zero)
        -(state.productSalesStatisticsDTO?.purchaseRepaymentDiscountAmount??Decimal.zero)
        - (state.productSalesStatisticsDTO?.purchaseDiscountAmount??Decimal.zero)
        - (state.productSalesStatisticsDTO?.purchaseCreditAmount??Decimal.zero));
    return DecimalUtil.formatAmount(saleAmount-purchaseAmount-(state.productSalesStatisticsDTO?.costTotalAmount??Decimal.zero));
  }

  String stockNumber() {
  var product = state.productDTO;
    if (null == product) {
      return '-';
    }
    if (product.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
      return '${DecimalUtil.formatDecimalNumber(product.unitDetailDTO?.stock)} ${product.unitDetailDTO?.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalNumber(product.unitDetailDTO?.masterStock )} ${product.unitDetailDTO?.masterUnitName} | ${product.unitDetailDTO?.slaveStock ?? '0'} ${product.unitDetailDTO?.slaveUnitName}';
    }
  }

  void changeDateSaleProduct() {
    _queryData();
  }
}
