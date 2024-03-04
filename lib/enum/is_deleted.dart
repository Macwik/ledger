enum IsDeleted{
  DELETED,
  NORMAL,
}


extension IsDeletedExtension on IsDeleted {
  int get value {
    switch (this) {
      case IsDeleted.DELETED:
        return 1;
      case IsDeleted.NORMAL:
        return 0;
      default:
        throw Exception('Unsupported IsDeleted');
    }
  }
}