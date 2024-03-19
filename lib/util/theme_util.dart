import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/device_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class ThemeUtil {
  static StreamSubscription? _subscription;

  /// 设置NavigationBar样式
  static void setSystemNavigationBar() {
    /// 主题切换动画（AnimatedTheme）时间为200毫秒，延时设置导航栏颜色，这样过渡相对自然。
    _subscription?.cancel();
    _subscription =
        Stream.value(1).delay(const Duration(milliseconds: 200)).listen((_) {
      setSystemBarStyle();
    });
  }

  /// 设置StatusBar、NavigationBar样式。(仅针对安卓)
  static void setSystemBarStyle() {
    if (Device.isAndroid) {
      final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  static ThemeData getTheme() {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
            primary: Colours.primary,
            surfaceTint: Colors.white,
            background: Colours.bg),
        hintColor: Colours.text_ccc,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colours.white,
        ),
        searchBarTheme: SearchBarThemeData().copyWith(
          hintStyle: MaterialStateProperty.all(TextStyle(
            color: Colours.text_999
          ))
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.light,
        ),
        datePickerTheme: DatePickerThemeData().copyWith(
            backgroundColor: Colours.white,
            confirmButtonStyle: ButtonStyle(
              textStyle: MaterialStateProperty.all(TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
              )),
            )));
  }
}
