import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BloodRequestController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final patientNameCon = TextEditingController();
  final patientAgeCon = TextEditingController();
  final contactPersonName =TextEditingController();
  final requestBloodUnitCon = TextEditingController(text: '1');
  final requestBloodLocationCon = TextEditingController();
  final requestBloodContactCon = TextEditingController();
  final requestBloodMessageCon = TextEditingController();
  List<String> _locations = ['Paramakudi','Emaneshwaram'];
  List<String> get locations => _locations;
  String? _patientGender;
  String? get patientGender => _patientGender;
  String? _requestBloodGroup;
  String? get requestBloodGroup => _requestBloodGroup;

}