// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:ledger/entity/app/app_check_dto.dart';
import 'package:ledger/entity/auth/ledger_tree_node.dart';
import 'package:ledger/entity/auth/role_dto.dart';
import 'package:ledger/entity/auth/sys_res_dto.dart';
import 'package:ledger/entity/auth/user_authorization_dto.dart';
import 'package:ledger/entity/auth/user_role_relation_dto.dart';
import 'package:ledger/entity/costIncome/cost_income_detail_dto.dart';
import 'package:ledger/entity/costIncome/cost_income_label_type_dto.dart';
import 'package:ledger/entity/costIncome/cost_income_order_dto.dart';
import 'package:ledger/entity/costIncome/order_pay_request.dart';
import 'package:ledger/entity/custom/custom_dto.dart';
import 'package:ledger/entity/draft/order_draft_detail_dto.dart';
import 'package:ledger/entity/draft/order_draft_dto.dart';
import 'package:ledger/entity/home/home_statistics_dto.dart';
import 'package:ledger/entity/home/income_repayment_total_dto.dart';
import 'package:ledger/entity/home/sales_credit_statistics_dto.dart';
import 'package:ledger/entity/home/sales_payment_statistics_dto.dart';
import 'package:ledger/entity/home/sales_product_statistics_dto.dart';
import 'package:ledger/entity/home/sales_repayment_statistics_dto.dart';
import 'package:ledger/entity/ledger/active_ledger_dto.dart';
import 'package:ledger/entity/ledger/ledger_create_request.dart';
import 'package:ledger/entity/ledger/ledger_dto_entity.dart';
import 'package:ledger/entity/ledger/ledger_user_detail_dto.dart';
import 'package:ledger/entity/ledger/user_ledger_dto.dart';
import 'package:ledger/entity/order/order_detail_dto.dart';
import 'package:ledger/entity/order/order_dto.dart';
import 'package:ledger/entity/order/order_payment_dto.dart';
import 'package:ledger/entity/order/order_product_detail_dto.dart';
import 'package:ledger/entity/order/order_product_request.dart';
import 'package:ledger/entity/payment/order_pay_dialog_result.dart';
import 'package:ledger/entity/payment/order_payment_request.dart';
import 'package:ledger/entity/payment/payment_method_dto.dart';
import 'package:ledger/entity/product/product_classify_dto.dart';
import 'package:ledger/entity/product/product_classify_list_dto.dart';
import 'package:ledger/entity/product/product_create_dto.dart';
import 'package:ledger/entity/product/product_detail_dto.dart';
import 'package:ledger/entity/product/product_dto.dart';
import 'package:ledger/entity/product/product_sales_credit_dto.dart';
import 'package:ledger/entity/product/product_sales_statistics_dto.dart';
import 'package:ledger/entity/product/product_shopping_car_dto.dart';
import 'package:ledger/entity/product/product_stock_adjust_request.dart';
import 'package:ledger/entity/product/stock_change_record_dto.dart';
import 'package:ledger/entity/remittance/payment_dto.dart';
import 'package:ledger/entity/remittance/remittance_detail_dto.dart';
import 'package:ledger/entity/remittance/remittance_dto.dart';
import 'package:ledger/entity/repayment/custom_credit_dto.dart';
import 'package:ledger/entity/repayment/repayment_bind_order_dto.dart';
import 'package:ledger/entity/repayment/repayment_detail_dto.dart';
import 'package:ledger/entity/repayment/repayment_dto.dart';
import 'package:ledger/entity/statistics/external_order_base_dto.dart';
import 'package:ledger/entity/statistics/money_payment_dto.dart';
import 'package:ledger/entity/statistics/purchase_money_statistics_dto.dart';
import 'package:ledger/entity/statistics/sales_money_statistic_dto.dart';
import 'package:ledger/entity/statistics/sales_order_accounts_dto.dart';
import 'package:ledger/entity/unit/unit_detail_dto.dart';
import 'package:ledger/entity/unit/unit_dto.dart';
import 'package:ledger/entity/unit/unit_group_dto.dart';
import 'package:ledger/entity/user/user_base_dto.dart';
import 'package:ledger/entity/user/user_detail_dto.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';

JsonConvert jsonConvert = JsonConvert();

typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);
typedef EnumConvertFunction<T> = T Function(String value);
typedef ConvertExceptionHandler = void Function(Object error, StackTrace stackTrace);
extension MapSafeExt<K, V> on Map<K, V> {
  T? getOrNull<T>(K? key) {
    if (!containsKey(key) || key == null) {
      return null;
    } else {
      return this[key] as T?;
    }
  }
}

class JsonConvert {
  static ConvertExceptionHandler? onError;
  JsonConvertClassCollection convertFuncMap = JsonConvertClassCollection();

  /// When you are in the development, to generate a new model class, hot-reload doesn't find new generation model class, you can build on MaterialApp method called jsonConvert. ReassembleConvertFuncMap (); This method only works in a development environment
  /// https://flutter.cn/docs/development/tools/hot-reload
  /// class MyApp extends StatelessWidget {
  ///    const MyApp({Key? key})
  ///        : super(key: key);
  ///
  ///    @override
  ///    Widget build(BuildContext context) {
  ///      jsonConvert.reassembleConvertFuncMap();
  ///      return MaterialApp();
  ///    }
  /// }
  void reassembleConvertFuncMap() {
    bool isReleaseMode = const bool.fromEnvironment('dart.vm.product');
    if (!isReleaseMode) {
      convertFuncMap = JsonConvertClassCollection();
    }
  }

  T? convert<T>(dynamic value, {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    if (value is T) {
      return value;
    }
    try {
      return _asT<T>(value, enumConvert: enumConvert);
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return null;
    }
  }

  List<T?>? convertList<T>(List<dynamic>? value,
      {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => _asT<T>(e, enumConvert: enumConvert))
          .toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value,
      {EnumConvertFunction? enumConvert}) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) =>
      _asT<T>(e, enumConvert: enumConvert)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      if (onError != null) {
        onError!(e, stackTrace);
      }
      return <T>[];
    }
  }

  T? _asT<T extends Object?>(dynamic value,
      {EnumConvertFunction? enumConvert}) {
    final String type = T.toString();
    final String valueS = value.toString();
    if (enumConvert != null) {
      return enumConvert(valueS) as T;
    } else if (type == "String") {
      return valueS as T;
    } else if (type == "int") {
      final int? intValue = int.tryParse(valueS);
      if (intValue == null) {
        return double.tryParse(valueS)?.toInt() as T?;
      } else {
        return intValue as T;
      }
    } else if (type == "double") {
      return double.parse(valueS) as T;
    } else if (type == "DateTime") {
      return DateTime.parse(valueS) as T;
    } else if (type == "bool") {
      if (valueS == '0' || valueS == '1') {
        return (valueS == '1') as T;
      }
      return (valueS == 'true') as T;
    } else if (type == "Map" || type.startsWith("Map<")) {
      return value as T;
    } else {
      if (convertFuncMap.containsKey(type)) {
        if (value == null) {
          return null;
        }
        return convertFuncMap[type]!(value as Map<String, dynamic>) as T;
      } else {
        throw UnimplementedError(
            '$type unimplemented,you can try running the app again');
      }
    }
  }

  //list is returned by type
  static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
    if (<AppCheckDTO>[] is M) {
      return data.map<AppCheckDTO>((Map<String, dynamic> e) =>
          AppCheckDTO.fromJson(e)).toList() as M;
    }
    if (<LedgerTreeNode>[] is M) {
      return data.map<LedgerTreeNode>((Map<String, dynamic> e) =>
          LedgerTreeNode.fromJson(e)).toList() as M;
    }
    if (<RoleDTO>[] is M) {
      return data.map<RoleDTO>((Map<String, dynamic> e) => RoleDTO.fromJson(e))
          .toList() as M;
    }
    if (<SysResDTO>[] is M) {
      return data.map<SysResDTO>((Map<String, dynamic> e) =>
          SysResDTO.fromJson(e)).toList() as M;
    }
    if (<UserAuthorizationDTO>[] is M) {
      return data.map<UserAuthorizationDTO>((Map<String, dynamic> e) =>
          UserAuthorizationDTO.fromJson(e)).toList() as M;
    }
    if (<UserRoleRelationDTO>[] is M) {
      return data.map<UserRoleRelationDTO>((Map<String, dynamic> e) =>
          UserRoleRelationDTO.fromJson(e)).toList() as M;
    }
    if (<CostIncomeDetailDTO>[] is M) {
      return data.map<CostIncomeDetailDTO>((Map<String, dynamic> e) =>
          CostIncomeDetailDTO.fromJson(e)).toList() as M;
    }
    if (<CostIncomeLabelTypeDTO>[] is M) {
      return data.map<CostIncomeLabelTypeDTO>((Map<String, dynamic> e) =>
          CostIncomeLabelTypeDTO.fromJson(e)).toList() as M;
    }
    if (<CostIncomeOrderDTO>[] is M) {
      return data.map<CostIncomeOrderDTO>((Map<String, dynamic> e) =>
          CostIncomeOrderDTO.fromJson(e)).toList() as M;
    }
    if (<OrderPayRequest>[] is M) {
      return data.map<OrderPayRequest>((Map<String, dynamic> e) =>
          OrderPayRequest.fromJson(e)).toList() as M;
    }
    if (<CustomDTO>[] is M) {
      return data.map<CustomDTO>((Map<String, dynamic> e) =>
          CustomDTO.fromJson(e)).toList() as M;
    }
    if (<OrderDraftDetailDTO>[] is M) {
      return data.map<OrderDraftDetailDTO>((Map<String, dynamic> e) =>
          OrderDraftDetailDTO.fromJson(e)).toList() as M;
    }
    if (<OrderDraftDTO>[] is M) {
      return data.map<OrderDraftDTO>((Map<String, dynamic> e) =>
          OrderDraftDTO.fromJson(e)).toList() as M;
    }
    if (<HomeStatisticsDTO>[] is M) {
      return data.map<HomeStatisticsDTO>((Map<String, dynamic> e) =>
          HomeStatisticsDTO.fromJson(e)).toList() as M;
    }
    if (<IncomeRepaymentTotalDTO>[] is M) {
      return data.map<IncomeRepaymentTotalDTO>((Map<String, dynamic> e) =>
          IncomeRepaymentTotalDTO.fromJson(e)).toList() as M;
    }
    if (<SalesCreditStatisticsDTO>[] is M) {
      return data.map<SalesCreditStatisticsDTO>((Map<String, dynamic> e) =>
          SalesCreditStatisticsDTO.fromJson(e)).toList() as M;
    }
    if (<SalesPaymentStatisticsDTO>[] is M) {
      return data.map<SalesPaymentStatisticsDTO>((Map<String, dynamic> e) =>
          SalesPaymentStatisticsDTO.fromJson(e)).toList() as M;
    }
    if (<SalesProductStatisticsDTO>[] is M) {
      return data.map<SalesProductStatisticsDTO>((Map<String, dynamic> e) =>
          SalesProductStatisticsDTO.fromJson(e)).toList() as M;
    }
    if (<SalesRepaymentStatisticsDTO>[] is M) {
      return data.map<SalesRepaymentStatisticsDTO>((Map<String, dynamic> e) =>
          SalesRepaymentStatisticsDTO.fromJson(e)).toList() as M;
    }
    if (<ActiveLedgerDTO>[] is M) {
      return data.map<ActiveLedgerDTO>((Map<String, dynamic> e) =>
          ActiveLedgerDTO.fromJson(e)).toList() as M;
    }
    if (<LedgerCreateRequest>[] is M) {
      return data.map<LedgerCreateRequest>((Map<String, dynamic> e) =>
          LedgerCreateRequest.fromJson(e)).toList() as M;
    }
    if (<LedgerDTOEntity>[] is M) {
      return data.map<LedgerDTOEntity>((Map<String, dynamic> e) =>
          LedgerDTOEntity.fromJson(e)).toList() as M;
    }
    if (<LedgerUserDetailDTO>[] is M) {
      return data.map<LedgerUserDetailDTO>((Map<String, dynamic> e) =>
          LedgerUserDetailDTO.fromJson(e)).toList() as M;
    }
    if (<UserLedgerDTO>[] is M) {
      return data.map<UserLedgerDTO>((Map<String, dynamic> e) =>
          UserLedgerDTO.fromJson(e)).toList() as M;
    }
    if (<LedgerUserRelationDetailDTO>[] is M) {
      return data.map<LedgerUserRelationDetailDTO>((Map<String, dynamic> e) =>
          LedgerUserRelationDetailDTO.fromJson(e)).toList() as M;
    }
    if (<OrderDetailDTO>[] is M) {
      return data.map<OrderDetailDTO>((Map<String, dynamic> e) =>
          OrderDetailDTO.fromJson(e)).toList() as M;
    }
    if (<OrderDTO>[] is M) {
      return data.map<OrderDTO>((Map<String, dynamic> e) =>
          OrderDTO.fromJson(e)).toList() as M;
    }
    if (<OrderPaymentDTO>[] is M) {
      return data.map<OrderPaymentDTO>((Map<String, dynamic> e) =>
          OrderPaymentDTO.fromJson(e)).toList() as M;
    }
    if (<OrderProductDetail>[] is M) {
      return data.map<OrderProductDetail>((Map<String, dynamic> e) =>
          OrderProductDetail.fromJson(e)).toList() as M;
    }
    if (<OrderProductRequest>[] is M) {
      return data.map<OrderProductRequest>((Map<String, dynamic> e) =>
          OrderProductRequest.fromJson(e)).toList() as M;
    }
    if (<OrderPayDialogResult>[] is M) {
      return data.map<OrderPayDialogResult>((Map<String, dynamic> e) =>
          OrderPayDialogResult.fromJson(e)).toList() as M;
    }
    if (<OrderPaymentRequest>[] is M) {
      return data.map<OrderPaymentRequest>((Map<String, dynamic> e) =>
          OrderPaymentRequest.fromJson(e)).toList() as M;
    }
    if (<PaymentMethodDTO>[] is M) {
      return data.map<PaymentMethodDTO>((Map<String, dynamic> e) =>
          PaymentMethodDTO.fromJson(e)).toList() as M;
    }
    if (<ProductClassifyDTO>[] is M) {
      return data.map<ProductClassifyDTO>((Map<String, dynamic> e) =>
          ProductClassifyDTO.fromJson(e)).toList() as M;
    }
    if (<ProductClassifyListDTO>[] is M) {
      return data.map<ProductClassifyListDTO>((Map<String, dynamic> e) =>
          ProductClassifyListDTO.fromJson(e)).toList() as M;
    }
    if (<ProductCreateDTO>[] is M) {
      return data.map<ProductCreateDTO>((Map<String, dynamic> e) =>
          ProductCreateDTO.fromJson(e)).toList() as M;
    }
    if (<ProductDetailDTO>[] is M) {
      return data.map<ProductDetailDTO>((Map<String, dynamic> e) =>
          ProductDetailDTO.fromJson(e)).toList() as M;
    }
    if (<ProductDTO>[] is M) {
      return data.map<ProductDTO>((Map<String, dynamic> e) =>
          ProductDTO.fromJson(e)).toList() as M;
    }
    if (<ProductSalesCreditDTO>[] is M) {
      return data.map<ProductSalesCreditDTO>((Map<String, dynamic> e) =>
          ProductSalesCreditDTO.fromJson(e)).toList() as M;
    }
    if (<ProductSalesStatisticsDTO>[] is M) {
      return data.map<ProductSalesStatisticsDTO>((Map<String, dynamic> e) =>
          ProductSalesStatisticsDTO.fromJson(e)).toList() as M;
    }
    if (<ProductShoppingCarDTO>[] is M) {
      return data.map<ProductShoppingCarDTO>((Map<String, dynamic> e) =>
          ProductShoppingCarDTO.fromJson(e)).toList() as M;
    }
    if (<ProductStockAdjustRequest>[] is M) {
      return data.map<ProductStockAdjustRequest>((Map<String, dynamic> e) =>
          ProductStockAdjustRequest.fromJson(e)).toList() as M;
    }
    if (<StockChangeRecordDTO>[] is M) {
      return data.map<StockChangeRecordDTO>((Map<String, dynamic> e) =>
          StockChangeRecordDTO.fromJson(e)).toList() as M;
    }
    if (<PaymentDTO>[] is M) {
      return data.map<PaymentDTO>((Map<String, dynamic> e) =>
          PaymentDTO.fromJson(e)).toList() as M;
    }
    if (<RemittanceDetailDTO>[] is M) {
      return data.map<RemittanceDetailDTO>((Map<String, dynamic> e) =>
          RemittanceDetailDTO.fromJson(e)).toList() as M;
    }
    if (<RemittanceDTO>[] is M) {
      return data.map<RemittanceDTO>((Map<String, dynamic> e) =>
          RemittanceDTO.fromJson(e)).toList() as M;
    }
    if (<CustomCreditDTO>[] is M) {
      return data.map<CustomCreditDTO>((Map<String, dynamic> e) =>
          CustomCreditDTO.fromJson(e)).toList() as M;
    }
    if (<RepaymentBindOrderDTO>[] is M) {
      return data.map<RepaymentBindOrderDTO>((Map<String, dynamic> e) =>
          RepaymentBindOrderDTO.fromJson(e)).toList() as M;
    }
    if (<RepaymentDetailDTO>[] is M) {
      return data.map<RepaymentDetailDTO>((Map<String, dynamic> e) =>
          RepaymentDetailDTO.fromJson(e)).toList() as M;
    }
    if (<RepaymentDTO>[] is M) {
      return data.map<RepaymentDTO>((Map<String, dynamic> e) =>
          RepaymentDTO.fromJson(e)).toList() as M;
    }
    if (<ExternalOrderBaseDTO>[] is M) {
      return data.map<ExternalOrderBaseDTO>((Map<String, dynamic> e) =>
          ExternalOrderBaseDTO.fromJson(e)).toList() as M;
    }
    if (<MoneyPaymentDTO>[] is M) {
      return data.map<MoneyPaymentDTO>((Map<String, dynamic> e) =>
          MoneyPaymentDTO.fromJson(e)).toList() as M;
    }
    if (<PurchaseMoneyStatisticsDTO>[] is M) {
      return data.map<PurchaseMoneyStatisticsDTO>((Map<String, dynamic> e) =>
          PurchaseMoneyStatisticsDTO.fromJson(e)).toList() as M;
    }
    if (<SalesMoneyStatisticDTO>[] is M) {
      return data.map<SalesMoneyStatisticDTO>((Map<String, dynamic> e) =>
          SalesMoneyStatisticDTO.fromJson(e)).toList() as M;
    }
    if (<SalesOrderAccountsDTO>[] is M) {
      return data.map<SalesOrderAccountsDTO>((Map<String, dynamic> e) =>
          SalesOrderAccountsDTO.fromJson(e)).toList() as M;
    }
    if (<UnitDetailDTO>[] is M) {
      return data.map<UnitDetailDTO>((Map<String, dynamic> e) =>
          UnitDetailDTO.fromJson(e)).toList() as M;
    }
    if (<UnitDTO>[] is M) {
      return data.map<UnitDTO>((Map<String, dynamic> e) => UnitDTO.fromJson(e))
          .toList() as M;
    }
    if (<UnitGroupDTO>[] is M) {
      return data.map<UnitGroupDTO>((Map<String, dynamic> e) =>
          UnitGroupDTO.fromJson(e)).toList() as M;
    }
    if (<UserBaseDTO>[] is M) {
      return data.map<UserBaseDTO>((Map<String, dynamic> e) =>
          UserBaseDTO.fromJson(e)).toList() as M;
    }
    if (<UserDetailDTO>[] is M) {
      return data.map<UserDetailDTO>((Map<String, dynamic> e) =>
          UserDetailDTO.fromJson(e)).toList() as M;
    }
    if (<UserDTOEntity>[] is M) {
      return data.map<UserDTOEntity>((Map<String, dynamic> e) =>
          UserDTOEntity.fromJson(e)).toList() as M;
    }

    debugPrint("$M not found");

    return null;
  }

  static M? fromJsonAsT<M>(dynamic json) {
    if (json is M) {
      return json;
    }
    if (json is List) {
      return _getListChildType<M>(
          json.map((dynamic e) => e as Map<String, dynamic>).toList());
    } else {
      return jsonConvert.convert<M>(json);
    }
  }
}

class JsonConvertClassCollection {
  Map<String, JsonConvertFunction> convertFuncMap = {
    (AppCheckDTO).toString(): AppCheckDTO.fromJson,
    (LedgerTreeNode).toString(): LedgerTreeNode.fromJson,
    (RoleDTO).toString(): RoleDTO.fromJson,
    (SysResDTO).toString(): SysResDTO.fromJson,
    (UserAuthorizationDTO).toString(): UserAuthorizationDTO.fromJson,
    (UserRoleRelationDTO).toString(): UserRoleRelationDTO.fromJson,
    (CostIncomeDetailDTO).toString(): CostIncomeDetailDTO.fromJson,
    (CostIncomeLabelTypeDTO).toString(): CostIncomeLabelTypeDTO.fromJson,
    (CostIncomeOrderDTO).toString(): CostIncomeOrderDTO.fromJson,
    (OrderPayRequest).toString(): OrderPayRequest.fromJson,
    (CustomDTO).toString(): CustomDTO.fromJson,
    (OrderDraftDetailDTO).toString(): OrderDraftDetailDTO.fromJson,
    (OrderDraftDTO).toString(): OrderDraftDTO.fromJson,
    (HomeStatisticsDTO).toString(): HomeStatisticsDTO.fromJson,
    (IncomeRepaymentTotalDTO).toString(): IncomeRepaymentTotalDTO.fromJson,
    (SalesCreditStatisticsDTO).toString(): SalesCreditStatisticsDTO.fromJson,
    (SalesPaymentStatisticsDTO).toString(): SalesPaymentStatisticsDTO.fromJson,
    (SalesProductStatisticsDTO).toString(): SalesProductStatisticsDTO.fromJson,
    (SalesRepaymentStatisticsDTO).toString(): SalesRepaymentStatisticsDTO
        .fromJson,
    (ActiveLedgerDTO).toString(): ActiveLedgerDTO.fromJson,
    (LedgerCreateRequest).toString(): LedgerCreateRequest.fromJson,
    (LedgerDTOEntity).toString(): LedgerDTOEntity.fromJson,
    (LedgerUserDetailDTO).toString(): LedgerUserDetailDTO.fromJson,
    (UserLedgerDTO).toString(): UserLedgerDTO.fromJson,
    (LedgerUserRelationDetailDTO).toString(): LedgerUserRelationDetailDTO
        .fromJson,
    (OrderDetailDTO).toString(): OrderDetailDTO.fromJson,
    (OrderDTO).toString(): OrderDTO.fromJson,
    (OrderPaymentDTO).toString(): OrderPaymentDTO.fromJson,
    (OrderProductDetail).toString(): OrderProductDetail.fromJson,
    (OrderProductRequest).toString(): OrderProductRequest.fromJson,
    (OrderPayDialogResult).toString(): OrderPayDialogResult.fromJson,
    (OrderPaymentRequest).toString(): OrderPaymentRequest.fromJson,
    (PaymentMethodDTO).toString(): PaymentMethodDTO.fromJson,
    (ProductClassifyDTO).toString(): ProductClassifyDTO.fromJson,
    (ProductClassifyListDTO).toString(): ProductClassifyListDTO.fromJson,
    (ProductCreateDTO).toString(): ProductCreateDTO.fromJson,
    (ProductDetailDTO).toString(): ProductDetailDTO.fromJson,
    (ProductDTO).toString(): ProductDTO.fromJson,
    (ProductSalesCreditDTO).toString(): ProductSalesCreditDTO.fromJson,
    (ProductSalesStatisticsDTO).toString(): ProductSalesStatisticsDTO.fromJson,
    (ProductShoppingCarDTO).toString(): ProductShoppingCarDTO.fromJson,
    (ProductStockAdjustRequest).toString(): ProductStockAdjustRequest.fromJson,
    (StockChangeRecordDTO).toString(): StockChangeRecordDTO.fromJson,
    (PaymentDTO).toString(): PaymentDTO.fromJson,
    (RemittanceDetailDTO).toString(): RemittanceDetailDTO.fromJson,
    (RemittanceDTO).toString(): RemittanceDTO.fromJson,
    (CustomCreditDTO).toString(): CustomCreditDTO.fromJson,
    (RepaymentBindOrderDTO).toString(): RepaymentBindOrderDTO.fromJson,
    (RepaymentDetailDTO).toString(): RepaymentDetailDTO.fromJson,
    (RepaymentDTO).toString(): RepaymentDTO.fromJson,
    (ExternalOrderBaseDTO).toString(): ExternalOrderBaseDTO.fromJson,
    (MoneyPaymentDTO).toString(): MoneyPaymentDTO.fromJson,
    (PurchaseMoneyStatisticsDTO).toString(): PurchaseMoneyStatisticsDTO
        .fromJson,
    (SalesMoneyStatisticDTO).toString(): SalesMoneyStatisticDTO.fromJson,
    (SalesOrderAccountsDTO).toString(): SalesOrderAccountsDTO.fromJson,
    (UnitDetailDTO).toString(): UnitDetailDTO.fromJson,
    (UnitDTO).toString(): UnitDTO.fromJson,
    (UnitGroupDTO).toString(): UnitGroupDTO.fromJson,
    (UserBaseDTO).toString(): UserBaseDTO.fromJson,
    (UserDetailDTO).toString(): UserDetailDTO.fromJson,
    (UserDTOEntity).toString(): UserDTOEntity.fromJson,
  };

  bool containsKey(String type) {
    return convertFuncMap.containsKey(type);
  }

  JsonConvertFunction? operator [](String key) {
    return convertFuncMap[key];
  }
}