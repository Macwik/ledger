import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DataExportState {
  DataExportState() {
    ///Initialize variables
  }
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  final formKey = GlobalKey<FormBuilderState>();

  String? dateRange;
}
