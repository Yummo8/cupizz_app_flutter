library services;

import 'package:cupizz_app/src/packages/object_mapper/object_mapper.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:momentum/momentum.dart';

import '../base/base.dart';
import '../screens/index.dart';
import '../services/graphql_query.dart';
import '../models/index.dart';

import '../screens/main/main_screen.dart';
part 'auth_service.dart';
part 'graphql_service.dart';
part 'storage_service.dart';
part 'user_service.dart';
