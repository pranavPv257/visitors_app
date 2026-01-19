import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:visitors_app/const/colors.dart';
import 'package:visitors_app/const/common_widgets.dart';
import 'package:visitors_app/const/responsive.dart';
import 'package:visitors_app/const/route_generate.dart';
import 'package:visitors_app/const/sized_box.dart';
import 'package:visitors_app/success_section/controller/success_controller.dart';

class SuccessScreen extends StatefulWidget {
  final bool? isFromRegister;
  const SuccessScreen({super.key, this.isFromRegister});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final SuccessController controller = Get.put(SuccessController());
  @override
  void initState() {
    controller.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Responsive.width * 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    // shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 5, color: AppColor.green),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, size: 55, color: AppColor.green),
                      text(text: '20s', size: 14, color: AppColor.black, fontWeight: FontWeight.w300),
                    ],
                  ),
                ),
                SizeBoxH(27),
                Center(
                  child: text(text: 'Thanks for that!', size: 24, color: AppColor.black, fontWeight: FontWeight.w700),
                ),
                SizeBoxH(11),
                Center(
                  child: text(
                    text: 'You request has been sent to the intended recipient.',
                    size: 14,
                    textAlign: TextAlign.center,
                    color: AppColor.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                widget.isFromRegister == true
                    ? Column(
                        children: [
                          SizeBoxH(46),
                          Container(
                            width: Responsive.width * 100,

                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 33),
                            decoration: BoxDecoration(color: Color(0xffEFFFF4)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text(text: 'Next Steps:', size: 22, color: AppColor.black, fontWeight: FontWeight.w700),
                                SizeBoxH(18),
                                Row(
                                  children: [
                                    CircleAvatar(backgroundColor: AppColor.black, radius: 3),
                                    SizeBoxV(12),
                                    text(
                                      text: 'Please be seated ',
                                      size: 14,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(backgroundColor: AppColor.black, radius: 3),
                                    SizeBoxV(12),
                                    Expanded(
                                      child: text(
                                        text:
                                            'Our admin team aware that you’re waiting, and we truly appreciate your patience',
                                        size: 14,
                                        maxLines: 3,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                SizeBoxH(25),
                GetBuilder(
                  init: controller,
                  builder: (getX) {
                    return Center(
                      child: button(
                        onTap: () {
                          Get.offAllNamed(RouteGenerate.landingScreen);
                        },

                        height: 53,
                        width: 280,
                        color: AppColor.green,
                        fontSize: 22,
                        borderRadius: BorderRadius.circular(10),
                        fontWeight: FontWeight.w600,
                        borderColor: AppColor.green,
                        name: 'Go Back Now (${getX.remainingSeconds}s)',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
