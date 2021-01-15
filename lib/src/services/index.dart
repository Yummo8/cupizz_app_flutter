library services;

import 'dart:io' as io;

import 'package:flutter/material.dart' hide Router;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pedantic/pedantic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base/base.dart';
import '../models/index.dart';
import 'graphql/index.dart';

export 'graphql/index.dart';

part 'auth_service.dart';
part 'graphql_service.dart';
part 'message_service.dart';
part 'one_signal_service.dart';
part 'storage_service.dart';
part 'system_service.dart';
part 'user_service.dart';
