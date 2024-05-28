import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/permission/permission_widget.dart';

import 'more_controller.dart';

class MoreView extends StatelessWidget {
  MoreView({super.key});

  final controller = Get.find<MoreController>();

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
        appBar: TitleBar(
          title: '更多',
        ),
        body: GetBuilder<MoreController>(
          id: 'app_list',
          init: controller,
          global: false,
          builder: (_) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Offstage(
                    offstage: getIndexCount(
                            controller.gridItemSalePermission,
                            5,
                            controller.toSale,
                            controller.gridItemSalePaths,
                            controller.gridItemSaleNames,
                            1) ==
                        0,
                    child: Container(
                        height: getIndexCount(
                                    controller.gridItemSalePermission,
                                    5,
                                    controller.toSale,
                                    controller.gridItemSalePaths,
                                    controller.gridItemSaleNames,
                                    1) >
                                4
                            ? 570.w
                            : 340.w,
                        child: Card(
                          elevation: 6,
                          shadowColor: Colors.black45,
                          margin: EdgeInsets.only(
                              left: 24.w, top: 16.w, right: 24.w),
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(28.w)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 24.w, left: 40.w, bottom: 16.w),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '销售',
                                  style: TextStyle(
                                      color: Colours.text_333,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32.sp),
                                ),
                              ),
                              Expanded(
                                  child: GridView.count(
                                crossAxisCount: 4,
                                crossAxisSpacing: 36.w,
                                mainAxisSpacing: 24.w,
                                childAspectRatio: 0.639,
                                physics: NeverScrollableScrollPhysics(),
                                // maxCrossAxisExtent: 80,
                                // mainAxisSpacing: 24.w,
                                padding: EdgeInsets.all(16.w),
                                children: buildWidgetPermission(
                                    controller.gridItemSalePermission,
                                    5,
                                    controller.toSale,
                                    controller.gridItemSalePaths,
                                    controller.gridItemSaleNames,
                                    1),
                              )),
                            ],
                          ),
                        )),
                  ),
                  Offstage(
                    offstage: getIndexCount(
                            controller.gridItemPurchasePermission,
                            4,
                            controller.toPurchase,
                            controller.gridItemPurchasePaths,
                            controller.gridItemPurchaseNames,
                            2) ==
                        0,
                    child: Container(
                        height: 340.w,
                        child: Card(
                          elevation: 6,
                          shadowColor: Colors.black45,
                          margin: EdgeInsets.only(
                              left: 24.w, top: 16.w, right: 24.w),
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(28.w)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 24.w, left: 40.w, bottom: 16.w),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '采购',
                                  style: TextStyle(
                                      color: Colours.text_333,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32.sp),
                                ),
                              ),
                              Expanded(
                                  child: GridView.count(
                                crossAxisCount: 4,
                                crossAxisSpacing: 36.w,
                                mainAxisSpacing: 24.w,
                                childAspectRatio: 0.639,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(16.w),
                                children: buildWidgetPermission(
                                    controller.gridItemPurchasePermission,
                                    4,
                                    controller.toPurchase,
                                    controller.gridItemPurchasePaths,
                                    controller.gridItemPurchaseNames,
                                    2),
                              )),
                            ],
                          ),
                        )),
                  ),
                  Offstage(
                    offstage: getIndexCount(
                            controller.gridItemStorePermission,
                            4,
                            controller.toStore,
                            controller.gridItemStorePaths,
                            controller.gridItemStoreNames,
                            3) ==
                        0,
                    child: Container(
                        height: 340.w,
                        child: Card(
                          elevation: 6,
                          shadowColor: Colors.black45,
                          margin: EdgeInsets.only(
                              left: 24.w, top: 16.w, right: 24.w),
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(28.w)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 24.w, left: 40.w, bottom: 16.w),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '库存',
                                  style: TextStyle(
                                      color: Colours.text_333,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32.sp),
                                ),
                              ),
                              Expanded(
                                  child: GridView.count(
                                crossAxisCount: 4,
                                crossAxisSpacing: 36.w,
                                mainAxisSpacing: 24.w,
                                childAspectRatio: 0.639,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(16.w),
                                children: buildWidgetPermission(
                                    controller.gridItemStorePermission,
                                    4,
                                    controller.toStore,
                                    controller.gridItemStorePaths,
                                    controller.gridItemStoreNames,
                                    3),
                              )),
                            ],
                          ),
                        )),
                  ),
                  Offstage(
                    offstage: getIndexCountMulti(
                            controller.gridItemFundPermission,
                            7,
                            controller.toFund,
                            controller.gridItemFundPaths,
                            controller.gridItemFundNames,
                            4) ==
                        0,
                    child: Container(
                        height: getIndexCountMulti(
                                    controller.gridItemFundPermission,
                                    7,
                                    controller.toFund,
                                    controller.gridItemFundPaths,
                                    controller.gridItemFundNames,
                                    4) >
                                4
                            ? 570.w
                            : 340.w,
                        child: Card(
                          elevation: 6,
                          shadowColor: Colors.black45,
                          margin: EdgeInsets.only(
                              left: 24.w, top: 16.w, right: 24.w),
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(28.w)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 24.w, left: 40.w, bottom: 16.w),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '资金',
                                  style: TextStyle(
                                      color: Colours.text_333,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32.sp),
                                ),
                              ),
                              Expanded(
                                  child: GridView.count(
                                crossAxisCount: 4,
                                crossAxisSpacing: 36.w,
                                mainAxisSpacing: 24.w,
                                childAspectRatio: 0.639,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(16.w),
                                children: buildWidgetMultiPermission(
                                    controller.gridItemFundPermission,
                                    7,
                                    controller.toFund,
                                    controller.gridItemFundPaths,
                                    controller.gridItemFundNames,
                                    4),
                              )),
                            ],
                          ),
                        )),
                  ),
                  PermissionWidget(
                      permissionCode: PermissionCode.account_page_permission,
                      child: Container(
                          height: 340.w,
                          child: Card(
                            elevation: 6,
                            shadowColor: Colors.black45,
                            margin: EdgeInsets.only(
                                left: 24.w, top: 16.w, right: 24.w),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(28.w)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 24.w, left: 40.w, bottom: 16.w),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '账目',
                                    style: TextStyle(
                                        color: Colours.text_333,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 32.sp),
                                  ),
                                ),
                                Expanded(
                                    child: GridView.count(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 36.w,
                                  mainAxisSpacing: 24.w,
                                  childAspectRatio: 0.639,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(16.w),
                                  children: List.generate(1, (index) {
                                    return InkWell(
                                      onTap: () =>
                                          Get.toNamed(RouteConfig.dailyAccount),
                                      child: Flex(
                                        direction: Axis.vertical,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: Center(
                                              child: LoadSvg(
                                                controller.gridItemAccountPaths[
                                                    index],
                                                width: 88.w,
                                                height: 88.w,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 13),
                                            child: Text(
                                              controller
                                                  .gridItemAccountNames[index],
                                              style: TextStyle(
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Colours.text_999,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                )),
                              ],
                            ),
                          )))
                ],
              ),
            );
          },
        ));
  }

  bool permissionCheck(String permissionCode) {
    if (PermissionCode.common_permission == permissionCode) {
      return true;
    }
    List<String>? permissionList = controller.state.permissionList;
    if (permissionList?.isEmpty ?? true) {
      return false;
    }
    return permissionList!.contains(permissionCode);
  }

  bool permissionListCheck(List<String>? permissionCodes) {
    if (permissionCodes?.isEmpty ?? true) {
      return false;
    }
    if (permissionCodes!.contains(PermissionCode.common_permission)) {
      return true;
    }
    List<String>? permissionList = controller.state.permissionList;
    if (permissionList?.isEmpty ?? true) {
      return false;
    }
    return permissionCodes.any((element) => permissionList!.contains(element));
  }

  List<Widget> buildWidgetPermission(
      List<String> permissionCodes,
      int total,
      Function(int index)? function,
      List<String> imgPath,
      List<String> nameList,
      int index) {
    List<Widget> result = [];
    for (int index = 0; index < total; ++index) {
      var permission = permissionCodes.elementAt(index);
      if (permissionCheck(permission)) {
        result.add(InkWell(
          onTap: () => function?.call(index),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Center(
                  child: LoadSvg(
                    imgPath[index],
                    width: 88.w,
                    height: 88.w,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Text(
                  nameList[index],
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colours.text_999,
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    }
    return result;
  }

  List<Widget> buildWidgetMultiPermission(
      List<List<String>> permissionCodes,
      int total,
      Function(int index)? function,
      List<String> imgPath,
      List<String> nameList,
      int index) {
    List<Widget> result = [];
    for (int index = 0; index < total; ++index) {
      var permissions = permissionCodes.elementAt(index);
      if (permissionListCheck(permissions)) {
        result.add(InkWell(
          onTap: () => function?.call(index),
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Center(
                  child: LoadSvg(
                    imgPath[index],
                    width: 88.w,
                    height: 88.w,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Text(
                  nameList[index],
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colours.text_999,
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    }
    return result;
  }

  int getIndexCount(
      List<String> permissionCodes,
      int total,
      Function(int index)? function,
      List<String> imgPath,
      List<String> nameList,
      int index) {
    var list = buildWidgetPermission(
        permissionCodes, total, function, imgPath, nameList, index);
    return list.length;
  }

  int getIndexCountMulti(
      List<List<String>> permissionCodes,
      int total,
      Function(int index)? function,
      List<String> imgPath,
      List<String> nameList,
      int index) {
    var list = buildWidgetMultiPermission(
        permissionCodes, total, function, imgPath, nameList, index);
    return list.length;
  }
}
