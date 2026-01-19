import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:visitors_app/const/assets.dart';
import 'package:visitors_app/const/colors.dart';
import 'package:visitors_app/const/common_widgets.dart';
import 'package:visitors_app/const/responsive.dart';
import 'package:visitors_app/const/route_generate.dart';
import 'package:visitors_app/const/sized_box.dart';
import 'package:visitors_app/const/svg_images.dart';
import 'package:visitors_app/landing_section/controller/landing_controller.dart';
import 'package:visitors_app/otp_section/controller/otp_controller.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    controller.startTimer();
    controller.clearVariable();
    super.initState();
  }

  final OtpController controller = Get.put(OtpController());
  final LandingController landingController = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(46.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonCompany(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder(
                  init: controller,
                  builder: (getX) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizeBoxH(27),
                        CommonIconContainer(image: 'assets/images/image 125.png'),
                        SizeBoxH(12),
                        text(text: 'Verify OTP', size: 24, color: AppColor.black, fontWeight: FontWeight.w700),
                        SizeBoxH(11),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColor.black,
                              fontWeight: FontWeight.w300,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Code sent to ${landingController.mobileController.text} '),
                              TextSpan(
                                text: 'Change',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff052D62),
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(RouteGenerate.landingScreen);
                                  },
                              ),
                            ],
                          ),
                        ),
                        SizeBoxH(38),
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: text(text: 'OTP code', size: 22, color: AppColor.black, fontWeight: FontWeight.w400),
                        ),
                        SizeBoxH(4),
                        Pinput(
                          controller: getX.otpController,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          length: 4,
                          focusedPinTheme: PinTheme(
                            textStyle: TextStyle(fontSize: 34),
                            height: Responsive.height * 10,
                            width: Responsive.width * 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.appPrimary.withOpacity(0.1),
                              border: Border.all(color: AppColor.appPrimary.withOpacity(.4)),
                            ),
                          ),
                          defaultPinTheme: PinTheme(
                            textStyle: TextStyle(fontSize: 34),
                            height: Responsive.height * 10,
                            width: Responsive.width * 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.black.withOpacity(.1)),
                            ),
                          ),
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onChanged: (value) {
                            controller.isOtpFieldVerifiedFn();
                          },
                          onCompleted: (pin) {},
                          errorPinTheme: PinTheme(
                            textStyle: TextStyle(fontSize: 34),
                            height: Responsive.height * 10,
                            width: Responsive.width * 15,
                            decoration: BoxDecoration(
                              color: AppColor.redColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.redColor.withOpacity(.4)),
                            ),
                          ),
                          errorText: 'Entered pin is incorrect',
                          errorTextStyle: TextStyle(color: AppColor.redColor, fontSize: 12),
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          pinAnimationType: PinAnimationType.fade,
                          submittedPinTheme: PinTheme(
                            textStyle: TextStyle(fontSize: 34),
                            height: Responsive.height * 10,
                            width: Responsive.width * 15,
                            decoration: BoxDecoration(
                              color: AppColor.appPrimary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.appPrimary.withOpacity(.4)),
                            ),
                          ),
                        ),

                        SizeBoxH(18),
                        button(
                          onTap: getX.isOtpFieldVerified
                              ? () {
                                  controller.verifyOtpFunction(context: context);
                                }
                              : null,
                          height: 75,
                          color: getX.isOtpFieldVerified ? AppColor.appPrimary : AppColor.buttonTransparent,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          borderColor: getX.isOtpFieldVerified ? AppColor.appPrimary : AppColor.buttonTransparent,
                          name: 'Verify OTP',
                        ),
                        SizeBoxH(23),
                        getX.isTimerRunning == false
                            ? GestureDetector(
                                onTap: () {
                                  landingController.sendOtpFunction(context: context).then((value) {
                                    controller.startTimer();
                                  });
                                },
                                child: text(
                                  text: 'Resend',
                                  size: 14,
                                  color: AppColor.appPrimary,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : text(
                                text: 'Resend OTP in ${getX.remainingSeconds} Seconds',
                                size: 14,
                                color: AppColor.black.withOpacity(.41),
                                fontWeight: FontWeight.w400,
                              ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonIconContainer extends StatelessWidget {
  final String? image;
  const CommonIconContainer({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.center,
      child: Container(
        width: 66,
        height: 66,
        decoration: BoxDecoration(color: AppColor.lightGreen, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(image ?? AppImages.profilePng, width: 35, height: 35)],
        ),
      ),
    );
  }
}

class CommonCompany extends StatelessWidget {
  const CommonCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColor.appPrimary, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [SvgPicture.asset(SvgCodes.logo), SizeBoxV(20), Image.asset(AppImages.companyName)],
      ),
    );
  }
}
