import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/comment/commentController.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/comment_tile/comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class PostCommentsModalBottomSheet extends StatefulWidget {
  final String postId;
  List<Comment?> comments;
 PostCommentsModalBottomSheet({super.key, required this.comments, required this.postId});

  @override
  State<PostCommentsModalBottomSheet> createState() => _PostCommentsModalBottomSheetState();
}

class _PostCommentsModalBottomSheetState extends State<PostCommentsModalBottomSheet> {
  var commentsController = Get.put(CommentController());
  double mainHeight = 450;

  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    // print(MediaQuery.of(context).viewInsets.bottom);
    // print(MediaQuery.of(context).size.height);

    return SizedBox(
      height: _keyboardVisible ? MediaQuery.of(context).size.height : 450,
      child: Column(
        children: [
          const Text(
            "Comments",
            textAlign: TextAlign.center,
            style: TextStyle(height: 2, fontSize: 18, color: Colors.black),
          ),
          Container(width: double.maxFinite, height: 0.5, color: Colors.black),
          SizedBox(
            height: _keyboardVisible ? (MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom - 120) : 320,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: const ScrollPhysics(),
                children: [
                  if (widget.comments.isNotEmpty) ...[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: widget.comments.length,
                      itemBuilder: (context, index) {
                        return PostCommentTile(
                          comment: widget.comments[index]!,
                        );
                      },
                    ),
                  ],
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: commentsController.instantComments.value.length,
                      itemBuilder: (context, index) {
                        //  print(commentsController.instantComments.value[index]);
                        return PostCommentTile(
                          comment: commentsController.instantComments.value[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width - 20,
            child: TextField(
              controller: commentsController.controller,
              // controller: textEditingController,
              decoration: InputDecoration(
                hintText: "write comment",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Obx(
                    () => IconButton(
                        onPressed: () {
                          commentsController.isPosting.value
                              ? debugPrint("sending comment")
                              : commentsController.postComment(widget.postId);
                          setState(() {
widget.comments.add( Comment(text: commentsController.controller.text,userId: UserSchema(sId:  commentsController.userId) ,comments: [],sId:  commentsController.userId));
                          });
                        },
                        icon: commentsController.isPosting.value
                            ? const Icon(
                                Icons.more_horiz,
                                color: Colors.blue,
                              )
                            : const Icon(
                                Icons.send,
                                color: Colors.blue,
                              )),
                  ),
                ),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
