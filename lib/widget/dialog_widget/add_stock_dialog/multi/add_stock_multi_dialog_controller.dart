import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/util/decimal_util.dart';

class AddStockMultiDialogController extends GetxController {
  final TextEditingController masterNumberController = TextEditingController();
  final TextEditingController slaveNumberController = TextEditingController();



  void updateMasterStock(UnitDetailDTO? unitDetailDTO) {
    var masterStock = masterNumberController.text;
    if (masterStock.isNotEmpty) {
      return;
    }
    var slaveStockStr = slaveNumberController.text;
    Decimal? slaveStock = Decimal.tryParse(slaveStockStr);
    Decimal? conversion = unitDetailDTO?.conversion;
    if (null != slaveStock && null != conversion) {
      masterNumberController.text = DecimalUtil.multiply(slaveStock, conversion);
    }
  }

  void updateSlaveStock(UnitDetailDTO? unitDetailDTO) {
    var slaveStock = slaveNumberController.text;
    if (slaveStock.isNotEmpty) {
      return;
    }
    var masterStockStr = masterNumberController.text;
    Decimal? masterStock = Decimal.tryParse(masterStockStr);
    Decimal? conversion = unitDetailDTO?.conversion;
    if (null != masterStock && null != conversion) {
      slaveNumberController.text = DecimalUtil.formatDecimal(
          DecimalUtil.divide(masterStock, conversion));
    }
  }

}
