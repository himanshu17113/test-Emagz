import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageStoryView extends StatefulWidget {
  final Uint8List snapshot;
  final bool isImage;

  const ImageStoryView(
      {super.key, required this.snapshot, this.isImage = true});

  @override
  State<ImageStoryView> createState() => _ImageStoryViewState();
}

class _ImageStoryViewState extends State<ImageStoryView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: MemoryImage(widget.snapshot), fit: BoxFit.cover)),
      ),
    );
  }
}
