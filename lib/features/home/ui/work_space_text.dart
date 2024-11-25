import 'package:flutter/material.dart';

class WorkSpaceText extends StatelessWidget {
  const WorkSpaceText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Work Spaces",style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),),
          ),
          Row(
            children: [
              Text("See All",style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),),
              Icon(Icons.arrow_right,color: Colors.grey,)
            ],
          )
        ],
      ),
    );
  }
}