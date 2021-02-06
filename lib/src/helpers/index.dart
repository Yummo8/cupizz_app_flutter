library helpers;

import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:pedantic/pedantic.dart';

import '../base/base.dart';

export 'debouncer.dart';
export 'format_datetime.dart';
export 'hero_key.dart';
export 'size_helper.dart';
export 'strings.dart';
export 'time_ago.dart';
export 'validator.dart';
export 'vi_time_ago_message.dart';

Future trycatch(Function func, {bool throwError = false}) async {
  try {
    await func();
  } catch (e) {
    unawaited(Fluttertoast.showToast(msg: e.toString()));
    if (throwError) {
      rethrow;
    } else {
      debugPrint(e.toString());
    }
  }
}

Color getTextColorFromColor(Color backgroundColor) {
  final computeLuminance = backgroundColor.computeLuminance();
  return computeLuminance > 0.95 ? Colors.black : Colors.white;
}
