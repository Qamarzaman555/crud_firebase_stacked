import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:stacked/stacked.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../res/utils.dart';

class EmployeeVM extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  String? _name, _regNo, _gender;
  int? _age;
  String id = randomAlphaNumeric(10);

  Future<void> addEmployeeDetails(
      Map<String, dynamic> employeeData, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('Employee')
          .doc(id)
          .set(employeeData);
      Utils.toastMessage('Employee data added Successfully');
      debugPrint('Employee data added to Firestore successfully.');
    } catch (e) {
      debugPrint('Error adding employee data: $e');
    }
  }

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

  onSavePatient(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      Map<String, dynamic> employeeData = {
        'Name': _name,
        'Registration No': _regNo,
        'Age': _age,
        'Gender': _gender,
        'Id': id
      };
      debugPrint('Employee Data: $employeeData');
      await addEmployeeDetails(employeeData, id);
      Navigator.pop(context);
    }
  }
}
