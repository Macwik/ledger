enum OrderType {
  SALE,
  PURCHASE,
  SALE_RETURN,
  PURCHASE_RETURN,
  CREDIT,
  REPAYMENT,
  ADD_STOCK
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
      case OrderType.ADD_STOCK:
        return 6;
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
        return '欠款单';
      case OrderType.ADD_STOCK:
        return '直接入库';
      default:
        throw Exception('Unsupported CustomDetailOrderType');
    }
  }
}
