import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/home/story/widgets/story_selection/ModalBottomSheet.dart';
import 'package:flutter/material.dart';

class MyStory extends StatelessWidget {
  const MyStory({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) {
              return const StorySelectionBottomSheet();
            });
      },
      child: Container(
        height: 55,
        width: 55,
        alignment: Alignment.centerRight,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/png/story_border.png"),
              fit: BoxFit.contain),
        ),
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-48 / 360),
          child: Stack(
            children: [
              Positioned(
                top: 24,
                left: 7.3,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //   border: Border.all( color: ),
                    image: const DecorationImage(
                        image: CachedNetworkImageProvider(
                            "https://picsum.photos/500/500?random=0"),
                        fit: BoxFit.cover),
                  ),
                  // child: Image.network(
                  //   url,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Positioned(
                top: 55,
                left: 15,
                child: CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 8,
                  child: const CircleAvatar(
                    backgroundColor: Color(0xff3B12AA),
                    radius: 6,
                    child: Icon(
                      Icons.add,
                      size: 9,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
