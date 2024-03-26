import 'package:fast_contacts/fast_contacts.dart';
import 'package:ledger/entity/contact/contact_dto.dart';
import 'package:ledger/util/permission_util.dart';
import 'package:permission_handler/permission_handler.dart';

/// 系统联系人工具类
class SystemContactUtil {
  // 申请权限
  static Future<List<ContactDTO>> requestSystemContact() async {
    // Get all contacts
    return PermissionUtil.requestAuthPermission(Permission.contacts)
        .then((value) async {
      if (value) {
        final contacts = await FastContacts.getAllContacts();
        if (contacts.isEmpty) {
          return List<ContactDTO>.empty();
        }
        List<ContactDTO> result = [];
        for (var contact in contacts) {
          var displayName = contact.displayName;
          if (displayName.isEmpty) {
            continue;
          }
          var phones = contact.phones;
          result.add(ContactDTO(
              name: contact.displayName,
              phone: phones.isEmpty ? '' : phones.first.number));
        }
        return result;
      } else {
        return List<ContactDTO>.empty();
      }
    });
  }
}
