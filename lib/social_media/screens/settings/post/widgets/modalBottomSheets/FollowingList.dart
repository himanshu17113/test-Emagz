import 'package:flutter/material.dart';
class FollowingList extends StatelessWidget {
  const FollowingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            child: Center(child: Text("Hide like & views Controll",style: TextStyle(
                color: Colors.black.withOpacity(0.60),
                fontSize: 18,
                fontWeight: FontWeight.w500
            ),)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(color: Colors.grey,height: 2,width: MediaQuery.of(context).size.width/2,),
          ),
          Center(child: Text("List of People"),)
        ],
      ),
    );
  }
}
