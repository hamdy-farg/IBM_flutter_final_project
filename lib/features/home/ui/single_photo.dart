import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class SinglePhoto extends StatelessWidget {
  const SinglePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 222,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/workspace.jpg"),
              fit: BoxFit.cover
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_outlined,color: ColorsManager.mainwhite,)),
                    Text("Titen Office",style: TextStyles.font20whitebold,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                 
                  width: 38,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                 child: Center(child: ColorChangingIcon()),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Center(
              child: Container(
                
                  width: 150,
                  height: 35,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                    
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_sharp,color: Colors.grey,),
                      Text("Cairo,Nasr City",style: TextStyle(
                        fontSize: 15,
                        color: ColorsManager.mainwhite,
                      ),)
                    ],
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }
}