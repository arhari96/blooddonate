import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDropDown extends StatelessWidget {
  String lable;
  List<String> items;
  String updateId;
  EdgeInsets margin;
  Function(String? callback) callBack;
  String? value;

  CustomDropDown(
      {Key? key,
      required this.lable,
      required this.items,
      required this.updateId,
      required this.margin,
      required this.callBack,
      required this.getxController,
      this.value})
      : super(key: key);
  var getxController;
  String? _selecteditem;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        decoration: BoxDecoration(
          border: Border.all(),
            color:  Colors.white70 ,
            borderRadius: BorderRadius.circular(10.sp)),
        alignment: Alignment.topCenter,
        child: GetBuilder<GetxController>(
            id: updateId,
            init: getxController,
            builder: (cntrl) {
              return DropdownButtonFormField<String>(
                hint: Text(lable),
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 20.sp,
                ),
                style: Theme.of(Get.context!)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 15.sp),

                value: _selecteditem,
                validator: (value) => value == null ? 'field required' : null,
                onChanged: (v) {
                  _selecteditem = v!;
                  callBack(v);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                isDense: true,
                itemHeight: 48,
                menuMaxHeight: 40.h,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                items: items.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: value.toString(),
                    // child: Text(value),
                    child: Text(value),
                  );
                }).toList(),
              );
            }));
  }
}
