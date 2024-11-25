import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/features/home/ui/single_item_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class WorkSpaces extends StatelessWidget {
  const WorkSpaces({super.key});

  @override
  
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        
        height: 240,
        width: double.infinity,
        child: ListView.builder(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
          return Stack(
            children: [

            
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleItemScreen()));
                },
                child: Container(
                  height: 198,
                  width: 134,
                 child: Image.asset("assets/images/workspace.jpg",fit: BoxFit.cover,),
                            
                ),
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 95),
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
            Padding(
              padding: const EdgeInsets.only(top: 160,left: 25),
              child: Container(
                width: 100,
                height: 35,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_sharp,color: Colors.black87,),
                    Text("Cairo,Nasr City",style: TextStyle(
                      fontSize: 10,
                      color: Colors.black87,
                    ),)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 210,left: 10),
              child: Container(
                width: 130,
                height: 40,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white24,
                      spreadRadius: 2,
                    )
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Titen Office Center",style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),),
                ),
              ),
            )
            ],
          );
        }),
      ),
    );
  }
}