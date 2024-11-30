import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/home/ui/comfortable_place_items.dart';
import 'package:ibm_flutter_final_project/features/home/ui/single_photo.dart';

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
            const SizedBox(
                height: 250, width: double.infinity, child: SinglePhoto()),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "Most Comfortable \n Place",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
                height: 300,
                width: double.infinity,
                child: ComfortablePlaceItems()),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "Location",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 300,
              width: double.infinity,
            ),
            Center(
              child: Container(
                width: 230,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorsManager.mainBlue,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        "Explore More",
                        style: TextStyles.font20WhiteBold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue[900],
                        radius: 15,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: ColorsManager.mainWhite,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
