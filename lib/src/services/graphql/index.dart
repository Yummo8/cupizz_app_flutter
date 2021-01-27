library graphql;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../base/base.dart';
import 'dart:io' as io;

part 'graphql_mutation.dart';
part 'graphql_query.dart';
part 'graphql_supscription.dart';

Future<MultipartFile> multiPartFile(io.File file) async {
  return MultipartFile(
    file,
    filename: '${DateTime.now().second}-${DateTime.now().hour}.png',
  );
}
