import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitors_app/const/colors.dart';
import 'package:visitors_app/const/common_widgets.dart';
import 'package:visitors_app/const/server_client.dart';
import 'package:visitors_app/const/urls.dart';
import 'package:visitors_app/landing_section/controller/landing_controller.dart';
import 'package:visitors_app/registration_section/model/all_employees_model.dart';
import 'package:visitors_app/registration_section/model/visitor_data.dart';
import 'package:visitors_app/success_section/view/success_screen.dart';

class VisitorDetailsController extends GetxController {
  /* Variables */
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController visitTypeController = TextEditingController();

  TextEditingController personToMeetController = TextEditingController(text: 'Personal');

  TextEditingController durationController = TextEditingController(text: '10');

  TextEditingController reasonController = TextEditingController();

  bool isSubmiting = false;
  bool isSubmitDetailsVerified = false;

  void isSubmitDetailsVerifiedFn() {
    if (fullNameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        visitTypeController.text.trim().isNotEmpty &&
        personToMeetController.text.trim().isNotEmpty &&
        durationController.text.trim().isNotEmpty &&
        reasonController.text.trim().isNotEmpty) {
      isSubmitDetailsVerified = true;
    } else {
      isSubmitDetailsVerified = false;
    }
    update();
  }

  void setVisitType(String type) {
    visitTypeController.text = type;
    isSubmitDetailsVerifiedFn();
  }

  void setDuration(String duration) {
    durationController.text = duration;
    isSubmitDetailsVerifiedFn();
  }

  Result dataResult = Result();
  void setPersonToMeet(Result person) {
    dataResult = person;
    personToMeetController.text = person.name ?? '';
    isSubmitDetailsVerifiedFn();
  }

  /*  API Function */
  Future<void> registerVisitorFn({required BuildContext context}) async {
    isSubmiting = true;
    update();
    try {
      final LandingController landingController = Get.find<LandingController>();

      var body = {
        "name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": landingController.mobileController.text.trim(),
        "whatzapp": true,
        "verified": true,
        "visitorsVisit": {
          "who_to_meet": dataResult.id ?? 0,
          "type": visitTypeController.text,
          "reason": reasonController.text,
          "duration_mins": int.parse(durationController.text),
          "verified": true,
          "verified_method": "sms",
        },
      };
      final response = await ServerClient.post(Urls.visitorRegister, data: body, post: true, context);
      // log('response.first in Verifying otp: ${response.first} response.last in Verifying otp: ${response.last}');
      if (response.first >= 200 && response.first < 300) {
        toast(context, title: 'Visitor Registered successfully', backgroundColor: AppColor.green);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SuccessScreen(isFromRegister: true)),
          (route) => true,
        );
        clearAllVariables();
      } else {
        toast(context, title: response.last, backgroundColor: AppColor.redColor);
      }
    } catch (e) {
      toast(context, title: 'Server busy , please try again later', backgroundColor: AppColor.redColor);
      debugPrint('error in Verifying otp: $e');
    } finally {
      isSubmiting = false;
      update();
    }
  }

  /* Fetch All Employees */

  bool isFetchingEmployees = false;
  FetchAllEmployees? employees;

  Future<void> getAllEmployeesFn({required BuildContext context}) async {
    isFetchingEmployees = true;

    update();

    try {
      String url = "${Urls.baseUrl}/Visitors/FetchAllEmployees";
      List response = await ServerClient.post(url, context);

      log('employees response.first ${response.first} response.last ${response.last}');

      if (response.first >= 200 && response.first < 300) {
        final employeeData = FetchAllEmployees.fromJson(response.last);
        employees = employeeData;
      } else {}
    } finally {
      isFetchingEmployees = false;
      update();
    }
  }

  bool isCheckouting = false;
  /*  API Function */
  Future<void> chekoutVisitor({required BuildContext context}) async {
    isCheckouting = true;
    update();
    print("AAAA 45678367834658743685");
    final LandingController landingController = Get.find<LandingController>();

    try {
      print(Urls.checkExists + landingController.mobileController.text);
      final response = await ServerClient.post(
        Urls.checkExists + landingController.mobileController.text,
        post: false,
        context,
      );
      log('response.first in sending otp: ${response.first} response.last in sending otp: ${response.last['message']}');
      if (response.first >= 200 && response.first < 300) {
        // Get.offAllNamed(RouteGenerate.landingScreen);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SuccessScreen()),
          (route) => true,
        );
      }
    } catch (e) {
      toast(context, title: 'Server busy , please try again later', backgroundColor: AppColor.redColor);
      debugPrint('error in sending otp: $e');
    } finally {
      isCheckouting = false;
      update();
    }
  }
  /* Fetch All Employees */

  bool isFetchingVisitor = false;
  FetchVisitorEmployees? visitor;

  Future<void> getAllVisitorFn({required BuildContext context, required String phone}) async {
    isFetchingVisitor = true;

    update();

    try {
      String url = "${Urls.fetchVisitorByPhone}/$phone";
      List response = await ServerClient.post(url, context);

      log('employees response.first ${response.first} response.last ${response.last}');

      if (response.first >= 200 && response.first < 300) {
        final visitorData = FetchVisitorEmployees.fromJson(response.last);
        visitor = visitorData;
      } else {}
    } finally {
      isFetchingVisitor = false;
      update();
    }
  }

  void clearAllVariables() {
    fullNameController = TextEditingController();
    emailController = TextEditingController();

    visitTypeController = TextEditingController();

    personToMeetController = TextEditingController();

    durationController = TextEditingController();

    reasonController = TextEditingController();
    dataResult = Result();

    isSubmiting = false;
    isSubmitDetailsVerified = false;
    update();
  }
}
