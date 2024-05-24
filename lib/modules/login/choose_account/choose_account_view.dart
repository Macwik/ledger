import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/res/colors.dart';
import 'package:ledger/widget/empty_layout.dart';
import 'package:ledger/widget/image.dart';

import 'choose_account_controller.dart';

class ChooseAccountView extends StatelessWidget {
  ChooseAccountView({super.key});

  final controller = Get.find<ChooseAccountController>();
  final state = Get.find<ChooseAccountController>().state;

  @override
  Widget build(BuildContext context) {
    controller.initState();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
         Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 120.w,right: 100.w),
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child:  InkWell(
                onTap: ()=>Get.back(),
                child: LoadAssetImage(
                'get_back',
                width: 40.w,
                height: 40.w,
                color: Colors.black87,
              ),
            ) ,
          ),
          Expanded(child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(width: 80.w,),
                  Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colours.divider,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '1',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    width: 100.w,
                    height: 3.w,
                    color: Colours.divider,
                  ),
                  Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colours.divider,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '2',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    width: 100.w,
                    height: 3.w,
                    color: Colours.divider,
                  ),
                  Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colours.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '3',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 80.w,left: 80.w),
                child: Text('选择账本，开始记账',
                  style: TextStyle(
                      color: Colours.text_333,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600
                  ),),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 24.w,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical:24.w,horizontal: 56.w),
                      width: double.infinity,
                      child: Text(
                        '我创建的账本',
                        style: TextStyle(fontSize: 32.sp,color: Colours.text_999,fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 24.w,  bottom:24.w,),
                        color: Colors.white,
                        child: GetBuilder<ChooseAccountController>(
                            id: 'own_account',
                            builder: (_) {
                              return state.userLedger?.ownerList?.isEmpty ?? true
                                  ?  EmptyLayout(hintText: '还没有创建账本'.tr)
                                  : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var userRelationDetailDTO = state.userLedger?.ownerList![index];
                                  return Container(
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
                                          child:  Text(
                                              userRelationDetailDTO?.ledgerName ?? '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 32.sp),
                                            ),
                                          ),
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
                                                    )))
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
                        child: GetBuilder<ChooseAccountController>(
                            id: 'join_account',
                            builder: (_) {
                              return state.userLedger?.joinList?.isEmpty ?? true
                                  ?  EmptyLayout(hintText: '还没有人邀请加入'.tr)
                                  : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var userRelationDetailDTO =
                                  state.userLedger?.joinList![index];
                                  return  Container(
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
                                            Container(
                                                  height: 80.w,
                                                  width: 2.w,
                                                  color: Colours.divider,
                                                ),
                                            Expanded(
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
                                                        InkWell(
                                                            onTap: () =>
                                                                controller.toChangeAccount(userRelationDetailDTO!.ledgerId!),
                                                            child: Text('进入账本',
                                                              style: TextStyle(
                                                                color: userRelationDetailDTO
                                                                    ?.active ??
                                                                    false
                                                                    ? Colours.primary
                                                                    : Colours.text_666,
                                                                fontSize: 28.sp,
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            )),
                                                      ],
                                                    ))
                                          ],
                                        ),
                                      );
                                },
                                itemCount: state.userLedger?.joinList?.length ?? 0,
                              );
                            })),

                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
