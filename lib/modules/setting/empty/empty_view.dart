import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ledger/modules/setting/empty/empty_controller.dart';
import 'package:ledger/res/colors.dart';


class EmptyView extends StatelessWidget {
  EmptyView({super.key});

  final controller = Get.find<EmptyController>();
  final state = Get.find<EmptyController>().state;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
         toolbarHeight: 1.w,
         backgroundColor: Colors.white,
       ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          //color: Colors.white,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: '销售',),
                  Tab(text: '退货',)
                ],
                indicatorWeight: 3.w,
                indicatorPadding: EdgeInsets.all(0),
                labelPadding: EdgeInsets.all(0),
                isScrollable: false,
                indicatorColor: Colours.primary,
                unselectedLabelColor: Colours.text_999,
                unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w500),
                labelStyle: TextStyle(fontWeight: FontWeight.w500),
                labelColor: Colors.red,
              ),
              Expanded(
                  child: TabBarView(children: [
                tabBarWidget1(context),
                tabBarWidget2(),
              ]))
            ],
          ),
        ),

      )
    );
  }

  tabBarWidget2() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(4),
            width: 100,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10)),
          );
        });
  }
}

Widget tabBarWidget1(BuildContext context) {
    //继承AutomaticKeepAliveClientMixin类
    return ReorderableListView(
        header: Container(
          height: 50,
        ),
        children: _data.map((s) => Card(
          color: s,
          key: Key(s.toString()),
          child: Container(
            width: 300,
            height: 100,
          ),
        ))
            .toList(),
        onReorder: (int oldIndex, int newIndex) {
          print('$oldIndex --- $newIndex');
        });
}
List<Color> _data = [
  Colors.blue,
  Colors.pinkAccent,
  Colors.deepPurple,
  Colors.orangeAccent
];
