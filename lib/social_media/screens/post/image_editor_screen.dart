import 'package:emagz_vendor/social_media/common/appbar/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:image_editor/image_editor.dart';

class ImageEditorScreen extends StatefulWidget {
  final Uint8List imagePath;
  const ImageEditorScreen({super.key, required this.imagePath});

  @override
  State<ImageEditorScreen> createState() => _ImageEditorScreenState();
}

class _ImageEditorScreenState extends State<ImageEditorScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SocialMediaAppBar(title: "title"),
      // body:
    );
  }
}
