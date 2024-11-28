import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/add_new_worksapce.dart';
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
          builder: (_) => WorkspaceStatus(),
        );     case Routes.addNewWorkSpace:
        return MaterialPageRoute(
          builder: (_) => AddNewWorkspace(),
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
