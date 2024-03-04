import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/entity/unit/unit_dto.dart';

class UnitState {

  List<UnitDTO>? unitList;
  UnitDetailDTO? unitDetailDTO;

  var pageMode = 0;

  UnitState() {
    ///Initialize variables
  }
}
