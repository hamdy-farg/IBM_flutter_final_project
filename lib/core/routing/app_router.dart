import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/User/logic/book_room/book_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/ui/User_screen.dart';
import 'package:ibm_flutter_final_project/features/User/ui/edit_profile_screen.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/workSpaceCubit/work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/add_new_worksapce.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/bookingCubit/bookings_cubit.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/cubit/booking_cubit.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/booked_details_screen.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/booking_screen.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/sign_in_bloc/sign_in_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/singupCubit/sign_up_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/reset_password.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/sign_in_screen.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/sign_up_screen.dart';
import 'package:ibm_flutter_final_project/features/home/logic/availableRoomHours/available_room_hours_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/logic/bookingRoom/booking_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/logic/homeCubit/home_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/logic/homeRomesCubit/hoom_rooms_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/logic/workSpaceRooms/work_space_rooms_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/ui/booking_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/home_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/single_item_screen.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/addNewRoomCubit/add_new_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/getAdminRoomsCubit/admin_rooms_cubit.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/ui/add_new_room.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/ui/admin_rooms_screen.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_cubit.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/navigationBar/navigation_bar_cubit.dart';
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

      case Routes.mainHomeScreen:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => getIt<HomeWorkSpaceCubit>(),
                    ),
                    BlocProvider(
                      create: (context) => getIt<HomeRoomsCubit>(),
                    ),
                  ],
                  child: MainScreen(),
                ));
      case Routes.bookingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<BookingsCubit>(),
            child: const BookingScreen(),
          ),
        );

      case Routes.bookedDeatilsScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<EditBookingCubit>(),
            child: BookedDetailsScreen(),
          ),
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
            settings: settings,
            builder: (_) => BlocProvider(
                  create: (_) => getIt<WorkSpaceCubit>(),
                  child: AddNewWorkspace(),
                ));

      case Routes.workspaceStatus:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<GetAdminWorkSpacesCubit>()),
              BlocProvider(create: (_) => getIt<NavigationBarCubit>())
            ],
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
      case Routes.adminRoomsScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<AdminRoomsCubit>(),
            child: AdminRoomsScreen(),
          ),
        );
      case Routes.singleItemScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<WorkSpaceRoomsCubit>(),
            child: const SingleItemScreen(),
          ),
        );
      case Routes.bookingRoom:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => getIt<AvailableRoomHoursCubit>()),
              BlocProvider(create: (context) => getIt<BookRoomDataCubit>()),
              BlocProvider(
                create: (context) => getIt<BookingRoomCubit>(),
              )
            ],
            child: BookingRoom(),
          ),
        );

      case Routes.addNewRoom:
        return MaterialPageRoute(
            settings: settings,
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
