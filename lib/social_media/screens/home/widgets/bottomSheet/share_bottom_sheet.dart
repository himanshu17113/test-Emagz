import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
class ShareBottomSheet extends StatefulWidget {
  final Post post;
  const ShareBottomSheet({super.key,required this.post});

  @override
  State<ShareBottomSheet> createState() => _ShareBottomSheetState();
}

class _ShareBottomSheetState extends State<ShareBottomSheet> {

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 30,
              child: Center(child: Text("Share",style: TextStyle(
                  color: Colors.black.withOpacity(0.60),
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(color: Colors.grey,height: 2,width: MediaQuery.of(context).size.width/2,),
          ),
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width/1.1,
            child:PageView.builder(

              onPageChanged: (value) {
                pageIndex = value;
                setState(() {});
              },
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, pageIndex) {
              return GridView.builder(itemCount: 6,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Share.share("More Data Will be Available later " );
                  },
                  child: Container(
                      child: Center(child: Image.asset("assets/socialMediaIcons/$pageIndex$index.png"))),
                );
                  },);
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 150,
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Container(
                          decoration: BoxDecoration(
                          color: Colors.blue, borderRadius: BorderRadius.circular(5),
                            border: (index != pageIndex) ? Border.all(
                                width: 2,
                                style:  BorderStyle.solid,
                                color: Colors.white) : null
                          ),height: 10,width: 10),
                    ),),
                ),
              ),
            ],
          )
        ],
      ),
    );;
  }
}
