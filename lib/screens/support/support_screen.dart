import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/support/create_support.dart';
import 'package:emagz_vendor/screens/support/support_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../social_media/common/common_appbar.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}
class _SupportScreenState extends State<SupportScreen>{
  var supportController = Get.put(SupportController());
  @override
  Widget build(BuildContext context) {
      var w= MediaQuery.of(context).size.width;
      return Scaffold(
        backgroundColor: socialBack,
        appBar: const SocialMediaSettingAppBar(title: 'Support',),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('Recent',
                      style:  TextStyle(
                      color:  textSetting,
                        fontSize: 14,
                      fontWeight: FontWeight.w500),
                    ),
                  ),
                  Obx(()
                  {
                    return ListView.builder(

                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: supportController.supports!.length,
                      itemBuilder: (ctx,index){
                        return ListTile(
                          tileColor: Colors.white,
                          isThreeLine: true,

                          subtitle: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('12 sept 2022',
                                style: TextStyle(
                                    color:  textSetting,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                              Divider(),
                            ],
                          ),
                          trailing: const Text('Closed',
                            style: TextStyle(
                                color:  textSetting,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ticket No#${supportController.supports![index].ticketNumber??"12345"}',
                                  style: const TextStyle(
                                      color:  textSetting,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 4,),
                              Text(supportController.supports![index].message!),
                            ],
                          ),
                        );
                      },
                    );
                  }),

                  const Padding(

                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('History',
                      style:  TextStyle(
                          color:  textSetting,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Obx(()
                  {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: supportController.supports!.length,
                      itemBuilder: (ctx,index){
                        //print(supportController.supports![index].message);
                        return ListTile(
                          leading: Text(supportController.supports![index].ticketNumber??'12345'),
                            trailing: const Text('Closed'),
                          title: Text(supportController.supports![index].message??'Hello'),
                        );
                      },
                    );
                  }),




                ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: w,
          height: 76,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: chipColor),
              onPressed: (){
                  Get.to(()=>const CreateSupport());
              },
              child: const Text('Raise Ticket')
          ),
        ),
      );

  }
}

