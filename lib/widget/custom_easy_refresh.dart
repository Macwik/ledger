import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

/// 已包装头部和尾部的EasyRefresh
class CustomEasyRefresh extends StatelessWidget {
  const CustomEasyRefresh({
    super.key,
    required this.child,
    this.controller,
    this.onRefresh,
    this.onLoad,
    this.emptyWidget,
  });

  final Widget child;
  final EasyRefreshController? controller;
  final FutureOr Function()? onRefresh;
  final FutureOr Function()? onLoad;
  final Widget? emptyWidget;

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: controller,
      child: emptyWidget ?? child,
      onRefresh: onRefresh,
      onLoad: onLoad,
      header: ClassicHeader(
          dragText: '下拉刷新',
          armedText: '松开刷新',
          readyText: '努力加载中',
          processingText: '努力加载中',
          processedText: '加载成功',
          noMoreText: '我是有底线的',
          failedText: '网络错误',
          messageText: '最近一次更新 %T',
          textStyle: TextStyle(color: Colors.black54)),
      footer: ClassicFooter(
          dragText: '下拉刷新',
          armedText: '松开刷新',
          readyText: '努力加载中',
          processingText: '努力加载中',
          processedText: '加载成功',
          noMoreText: '我是有底线的',
          failedText: '网络错误',
          messageText: '最近一次更新 %T',
          textStyle: TextStyle(color: Colors.black54)),
    );
  }
}
