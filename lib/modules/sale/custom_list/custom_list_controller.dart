import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
import 'package:ledger/entity/contact/contact_dto.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/util/system_contact_util.dart';

import 'custom_list_state.dart';

class CustomListController extends GetxController {
  final CustomListState state = CustomListState();

  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['ledgerId'] != null) {
      state.ledgerId = arguments['ledgerId'];
    }
    if ((arguments != null) && arguments['isAddressList'] != null) {
      state.isAddressList = arguments['isAddressList'];
    }
    if ((arguments != null) && arguments['customType'] != null) {
      state.customType = arguments['customType'];
    }
    _queryData();
  }

  _queryData() async {
    if (state.isAddressList == IsSelectType.TRUE.value) {
      await queryCustom();
      queryContact();
    } else {
      await queryCustom();
      queryImportCustom();
    }
  }

  //拉数据--通讯录
  void queryContact() {
    SystemContactUtil.requestSystemContact().then((result) {
      state.contactList = result;
      update(['contact_list']);
    });
  }

  //拉数据--其他账本
  Future<void> queryImportCustom() async {
    await Http().network<List<CustomDTO>>(
        Method.post, CustomApi.batchImportCustom,
        queryParameters: {
          'ledgerId': state.ledgerId,
          'customType':state.customType?.value,
        }).then((result) {
      if (result.success) {
        if (result.d?.isNotEmpty ?? false) {
          state.contactList.clear();
          result.d?.forEach((element) {
            state.contactList.add(ContactDTO(name: element.customName, phone: element.phone));
          });
        }
      }
    });
    update(['contact_list']);
  }

  //拉数据
  Future<void> queryCustom() async {
    await Http().network<List<CustomDTO>>(Method.post, CustomApi.getCustomList,
        queryParameters: {
          'customType': state.customType?.value,
        }).then((result) {
      if (result.success) {
        if (result.d?.isNotEmpty ?? false) {
          result.d?.forEach((element) {
            if (element.customName?.isNotEmpty ?? false) {
              state.customNameSet.add(element.customName!);
            }
          });
        }
      }
    });
  }

  void addCustom(String name, String phone, remark) {
    Loading.showDuration();
    Http().network(Method.post, CustomApi.addCustom, data: {
      'customName': name,
      'phone': phone,
      'remark': remark,
      'customType': state.customType?.value,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        _queryData();
        Toast.showSuccess('导入成功');
      }
    });
  }
}
