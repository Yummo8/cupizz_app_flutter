library helpers;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pedantic/pedantic.dart';
import 'package:timeago/timeago.dart' as time_ago;

import '../base/base.dart';

part 'format_datetime.dart';
part 'size_helper.dart';
part 'strings.dart';
part 'validator.dart';
part 'vi_time_ago_message.dart';
part 'time_ago.dart';
part 'hero_key.dart';
part 'debouncer.dart';

Future trycatch(Function func, {bool throwError = false}) async {
  try {
    await func();
  } catch (e) {
    unawaited(Fluttertoast.showToast(msg: e.toString()));
    if (throwError) rethrow;
  }
}
