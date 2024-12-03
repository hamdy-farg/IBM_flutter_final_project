import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/User/logic/book_room/book_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/ui/User_screen.dart';
import 'package:ibm_flutter_final_project/features/User/ui/edit_profile_screen.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/booking_screen.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/sign_in_bloc/sign_in_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/singupCubit/sign_up_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/reset_password.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/sign_in_screen.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/sign_up_screen.dart';
import 'package:ibm_flutter_final_project/features/reservation_chart/Ui/data_visualization.dart';
import 'package:ibm_flutter_final_project/features/home/ui/booking_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/home_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/single_item_screen.dart';
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
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.bookingScreen:
        return MaterialPageRoute(
          builder: (_) => const BookingScreen(),
        );
      case Routes.workspaceStatus:
        return MaterialPageRoute(
          builder: (_) => const WorkspaceStatus(),
        );

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
      case Routes.singleItemScreen:
        return MaterialPageRoute(
          builder: (_) => const SingleItemScreen(),
        );
      case Routes.bookingRoom:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<BookRoomCubit>(),
            child: BookingRoom(),
          ),
        );
      case Routes.barChartScreen:
        return MaterialPageRoute(
          builder: (_) =>   BarChartScreen(),
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
