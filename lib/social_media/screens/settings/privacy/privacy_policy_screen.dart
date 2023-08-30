import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool isTwoWayVerification = false;
  bool isDeactivateAccount = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xffE7E9FE),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            // ZoomDrawer.of(context)!.toggle();
                          },
                          child: Image.asset(
                            "assets/png/new_logo.png",
                            color: const Color(0xff1B47C1),
                            height: 38,
                            width: 36,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: purpleColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        weight: .5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                FormHeadingText(
                  headings: "Privacy policy",
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 331,
                  child: FormHeadingText(
                    headings:
                        """Lorem ipsum dolor sit amet consectetur. Semper ut eleifend porttitor consectetur phasellus ullamcorper tristique. Eu sed arcu ipsum massa tempor sagittis. At ultricies massa massa euismod suspendisse ut egestas. Semper porta morbi ac aliquam. Phasellus vestibulum ornare sit lorem nam elit enim vestibulum euismod. Iaculis fermentum eu in ornare.
Imperdiet amet consectetur nisl lorem arcu. Aliquam nibh vitae viverra ornare feugiat non convallis ultrices enim. Tellus orci egestas vitae auctor risus massa est justo ut. Sollicitudin odio molestie eu sit enim lacinia congue convallis. Aliquet erat tincidunt nunc sit turpis at. Mattis elit nibh egestas ipsum dolor vulputate lacus sit ut. Ornare ut faucibus sed volutpat nascetur. Tellus facilisi augue aliquet facilisis dui. Elementum cras elementum semper ut at malesuada massa lobortis natoque.
Fusce mattis sit in ligula. Enim malesuada mollis ac id. Eget purus tortor vestibulum faucibus. Cursus lorem tempor vitae aenean. Malesuada leo duis dictum sit facilisi ut vel orci. Ultrices turpis quis nisl cursus erat pellentesque quam. Massa gravida metus vel in purus ipsum. Risus iaculis et ut ultrices id. Cursus semper nec vestibulum consectetur commodo purus lacus quis. Elementum nibh amet nulla odio phasellus adipiscing. Ridiculus vulputate vel elit tincidunt id semper a hendrerit nibh. Diam diam sed magna rhoncus.
Enim eget eu augue proin risus arcu diam eu. Quis posuere magna nunc amet. Amet diam integer amet neque nulla imperdiet amet sed sed. Tellus non penatibus rhoncus pharetra turpis ipsum. Nunc curabitur egestas bibendum faucibus feugiat faucibus non. Risus hac habitant phasellus egestas. Vitae odio mauris amet sit purus varius.
Egestas pulvinar pulvinar sollicitudin sapien viverra risus eget. At tempus aliquet convallis venenatis ut. Morbi amet elit gravida eget risus dignissim. Neque id velit rhoncus purus risus. Et lorem enim purus nam. Pellentesque eget id ac at feugiat pretium aliquam. Nulla in sagittis et amet nunc facilisi vel blandit est. Molestie nibh ullamcorper convallis tortor scelerisque donec fames tellus. Hendrerit diam rhoncus lorem metus tellus et iaculis. Ut eu vel et enim. Arcu sollicitudin dignissim senectus id adipiscing gravida quis mi. Velit lacus purus mattis fermentum vel est amet. Quis vivamus pharetra at erat. Ante elementum egestas ac adipiscing venenatis euismod sit enim.
""",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: toggleInactive,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
