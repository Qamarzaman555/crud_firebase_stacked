import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../res/utils.dart';

class HomeScreenVM extends BaseViewModel {
  Stream<QuerySnapshot> employeeStream = Stream.empty();

  HomeScreenVM(BuildContext context) {
    getEmployeeData().then((stream) {
      // Assign the stream to employeeStream once it's retrieved
      employeeStream = stream;
      notifyListeners();
    }).catchError((error) {
      // Handle errors
      debugPrint('Error fetching employee data: $error');
    });
  }

  Future<Stream<QuerySnapshot>> getEmployeeData() async {
    return FirebaseFirestore.instance.collection('Employee').snapshots();
  }

  Future removeEmployeeData(String id) {
    Utils.toastMessage('Employee data removed Successfully');
    return FirebaseFirestore.instance.collection('Employee').doc(id).delete();
  }
}
