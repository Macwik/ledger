enum OrderStateType{
  SETTLED_ACCOUNT,
  DEBT_ACCOUNT,
  DELETED,
  ON_ACCOUNT,
}


extension OrderTypeExtension on OrderStateType {
  int get value {
    switch (this) {
      case OrderStateType.DEBT_ACCOUNT:
        return 0;
      case OrderStateType.SETTLED_ACCOUNT:
        return 1;
      case OrderStateType.DELETED:
        return 2;
      case OrderStateType.ON_ACCOUNT:
        return 3;
      default:
        throw Exception('Unsupported OrderType');
    }
  }

  String get desc {
    switch (this) {
      case OrderStateType.SETTLED_ACCOUNT:
        return '已结清';
      case OrderStateType.DEBT_ACCOUNT:
        return '未结清';
      case OrderStateType.DELETED:
        return '已作废';
      case OrderStateType.ON_ACCOUNT:
        return '挂账单';
      default:
        throw Exception('Unsupported OrderType');
    }
  }
}