import 'package:get/get.dart';
import 'package:ledger/util/system_contact_util.dart';

import 'custom_list_state.dart';

class CustomListController extends GetxController {
  final CustomListState state = CustomListState();

  Future<void> initState() async {
    queryContact();
  }

  //拉数据
  void queryContact() {
      SystemContactUtil.requestSystemContact().then((result){
        state.contactList = result;
        update(['contact_list']);
      });

  }
}
