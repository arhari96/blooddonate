import 'package:blooddonateapplication/shared/presentation/extensions/date_time_formatter_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {required this.title,
      required this.controller,
      required this.lable,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.enabled = false,
      this.maxLines = 1,
      this.inputAction = TextInputAction.done,
      this.prefix = '',
      this.icon,
      this.maxLength = 25,
      this.dateChange = false,
      this.onChanged});

  IconData? icon;
  String title;
  TextEditingController controller;
  String lable;
  FormFieldValidator<String>? validator ;
  TextInputType keyboardType = TextInputType.text;
  bool enabled = false;
  bool dateChange = false;
  String prefix;
  int maxLines = 1;
  TextInputAction inputAction = TextInputAction.done;
  Function(String v)? onChanged;
  int maxLength;
  String dateFormat = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title != '',
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.3.h, horizontal: 3.w),
              child: Text(title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ))),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.3.h, horizontal: 3.w),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: maxLength,
            textInputAction: inputAction,
            onChanged: onChanged ?? (String v) {},
            validator: validator ??(v) {
              if (v!.isEmpty) {
                return 'This field is required';
              } else {
                return null;
              }
            },
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.5.sp),
            readOnly: enabled,
            maxLines: maxLines,
            decoration: InputDecoration(
                isDense: true,
                errorStyle: TextStyle(fontSize: 13.sp),
                counterText: "",
                prefixStyle: TextStyle(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w500,
                ),
                prefixText: prefix != '' ? prefix : '',
                suffixIcon: icon != null
                    ? InkWell(
                        child: Icon(
                          icon,
                          size: 18.sp,
                        ),
                        onTap: dateChange
                            ? () async {
                                final DateTime? picked = await showDatePicker(
                                  context: Get.context!,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  if (dateFormat == '') {
                                    controller.text = picked.toDDMMYYYY;
                                  } else {
                                    controller.text = picked.toMMM_YY;
                                  }
                                }
                              }
                            : null,
                      )
                    : null,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.0.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                hintText: lable,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 13.sp)),
          ),
        ),
      ],
    );
  }
}
