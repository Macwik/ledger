import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledger/res/export.dart';

import 'business_condition_controller.dart';

class BusinessConditionView extends StatelessWidget {
  BusinessConditionView({super.key});

  final controller = Get.find<BusinessConditionController>();
  final state = Get.find<BusinessConditionController>().state;

  @override
  Widget build(BuildContext context) {
    //controller.initState();
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white,),
          title: Text('经营状况',style: TextStyle(color: Colors.white),),
        ),
      body: Column(
       children: [
         Container(
           height: 100.w,
           margin: EdgeInsets.only(bottom: 10.w),
           padding: EdgeInsets.only(left:30.w,top: 20.w ),
           color: Colors.white,
           width: double.infinity,
           child: InkWell(
             onTap: () => controller.selectDateRange(context),
             child: Row(
               children: [
                 GetBuilder<BusinessConditionController>(
                     id: 'date_range',
                     builder: (_) {
                       return Text(
                         state.dateRange ?? '',
                         style: TextStyle(
                           color: Colours.text_333,
                           fontSize: 28.sp,
                           fontWeight: FontWeight.w600,
                         ),
                       );
                     }),
               ],
             ),
           ),
         ),
         Container(
           padding: EdgeInsets.only(left:20,right:20,top: 20,bottom: 20),
           margin: EdgeInsets.only(bottom: 10.w),
           width: double.infinity,
           color: Colors.white,
           child: Column(
             children: [
               Row(
                 children: [
                   Container(
                     color: Colours.primary,
                     margin: EdgeInsets.only(bottom: 20),
                     height: 38.w,
                     width: 12.w,
                   ),
                   Container(
                     color: Colors.white,
                     margin: EdgeInsets.only(left: 10,bottom: 20),
                     child: Text('自营货物经营状况',
                     style: TextStyle(
                       fontSize: 34.sp,
                       fontWeight: FontWeight.bold
                     ),
                     ),
                   ),
                 ],
               ),
               Flex(
                 direction: Axis.horizontal,
                 children: [
                   Expanded(
                     flex: 1,
                     child: Row(
                       children: [
                         Text('利润（元）',
                           style: TextStyle(
                             fontSize: 28.sp,
                             color: Colors.black87,
                             // fontWeight: FontWeight.bold
                           ),
                         ),
                         Text('含外欠',
                           style: TextStyle(
                             fontSize: 24.sp,
                             color: Colors.black45,
                             // fontWeight: FontWeight.bold
                           ),
                         ),
                       ],
                     )

                   ),
                   Expanded(
                     flex: 1,
                     child: Text('其他费用（元）',
                     style: TextStyle(
                           fontSize: 28.sp,
                       color: Colors.black87,
                         // fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 20.w,),
               Flex(
                 direction: Axis.horizontal,
                 children: [
                   //Todo 填充下利润
                   Expanded(
                     flex: 1,
                     child: Text('5555',
                       style: TextStyle(
                         fontSize: 34.sp,
                         color: Colors.black87,
                         fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                   Expanded(
                     flex: 1,
                     //Todo 填充下其他费用
                     child: Text('000',
                       style: TextStyle(
                         fontSize: 34.sp,
                         color: Colors.black87,
                         fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 40.w,),
               Flex(
                 direction: Axis.horizontal,
                 children: [
                   Expanded(
                     flex: 1,
                     child: Text('收入（元）',
                       style: TextStyle(
                         fontSize: 28.sp,
                         color: Colors.black87,
                         // fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                   Expanded(
                     flex: 1,
                     child: Row(
                       children: [
                         Text('采购及其费用（元）',
                           style: TextStyle(
                             fontSize: 28.sp,
                             color: Colors.black87,
                             // fontWeight: FontWeight.bold
                           ),
                         ),
                         Text('含外欠',
                           style: TextStyle(
                             fontSize: 24.sp,
                             color: Colors.black45,
                             // fontWeight: FontWeight.bold
                           ),
                         ),
                       ],
                     )

                   ),
                 ],
               ),
               SizedBox(height: 20.w,),
               Flex(
                 direction: Axis.horizontal,
                 children: [
                   //Todo 填充下收入
                   Expanded(
                     flex: 1,
                     child: Text('5555',
                       style: TextStyle(
                           fontSize: 34.sp,
                           color: Colors.black87,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                   Expanded(
                     flex: 1,
                     //Todo 填充下采购及其费用
                     child: Text('000',
                       style: TextStyle(
                           fontSize: 34.sp,
                           color: Colors.black87,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 20.w,),


             ],
           ),
           //ToDo 货物详情部分没有写
         ),
         Container(
           padding: EdgeInsets.only(left:20,right:20,top: 20,bottom: 20),
           margin: EdgeInsets.only(bottom: 10.w),
           width: double.infinity,
           color: Colors.white,
           child: Column(
             children: [
               Row(
                 children: [
                   Container(
                     color: Colours.primary,
                     margin: EdgeInsets.only(bottom: 20),
                     height: 38.w,
                     width: 12.w,
                   ),
                   Container(
                     color: Colors.white,
                     margin: EdgeInsets.only(left: 10,bottom: 20),
                     child: Text('赊账情况',
                       style: TextStyle(
                           fontSize: 34.sp,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ],
               ),
               Flex(
                 direction: Axis.horizontal,
                 children: [
                   Expanded(
                     flex: 1,
                     child: Text('应收账款（元）',
                       style: TextStyle(
                         fontSize: 28.sp,
                         color: Colors.black87,
                         // fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                   Expanded(
                     flex: 1,
                     child: Text('应付账款（元）',
                       style: TextStyle(
                         fontSize: 28.sp,
                         color: Colors.black87,
                         // fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 20.w,),
               Flex(
                 direction: Axis.horizontal,
                 children: [
                   //Todo 填充下利润
                   Expanded(
                     flex: 1,
                     child: Text('5555',
                       style: TextStyle(
                           fontSize: 34.sp,
                           color: Colors.black87,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                   Expanded(
                     flex: 1,
                     //Todo 填充下其他费用
                     child: Text('000',
                       style: TextStyle(
                           fontSize: 34.sp,
                           color: Colors.black87,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 20.w,),
               Flex(
                 direction: Axis.horizontal,
                 children: [
                   Expanded(
                     flex: 1,
                     child: Text('他人欠我，我应收回的欠款',
                       style: TextStyle(
                         fontSize: 22.sp,
                         color: Colors.black54,
                         // fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                   Expanded(
                     flex: 1,
                     child: Text('我欠他人，我应归还的欠款',
                       style: TextStyle(
                         fontSize: 22.sp,
                         color: Colors.black54,
                         // fontWeight: FontWeight.bold
                       ),
                     ),
                   ),
                 ],
               ),
             ],
           ),
         ),

       ],
      )


    );
  }
}
