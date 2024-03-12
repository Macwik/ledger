import 'package:fast_contacts/fast_contacts.dart';
import 'package:ledger/entity/contact/contact_dto.dart';
import 'package:ledger/util/permission_util.dart';
import 'package:permission_handler/permission_handler.dart';

/// 系统联系人工具类
class SystemContactUtil {
  // 申请权限
  static Future<List<ContactDTO>> requestSystemContact() async {
    // Get all contacts
    PermissionUtil.requestAuthPermission(Permission.contacts);
    final contacts = await FastContacts.getAllContacts();
    if (contacts.isEmpty) {
      return List<ContactDTO>.empty();
    }
    List<ContactDTO> result = [];
    for (var contact in contacts) {
      var phones = contact.phones;
      if (phones.isNotEmpty) {
        for (var phone in phones) {
          result
              .add(ContactDTO(name: contact.displayName, phone: phone.number));
        }
      } else {
        result.add(ContactDTO(name: contact.displayName, phone: ''));
      }
    }
    return result;
  }
}
