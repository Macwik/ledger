import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'repaint_boundary_utils.dart';

class ShareUtils {
  //share_plus分享
  static void onSharePlusShare(BuildContext context, GlobalKey globalKey) async {
    // FocusScope.of(context).requestFocus(FocusNode());
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    //获取截图地址
    XFile xFile = await RepaintBoundaryUtils().captureImage(context, globalKey);
    List<XFile> xFileList = [xFile];
    //分享
    await Share.shareXFiles(xFileList,
        text: '开单详情',
        subject: '开单',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
