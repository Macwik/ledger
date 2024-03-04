enum ChangeStatus{ NO_CHANGE, CHANGE }

extension ChangeStatusExtension on ChangeStatus {
  int get value {
    switch (this) {
      case ChangeStatus.CHANGE:
        return 1;
      case ChangeStatus.NO_CHANGE:
        return 0;
      default:
        throw Exception('Unsupported ChangeStatus');
    }
  }
}