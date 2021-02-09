library base;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:intl/intl.dart';
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../helpers/index.dart';

export 'dart:io' hide HeaderValue;

export 'package:flutter/cupertino.dart' hide Router, RefreshCallback;
export 'package:flutter/material.dart' hide Router, ButtonBar;
export 'package:fluttertoast/fluttertoast.dart';
export 'package:get/get.dart';
export 'package:object_mapper/object_mapper.dart';
export 'package:pedantic/pedantic.dart';
export 'package:supercharged/supercharged.dart';

export '../assets.dart';
export '../components/index.dart';
export '../config.dart';
export '../constants/index.dart';
export '../helpers/index.dart';
export '../models/index.dart';
export '../packages/index.dart';
export '../packages/momentum/momentum.dart';
export '../routes.dart';
export '../screens/index.dart';
export '../services/index.dart';
export '../widgets/index.dart';

part 'src/app_base.dart';
part 'src/app_config.dart';
part 'src/cache_provider.dart';
part 'src/exts/context_ext.dart';
part 'src/exts/date_ext.dart';
part 'src/exts/list_ext.dart';
part 'src/exts/string_ext.dart';
part 'src/mixins/keep_scroll_offset.dart';
part 'src/mixins/load_more_mixin.dart';
part 'src/storage_provider.dart';
