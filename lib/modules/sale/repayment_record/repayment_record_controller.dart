import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/config/api/repayment_api.dart';
import 'package:ledger/config/permission_code.dart';
import 'package:ledger/entity/repayment/repayment_dto.dart';
import 'package:ledger/enum/custom_type.dart';
import 'package:ledger/enum/process_status.dart';
import 'package:ledger/http/base_page_entity.dart';
import 'package:ledger/http/http_util.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/route/route_config.dart';
import 'package:ledger/store/store_controller.dart';
import 'package:ledger/util/date_util.dart';
import 'package:ledger/util/decimal_util.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/util/toast_util.dart';
import 'package:ledger/widget/custom_easy_refresh.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/loading.dart';
import 'package:ledger/widget/lottie_indicator.dart';

import 'repayment_record_state.dart';

class RepaymentRecordController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements DisposableInterface {
  final RepaymentRecordState state = RepaymentRecordState();

  late TabController tabController;

  Future<void> initState() async {
    var arguments = Get.arguments;
    if (arguments != null && arguments['index'] != null) {
      state.index = arguments['index'];
    }
    onRefresh();
  }

  @override
  void onInit() {
    tabController = TabController(length: permissionCount(), vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      state.index = index;
      clearCondition();
      onRefresh();
    });
    super.onInit();
  }

  Future<BasePageEntity<RepaymentDTO>> _queryData(int currentPage) async {
    return await Http().networkPage<RepaymentDTO>(
        Method.post, RepaymentApi.repayment_record,
        data: {
          'page': currentPage,
          'customType': state.customTypeList[state.index].value,
          'searchContent': state.searchContent,
          'startDate': DateUtil.formatDefaultDate(state.startDate),
          'endDate': DateUtil.formatDefaultDate(state.endDate),
          'invalid': state.invalid
        });
  }

  Future<void> onLoad() async {
    state.currentPage += 1;
    _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.items?.addAll(result.d!.result!);
        state.hasMore = result.d?.hasMore;
        update(['custom_detail', 'supplier_detail']);
        state.refreshController.finishLoad(state.hasMore ?? false
            ? IndicatorResult.success
            : IndicatorResult.noMore);
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishLoad(IndicatorResult.fail);
      }
    });
  }

  Future<void> onRefresh() async {
    state.currentPage = 1;
    Loading.showDuration();
    await _queryData(state.currentPage).then((result) {
      if (result.success) {
        state.items = result.d?.result;
        state.hasMore = result.d?.hasMore;
        update(['custom_detail', 'supplier_detail']);
        state.refreshController.finishRefresh();
        state.refreshController.resetFooter();
      } else {
        Toast.show(result.m.toString());
        state.refreshController.finishRefresh();
      }
    });
  }

  //筛选里清空条件
  void clearCondition() {
    state.startDate = DateTime.now().subtract(Duration(days: 90));
    state.endDate = DateTime.now();
    state.invalid = 0;
    update(['date_range', 'switch']);
  }

  //筛选里‘确定’
  void confirmCondition() {
    onRefresh();
    Get.back();
  }

  void toRepaymentDetail(int? id) {
    Get.toNamed(RouteConfig.repaymentDetail, arguments: {
      'id': id,
      'customType': state.customTypeList[state.index].value
    })?.then((value) {
      if (ProcessStatus.OK == value) {
        onRefresh();
      }
    });
  }

  void searchRepaymentRecord(String value) {
    state.searchContent = value;
    onRefresh();
  }

  //权限控制相关--标签数量
  permissionCount() {
    int count = 0;
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if (permissionList
        .contains(PermissionCode.funds_repayment_record_permission)) {
      state.customTypeList.add(CustomType.CUSTOM);
      count++;
    }
    if (permissionList
        .contains(PermissionCode.supplier_custom_repayment_record_permission)) {
      state.customTypeList.add(CustomType.SUPPLIER);
      count++;
    }
    return count;
  }

  //权限控制相关--内容body
  widgetTabBarViews() {
    List<Widget> widgetList = [];
    for (int i = 0; i < permissionCount(); i++) {
      widgetList.add(widgetRepaymentRecord());
    }
    return widgetList;
  }

  //权限控制相关--标签
  permissionWidget() {
    List<Widget> widgetList = [];
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if (permissionList
        .contains(PermissionCode.funds_repayment_record_permission)) {
      widgetList.add(Tab(text: '客户'));
    }
    if (permissionList
        .contains(PermissionCode.supplier_custom_repayment_record_permission)) {
      widgetList.add(Tab(text: '供应商'));
    }
    return widgetList;
  }

  Future<void> toRepaymentBill() async {
    List<String>? permissionList = StoreController.to.getPermissionCode();
    if (((state.customTypeList[state.index]) == CustomType.CUSTOM) &&
        (permissionList.contains(
            PermissionCode.supplier_detail_repayment_order_permission))) {
      await Get.toNamed(RouteConfig.repaymentBill,
          arguments: {'customType': CustomType.CUSTOM.value})?.then((value) {
        onRefresh();
      });
    }
    if (((state.customTypeList[state.index]) == CustomType.SUPPLIER) &&
        (permissionList
            .contains(PermissionCode.supplier_repayment_order_permission))) {
      await Get.toNamed(RouteConfig.repaymentBill,
          arguments: {'customType': CustomType.SUPPLIER.value})?.then((value) async {
        await onRefresh();
      });
    }
  }

//主体内容
  widgetRepaymentRecord() {
    return Stack(
      children: [
        Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    child: Container(
                        height: 100.w,
                        padding:
                            EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                        child: SearchBar(
                          leading: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 40.w,
                          ),
                          shadowColor:
                              MaterialStatePropertyAll<Color>(Colors.black26),
                          hintStyle: MaterialStatePropertyAll<TextStyle>(
                              TextStyle(
                                  fontSize: 34.sp, color: Colors.black26)),
                          onChanged: (value) {
                            searchRepaymentRecord(value);
                          },
                          hintText: '请输入名称',
                        ))),
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LoadAssetImage(
                          'screen',
                          format: ImageFormat.png,
                          color: Colours.text_999,
                          height: 40.w,
                          width: 40.w,
                        ), // 导入的图像
                        SizedBox(width: 8.w), // 图像和文字之间的间距
                        Text(
                          '筛选',
                          style: TextStyle(
                              fontSize: 30.sp, color: Colours.text_666),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //搜索框
            Expanded(
                child: GetBuilder<RepaymentRecordController>(
                    id: 'custom_detail',
                    builder: (_) {
                      return CustomEasyRefresh(
                        controller: state.refreshController,
                        onLoad: onLoad,
                        onRefresh: onRefresh,
                        emptyWidget: state.items == null
                            ? LottieIndicator()
                            : state.items!.isEmpty
                                ? EmptyLayout(hintText: '什么都没有'.tr)
                                : null,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var repaymentOrderDTO = state.items![index];
                            return InkWell(
                                onTap: () =>
                                    toRepaymentDetail(repaymentOrderDTO.id),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: 10.w, left: 30.w, top: 10.w),
                                      alignment: Alignment.centerLeft,
                                      color: Colors.white12,
                                      child: Text(
                                          DateUtil.formatDefaultDate2(
                                              repaymentOrderDTO.repaymentDate),
                                          style: TextStyle(
                                            color: Colours.text_ccc,
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.w, vertical: 20.w),
                                      child: Column(
                                        children: [
                                          Flex(
                                            direction: Axis.horizontal,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                repaymentOrderDTO.customName ??
                                                    '',
                                                style: TextStyle(
                                                  color: repaymentOrderDTO
                                                              .invalid ==
                                                          0
                                                      ? Colours.text_333
                                                      : Colours.text_ccc,
                                                  fontSize: 30.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                              Visibility(
                                                  visible: repaymentOrderDTO
                                                              .invalid ==
                                                          0
                                                      ? false
                                                      : true,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 2.w,
                                                        bottom: 2.w,
                                                        left: 4.w,
                                                        right: 4.w),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colours.text_ccc,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Text('已作废',
                                                        style: TextStyle(
                                                          color:
                                                              Colours.text_666,
                                                          fontSize: 26.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                  )),
                                            ],
                                          ),
                                          Container(
                                            height: 1.w,
                                            margin: EdgeInsets.only(
                                                top: 16.w, bottom: 16.w),
                                            width: double.infinity,
                                            color: Colours.divider,
                                          ),
                                          Flex(
                                            direction: Axis.horizontal,
                                            children: [
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  Text(
                                                    '本次还款：',
                                                    style: TextStyle(
                                                      color: Colours.text_ccc,
                                                      fontSize: 26.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    textAlign: TextAlign.left,
                                                    DecimalUtil.formatAmount(
                                                        repaymentOrderDTO
                                                            .totalAmount),
                                                    style: TextStyle(
                                                      color: repaymentOrderDTO
                                                                  .invalid ==
                                                              0
                                                          ? Colours.text_333
                                                          : Colours.text_ccc,
                                                      fontSize: 28.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ))
                                                ],
                                              )),
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  Text(
                                                    '业务员：',
                                                    style: TextStyle(
                                                      color: Colours.text_ccc,
                                                      fontSize: 26.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    repaymentOrderDTO
                                                            .creatorName ??
                                                        '',
                                                    style: TextStyle(
                                                      color: repaymentOrderDTO
                                                                  .invalid ==
                                                              0
                                                          ? Colours.text_666
                                                          : Colours.text_ccc,
                                                      fontSize: 26.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16.w,
                                          ),
                                          Flex(
                                            direction: Axis.horizontal,
                                            children: [
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  Text(
                                                    '其中优惠：',
                                                    style: TextStyle(
                                                      color: Colours.text_ccc,
                                                      fontSize: 26.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    DecimalUtil.formatAmount(
                                                        repaymentOrderDTO
                                                            .discountAmount),
                                                    style: TextStyle(
                                                      color: repaymentOrderDTO
                                                                  .invalid ==
                                                              0
                                                          ? Colours.text_666
                                                          : Colours.text_ccc,
                                                      fontSize: 26.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              Expanded(
                                                child: Text(
                                                    DateUtil
                                                        .formatDefaultDateTimeMinute(
                                                            repaymentOrderDTO
                                                                .gmtCreate),
                                                    style: TextStyle(
                                                      color: Colours.text_ccc,
                                                      fontSize: 28.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                          itemCount: state.items?.length ?? 0,
                        ),
                      );
                    })),
          ],
        ),
        Positioned(
            bottom: 20.w,
            right: 20.w,
            child: Container(
                width: 210.w,
                height: 110.w,
                margin: EdgeInsets.only(bottom: 30.w),
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // 设置圆角大小
                  ),
                  onPressed: () => toRepaymentBill(),
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 30.w,
                      ),
                      Text(
                        '还款',
                        style: TextStyle(fontSize: 32.sp),
                      ),
                    ],
                  )), // 按钮上显示的图标
                )))
      ],
    );
  }
}
