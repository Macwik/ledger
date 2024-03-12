import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ledger/res/export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class RepaintBoundaryUtils {
//生成截图
  /// 截屏图片生成图片流ByteData
  Future<XFile> captureImage(
      BuildContext context, GlobalKey boundaryKey) async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    double dpr = MediaQuery.of(context).devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // 获取手机存储（getTemporaryDirectory临时存储路径）
    Directory applicationDir = await getTemporaryDirectory();
    // 判断路径是否存在
    bool isDirExist = await Directory(applicationDir.path).exists();
    if (!isDirExist) Directory(applicationDir.path).create();
    // 直接保存，返回的就是保存后的文件
    File saveFile = await File(
            '${applicationDir.path}${DateTime.now().toIso8601String()}.jpg')
        .writeAsBytes(pngBytes);

    return XFile.fromData(pngBytes,
        name: '${DateTime.now().toIso8601String()}.png', path: saveFile.path);
  }

//申请存本地相册权限
  Future<bool> getPermission() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }
    return status.isGranted;
  }

//保存到相册
  void savePhoto(BuildContext context, GlobalKey boundaryKey) async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;

    double dpr = MediaQuery.of(context).devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    PermissionUtil.requestAuthPermission(Permission.photos);
    if (Platform.isIOS) {
      Uint8List images = byteData!.buffer.asUint8List();
      await ImageGallerySaver.saveImage(images,
          quality: 60, name: DateTime.now().toIso8601String());
      Toast.show('保存成功');
    } else {
      //安卓
      Uint8List images = byteData!.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(images, quality: 60);
      if (result != null) {
        Toast.show('保存成功');
      } else {
        Toast.showError('保存失败');
      }
    }
  }
}
