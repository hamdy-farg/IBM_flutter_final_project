import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/User/ui/User_screen.dart';
import 'package:ibm_flutter_final_project/features/User/ui/edit_profile_screen.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/login_scren.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/reset_password.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/sign_up_screen.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/ui/workspace_status.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // this arguments to be passed in any screen like this (arguments as ClassName)
    final arguments = settings.arguments;
    switch (settings.name) {
      //! this is how to add route and navigate by
      //! first added your route in routes.dart
      //! context.pushNamed()
      // case Routes.onBoardingScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const OnboardingScreen(),
      //   );
      case Routes.workspaceStatus:
        return MaterialPageRoute(
          builder: (_) => const WorkspaceStatus(),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScren(),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPassword(),
        );
      case Routes.workspaceStatus:
        return MaterialPageRoute(
          builder: (_) => const WorkspaceStatus(),
        );
      case Routes.userScreen:
        return MaterialPageRoute(
          builder: (_) => const UserScreen(),
        );
      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("no route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
