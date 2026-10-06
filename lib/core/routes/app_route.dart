import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:rally/core/routes/routes.dart';
import 'package:rally/presentation/forget_password/forget_password_screen.dart';
import 'package:rally/presentation/login/login_screen.dart';
import 'package:rally/presentation/onboarding/onboarding_screen.dart';
import 'package:rally/presentation/register/register_screen.dart';
import 'package:rally/presentation/setup/setup_screen.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print('Navigating to: ${settings.name}');
    }

    final uri = Uri.parse(settings.name ?? '/');

    switch (uri.path) {
      case Routes.setup:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SetupScreen(),
        );
      case Routes.onboarding:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OnBoardingScreen(),
        );
      case Routes.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginScreen(),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ForgetPasswordScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RegisterScreen(),
        );
      
      // case Routes.main:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => MainScreen(),
      //   );
      //
      // case Routes.addEvent:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => AddEventScreen(),
      //   );
      //
      // case Routes.editEvent:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => EditEventScreen(event: settings.arguments as EventDM,),
      //   );
      //
      // case Routes.eventDetails:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => EventDetails(),
      //   );
      //
      // case Routes.selectLocation:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => SelectLocation(),
      //   );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 - Page Not Found')),
              ),
        );
    }
  }
}
