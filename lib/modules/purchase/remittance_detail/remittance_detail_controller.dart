import 'package:get/get.dart';
import 'package:ledger/config/api/remittance_api.dart';
import 'package:ledger/entity/remittance/payment_dto.dart';
import 'package:ledger/entity/remittance/remittance_detail_dto.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/warning.dart';

import 'remittance_detail_state.dart';

class RemittanceDetailController extends GetxController {
  final RemittanceDetailState state = RemittanceDetailState();

  Future<void> initState() async{
    var arguments = Get.arguments;
    if ((arguments != null) && arguments['remittanceDTO'] != null) {
      state.remittanceDTO = arguments['remittanceDTO'];
    }
    Http().network<RemittanceDetailDTO>(
        Method.get, RemittanceApi.remittance_detail,
        queryParameters: {'remittanceId':state.remittanceDTO?.id}).then((result) {
      if (result.success) {
        state.remittanceDetailDTO = result.d;
        update(['remittance_detail','remittance_product', 'remittance_amount_record','remittance_detail_title'
        ]);
      } else {
        Toast.show(result.m.toString());
      }
    });

  }

  void toDeleteOrder() {
    Get.dialog(
      Warning(
        cancel: '取消',
        confirm: '确定',
        content: '确认作废此单吗？',
        onCancel: () {},
        onConfirm: () {
          Http().network(Method.put, RemittanceApi.remittance_invalid, queryParameters: {
            'id': state.remittanceDTO?.id,
          }).then((result) {
            if (result.success) {
              Toast.show('作废成功');
              Get.back(result: ProcessStatus.OK);
            } else {
              Toast.show(result.m.toString());
            }
          });
        },
      ),
      barrierDismissible: false,
    );
  }


  String formatPayment(List<PaymentDTO>? paymentDTOList){
    if((null == paymentDTOList) || paymentDTOList.isEmpty){
      return '';
    }
    String result = '';
    for (var value in paymentDTOList) {
      result = result + (value.paymentMethodName ?? '');
    }
    return result;
  }

}
