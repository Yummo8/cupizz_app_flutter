library home_screen;

import 'dart:async';
import 'dart:math' as math;

import 'package:cupizz_app/src/components/theme/theme.controller.dart';
import 'package:cupizz_app/src/helpers/index.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/physics.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:momentum/momentum.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../assets.dart';
import '../../base/base.dart';
import '../../widgets/index.dart';

part 'widgets/animated_background.dart';
part 'widgets/c_card.dart';
part 'widgets/options_button.dart';
part 'widgets/options_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _drawerController = OptionsDrawerController();
  final _headerHeight = 75.0;

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            AnimatedBackground(),
            Positioned(right: 0, top: 30, child: _buildHeader()),
            Positioned.fill(child: _buildCards()),
            OptionsDrawer(controller: _drawerController),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Builder(builder: (context) {
      return OptionsButton(
        onPressed: () {
          _drawerController.openMenu();
        },
      );
    });
  }

  Widget _buildCards() {
    return CCard(
      padding: EdgeInsets.only(top: _headerHeight + 50),
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      cards: [
        Image.network(
          'https://loremflickr.com/888/851/girl?lock=7585',
          fit: BoxFit.cover,
        ),
        Image.network(
          'https://loremflickr.com/958/610/girl?lock=3435',
          fit: BoxFit.cover,
        ),
        Image.network(
          'https://loremflickr.com/431/1243/girl?lock=3461',
          fit: BoxFit.cover,
        ),
      ]
          .map((e) => ClipRRect(
                child: e,
                borderRadius: BorderRadius.circular(15),
              ))
          .toList(),
    );
  }
}
