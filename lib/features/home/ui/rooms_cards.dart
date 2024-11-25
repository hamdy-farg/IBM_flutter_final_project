import 'package:flutter/material.dart';

import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class RoomsCards extends StatefulWidget {
  const RoomsCards({super.key});

  @override
  
  State<RoomsCards> createState() => _RoomsCardsState();
}

class _RoomsCardsState extends State<RoomsCards> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 500,
          width: double.infinity,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.vertical,
            itemBuilder: (context,index){
            return Container(
             padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 6,
                offset: Offset(0, 3),
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
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/roomsnearby.jpg'), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Text and Info Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Women's leadership \n conference",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Cairo, Elshourouk city",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Price Section
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    ColorChangingIcon(),
                  Text(
                    "3.0",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
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
        ),
      ),
    );
  }
}