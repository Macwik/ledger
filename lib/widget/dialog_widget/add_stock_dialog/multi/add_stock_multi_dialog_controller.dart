import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/util/decimal_util.dart';

class AddStockMultiDialogController extends GetxController {
  final TextEditingController masterStockController = TextEditingController();
  final TextEditingController slaveStockController = TextEditingController();



  void updateMasterStock(UnitDetailDTO? unitDetailDTO) {
    var masterStock = masterStockController.text;
    if (masterStock.isNotEmpty) {
      return;
    }
    var slaveStockStr = slaveStockController.text;
    Decimal? slaveStock = Decimal.tryParse(slaveStockStr);
    Decimal? conversion = unitDetailDTO?.conversion;
    if (null != slaveStock && null != conversion) {
      masterStockController.text = DecimalUtil.multiply(slaveStock, conversion);
    }
  }

  void updateSlaveStock(UnitDetailDTO? unitDetailDTO) {
    var slaveStock = slaveStockController.text;
    if (slaveStock.isNotEmpty) {
      return;
    }
    var masterStockStr = masterStockController.text;
    Decimal? masterStock = Decimal.tryParse(masterStockStr);
    Decimal? conversion = unitDetailDTO?.conversion;
    if (null != masterStock && null != conversion) {
      slaveStockController.text = DecimalUtil.formatDecimal(
          DecimalUtil.divide(masterStock, conversion));
    }
  }

}
