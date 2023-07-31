import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LikesAndViewsOptions extends StatelessWidget {
  final Function(String value,String showValue) onTap;
  const LikesAndViewsOptions({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            child: Center(child: Text("Likes and Views",style: TextStyle(
              color: Colors.black.withOpacity(0.60),
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(color: Colors.grey,height: 2,width: MediaQuery.of(context).size.width/2,),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: visibilityOptions.length,
              itemBuilder: (context, index) => ListTile(
                leading: visibilityOptions[index].icon,
                title: Text(visibilityOptions[index].data),
                onTap: () {
                  Get.back();
                  onTap(visibilityOptions[index].touchValue,visibilityOptions[index].data);
                },
              ),),
          )
        ],
      ),
    );
  }
}

class TileOption{
  Icon icon;
  String touchValue;
  String data;
  TileOption({required this.data,required this.icon,required this.touchValue});
}

List<TileOption> visibilityOptions = [
  TileOption(data: "Hide from EveryOne", icon: const Icon(Icons.groups),touchValue: "hideFromEveryone"),
  TileOption(data: "People you follow", icon: const Icon(Icons.nature_people),touchValue: "peopleYouFollow"),
  TileOption(data: "No one", icon: const Icon(Icons.no_accounts_rounded),touchValue: "noOne"),
];