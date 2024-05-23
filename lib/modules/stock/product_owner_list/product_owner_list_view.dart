import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/util/image_util.dart';
import 'package:ledger/util/text_util.dart';
import 'package:ledger/widget/elevated_btn.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/image.dart';
import 'package:ledger/widget/title_bar.dart';

import 'product_owner_list_container.dart';

class ProductOwnerListView extends StatelessWidget {
  ProductOwnerListView({super.key});

  final controller = Get.find<ProductOwnerListContainer>();
  final state = Get.find<ProductOwnerListContainer>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: TitleBar(
          title: '货主列表',
        ),
        endDrawer: Drawer(
          width: ScreenUtil().screenWidth * 0.8,
          backgroundColor: Colours.bg,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 100.w, left: 20.w, right: 20.w),
              child: Stack(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  onPressed: () => Get.back(),
                                  icon: Icon(
                                    Icons.close_sharp,
                                    size: 40.w,
                                  )),
                            )),
                        Text(
                          '筛选',
                          style: TextStyle(
                            color: Colours.text_333,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Expanded(flex: 1, child: Container())
                      ],
                    ),
                    SizedBox(
                      height: 40.w,
                    ),
                   GetBuilder<ProductOwnerListContainer>(
                            id: 'switch',
                            init: controller,
                            global: false,
                            builder: (_) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '停用货主',
                                    style: TextStyle(
                                      color: Colours.text_333,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        controller.state.invalid == null
                                            ? '显示'
                                            : '不显示',
                                        style:
                                        TextStyle(color: Colours.text_999),
                                      ),
                                      Switch(
                                          trackOutlineColor:
                                          WidgetStateProperty.resolveWith(
                                                  (states) {
                                                if (states.contains(
                                                    WidgetState.selected)) {
                                                  return Colours
                                                      .primary; // 设置轨道边框颜色
                                                }
                                                return Colors.grey; // 默认的轨道边框颜色
                                              }),
                                          inactiveThumbColor: Colors.grey[300],
                                          value:
                                          controller.state.invalid == null,
                                          onChanged: (value) {
                                            controller.state.invalid = value ? null : 0;
                                            controller.update(['switch']);
                                          }),
                                    ],
                                  )
                                ],
                              );
                            }),
                  ],
                ),
                Positioned(
                  bottom: 100.w,
                  right: 20.w,
                  left: 20.w,
                  child: GetBuilder<ProductOwnerListContainer>(
                      id: 'screen_btn',
                      init: controller,
                      global: false,
                      builder: (logic) {
                        return Row(
                          children: [
                            Expanded(
                              child: ElevatedBtn(
                                elevation: 2,
                                margin: EdgeInsets.only(top: 80.w),
                                size: Size(double.infinity, 90.w),
                                onPressed: () => controller.clearCondition(),
                                radius: 15.w,
                                backgroundColor: Colors.white,
                                text: '重置',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: ElevatedBtn(
                                elevation: 2,
                                margin: EdgeInsets.only(top: 80.w),
                                size: Size(double.infinity, 90.w),
                                onPressed: () => controller.confirmCondition(),
                                radius: 15.w,
                                backgroundColor: Colours.primary,
                                text: '确定',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                )
              ])),
        ),
        body: Column(
          children: [
            Flex(direction: Axis.horizontal, children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white30,
                  height: 100.w,
                  padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                  child: SearchBar(
                    onChanged: (value) => controller.searchCustom(value),
                    leading: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 40.w,
                    ),
                    shadowColor: WidgetStatePropertyAll<Color>(Colors.black26),
                    hintStyle: WidgetStatePropertyAll<TextStyle>(
                        TextStyle(fontSize: 34.sp, color: Colors.black26)),
                    hintText: '请输入客户名称',
                  ),
                ),
              ),
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
                        style: TextStyle(fontSize: 30.sp, color: Colours.text_666),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            SizedBox(height: 8.w,),
            Expanded(
                child: GetBuilder<ProductOwnerListContainer>(
                    id: 'product_owner_list',
                    builder: (_) {
                      return state.productOwnerList.isEmpty
                          ? EmptyLayout(hintText: '什么都没有'.tr)
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                var supplierDTO = state.productOwnerList[index];
                                return InkWell(
                                  onTap: () =>
                                      controller.toSelectProductOwner(supplierDTO),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 32.w, horizontal: 40.w),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              supplierDTO.supplierName ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 34.sp,
                                                  color: supplierDTO.invalid == 1 ?Colours.text_ccc:Colours.text_333),
                                            ),
                                            Offstage(
                                              offstage:  (supplierDTO.remark==null)||(supplierDTO.remark!.isEmpty),
                                              child: SizedBox(height: 16.w),
                                            ),
                                            Offstage(
                                              offstage:  (supplierDTO.remark==null)||(supplierDTO.remark!.isEmpty),
                                              child:   Text(
                                                supplierDTO.remark ?? '',
                                                style: TextStyle(
                                                    fontSize: 28.sp,
                                                    color: supplierDTO.invalid == 1 ?Colours.text_ccc: Colours.text_666),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                            child: Text(
                                                TextUtil.hideNumber(supplierDTO.phone??''),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 32.sp,
                                                  color: supplierDTO.invalid == 1 ?Colours.text_ccc:Colours.text_333),
                                            )),
                                  IconButton(
                                    onPressed: () =>controller.showBottomSheet(context, supplierDTO),
                                    icon: Icon(Icons.more_vert,
                                        color: Colors.grey))
                                      ],
                                    ),
                                  ),
                                );
                              },
                              //separatorBuilder是分隔符组件，可以直接拿来用
                              separatorBuilder: (context, index) => Container(
                                height: 2.w,
                                color: Colours.divider,
                                width: double.infinity,
                              ),
                              itemCount: state.productOwnerList.length,
                            );
                    })),
            Container(
              height: 100.w,
              width: double.infinity,
              margin: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 10.w),
              child: Center(
                child: ElevatedButton(
                  onPressed: () => controller.addProductOwner(),
                  child: Text('+ 新增货主',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w500,
                      )),
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(Size(300, 50)), // 设置
                    backgroundColor: WidgetStateProperty.all(Colours.primary),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
