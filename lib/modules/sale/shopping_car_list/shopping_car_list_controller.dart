import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/enum/unit_type.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';

import 'shopping_car_list_state.dart';

class ShoppingCarListController extends GetxController {
  final ShoppingCarListState state = ShoppingCarListState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['shoppingCar'] != null) {
      state.shoppingCarList = arguments['shoppingCar'];
    }
    update(['shopping_car_list_title', 'shopping_car_list_detail']);
  }

  void toDeleteOrder(ProductShoppingCarDTO productShoppingCarDTO) {
    Get.dialog(
      Warning(
          cancel: '取消',
          confirm: '确定',
          content: '确认删除此条吗？',
          onCancel: () {},
          onConfirm: () {
            state.shoppingCarList.remove(productShoppingCarDTO);
            if (state.shoppingCarList.isEmpty) {
              state.totalAmount = Decimal.zero;
            } else {
              state.totalAmount = state.shoppingCarList
                  .map((e) => (e.unitDetailDTO?.totalAmount ?? Decimal.zero))
                  .reduce((value, element) => value + element);
            }
            if (productShoppingCarDTO.unitDetailDTO?.unitType ==
                UnitType.SINGLE.value) {
              state.totalNumber = state.totalNumber -
                  (productShoppingCarDTO.unitDetailDTO?.number ?? Decimal.zero);
            } else {
              state.totalNumber = state.totalNumber -
                  (productShoppingCarDTO.unitDetailDTO?.slaveNumber ??
                      Decimal.zero);
            }
            update(['shopping_car_list_detail', 'shopping_car_list_title']);
            Toast.show('删除成功');
          }),
    );
  }

  String? getPrice(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.SINGLE.value == unitType) {
      if (unitDetailDTO.price == null) {
        return '/';
      }
      return '${unitDetailDTO.price}元/${unitDetailDTO.unitName}';
    } else {
      if (unitDetailDTO.selectMasterUnit ?? true) {
        if ((unitDetailDTO.masterPrice == null) &&
            (unitDetailDTO.slaveNumber == null)) {
          return '/';
        }
        return '${unitDetailDTO.masterPrice}元/${unitDetailDTO.masterUnitName}';
      }
      return '${unitDetailDTO.slavePrice}元/${unitDetailDTO.slaveUnitName}';
    }
  }

  String? getNum(UnitDetailDTO unitDetailDTO) {
    var unitType = unitDetailDTO.unitType;
    if (UnitType.SINGLE.value == unitType) {
      if (unitDetailDTO.number == null) {
        return '/';
      }
      return '${DecimalUtil.formatDecimalNumber(unitDetailDTO.number)} ${unitDetailDTO.unitName}';
    } else {
      return '${DecimalUtil.formatDecimalNumber(unitDetailDTO.slaveNumber)} ${unitDetailDTO.slaveUnitName}'
          ' | ${DecimalUtil.formatDecimalNumber(unitDetailDTO.masterNumber)} ${unitDetailDTO.masterUnitName}';
    }
  }

  //计算数量
  Decimal getShoppingCarTotalNumber() {
    var shoppingCarList = state.shoppingCarList;
    if (shoppingCarList.isEmpty) {
      return Decimal.zero;
    }
    return shoppingCarList.fold(Decimal.zero, (previousValue, element) {
      if (element.unitDetailDTO?.unitType == UnitType.SINGLE.value) {
        return previousValue + (element.unitDetailDTO?.number ?? Decimal.zero);
      } else {
        return previousValue +
            (element.unitDetailDTO?.slaveNumber ?? Decimal.zero);
      }
    });
  }

  // 计算金额
  String? getTotalAmount() {
    var totalAmount = Decimal.zero;
    for (var element in state.shoppingCarList) {
      totalAmount = totalAmount + element.unitDetailDTO!.totalAmount!;
    }
    state.totalAmount = totalAmount;
    return DecimalUtil.formatDecimalDefault(totalAmount);
  }
}
