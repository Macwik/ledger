import 'package:get/get.dart';
import 'package:ledger/entity/product/stock_change_record_dto.dart';
import 'package:ledger/enum/unit_type.dart';

import 'stock_change_detail_state.dart';

class StockChangeDetailController extends GetxController {
  final StockChangeDetailState state = StockChangeDetailState();

  Future<void> initState() async{
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['stockChangeRecordDTO'] != null) {
      state.stockChangeRecordDTO  = arguments['stockChangeRecordDTO'];
    }

  }

  String getDiff(StockChangeRecordDTO? recordDTO) {
    if(null == recordDTO){
      return '-';
    }
    if(recordDTO.unitType == UnitType.SINGLE.value){
      return '${recordDTO.afterStock! - recordDTO.beforeStock!} ${recordDTO.unitName}';
    }else{
      return '${recordDTO.afterMasterStock! - recordDTO.beforeMasterStock!} ${recordDTO.masterUnitName}| ${recordDTO.afterSlaveStock! - recordDTO.beforeSlaveStock!} ${recordDTO.slaveUnitName}';
    }
  }

  String afterCount(StockChangeRecordDTO? afterRecordDTO) {
    if(null == afterRecordDTO){
      return '-';
    }
    if(afterRecordDTO.unitType == UnitType.SINGLE.value){
      return '${afterRecordDTO.afterStock! - afterRecordDTO.beforeStock!} ${afterRecordDTO.unitName}';
    }else{
      return '${afterRecordDTO.afterMasterStock!} ${afterRecordDTO.masterUnitName}| ${afterRecordDTO.afterSlaveStock!} ${afterRecordDTO.slaveUnitName}';
    }
  }

  String beforeCount(StockChangeRecordDTO? beforeRecordDTO) {
    if(null == beforeRecordDTO){
      return '-';
    }
    if(beforeRecordDTO.unitType == UnitType.SINGLE.value){
      return '${beforeRecordDTO.beforeStock!} ${beforeRecordDTO.unitName}';
    }else{
      return '${beforeRecordDTO.beforeMasterStock!} ${beforeRecordDTO.masterUnitName}| ${beforeRecordDTO.beforeSlaveStock!} ${beforeRecordDTO.slaveUnitName}';
    }
  }
}
