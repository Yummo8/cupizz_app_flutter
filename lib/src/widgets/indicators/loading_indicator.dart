import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double width;
  final Color color;
  final EdgeInsets padding;
  final bool isSeparatePlatform;

  const LoadingIndicator(
      {Key key,
      this.width = 50,
      this.color,
      this.padding,
      this.isSeparatePlatform = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(10),
      child: Platform.isAndroid || !isSeparatePlatform
          ? CircularProgressIndicator(backgroundColor: color)
          : CupertinoActivityIndicator(),
    );
  }
}
