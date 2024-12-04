import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/location_picker.dart';
import 'package:ibm_flutter_final_project/core/widgets/map_luncher_button.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_button_authentication.dart';
import 'package:ibm_flutter_final_project/features/home/logic/workSpaceRooms/work_space_rooms_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/comfortable_place_items.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/single_photo.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

class SingleItemScreen extends StatelessWidget {
  const SingleItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WorkSpaceModel? workSpaceModel;

    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is WorkSpaceModel) {
      workSpaceModel = arguments;
    }
    log("room model is ${workSpaceModel}");
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          horizantalSpace(25),
          CustemButtonAuthentication(
            text: 'Explore more',
            width: 300.w,
            height: 58.h,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SinglePhoto(
              imageLink: workSpaceModel != null ? workSpaceModel.image : null,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      workSpaceModel != null
                          ? " ${workSpaceModel.title} "
                          : "Most Comfortable \n Place",
                      style: TextStyles.font22BlackBold),
                  Text(
                      workSpaceModel != null
                          ? "           ${workSpaceModel.description} "
                          : "Most Comfortable \n Place",
                      style: TextStyles.font16BlackBold),
                  verticalSpace(20),
                  Text("Location", style: TextStyles.font22BlackBold),
                  LocationPickerWidget(
                    locationLatLong: extractLatLong(workSpaceModel!.location),
                    onLocationPicked: (onpicker) {},
                    isStatic: true,
                  ),
                  verticalSpace(10),
                  urlButtonLuncher(url: workSpaceModel.location),
                  BlocBuilder<WorkSpaceRoomsCubit, WorkSpaceRoomsState>(
                    bloc: getIt<WorkSpaceRoomsCubit>(),
                    builder: (context, state) {
                      return (state is WorkSpaceRoomsSuccessState)
                          ? SizedBox(
                              height: 400.h,
                              child: ComfortablePlaceItems(
                                roomModelList: state.roomModelList,
                              ),
                            )
                          : (state is WorkSpaceRoomsFialState)
                              ? Text("${state.errorMessage}")
                              : CircularProgressIndicator();
                    },
                  ),
                  verticalSpace(20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
