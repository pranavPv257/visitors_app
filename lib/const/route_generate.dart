import 'package:get/get_navigation/get_navigation.dart';
import 'package:visitors_app/landing_section/view/landing_screen.dart';

class RouteGenerate {
  // Onbaording
  static const landingScreen = '/landing_screen';

  static final routes = [GetPage(name: landingScreen, page: () => const LandingScreen(), transition: Transition.zoom)];
}
