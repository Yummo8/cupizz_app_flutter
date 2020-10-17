import 'package:cubizz_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../base/base.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Center(
        child: Text(AppConfig.instance.appName),
      ),
    );
  }
}
