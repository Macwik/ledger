import 'package:ledger/entity/user/user_detail_dto.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';
import 'package:ledger/store/store_controller.dart';

class MineState {
  UserDetailDTO? userDetailDTO;

  MineState() {
    ///Initialize variables
  }
  final UserDTOEntity? user = StoreController.to.getUser();


}
