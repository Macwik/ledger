import 'package:get/get.dart';
import 'package:ledger/config/api/custom_api.dart';
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

    if(state.isAddressList ==  IsSelectType.TRUE.value){
      await queryCustom();
      queryContact();
    }else{
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
    await Http().network<List<CustomDTO>>(Method.post, CustomApi.batchImportCustom,
        queryParameters: {
          'ledgerId': state.ledgerId,
          'customType': CustomType.CUSTOM.value,
        }).then((result) {
      if (result.success) {
        if (null != result.d && (result.d!.isNotEmpty)) {
          for (var element in result.d!) {
            state.customNameSet.add(element.customName ?? '');
          }
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
        if (null != result.d && (result.d!.isNotEmpty)) {
          for (var element in result.d!) {
            state.customNameSet.add(element.customName ?? '');
          }
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

  //批量导入选择导入客户
  // bool? judgeIsSelect(ContactDTO contactDTO) {
  //   for (var value in state.selected) {
  //     if (contactDTO == value) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  //批量导入checkBox选择的控制
  // void addToSelected(bool? selected, ContactDTO contactDTO) {
  //   if (true == selected) {
  //       state.selected.add(contactDTO);
  //   } else {
  //       state.selected.remove(contactDTO);
  //   }
  //   update(['contact_list',]);
  // }
}
