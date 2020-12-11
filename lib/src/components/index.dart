library components;

import 'dart:io' as io;
import 'dart:math';

import 'package:cupizz_app/src/app.dart';
import 'package:cupizz_app/src/screens/main/pages/friend/friend_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pedantic/pedantic.dart';

import '../base/base.dart';
import '../screens/index.dart';
import '../services/index.dart';

part 'auth/auth.controller.dart';
part 'auth/auth.model.dart';
part 'current_user/current_user.controller.dart';
part 'current_user/current_user.model.dart';
part 'hobby_list/hobby_list.controller.dart';
part 'hobby_list/hobby_list.model.dart';
part 'recommendable_users/recommendable_users.controller.dart';
part 'recommendable_users/recommendable_users.model.dart';
part 'theme/theme.controller.dart';
part 'theme/theme.data.dart';
part 'theme/theme.model.dart';
