import 'package:get/get.dart';
import 'package:visitors_app/landing_section/controller/landing_controller.dart';
import 'package:visitors_app/otp_section/controller/otp_controller.dart';
import 'package:visitors_app/registration_section/controller/visitor_details_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LandingController());
    Get.put(OtpController());
    Get.put(VisitorDetailsController());
  }
}
