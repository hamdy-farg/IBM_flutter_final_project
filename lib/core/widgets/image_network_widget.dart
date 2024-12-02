import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_network/image_network.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageLink;
  final double hight;
  final double width;

  const ImageNetworkWidget(
      {super.key,
      required this.imageLink,
      required this.hight,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return ImageNetwork(
      image: imageLink,
      height: hight.h,
      width: width.w,
      duration: 100,
      curve: Curves.easeIn,
      onPointer: true,
      debugPrint: false,
      fullScreen: false,
      fitAndroidIos: BoxFit.cover,
      fitWeb: BoxFitWeb.cover,
      borderRadius: BorderRadius.circular(12),
      onLoading: const CircularProgressIndicator(
        color: Colors.indigoAccent,
      ),
      onError: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      onTap: () {
        debugPrint("©gabriel_patrick_souza");
      },
    );
  }
}
