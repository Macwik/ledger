enum IsSelectType{
  TRUE,
  FALSE,
}


extension IsSelectTypeExtension on IsSelectType {
  int get value {
    switch (this) {
      case IsSelectType.TRUE:
        return 1;
      case IsSelectType.FALSE:
        return 0;
      default:
        throw Exception('Unsupported IsSelectType');
    }
  }
}