import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class AppBarTop extends StatelessWidget {
  const AppBarTop({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
      decoration: BoxDecoration(
        color: Color(0xFF4B3FFF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.filter_list,color: ColorsManager.mainwhite,size: 40,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Row(
                   children: [
                     Text(
                                 'Current Location',
                                 style: TextStyles.font18whitewithopacity,
                                 
                                 
                               ),
                               Icon(Icons.arrow_drop_down_outlined,color: ColorsManager.mainwhite,)
                   ],
                 ),
          Text(
            'New York, USA',
            style: TextStyles.font20whitebold,
          ),
              ],
            ),
            Icon(Icons.circle_notifications_outlined,color: ColorsManager.mainwhite,size: 40,),
          ],
         ),
          SizedBox(height: 20),
         
          
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.search_sharp, color: Colors.white.withOpacity(0.7),size: 30,
              ),
              
              SizedBox(width: 10),
              Container(
                height: 30,
                width: 100,
                child: TextField(
                style: TextStyle(color: ColorsManager.mainwhite),
                decoration: InputDecoration(
                  hintText: "Search....",hintStyle: TextStyles.font18whitewithopacity,
                  border: InputBorder.none,
                ),
                ),
              ),
              Spacer(),
              
            ],
          ),
        ],
      ),
      ),
    );
  }
}

    