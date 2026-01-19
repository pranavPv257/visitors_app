import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitors_app/const/app_pref.dart';
import 'package:visitors_app/const/colors.dart';
import 'package:visitors_app/const/common_widgets.dart';
import 'package:visitors_app/const/route_generate.dart';
import 'package:visitors_app/const/server_client.dart';
import 'package:visitors_app/const/urls.dart';
import 'package:visitors_app/registration_section/controller/visitor_details_controller.dart';

class LandingController extends GetxController {
  /* Variables */
  TextEditingController mobileController = TextEditingController();
  bool isSendingOtp = false;
  bool isPhoneVerified = false;

  void isPhoneNumberVerifiedFn() {
    if (mobileController.text.trim().length == 10) {
      isPhoneVerified = true;
    } else {
      isPhoneVerified = false;
    }
    update();
  }

  bool isUserExists = false;
  /*  API Function */
  Future<void> checkUserExistFunction({required BuildContext context}) async {
    isSendingOtp = true;
    update();
    print("AAAA 45678367834658743685");

    try {
      print(Urls.checkExists + mobileController.text);
      final response = await ServerClient.post(Urls.checkExists + mobileController.text, post: false, context);
      log('response.first in sending otp: ${response.first} response.last in sending otp: ${response.last['message']}');
      if (response.first >= 200 && response.first < 300) {
        if (response.last['message'].toString().toLowerCase().contains(
          'Visitor check out has been successfully saved..'.toLowerCase(),
        )) {
          final VisitorDetailsController controller = Get.find<VisitorDetailsController>();
          controller.getAllVisitorFn(context: context, phone: mobileController.text);
          Get.toNamed(RouteGenerate.registeredVisitorScreen);
        }
      }
    } catch (e) {
      sendOtpFunction(context: context);
      debugPrint('error in sending otp: $e');
    } finally {
      isSendingOtp = false;
      update();
    }
  }

  /*  API Function */
  Future<void> sendOtpFunction({required BuildContext context}) async {
    log("raeacef");
    isSendingOtp = true;
    update();
    try {
      var body = {"phone": mobileController.text.trim().toString()};
      final response = await ServerClient.post(Urls.sendOTP, data: body, post: true, context);

      if (response.first >= 200 && response.first < 300) {
        AppPref.otp = response.last['data']['otp'];
        toast(context, title: '${AppPref.otp} OTP Sent successfully ', backgroundColor: AppColor.green);
        Get.toNamed(RouteGenerate.otpScreen);
      } else {
        toast(context, title: response.last, backgroundColor: AppColor.redColor);
      }
    } catch (e) {
      toast(context, title: 'Server busy , please try again later', backgroundColor: AppColor.redColor);
      debugPrint('error in sending otp: $e');
    } finally {
      isSendingOtp = false;
      update();
    }
  }
}
