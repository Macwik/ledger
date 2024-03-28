import 'package:ledger/entity/contact/contact_dto.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/is_select.dart';

class CustomListState {
  CustomListState() {
    ///Initialize variables
  }

  List<ContactDTO> contactList = [];

  Set<String> customNameSet = <String>{};

  int? ledgerId;

  /// TRUE  通讯录导入  | FALSE  其他账本导入
  int? isAddressList = IsSelectType.FALSE.value;

  CustomType? customType;

}
