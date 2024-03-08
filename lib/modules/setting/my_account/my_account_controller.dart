import 'package:get/get.dart';
import 'package:ledger/config/api/ledger_api.dart';
import 'package:ledger/entity/ledger/user_ledger_dto.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/store/store_controller.dart';

import 'my_account_state.dart';

class MyAccountController extends GetxController {
  final MyAccountState state = MyAccountState();

  Future<void> onLoad() async {
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['isSelect'] != null) {
      state.isSelect = arguments['isSelect'];
    }
    await listLedger();
  }

  //此处是Init Controller执行的内容
  Future<void> initState() async {
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
        onConfirm: () {
          Loading.showDuration();
          Http().network(Method.put, LedgerApi.ledger_change, queryParameters: {
            'ledgerId': ledgerId,
          }).then((result) {
            Loading.dismiss();
            if (result.success) {
              Get.defaultDialog(
                  title: '提示',
                  barrierDismissible: false,
                  middleText: '账本切换成功, 请重新登录',
                  onConfirm: () {
                    StoreController.to.signOut();
                    Get.offAllNamed(RouteConfig.loginVerify);
                  });
            } else {
              Toast.show(result.m.toString());
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
                'id': id,
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
    Get.toNamed(RouteConfig.addAccount)?.then((result) {
      if (ProcessStatus.OK == result) {
        listLedger();
      }
    });
  }

  void accountManage(int? id) {
    if(state.isSelect == IsSelectType.FALSE.value){
      Get.toNamed(RouteConfig.accountManage,
          arguments: {'ledgerId': id
          })?.then((value){
        if (ProcessStatus.OK == value) {
          listLedger();
        }
      });
    }else{
      Get.back(result: id );
    }

  }

  void joiningAccountManage(int? id) {
    if(state.isSelect == IsSelectType.FALSE.value){
      Get.toNamed(
          RouteConfig.accountManage,
          arguments: {
            'ledgerId': id
          });
    }else{
      Toast.show('不能选择我参与的账本');
    }
  }
}
