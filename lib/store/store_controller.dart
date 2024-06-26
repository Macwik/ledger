import 'package:ledger/config/api/auth_api.dart';
import 'package:ledger/entity/auth/user_authorization_dto.dart';
import 'package:ledger/entity/user/user_dto_entity.dart';
import 'package:ledger/res/export.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  static StoreController get to => Get.find();
  final RxBool authenticated = false.obs;
  final RxList<String> permissions = <String>[].obs;
  final RxList<String> bakPermissions = <String>[].obs;
  final RxObjectMixin<UserDTOEntity> userEntity = UserDTOEntity().obs;

  /// 获取当前用户
  UserDTOEntity? getUser() {
    if (!authenticated.value) {
      Map<String, dynamic>? userJson = GetStorage().read(Constant.CURRENT_USER);
      if (userJson?.isEmpty ?? true) {
        return null;
      }
      userEntity.value = UserDTOEntity.fromJson(userJson!);
      _changeLoginStatus(true);
    }
    return userEntity.value;
  }

  int? getCurrentUser() {
    var user = getUser();
    if (user == null) {
      return null;
    }
    return user.id;
  }

  ///是否登录
  bool isLogin() {
    return getUser() != null;
  }

  ///获取当前活跃账本
  int? getActiveLedgerId() {
    var user = getUser();
    if (user == null) {
      return null;
    }
    return user.activeLedger?.ledgerId;
  }

  ///获取是否为当前账本owner
  bool? isCurrentLedgerOwner() {
    var user = getUser();
    if (user == null) {
      return null;
    }
    return user.activeLedger?.owner;
  }

  Future<void> signIn(UserDTOEntity user) async {
    userEntity.value = user;
    await GetStorage().write(Constant.CURRENT_USER, user.toJson());
    _changeLoginStatus(true);
  }

  Future<void> updateUser(String? username) async {
    userEntity.value.username = username;
    await GetStorage().write(Constant.CURRENT_USER, userEntity.value.toJson());
    _changeLoginStatus(true);
  }

  Future<void> signOut() async {
    await Http().clearCookie();
    await GetStorage().remove(Constant.CURRENT_USER);
    clearPermission();
    _changeLoginStatus(false);
  }

  reload() async {
    await GetStorage().remove(Constant.CURRENT_USER);
    clearPermission();
    _changeLoginStatus(false);
  }

  void _changeLoginStatus(bool flag) {
    if (authenticated.value != flag) {
      authenticated.value = flag;
    }
    update();
  }

  clearPermission() {
    GetStorage().remove(Constant.PERMISSION_LIST);
    permissions.clear();
  }

  savePermission(UserAuthorizationDTO userAuthorizationDTO) async {
    await GetStorage()
        .write(Constant.PERMISSION_LIST, userAuthorizationDTO.toJson());
  }

  UserAuthorizationDTO? getUserAuthorizationDTO() {
    Map<String, dynamic>? userPermissionDTO =
        GetStorage().read(Constant.PERMISSION_LIST);
    if (userPermissionDTO?.isEmpty ?? true) {
      return null;
    }
    return UserAuthorizationDTO.fromJson(userPermissionDTO!);
  }

  List<String>? getPermissionList() {
    UserAuthorizationDTO? userAuthorizationDTO = getUserAuthorizationDTO();
    if (null == userAuthorizationDTO ||
        (userAuthorizationDTO.authorizationCodes?.isEmpty ?? true)) {
      return List<String>.empty();
    }
    return userAuthorizationDTO.authorizationCodes;
  }

  Future<bool> updatePermissionCode() async {
    return await Http().network<UserAuthorizationDTO>(
        Method.get, AuthApi.list_role_auth, queryParameters: {
      'version': getUserAuthorizationDTO()?.version
    }).then((result) async {
      if (result.success) {
        var userAuthorization = result.d!;
        if (userAuthorization.latest == false) {
          await savePermission(userAuthorization);
          if (permissions.isNotEmpty) {
            bakPermissions.clear();
            bakPermissions.addAll(permissions);
          }
          permissions.clear();
          permissions.addAll(userAuthorization.authorizationCodes!);
          return true;
        }
      }
      return false;
    });
  }

  /// 获取用户当前全量权限点
  List<String> getPermissionCode() {
    if (permissions.isNotEmpty) {
      return permissions;
    }
    List<String>? permissionList = getPermissionList();
    if (permissionList?.isNotEmpty ?? false) {
      permissions.addAll(permissionList!);
      return permissionList;
    } else if (bakPermissions.isNotEmpty) {
      return bakPermissions;
    } else {
      updatePermissionCode();
    }
    return List<String>.empty();
  }

  /// 获取用户当前全量权限点
  Future<List<String>> getPermissionCodeAsync() async {
    if (permissions.isNotEmpty) {
      return Future.value(permissions);
    }
    List<String>? permissionList = getPermissionList();
    if (permissionList?.isNotEmpty ?? false) {
      permissions.addAll(permissionList!);
      return Future.value(permissions);
    } else {
      return await Http().network<UserAuthorizationDTO>(
          Method.get, AuthApi.list_role_auth, queryParameters: {
        'version': getUserAuthorizationDTO()?.version
      }).then((result) async {
        if (result.success) {
          var userAuthorization = result.d!;
          await savePermission(userAuthorization);
          if (permissions.isNotEmpty) {
            bakPermissions.clear();
            bakPermissions.addAll(permissions);
          }
          permissions.clear();
          permissions.addAll(userAuthorization.authorizationCodes!);
        }
        return List<String>.empty();
      });
    }
  }
}
