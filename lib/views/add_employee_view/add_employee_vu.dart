import 'package:crud_firebase/res/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../res/componenets/custom_field.dart';
import '../../res/componenets/custom_text.dart';
import '../../res/componenets/round_btn.dart';
import 'add_employee_vm.dart';

class EmployeeVU extends StackedView<EmployeeVM> {
  const EmployeeVU({super.key});

  @override
  Widget builder(BuildContext context, EmployeeVM viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
                text: "Employee", fontSize: 24, color: Colors.blue),
            4.spaceX,
            const CustomText(text: "Form", fontSize: 24, color: Colors.orange),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(text: 'Name'),
                2.spaceY,
                UKTextField(
                  validator: viewModel.validator,
                  onSaved: viewModel.onNameSaved,
                ),
                12.spaceY,
                const CustomText(text: 'Registeraion No.'),
                2.spaceY,
                UKTextField(
                  validator: viewModel.validator,
                  onSaved: viewModel.onRegNoSaved,
                ),
                12.spaceY,
                const CustomText(text: 'Age'),
                2.spaceY,
                UKTextField(
                  validator: viewModel.validator,
                  onSaved: viewModel.onAgeSaved,
                ),
                12.spaceY,
                const CustomText(text: 'Gender'),
                2.spaceY,
                UKTextField(
                  validator: viewModel.validator,
                  onSaved: viewModel.onGenderSaved,
                ),
                12.spaceY,
                RoundButton(
                  title: 'Add',
                  onPressed: () {
                    viewModel.onSavePatient(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  EmployeeVM viewModelBuilder(BuildContext context) => EmployeeVM();
}
