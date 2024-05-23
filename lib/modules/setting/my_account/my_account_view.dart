import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ledger/enum/is_select.dart';
import 'package:ledger/res/export.dart';
import 'package:ledger/widget/will_pop.dart';

import 'my_account_controller.dart';

class MyAccountView extends StatelessWidget {
  final controller = Get.find<MyAccountController>();
  final state = Get.find<MyAccountController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Scaffold(
      appBar: TitleBar(
        title:
          state.isSelect == IsSelectType.FALSE.value
              ?'账本管理'
              :'请选择账本',
        backPressed: ()=> controller.myAccountGetBack(),
        actionWidget:
          Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: IconButton(
                  onPressed: () {
                    controller.toAddAccount();
                  },
                  icon: Icon(Icons.add),
                  color: Colors.black54,
                )),
          ])
      ),
      body:  MyWillPop(
          onWillPop: () async {
            controller.myAccountGetBack();
            return true;
          },
          child:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical:24.w,horizontal: 56.w),
              width: double.infinity,
              child: Text(
                '我的账本',
                style: TextStyle(fontSize: 32.sp,color: Colours.text_999,fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 24.w,  bottom:24.w,),
              color: Colors.white,
                child: GetBuilder<MyAccountController>(
                id: 'own_account',
                builder: (_) {
                  return state.userLedger?.ownerList?.isEmpty ?? true
                      ?  EmptyLayout(hintText: '什么都没有'.tr)
                      : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var userRelationDetailDTO = state.userLedger?.ownerList![index];
                      return Container(
                       // width: double.maxFinite,
                        height: 130.w,
                        padding: EdgeInsets.only(left: 40.w, right: 40.w),
                        margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom:32.w,),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.2),
                              offset: Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => controller.accountManage(userRelationDetailDTO?.ledgerId),
                                child: Text(
                                  userRelationDetailDTO?.ledgerName ?? '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 32.sp),
                                ),
                              ),
                            ),
                            Visibility(
                                visible: state.isSelect == IsSelectType.FALSE.value ,
                                child:
                                Container(
                                  height: 80.w,
                                  width: 2.w,
                                  color: Colours.divider,
                                )),
                            Visibility(
                                visible: state.isSelect == IsSelectType.FALSE.value ,
                                child:
                                Expanded(
                                    child: InkWell(
                                        onTap: () {
                                          controller.toChangeAccount(
                                              userRelationDetailDTO!.ledgerId!);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            LoadSvg(
                                              userRelationDetailDTO?.active ??
                                                  false
                                                  ? 'svg/my_account_check'
                                                  : 'svg/my_account_change',
                                              width: 40.w,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Text(
                                              userRelationDetailDTO?.active ?? false
                                                  ? '当前账本'
                                                  : '进入账本',
                                              style: TextStyle(
                                                color: userRelationDetailDTO
                                                    ?.active ??
                                                    false
                                                    ? Colours.primary
                                                    : Colours.text_666,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ))))
                          ],
                        ),
                      );
                    },
                    itemCount: state.userLedger?.ownerList?.length ?? 0,
                  );
                })),
            Container(
              padding: EdgeInsets.symmetric(vertical:24.w,horizontal: 56.w),
              width: double.infinity,
              child: Text(
                '我参与的账本',
                style: TextStyle(fontSize: 32.sp,color: Colours.text_999,fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 24.w,  bottom:24.w,),
                color: Colors.white,
                child: GetBuilder<MyAccountController>(
                id: 'join_account',
                builder: (_) {
                  return state.userLedger?.joinList?.isEmpty ?? true
                      ?  EmptyLayout(hintText: '什么都没有'.tr)
                      : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var userRelationDetailDTO =
                      state.userLedger?.joinList![index];
                      return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.25,
                            children: [
                              SlidableAction(
                                label: '删除',
                                backgroundColor: Colors.red,
                                icon: Icons.delete_outline_rounded,
                                onPressed: (context) =>
                                    controller.toDeleteLedger(userRelationDetailDTO!.ledgerId!),
                              ),
                            ],
                          ),
                          child: Container(
                            height: 130.w,
                            padding: EdgeInsets.only(left: 40.w, right: 40.w),
                            margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom:32.w,),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(1, 1),
                                  blurRadius: 3,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black12,
                                width: 1.0,
                              ),
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                    child: Text(
                                        userRelationDetailDTO?.ledgerName ?? '',
                                        style: TextStyle(
                                          fontSize: 30.w,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                Visibility(
                                    visible: state.isSelect ==
                                        IsSelectType.FALSE.value,
                                    child: Container(
                                      height: 80.w,
                                      width: 2.w,
                                      color: Colours.divider,
                                    )),
                                Visibility(
                                    visible: state.isSelect ==
                                        IsSelectType.FALSE.value,
                                    child:  Expanded(
                                        child:InkWell(
                                            onTap: () =>
                                                controller.toChangeAccount(
                                                    userRelationDetailDTO!.ledgerId!),
                                            child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            LoadSvg(
                                              userRelationDetailDTO?.active ?? false
                                                  ? 'svg/my_account_check'
                                                  : 'svg/my_account_change',
                                              width: 40.w,
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Text(
                                                  userRelationDetailDTO?.active ??
                                                      false
                                                      ? '当前账本'
                                                      : '切换账本',
                                                  style: TextStyle(
                                                    color: userRelationDetailDTO
                                                        ?.active ??
                                                        false
                                                        ? Colours.primary
                                                        : Colours.text_666,
                                                    fontSize: 28.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                          ],
                                        ))))
                              ],
                            ),
                          ));
                    },
                    itemCount: state.userLedger?.joinList?.length ?? 0,
                  );
                })),

          ],
        ),
      ))
    );
  }
}
