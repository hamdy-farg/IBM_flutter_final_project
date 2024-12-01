import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/booked_details_screen.dart';

class ReservationItems extends StatelessWidget {
  const ReservationItems({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 500,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 2,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 357.w,
              height: 250.h,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorsManager.mainWhite,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.1),
                    blurRadius: 10, 
                offset: Offset(5, 5),  
                spreadRadius: 3,
                  )
                ]
              ),
              child: Column(
               
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hilton San Francisco \n Union Square',
                              style: TextStyles.font18blackbold
                            ),
                            SizedBox(height: 3),
                            Text('Date: Jan 7, 2024',style: TextStyles.font14greybold,),
                            Text('Hours: 5:00 pm to 7:00 pm',style: TextStyles.font14greybold,),
                            SizedBox(height: 7),
                            Text(
                              'Price: 500 EGP',
                              style: TextStyles.font14bluebold,
                            ),
                          ],
                        ),
                        
                      ),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 50),
                           child: Container(
                            height: 118.h,
                            width: 118.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: AssetImage("assets/images/mone.png"))
                            ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             children: [
                               Padding(
                                 padding: const EdgeInsets.only(left: 30),
                                 child: Text("Statues : Approved",style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold
                                 )),
                               ),
                               Icon(Icons.circle,color: Colors.green,)
                             ],
                           ),
                         )
                       ],
                     )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BookedDetailsScreen()));
                      },
                      child: Container(
                        height: 40.h,
                        width: 318.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorsManager.mainblue2,
                          
                        ),
                        child: Center(
                          child: Text("Edit reservation and see details",style: TextStyles.font14WhiteBold,),
                        ),
                      ),
                    ),
                  )
                 
                ],
              ),
            ),
          ),
      );
          
        },
      ),
    );
  }
}