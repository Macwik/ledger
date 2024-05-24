import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:ledger/config/application.dart';
import 'package:ledger/lang/lang.dart';
import 'package:ledger/res/export.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:ledger/store/initial_binding.dart';
import 'package:lifecycle/lifecycle.dart';
import 'generated/json/base/custom_json_convert.dart';
import 'generated/json/base/json_convert_content.dart';
import 'util/theme_util.dart';

Future<void> main() async {
  FlutterBugly.postCatchedException(() async {
    WidgetsFlutterBinding.ensureInitialized();
    jsonConvert = CustomJsonConvert();
    await GetStorage.init();
    InitialBinding().dependencies();
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var hasCookie = await Http().hasCookie();
    runApp(MyApp(hasCookie: hasCookie));
  });
}

class MyApp extends StatefulWidget {
  final bool hasCookie;

  MyApp({required this.hasCookie});

  @override
  State<MyApp> createState() => _MyAppState(hasCookie: hasCookie);
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool hasCookie;

  _MyAppState({required this.hasCookie});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: (context, child) => GetMaterialApp(
        title: '记账鲜生',
        localizationsDelegates: FormBuilderLocalizations.localizationsDelegates,
        navigatorObservers: [defaultLifecycleObserver],
        translations: Messages(),
        // 支持的语言列表
        supportedLocales: [
          const Locale('zh', 'CN'), // 中文简体
          const Locale('en', 'US'), // 英文
        ],
        locale: const Locale('zh', 'CN'),
        fallbackLocale: Locale('en', 'US'),
        initialRoute: hasCookie
            ? Http().hasActiveLedger()
                ? RouteConfig.main
                : RouteConfig.addAccount
            : RouteConfig.loginVerify,
        getPages: RouteConfig.getPages,
        debugShowCheckedModeBanner: true,
        builder: EasyLoading.init(
          builder: (context, child) {
            if (Device.isAndroid) {
              ThemeUtil.setSystemNavigationBar();
            }
            // 获取屏幕上的文本比例因子
            final textScale = MediaQuery.of(context).textScaler;
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: textScale),
              child: child!,
            );
          },
        ),
        theme: ThemeUtil.getTheme(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Application.getInstance().init();
  }

  @override
  void dispose() {
    FlutterBugly.dispose();
    super.dispose();
  }
}
