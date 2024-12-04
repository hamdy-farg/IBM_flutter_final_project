import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class urlButtonLuncher extends StatefulWidget {
  final String? url; // URL passed to the widget

  urlButtonLuncher({Key? key, this.url}) : super(key: key);

  @override
  State<urlButtonLuncher> createState() => _urlButtonLuncherState();
}

class _urlButtonLuncherState extends State<urlButtonLuncher> {
  Future<void> _launchURL(String url) async {
    // Parse the full URL
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      color: ColorsManager.mainBlue,
borderRadius: BorderRadius.circular(12.r)
      ),
      height: 40.h,
      width: 120.w,
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (widget.url != null && widget.url!.isNotEmpty) {
              _launchURL(widget.url!); // Pass the URL to the function
            } else {
      CherryToast.error(title: Text("Can't opem google Map "),);
            }
          },
          child:   Text(
            "Open in Map",
            style:TextStyles.font16WhiteBold
          ),
        ),
      ),
    );
  }
}
