import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/ui/User_screen.dart';
import 'package:ibm_flutter_final_project/features/User/ui/edit_profile_screen.dart';
import 'package:ibm_flutter_final_project/features/add-new-room/logic/cubit/add_new_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/add-new-room/ui/add_new_room.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/add_new_worksapce.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/sign_in_bloc/sign_in_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/singupCubit/sign_up_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/reset_password.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/sign_in_screen.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/sign_up_screen.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_cubit.dart';
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

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignInCubit>(),
            child: const SingInScreen(),
          ),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPassword(),
        );
      case Routes.addNewWorkSpace:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<AddNewWorkSpaceCubit>(),
                  child: AddNewWorkspace(),
                ));

      case Routes.workspaceStatus:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<GetAdminWorkSpacesCubit>(),
            child: const WorkspaceStatus(),
          ),
        );
      case Routes.userScreen:
        return MaterialPageRoute(
          builder: (_) => const UserScreen(),
        );
      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<EditProfileCubit>(),
            child: const EditProfileScreen(),
          ),
        );

      case Routes.addNewRoom:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<AddNewRoomCubit>(),
                  child: AddNewRoom(),
                ));

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
