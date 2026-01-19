import 'package:get/get_navigation/get_navigation.dart';
import 'package:visitors_app/landing_section/view/landing_screen.dart';
import 'package:visitors_app/otp_section/view/otp_screen.dart';
import 'package:visitors_app/registration_section/view/registered_visitor_screen.dart';
import 'package:visitors_app/registration_section/view/visitor_details_screen.dart';

class RouteGenerate {
  // Onbaording
  static const landingScreen = '/landing_screen';
  /* OTP */
  static const otpScreen = '/otp_screen';
  /* Visitor Details */
  static const visitorDetailScreen = '/visitor_detail_screen';
  static const registeredVisitorScreen = '/registeredVisitorScreen';

  static final routes = [
    GetPage(name: landingScreen, page: () => const LandingScreen(), transition: Transition.circularReveal),
    GetPage(name: otpScreen, page: () => const OtpScreen(), transition: Transition.circularReveal),
    GetPage(name: visitorDetailScreen, page: () => const VisitorDetailsScreen(), transition: Transition.circularReveal),
    GetPage(
      name: registeredVisitorScreen,
      page: () => const RegisteredVisitorScreen(),
      transition: Transition.circularReveal,
    ),
  ];
}
