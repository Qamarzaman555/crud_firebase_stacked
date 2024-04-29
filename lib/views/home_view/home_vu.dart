import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/res/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../res/componenets/custom_text.dart';
import '../add_employee_view/add_employee_vu.dart';
import '../update_emplyee_data_view/update_emplyee_data_vu.dart';
import 'home_vm.dart';

class HomeScreenVU extends StackedView<HomeScreenVM> {
  const HomeScreenVU({super.key});

  @override
  Widget builder(BuildContext context, HomeScreenVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(text: "Flutter", fontSize: 24, color: Colors.blue),
            4.spaceX,
            const CustomText(
                text: "Firebase", fontSize: 24, color: Colors.orange),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: viewModel.employeeStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CustomText(
                      text: 'Fetching Data',
                      color: Colors.blue,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error');
                } else if (!snapshot.hasData) {
                  return const Text('No data');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          elevation: 5,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              color: Colors.grey[70],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                          text: 'Name: ${ds['Name']}',
                                          color: Colors.blue,
                                          fontSize: 16),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            editEmployeeData(
                                                ds['Id'],
                                                ds['Name'],
                                                ds['Registration No'],
                                                ds['Age'],
                                                ds['Gender'],
                                                context);
                                          },
                                          icon: const Icon(
                                            Icons.edit_outlined,
                                            color: Colors.green,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            viewModel
                                                .removeEmployeeData(ds['Id']);
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                  CustomText(
                                      text:
                                          'Registeraion No: ${ds['Registration No']}',
                                      color: Colors.orange,
                                      fontSize: 16),
                                  CustomText(
                                      text: 'Age:  ${ds['Age']}',
                                      color: Colors.blue,
                                      fontSize: 16),
                                  CustomText(
                                      text: 'Gender:  ${ds['Gender']}',
                                      color: Colors.orange,
                                      fontSize: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const EmployeeVU();
            }));
          },
          child: const Icon(Icons.add)),
    );
  }

  Future editEmployeeData(String id, String name, String regNo, int age,
      String gender, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: UpdateEmployeeDataVU(
          id: id,
          name: name,
          regNo: regNo,
          age: age,
          gender: gender,
        ));
      },
    );
  }

  @override
  HomeScreenVM viewModelBuilder(BuildContext context) => HomeScreenVM(context);
}
