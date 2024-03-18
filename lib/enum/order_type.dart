enum OrderType {
  SALE,
  PURCHASE,
  SALE_RETURN,
  PURCHASE_RETURN,
  CREDIT,
  REPAYMENT,
  INCOME,
  COST,
  REMITTANCE,
  ADD_STOCK,
  REFUND
}

extension OrderTypeExtension on OrderType {
  int get value {
    switch (this) {
      case OrderType.PURCHASE:
        return 0;
      case OrderType.SALE:
        return 1;
      case OrderType.SALE_RETURN:
        return 2;
      case OrderType.PURCHASE_RETURN:
        return 3;
      case OrderType.REPAYMENT:
        return 4;
      case OrderType.CREDIT:
        return 5;
      case OrderType.INCOME:
        return 6;
      case OrderType.COST:
        return 7;
      case OrderType.REMITTANCE:
        return 8;
      case OrderType.ADD_STOCK:
        return 9;
      case OrderType.REFUND:
        return 10;
      default:
        throw Exception('Unsupported OrderType');
    }
  }

  String get desc {
    switch (this) {
      case OrderType.SALE:
        return '销售单';
      case OrderType.PURCHASE:
        return '采购单';
      case OrderType.SALE_RETURN:
        return '销售退货单';
      case OrderType.PURCHASE_RETURN:
        return '采购退货单';
      case OrderType.REPAYMENT:
        return '还款单';
      case OrderType.CREDIT:
        return '录入欠款单';
      case OrderType.INCOME:
        return '收入单';
      case OrderType.COST:
        return '费用单';
      case OrderType.REMITTANCE:
        return '汇款单';
      case OrderType.ADD_STOCK:
        return '直接入库单';
      case OrderType.REFUND:
        return '退款单';
      default:
        throw Exception('Unsupported CustomDetailOrderType');
    }
  }
}
