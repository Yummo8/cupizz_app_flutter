import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../base/base.dart';

class ImagesCropperScreen extends StatefulWidget {
  const ImagesCropperScreen({this.files, this.aspectRatio});

  final List<File?>? files;
  final CropAspectRatio? aspectRatio;

  @override
  _ImagesCropperScreenState createState() => _ImagesCropperScreenState();
}

class _ImagesCropperScreenState extends State<ImagesCropperScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.files!.length == 1) {
        cropImage(context, widget.files![0]!, widget.aspectRatio)
            .then((v) => Navigator.pop(context, [v]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(
        title: 'Cắt ảnh',
        actions: [
          SaveButton(
            onPressed: () {
              Navigator.pop(context, widget.files);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: GridView.builder(
          itemCount: widget.files!.length,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (_, index) => Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: context.width / 2,
                width: context.width / 2,
                child: Image.file(
                  widget.files![index]!,
                  height: context.width / 2,
                  width: context.width / 2,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: InkWell(
                  onTap: () async {
                    final croppedFile = await cropImage(
                        context, widget.files![index]!, widget.aspectRatio);
                    if (croppedFile != null) {
                      setState(() {
                        widget.files![index] = File(croppedFile.path);
                      });
                    }
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: const Icon(
                      Icons.crop,
                      size: 30,
                      color: Colors.white,
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
