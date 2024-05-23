import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/config/api/user_api.dart';
import 'package:ledger/entity/ledger/user_ledger_dto.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';

import 'my_account_state.dart';

class MyAccountController extends GetxController {
  final MyAccountState state = MyAccountState();

  Future<void> onLoad() async {
    await listLedger();
  }

  //此处是Init Controller执行的内容
  Future<void> initState() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['isSelect'] != null) {
      state.isSelect = arguments['isSelect'];
    }
    if ((arguments != null) && arguments['customType'] != null) {
      state.customType = arguments['customType'];
    }
    listLedger();
  }

  Future<void> listLedger() async {
    final result =
        await Http().network<UserLedgerDTO>(Method.get, LedgerApi.ledger_list);
    if (result.success) {
      state.userLedger = result.d;
      update(['join_account', 'own_account']);
    } else {
      Toast.show(result.m.toString());
    }
  }

  void toChangeAccount(int ledgerId) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认切换账本吗',
        onCancel: () {},
        onConfirm: () async {
          Loading.showDuration(status: '账本切换中...');
          await Http()
              .network(Method.put, LedgerApi.ledger_change, queryParameters: {
            'ledgerId': ledgerId,
          }).then((result) async {
            if (result.success) {
              await Http()
                  .network<UserDTOEntity>(Method.get, UserApi.user_info)
                  .then((value) async {
                if (value.strictSuccess) {
                  await StoreController.to
                      .updateCurrentUserActiveLedger(value.d!);
                  await StoreController.to.clearPermission();
                  await StoreController.to.updatePermissionCode();
                  listLedger();
                  Loading.dismiss();
                  Get.defaultDialog(
                      title: '提示',
                      barrierDismissible: false,
                      middleText: '账本切换成功, 点击确定会进入首页',
                      onConfirm: () {
                        Get.offAndToNamed(RouteConfig.main);
                      });
                } else {
                  Loading.dismiss();
                  Toast.showError('账本切换失败，请稍后再试');
                }
              });
            } else {
              Toast.showError(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }

  void toDeleteLedger(int id) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认删除此账本吗？删除后不可恢复！',
        onCancel: () {},
        onConfirm: () {
          Http().network(Method.delete, LedgerApi.ledger_delete,
              queryParameters: {
                'ledgerId': id,
              }).then((result) {
            if (result.success) {
              Toast.show('删除成功');
              listLedger();
            } else {
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }

  void toAddAccount() {
    Get.toNamed(RouteConfig.addAccount,arguments: {'firstIndex':false})?.then((result) {
      if (ProcessStatus.OK == result) {
        listLedger();
      }
    });
  }

  void accountManage(int? id) {
    if (state.isSelect == IsSelectType.FALSE.value) {
      Get.toNamed(RouteConfig.accountManage, arguments: {'ledgerId': id})
          ?.then((value) {
        if (ProcessStatus.OK == value) {
          listLedger();
        }
      });
    } else {
      Get.toNamed(RouteConfig.customList,
          arguments: {'ledgerId': id, 'customType': state.customType});
    }
  }

  void joiningAccountManage(int? id) {
    if (state.isSelect == IsSelectType.FALSE.value) {
      Get.toNamed(RouteConfig.accountManage, arguments: {'ledgerId': id});
    } else {
      Toast.show('不能选择我参与的账本');
    }
  }

  void myAccountGetBack() {
    Get.until((route) {
      return (route.settings.name == RouteConfig.main) ||
          (route.settings.name == RouteConfig.mine);
    });
  }
}
