import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../res/utils.dart';

class UpdateEmployeeDataVM extends BaseViewModel {
  UpdateEmployeeDataVM();
  final formKey = GlobalKey<FormState>();
  String? _name, _regNo, _gender;
  int? _age;

  onNameSaved(String? value) {
    _name = value;
  }

  onRegNoSaved(String? value) {
    _regNo = value;
  }

  onAgeSaved(String? value) {
    _age = int.parse(value!);
  }

  onGenderSaved(String? value) {
    _gender = value;
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  onUpdateEmployeeData(BuildContext context, String id) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      Map<String, dynamic> employeeData = {
        'Name': _name,
        'Registration No': _regNo,
        'Age': _age,
        'Gender': _gender,
        'id': id,
      };
      FirebaseFirestore.instance
          .collection('Employee')
          .doc(id)
          .update(employeeData);
      debugPrint('Employee Data: $employeeData');
      Utils.toastMessage('Employee data updated Successfully');
      // await addEmployeeDetails(employeeData, id);
      Navigator.pop(context);
    }
  }
}
