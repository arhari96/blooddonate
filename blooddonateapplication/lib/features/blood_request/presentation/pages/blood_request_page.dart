import 'package:blooddonateapplication/features/blood_request/presentation/getx/blood_request_controller.dart';
import 'package:blooddonateapplication/shared/presentation/widgets/custom_dropdown.dart';
import 'package:blooddonateapplication/shared/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BloodRequestPage extends GetView<BloodRequestController> {
  const BloodRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Request Page'),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          children: [
            CustomFormField(
                title: 'Patient Name',
                controller: controller.patientNameCon,
                lable: 'Ex: Hari'),
            CustomFormField(
              title: 'Patient Age',
              controller: controller.patientAgeCon,
              lable: '26',
              keyboardType: TextInputType.number,
              maxLength: 2,
            ),
            CustomDropDown(
                lable: 'Select Location',
                items: controller.locations,
                updateId: 'updateId',
                margin: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 3.w),
                callBack: (v) {},
                getxController: controller),
            CustomFormField(
                title: 'Contact Person Name',
                controller: controller.contactPersonName,
                lable: 'Chitra'),
            CustomFormField(
              title: 'Contact Person Number',
              controller: controller.requestBloodContactCon,
              lable: '9600849424',
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
            CustomFormField(
                title: 'Number of Unit',
                controller: controller.requestBloodUnitCon,
                lable: '5'),
            CustomFormField(
              title: 'Purpose of Request Blood',
              controller: controller.requestBloodMessageCon,
              lable: 'Ex : Fever',
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              inputAction: TextInputAction.newline,
              maxLength: 250,
            ),
            FilledButton(
                onPressed: () {
                  controller.formKey!.currentState!.validate();
                },
                child: Text('Request'))
          ],
        ),
      ),
    );
  }
}
