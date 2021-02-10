library graphql;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../base/base.dart';
import 'dart:io' as io;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

part 'graphql_mutation.dart';
part 'graphql_query.dart';
part 'graphql_supscription.dart';

Future<MultipartFile> multiPartFile(io.File file) async {
  return MultipartFile.fromBytes('photo', file.readAsBytesSync(),
      filename: '${DateTime.now().second}-${DateTime.now().hour}.jpg',
      contentType: MediaType('image', 'jpg'));
}
