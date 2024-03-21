import 'package:get/get.dart';
import 'package:ledger/entity/contact/contact_dto.dart';

class CustomListState {
  CustomListState() {
    ///Initialize variables
  }

  List<ContactDTO>? contactList;

  Set<String> customNameSet = <String>{};

  RxBool batch = RxBool(false);
}
