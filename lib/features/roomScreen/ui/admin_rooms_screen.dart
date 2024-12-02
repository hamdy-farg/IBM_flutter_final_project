import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/location_picker.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/getAdminRoomsCubit/admin_rooms_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/comfortable_place_iems_button.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/comfortable_place_items.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/single_photo.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

class AdminRoomsScreen extends StatelessWidget {
  const AdminRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workspace =
        ModalRoute.of(context)?.settings.arguments as WorkSpaceModel?;

    final cubit = getIt<AdminRoomsCubit>();
    return Scaffold(
      floatingActionButton: ComfortablePlaceIemsButton(
        onTap: () {
          context.pushNamed(Routes.addNewRoom);
        },
        mainAxisAlignment: MainAxisAlignment.center,
        buttonWidth: 60,
        buttonHight: 60,
        hasIcon: false,
        text: "ADD\nNew",
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SinglePhoto(
                  title: workspace?.title,
                  imageLink: workspace?.image,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${workspace?.title}",
                          style: TextStyles.font22BlackBold),
                      Text("Location", style: TextStyles.font22BlackBold),
                      LocationPickerWidget(
                        isStatic: true,
                        locationLatLong: extractLatLong(
                          "${workspace?.location}",
                        ),
                        onLocationPicked: (pickedLocation) {},
                      ),
                      Text("Rooms", style: TextStyles.font22BlackBold),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<AdminRoomsCubit, AdminRoomsState>(
            builder: (context, state) {
              return (state is AdminRoomsSeuccess)
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            child: CustemConfortablePlace(
                              index: index,
                              itemsLength: state.roomModel.length,
                              buttontext: "see room details",
                              buttonHight: 30,
                              buttonWidth: 230,
                              buttonhasIcon: false,
                              itemName: state.roomModel[index].title,
                              price: "${state.roomModel[index].pricePerHour}",
                            ),
                          );
                        },
                        childCount: state.roomModel.length,
                      ),
                    )
                  : (state is AdminRoomsFial)
                      ? CherryToast.error(title: Text(state.errorMessage))
                      : Center(
                          child: CircularProgressIndicator(),
                        );
            },
          ),
        ],
      ),
    );
  }
}
