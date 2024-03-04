enum SalesChannel{
  SELF_SUPPORT,
  AGENCY,
  COOPERATION,
}


extension SalesChannelExtension on SalesChannel {
  int get value {
    switch (this) {
      case SalesChannel.SELF_SUPPORT:
        return 0;
      case SalesChannel.AGENCY:
        return 1;
      case SalesChannel.COOPERATION:
        return 2;
      default:
        throw Exception('Unsupported SalesChannel');
    }
  }

  String get desc {
    switch (this) {
      case SalesChannel.SELF_SUPPORT:
        return '自营';
      case SalesChannel.AGENCY:
        return '代办';
      case SalesChannel.COOPERATION:
        return '联营';
      default:
        throw Exception('Unsupported SalesChannel');
    }
  }
}