import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/features/home/ui/single_item_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class WorkSpaces extends StatelessWidget {
  const WorkSpaces({super.key});

  @override
  
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SingleItemScreen()));
              },
              child: Container(
                width: 133.33.h,
                 // Width of the design
                 height: 198.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      spreadRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image with overlay
                    Stack(
                      children: [
                        // Background Image
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            'assets/images/workspace.jpg', // Replace with your image asset
                            width: 100.34.w,
                            height: 176.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Semi-transparent location container
                        Positioned(
                          bottom: 10,
                          left: 1,
                          child: Container(
                            height: 30.h,
                           width: 123.w,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black87.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Cairo, Nasr City',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Bookmark Icon
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 21.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: Colors.black87.withOpacity(0.5),
                            
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ColorChangingIcon(),
                          ),
                        ),
                      ],
                    ),
                    // Title below the image
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Titen Office Center',
                        style: TextStyle(
                          color: Color(0xff2C3E50),
                          fontSize: 12,
                          
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        ),
      );
        }
      
        
         
        }

    
 