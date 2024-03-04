enum ProcessStatus{ OK, FAIL }

extension ProcessStatusExtension on ProcessStatus {
  int get value {
    switch (this) {
      case ProcessStatus.OK:
        return 1;
      case ProcessStatus.FAIL:
        return 0;
      default:
        throw Exception('Unsupported ProcessStatus');
    }
  }
}