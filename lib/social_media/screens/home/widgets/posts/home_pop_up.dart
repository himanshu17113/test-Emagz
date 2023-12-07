import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';

import 'package:path_provider/path_provider.dart';

import '../../../../models/post_model.dart';

class HomePagePopupWidget extends StatelessWidget {
  final String title;
  final bool isBorder;
  final Post? post;
  final String? url;
  const HomePagePopupWidget({
    super.key,
    required this.title,
    this.post,
    this.url,
    this.isBorder = true,
  });
  Future<void> _saveImage(String url, BuildContext context) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final http.Response response = await http.get(Uri.parse(url));
      final dir = await getTemporaryDirectory();
      var filename = '${dir.path}/${post!.sId}.png';
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      debugPrint(e.toString());
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'View Post') {
          Get.back();
        } else if (title == 'Share') {
          Get.back();
          Share.share("http://emagz.live/Post/${post?.sId}");
        } else if (title == 'Download') {
          Get.back();
          debugPrint(post?.mediaUrl?.toString());
          _saveImage(post!.mediaUrl![0]!, context);
        } else {
          Get.back();
          CustomSnackbar.show("No Stats for this post ");
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        height: 50,
        width: 260,
        decoration: BoxDecoration(
          color: isBorder == true ? null : Colors.white,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: FormHeadingText(
          headings: title,
          fontSize: 18,
          color: isBorder == true ? Colors.white : Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
