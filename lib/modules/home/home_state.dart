import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ledger/entity/home/home_statistics_dto.dart';
import 'package:ledger/entity/home/sales_credit_statistics_dto.dart';
import 'package:ledger/entity/home/sales_payment_statistics_dto.dart';
import 'package:ledger/entity/home/sales_product_statistics_dto.dart';
import 'package:ledger/entity/home/sales_repayment_statistics_dto.dart';

class HomeState {

  HomeStatisticsDTO? homeStatisticsDTO;

  List<SalesProductStatisticsDTO>? salesProductStatisticsDTO;

  List<SalesRepaymentStatisticsDTO>? salesRepaymentStatisticsDTO;

  List<SalesPaymentStatisticsDTO>? salesPaymentStatisticsDTO;

  List<SalesCreditStatisticsDTO>? salesCreditStatisticsDTO;

  Decimal?  todaySalesAmount;
  Decimal?  todayPaymentAmount;
  Decimal?  todayRepaymentAmount;
  Decimal?  todayCreditAmount;

  HomeState() {
    ///Initialize variables
  }

  final formKey = GlobalKey<FormBuilderState>();

  bool privacyText = false;
}
