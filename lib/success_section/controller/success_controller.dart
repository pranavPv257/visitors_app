import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitors_app/const/colors.dart';
import 'package:visitors_app/const/common_widgets.dart';
import 'package:visitors_app/const/route_generate.dart';
import 'package:visitors_app/const/server_client.dart';
import 'package:visitors_app/const/urls.dart';
import 'package:visitors_app/landing_section/controller/landing_controller.dart';
import 'package:visitors_app/registration_section/controller/visitor_details_controller.dart';

class SuccessController extends GetxController {
  Timer? _timer;
  // .obs makes the variable reactive
  var remainingSeconds = 20;
  var isTimerRunning = false;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    isTimerRunning = true;
    remainingSeconds = 20; // Reset to 20

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
      } else {
        Get.offAllNamed(RouteGenerate.landingScreen);
        stopTimer();
      }
      update();
    });
  }

  void stopTimer() {
    _timer?.cancel();
    isTimerRunning = false;
    update();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Important: Stop timer when controller is destroyed
    super.onClose();
  }

  /* Variables */
  TextEditingController otpController = TextEditingController();
  bool isVerifyingOtp = false;
  bool isOtpFieldVerified = false;

  void isOtpFieldVerifiedFn() {
    if (otpController.text.trim().length == 4) {
      isOtpFieldVerified = true;
    } else {
      isOtpFieldVerified = false;
    }
    update();
  }

  /*  API Function */
  Future<void> verifyOtpFunction({required BuildContext context}) async {
    isVerifyingOtp = true;
    update();
    try {
      final LandingController landingController = Get.find<LandingController>();
      final VisitorDetailsController visitorDetailsController = Get.find<VisitorDetailsController>();

      var body = {"phone": landingController.mobileController.text, 'otp': otpController.text.trim()};
      final response = await ServerClient.post(Urls.verifyOTP, data: body, post: true, context);
      // log('response.first in Verifying otp: ${response.first} response.last in Verifying otp: ${response.last}');
      if (response.first >= 200 && response.first < 300) {
        toast(context, title: 'OTP Verified successfully', backgroundColor: AppColor.green);
        visitorDetailsController.getAllEmployeesFn(context: context);
        Get.toNamed(RouteGenerate.visitorDetailScreen);
      } else {
        toast(context, title: response.last, backgroundColor: AppColor.redColor);
      }
    } catch (e) {
      toast(context, title: 'Server busy , please try again later', backgroundColor: AppColor.redColor);
      debugPrint('error in Verifying otp: $e');
    } finally {
      isVerifyingOtp = false;
      update();
    }
  }
}
