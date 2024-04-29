import 'package:crud_firebase/res/utils.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../res/componenets/custom_field.dart';
import '../../res/componenets/custom_text.dart';
import '../../res/componenets/round_btn.dart';
import 'update_emplyee_data_vm.dart';

class UpdateEmployeeDataVU extends StackedView<UpdateEmployeeDataVM> {
  final String id;
  final String name, regNo, gender;
  final int age;
  const UpdateEmployeeDataVU(
      {super.key,
      required this.id,
      required this.name,
      required this.regNo,
      required this.age,
      required this.gender});

  @override
  Widget builder(
      BuildContext context, UpdateEmployeeDataVM viewModel, Widget? child) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomText(
                        text: "Edit", fontSize: 24, color: Colors.blue),
                    4.spaceX,
                    const CustomText(
                        text: "Employee", fontSize: 24, color: Colors.orange),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel_rounded),
                    ),
                  ],
                ),
                8.spaceY,
                const CustomText(text: 'Name'),
                2.spaceY,
                UKTextField(
                  validator: viewModel.validator,
                  onSaved: viewModel.onNameSaved,
                  initialValue: name,
                ),
                12.spaceY,
                const CustomText(text: 'Registeraion No.'),
                2.spaceY,
                UKTextField(
                  validator: viewModel.validator,
                  onSaved: viewModel.onRegNoSaved,
                  initialValue: regNo,
                ),
                12.spaceY,
                const CustomText(text: 'Age'),
                2.spaceY,
                UKTextField(
                  validator: viewModel.validator,
                  onSaved: viewModel.onAgeSaved,
                  initialValue: age.toString(),
                ),
                12.spaceY,
                const CustomText(text: 'Gender'),
                2.spaceY,
                UKTextField(
                  validator: viewModel.validator,
                  onSaved: viewModel.onGenderSaved,
                  initialValue: gender,
                ),
                12.spaceY,
                RoundButton(
                  title: 'Add',
                  onPressed: () {
                    viewModel.onUpdateEmployeeData(context, id);
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
  UpdateEmployeeDataVM viewModelBuilder(BuildContext context) =>
      UpdateEmployeeDataVM();
}
