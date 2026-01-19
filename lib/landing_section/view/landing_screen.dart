import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitors_app/const/assets.dart';
import 'package:visitors_app/const/colors.dart';
import 'package:visitors_app/const/common_widgets.dart';
import 'package:visitors_app/const/sized_box.dart';
import 'package:visitors_app/const/svg_images.dart';
import 'package:visitors_app/landing_section/controller/landing_controller.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final LandingController controller = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(46.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonCompany(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder(
                  init: controller,
                  builder: (getX) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeBoxH(27),
                        CommonIconContainer(),
                        SizeBoxH(12),
                        text(text: 'Mobile Number', size: 22, color: AppColor.black, fontWeight: FontWeight.bold),
                        SizeBoxH(14),
                        buildCommonTextFormField(
                          onChanged: (_) {
                            controller.isPhoneNumberVerifiedFn();
                          },
                          maxLength: 10,
                          bgColor: AppColor.bluishGrey,
                          hintText: '0000 000 000',
                          style: GoogleFonts.inter(fontSize: 34),
                          contentPadding: EdgeInsets.all(27),
                          borderColor: AppColor.black.withOpacity(.09),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.continueAction,
                          controller: controller.mobileController,
                          context: context,
                        ),
                        SizeBoxH(14),
                        text(
                          text: 'We’ll send a 4 digit verification code to this number ',
                          size: 17,
                          color: AppColor.black.withOpacity(.32),
                          fontWeight: FontWeight.w400,
                        ),
                        SizeBoxH(41),
                        button(
                          onTap: getX.isPhoneVerified
                              ? () {
                                  controller.checkUserExistFunction(context: context);
                                }
                              : null,
                          isLoading: getX.isSendingOtp,
                          height: 75,
                          color: getX.isPhoneVerified ? AppColor.appPrimary : AppColor.buttonTransparent,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          borderColor: getX.isPhoneVerified ? AppColor.appPrimary : AppColor.buttonTransparent,
                          name: 'Send OTP',
                        ),
                        SizeBoxH(23),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColor.black,
                              fontWeight: FontWeight.w300,
                            ),
                            children: <TextSpan>[
                              const TextSpan(text: 'By continuing, you agree to our '),
                              TextSpan(
                                text: 'Terms of service',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: AppColor.green,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {},
                              ),
                              const TextSpan(text: ' and'),
                              TextSpan(
                                text: ' privacy policy',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: AppColor.green,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {},
                              ),
                            ],
                          ),
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
  const CommonIconContainer({super.key});

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
          children: [Image.asset(AppImages.profilePng, width: 35, height: 35)],
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
