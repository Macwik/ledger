import 'package:ledger/entity/contact/contact_dto.dart';
import 'package:ledger/enum/is_select.dart';

class CustomListState {
  CustomListState() {
    ///Initialize variables
  }

  List<ContactDTO>? contactList;

  Set<String> customNameSet = <String>{};

  int? ledgerId;

  int? isAddressList = IsSelectType.FALSE.value;

  // RxBool batch = RxBool(false);

  // List<ContactDTO> selected = [];

}
