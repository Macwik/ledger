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

    if (state.isAddressList == IsSelectType.TRUE.value) {
      await queryCustom();
      queryContact();
    } else {
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
          'customType': CustomType.CUSTOM.value,
        }).then((result) {
      if (result.success) {
        if (result.d?.isNotEmpty ?? false) {
          result.d?.forEach((element) {
            state.contactList.add(
                ContactDTO(name: element.customName, phone: element.phone));
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
          'customType': CustomType.CUSTOM.value,
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

  void addCustom(String name, String phone) {
    Loading.showDuration();
    Http().network(Method.post, CustomApi.addCustom, data: {
      'customName': name,
      'phone': phone,
      'remark': '通讯录导入',
      'customType': CustomType.CUSTOM.value,
    }).then((result) {
      Loading.dismiss();
      if (result.success) {
        Toast.showSuccess('导入成功');
        initState();
      }
    });
  }
}
