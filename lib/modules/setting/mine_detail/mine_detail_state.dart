import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/entity/user/user_detail_dto.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';
import 'package:ledger/enum/change_status.dart';
import 'package:ledger/store/store_controller.dart';

class MineDetailState {
  List<RoleDTO>? roleList;

  UserDetailDTO? userDetailDTO;

  ChangeStatus changeStatus = ChangeStatus.NO_CHANGE;

  MineDetailState() {
    ///Initialize variables
  }
  final UserDTOEntity? user = StoreController.to.getUser();
}
