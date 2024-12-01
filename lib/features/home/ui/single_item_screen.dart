import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_button_authentication.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/comfortable_place_items.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/single_photo.dart';

class SingleItemScreen extends StatefulWidget {
  const SingleItemScreen({super.key});

  @override
  State<SingleItemScreen> createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SinglePhoto(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Most Comfortable \n Place",
                      style: TextStyles.font22BlackBold),
                  ComfortablePlaceItems(),
                  verticalSpace(20),
                  Text("Location", style: TextStyles.font22BlackBold),
                  const SizedBox(
                    height: 300,
                    width: double.infinity,
                  ),
                  Center(
                    child: CustemButtonAuthentication(
                      text: 'Explore more',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
