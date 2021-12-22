import 'package:flutter/cupertino.dart';
import 'package:movieaplikasi/splash_screen.dart';

import 'homepage.dart';

class NavigateName {
  NavigateName._();
  static const splash_screen = '/splash-screen';
  static const homescreen = '/homescreen';
}

/*Widget makeRoutes(Object? arguments,
    {required BuildContext context, required String? routeName}) {
  final Widget child =
      _buildRoute(arguments, context: context, routeName: routeName);
  return child;
  ;
}*/

Widget buildRoute(
  Object? arguments, {
  required BuildContext context,
  required String? routeName,
}) {
  switch (routeName) {
    case NavigateName.splash_screen:
      return SplashScreen();
    case NavigateName.homescreen:
      HomeScreen argument = arguments as HomeScreen;
      return HomeScreen(title: argument.title, subTitle: argument.subTitle,);
    default:
      throw 'Route $routeName is not defined';
  }
}
