import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/home/ui/booking_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class ComfortablePlaceItems extends StatelessWidget {
  const ComfortablePlaceItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Image Section
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/roomsnearby.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text and Info Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Women's leadership \n conference",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(width: 4),
                        Container(
                          height: 30,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blueAccent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BookingScreen()));
                                    },
                                    child: Text(
                                      "Book !",
                                      style: TextStyles.font20WhiteBold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[900],
                                  radius: 11,
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: ColorsManager.mainWhite,
                                    size: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Price Section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorChangingIcon(),
                      const Text(
                        "3.0",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Text(
                        "EGP/Hour",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
