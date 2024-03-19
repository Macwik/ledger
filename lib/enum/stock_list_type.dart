enum StockListType{ DETAIL, SELECT_PRODUCT }

extension StockListTypeExtension on StockListType {
  int get value {
    switch (this) {
      case StockListType.DETAIL:
        return 1;
      case StockListType.SELECT_PRODUCT:
        return 0;
      default:
        throw Exception('Unsupported ProcessStatus');
    }
  }
}