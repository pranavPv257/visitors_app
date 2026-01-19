import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
import 'package:visitors_app/registration_section/controller/visitor_details_controller.dart';
import 'package:visitors_app/registration_section/model/all_employees_model.dart';

class VisitorDetailsScreen extends StatefulWidget {
  const VisitorDetailsScreen({super.key});

  @override
  State<VisitorDetailsScreen> createState() => _VisitorDetailsScreenState();
}

class _VisitorDetailsScreenState extends State<VisitorDetailsScreen> {
  final VisitorDetailsController controller = Get.find<VisitorDetailsController>();
  final LandingController landingController = Get.find<LandingController>();
  final List<String> _durationList = ['10', '15', '30', '45'];
  final List<String> _typeList = ['Personal', 'Official', 'Semi-Formal:', 'Social'];

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
                              text: 'Visitors Details',
                              size: 24,
                              color: AppColor.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizeBoxH(3),
                          Center(
                            child: text(
                              text: 'Please provide your visit information',
                              size: 14,
                              color: AppColor.black,
                              fontFamily: GoogleFonts.inter(
                                color: AppColor.black,
                                fontWeight: FontWeight.w300,
                              ).fontFamily,
                            ),
                          ),

                          SizeBoxH(22),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StarText(label: 'Full Name'),
                                    SizeBoxH(7),
                                    buildCommonTextFormField(
                                      onChanged: (_) {
                                        controller.isSubmitDetailsVerifiedFn();
                                      },
                                      hintFontSize: 14,
                                      bgColor: AppColor.bluishGrey,
                                      hintText: 'John doe',
                                      style: GoogleFonts.inter(fontSize: 24),
                                      contentPadding: EdgeInsets.all(16),
                                      borderColor: AppColor.black.withOpacity(.09),
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.continueAction,
                                      controller: getX.fullNameController,
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                              SizeBoxV(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StarText(label: 'Email'),
                                    SizeBoxH(7),
                                    buildCommonTextFormField(
                                      onChanged: (_) {
                                        controller.isSubmitDetailsVerifiedFn();
                                      },
                                      hintFontSize: 14,
                                      bgColor: AppColor.bluishGrey,
                                      hintText: 'john@example.com',
                                      style: GoogleFonts.inter(fontSize: 24),
                                      contentPadding: EdgeInsets.all(16),
                                      borderColor: AppColor.black.withOpacity(.09),
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.continueAction,
                                      controller: getX.emailController,
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizeBoxH(12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StarText(label: 'Visit Type'),
                                    SizeBoxH(7),
                                    CustomDropdown<String>(
                                      decoration: CustomDropdownDecoration(
                                        closedFillColor: AppColor.bluishGrey,
                                        expandedFillColor: AppColor.bluishGrey,
                                        closedBorder: Border.all(color: AppColor.black.withOpacity(.09)),
                                      ),
                                      hintText: 'Select Visit Type',
                                      items: _typeList,
                                      initialItem: _typeList[0],
                                      onChanged: (value) {
                                        controller.setVisitType(value ?? '');
                                        log('changing value to: $value');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizeBoxV(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StarText(label: 'Person to Meet'),
                                    SizeBoxH(7),
                                    CustomDropdown<Result>(
                                      decoration: CustomDropdownDecoration(
                                        closedFillColor: AppColor.bluishGrey,
                                        expandedFillColor: AppColor.bluishGrey,
                                        closedBorder: Border.all(color: AppColor.black.withOpacity(.09)),
                                      ),
                                      hintText: 'Select Person to Meet',
                                      items: getX.employees?.data?.result ?? [],

                                      // This tells the dropdown how to show the item in the list
                                      listItemBuilder: (context, item, isSelected, onItemSelect) {
                                        return Text(item.name ?? "");
                                      },
                                      headerBuilder: (context, selectedItem, enabled) {
                                        return Text(selectedItem.name ?? "");
                                      },

                                      // This tells the dropdown how to show the selected item in the closed box
                                      onChanged: (value) {
                                        controller.setPersonToMeet(value ?? Result());
                                        log('changing value to: $value');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizeBoxH(15),
                          StarText(label: 'Duration (minutes)'),
                          SizeBoxH(7),
                          CustomDropdown<String>(
                            decoration: CustomDropdownDecoration(
                              closedFillColor: AppColor.bluishGrey,
                              expandedFillColor: AppColor.bluishGrey,
                              closedBorder: Border.all(color: AppColor.black.withOpacity(.09)),
                            ),
                            hintText: 'Select job role',
                            items: _durationList,
                            initialItem: _durationList[0],
                            onChanged: (value) {
                              controller.setDuration(value ?? '');
                              log('changing value to: $value');
                            },
                          ),

                          SizeBoxH(15),
                          StarText(label: 'Reason for visit'),
                          SizeBoxH(7),
                          buildCommonTextFormField(
                            onChanged: (_) {
                              controller.isSubmitDetailsVerifiedFn();
                            },
                            hintFontSize: 14,
                            minLine: 4,
                            bgColor: AppColor.bluishGrey,
                            hintText: 'Briefly describe the purpose of your visit',
                            style: GoogleFonts.inter(fontSize: 24),
                            contentPadding: EdgeInsets.all(16),
                            borderColor: AppColor.black.withOpacity(.09),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.continueAction,
                            controller: getX.reasonController,
                            context: context,
                          ),
                          SizeBoxH(28),
                          button(
                            onTap: getX.isSubmitDetailsVerified
                                ? () {
                                    controller.registerVisitorFn(context: context);
                                  }
                                : null,
                            isLoading: getX.isSubmiting,
                            height: 75,
                            color: getX.isSubmitDetailsVerified ? AppColor.appPrimary : AppColor.buttonTransparent,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            borderColor: getX.isSubmitDetailsVerified
                                ? AppColor.appPrimary
                                : AppColor.buttonTransparent,
                            name: 'Submit Details',
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

class StarText extends StatelessWidget {
  final String label;
  const StarText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.poppins(fontSize: 14, color: AppColor.black, fontWeight: FontWeight.w300),
        children: <TextSpan>[
          TextSpan(text: label),
          TextSpan(
            text: '*',
            style: GoogleFonts.poppins(fontSize: 14, color: Color(0xffFF0000), fontWeight: FontWeight.w600),
          ),
        ],
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

// class SelectVisitorType extends StatefulWidget {
//   const SelectVisitorType({super.key});

//   @override
//   State<SelectVisitorType> createState() => _SelectVisitorTypeState();
// }

// class _SelectVisitorTypeState extends State<SelectVisitorType> {
//   final VisitorDetailsController controller = Get.find<VisitorDetailsController>();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.zero,
//       content: Container(
//         width: Responsive.width * 100,
//         height: Responsive.height * 40,
//         decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(15)),
//         child: GetBuilder(
//           init: controller,
//           builder: (getX) {
//             return ListView.separated(
//               shrinkWrap: true,
//               // physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   onTap: () {},
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
//                   style: ListTileStyle.list,
//                   minTileHeight: 68,

//                   title: text(text: item?.foodName ?? '', color: AppColor.black, size: 16, fontWeight: FontWeight.w600),
//                   subtitle: text(
//                     text: item?.type.toString().capitalizeFirstLetter(),
//                     color: AppColor.black,
//                     size: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   shape: Border(bottom: BorderSide(color: AppColor.black.withOpacity(.1))),
//                 );
//               },
//               separatorBuilder: (context, index) => Divider(color: AppColor.black.withOpacity(.1)),
//               itemCount: provider.getPreBookFood?.data?.length ?? 0,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
