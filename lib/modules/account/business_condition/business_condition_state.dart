class BusinessConditionState {
  String? dateRange;

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  BusinessConditionState() {
    ///Initialize variables
  }
}
