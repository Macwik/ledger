import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/config/api/user_api.dart';
import 'package:ledger/entity/ledger/user_ledger_dto.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/loading.dart';
import 'package:ledger/widget/warning.dart';

import 'choose_account_state.dart';

class ChooseAccountController extends GetxController {
  final ChooseAccountState state = ChooseAccountState();

  Future<void> initState() async {
    listLedger();
  }

  void toChangeAccount(int ledgerId) {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认进入此账本吗',
        onCancel: () {},
        onConfirm: () async {
          Loading.showDuration(status: '进入账本...');
          await Http()
              .network(Method.put, LedgerApi.ledger_change, queryParameters: {
            'ledgerId': ledgerId,
          }).then((result) async {
            if (result.success) {
              await Http()
                  .network<UserDTOEntity>(Method.get, UserApi.user_info)
                  .then((value) async {
                if (value.strictSuccess) {
                  await StoreController.to.reload();
                  Future.delayed(Duration(seconds: 3)).then((_) async {
                    await StoreController.to.signIn(value.d!);
                    await StoreController.to.clearPermission();
                    StoreController.to.updatePermissionCode();
                    listLedger();
                    Loading.dismiss();
                    Get.defaultDialog(
                        title: '提示',
                        barrierDismissible: false,
                        middleText: '账本切换成功, 可以开始记账啦~',
                        onConfirm: () {
                          Get.offAllNamed(RouteConfig.main);
                        });
                  });
                } else {
                  Loading.dismiss();
                  Toast.showError('账本进入失败，请稍后再试');
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
}
