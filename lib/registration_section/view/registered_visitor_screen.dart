import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitors_app/const/colors.dart';
import 'package:visitors_app/const/common_widgets.dart';
import 'package:visitors_app/const/route_generate.dart';
import 'package:visitors_app/const/sized_box.dart';
import 'package:visitors_app/landing_section/view/landing_screen.dart';
import 'package:visitors_app/registration_section/controller/visitor_details_controller.dart';

class RegisteredVisitorScreen extends StatefulWidget {
  const RegisteredVisitorScreen({super.key});

  @override
  State<RegisteredVisitorScreen> createState() => _RegisteredVisitorScreenState();
}

class _RegisteredVisitorScreenState extends State<RegisteredVisitorScreen> {
  final VisitorDetailsController controller = Get.find<VisitorDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(46.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonCompany(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GetBuilder(
                    init: controller,
                    builder: (getX) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizeBoxH(44),
                          Center(
                            child: text(
                              text: 'Visitors checkout',
                              size: 24,
                              color: AppColor.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizeBoxH(3),
                          Center(
                            child: text(
                              text: 'Ready to leave? Please confirm your details below',
                              size: 14,
                              textAlign: TextAlign.center,
                              color: AppColor.black,
                              fontFamily: GoogleFonts.inter(
                                color: AppColor.black,
                                fontWeight: FontWeight.w300,
                              ).fontFamily,
                            ),
                          ),
                          SizeBoxH(3),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteGenerate.landingScreen);
                              },
                              child: text(
                                text: 'Go back to phone entry',
                                size: 13,
                                textAlign: TextAlign.center,
                                color: AppColor.black,
                                decoration: TextDecoration.underline,
                                fontFamily: GoogleFonts.inter(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w700,
                                ).fontFamily,
                              ),
                            ),
                          ),
                          SizeBoxH(35),
                          text(
                            text: 'Your Visit Details',
                            size: 22,
                            color: AppColor.black,
                            fontWeight: FontWeight.w400,
                          ),
                          SizeBoxH(36),
                          TableRow(title: 'Full Name', subtitle: getX.visitor?.data?.result?.name ?? ''),
                          SizeBoxH(20),
                          TableRow(title: 'Email', subtitle: getX.visitor?.data?.result?.email ?? ''),
                          SizeBoxH(20),
                          TableRow(
                            title: 'Visit Type',
                            subtitle: getX.visitor?.data?.result?.visitorsVisit?.type ?? '',
                          ),
                          SizeBoxH(20),
                          TableRow(
                            title: 'Person to meet',
                            subtitle: getX.visitor?.data?.result?.visitorsVisit?.id.toString() ?? '',
                          ),
                          SizeBoxH(20),
                          TableRow(
                            title: 'Visit Duration',
                            subtitle: getX.visitor?.data?.result?.visitorsVisit?.durationMins.toString() ?? '',
                          ),
                          SizeBoxH(20),
                          TableRow(
                            title: 'Visit Reason',
                            subtitle: getX.visitor?.data?.result?.visitorsVisit?.reason ?? '',
                          ),
                          SizeBoxH(45),
                          Center(
                            child: button(
                              onTap: () {
                                controller.chekoutVisitor(context: context);
                              },
                              isLoading: getX.isCheckouting,
                              height: 45,
                              width: 200,
                              color: Color(0xffDC2626),
                              fontSize: 22,
                              borderRadius: BorderRadius.circular(10),
                              fontWeight: FontWeight.w600,
                              borderColor: Color(0xffDC2626),
                              name: 'Confirm Logout',
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
      ),
    );
  }
}

class TableRow extends StatelessWidget {
  final String title, subtitle;

  const TableRow({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: text(text: title, size: 14, color: AppColor.black, fontWeight: FontWeight.w300),
            ),
            SizeBoxV(10),
            Expanded(
              child: text(
                textAlign: TextAlign.end,
                text: subtitle,
                size: 14,
                maxLines: 5,
                color: AppColor.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizeBoxV(),
          ],
        ),
        SizeBoxH(12),
        Divider(thickness: 1, color: AppColor.black.withOpacity(.1)),
      ],
    );
  }
}
