import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../home_page.dart';

class SideBar extends StatefulWidget {
  final OptionsDrawerController controller;

  const SideBar({Key key, this.controller}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  OptionsDrawerController controller;
  AnimationController _animationController;
  final _animationDuration = const Duration(milliseconds: 500);
  bool isMenuOpen = false;
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    controller = widget.controller ?? OptionsDrawerController();

    controller.addListener(() {
      setState(() {
        isMenuOpen = controller.isMenuOpen;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onIconPressed() {
    if (isMenuOpen) {
      controller.closeMenu();
      _animationController.reverse();
    } else {
      controller.openMenu();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: _animationDuration,
      top: 0,
      curve: Curves.easeInOut,
      bottom: 0,
      left: isMenuOpen ? 0 : screenWidth - 60,
      right: isMenuOpen ? 0 : -screenWidth,
      child: ClipPath(
        clipper: HierenMenuClipper(),
        child: Plasma(
          particles: 10,
          foregroundColor: context.colorScheme.primary.withOpacity(0.9),
          backgroundColor: context.colorScheme.onPrimary.withOpacity(0.9),
          size: 1.00,
          speed: 6.00,
          offset: 0.00,
          blendMode: BlendMode.dstATop,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: onIconPressed,
                  child: Container(
                    width: 55,
                    height: 100,
                    margin: EdgeInsets.only(top: 50),
                    alignment: Alignment.centerRight,
                    child: AnimatedIcon(
                      progress: _animationController.view,
                      icon: AnimatedIcons.menu_close,
                      color: context.colorScheme.onBackground,
                      size: 25,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _buildBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: MomentumBuilder(
          controllers: [CurrentUserController],
          builder: (context, snapshot) {
            final model = snapshot<CurrentUserModel>();
            if (model.currentUser == null) {
              return ErrorIndicator(
                onReload: Momentum.controller<CurrentUserController>(context)
                    .getCurrentUser,
              );
            }
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: _buildTitle(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildGender(model.currentUser),
                        _buildHobbies(model.currentUser),
                        _buildDistance(model.currentUser),
                        _buildAge(model.currentUser),
                        _buildHeight(model.currentUser),
                        _buildEnum<EducationLevel>(
                          title: Strings.common.educationLevel,
                          itemToString: (i) => i.displayValue,
                          items: EducationLevel.getAll(),
                          value: model.currentUser.educationLevelsPrefer,
                          onPressed: (i) {
                            if (model.currentUser.educationLevelsPrefer !=
                                    null &&
                                model.currentUser.educationLevelsPrefer
                                    .contains(i)) {
                              model.currentUser.educationLevelsPrefer.remove(i);
                            } else {
                              model.currentUser.educationLevelsPrefer.add(i);
                            }
                            model.controller.updateDatingSetting(
                                educationLevelsPrefer:
                                    model.currentUser.educationLevelsPrefer);
                          },
                        ),
                        _buildEnum<HaveKids>(
                          title: 'Con cái',
                          itemToString: (i) => i.theirDisplay,
                          items: HaveKids.getAll(),
                          value: [model.currentUser.theirKids],
                          onPressed: (i) {
                            model.currentUser.theirKids = i;
                            model.controller.updateDatingSetting(
                                theirKids: model.currentUser.theirKids);
                          },
                        ),
                        _buildEnum<Religious>(
                          title: 'Tôn giáo',
                          itemToString: (i) => i.displayValue,
                          items: Religious.getAll(),
                          value: model.currentUser.religiousPrefer,
                          onPressed: (i) {
                            if (model.currentUser.religiousPrefer != null &&
                                model.currentUser.religiousPrefer.contains(i)) {
                              model.currentUser.religiousPrefer.remove(i);
                            } else {
                              model.currentUser.religiousPrefer.add(i);
                            }
                            model.controller.updateDatingSetting(
                                religiousPrefer:
                                    model.currentUser.religiousPrefer);
                          },
                        ),
                        const SizedBox(height: 56),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Strings.drawer.filter,
          style:
              context.textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
        ),
        InkWell(
          enableFeedback: true,
          child: Icon(
            Icons.color_lens,
            color: context.colorScheme.primary,
            size: 20,
          ),
          onTap: () {
            Momentum.of<ThemeController>(context).randomTheme();
          },
        ),
      ],
    );
  }

  Widget _buildGender(User user) {
    return _buildItem(
      title: Strings.drawer.whoAreYouLookingFor,
      body: Row(
        children: [
          Expanded(
            child: _buildGenderButton(user, Gender.male),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildGenderButton(user, Gender.female),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildGenderButton(user, Gender.other),
          ),
        ],
      ),
    );
  }

  Widget _buildHobbies(User currentUser) {
    return _buildItem(
      title: Strings.common.hobbies,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 10,
            children: currentUser.hobbies
                .take(5)
                .map(
                  (e) => HobbyItem(hobby: e, isSelected: true),
                )
                .toList(),
          ),
          OutlineButton(
            onPressed: () {
              HobbiesBottomSheet().show(context);
            },
            borderSide: BorderSide(width: 1, color: Colors.grey[500]),
            highlightColor: context.colorScheme.primary.withOpacity(0.5),
            child: Text(Strings.drawer.chooseOtherHoddies),
          )
        ],
      ),
    );
  }

  Widget _buildDistance(User currentUser) {
    return currentUser.distancePrefer == null
        ? const SizedBox.shrink()
        : _buildItem(
            title: Strings.common.distance,
            actions: Row(
              children: [
                Icon(
                  Icons.room,
                  size: 12,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 5),
                Text('${currentUser.distancePrefer} km',
                    style: context.textTheme.caption),
              ],
            ),
            body: FlutterSlider(
              values: [currentUser.distancePrefer.toDouble()],
              max: (1000 < currentUser.distancePrefer
                      ? currentUser.distancePrefer
                      : 1000)
                  .toDouble(),
              min: 0,
              trackBar: FlutterSliderTrackBar(
                activeTrackBar:
                    BoxDecoration(color: context.colorScheme.primary),
              ),
              handler: HeartSliderHandler(context),
              tooltip: CustomSliderTooltip(context, unit: 'km'),
              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                Momentum.controller<CurrentUserController>(context)
                    .updateDatingSetting(
                        distancePrefer:
                            double.tryParse(lowerValue.toString()).round());
              },
            ),
          );
  }

  Widget _buildAge(User currentUser) {
    return currentUser.minAgePrefer == null || currentUser.maxAgePrefer == null
        ? const SizedBox.shrink()
        : _buildItem(
            title: Strings.common.age,
            actions: Text(
                '${currentUser.minAgePrefer} - ${currentUser.maxAgePrefer} tuổi',
                style: context.textTheme.caption),
            body: FlutterSlider(
              values: [
                currentUser.minAgePrefer.toDouble(),
                currentUser.maxAgePrefer.toDouble()
              ],
              max: (60 < currentUser.maxAgePrefer
                      ? currentUser.maxAgePrefer
                      : 60)
                  .toDouble(),
              min: (18 > currentUser.minAgePrefer
                      ? currentUser.minAgePrefer
                      : 18)
                  .toDouble(),
              rangeSlider: true,
              minimumDistance: 1,
              trackBar: FlutterSliderTrackBar(
                activeTrackBar:
                    BoxDecoration(color: context.colorScheme.primary),
              ),
              handlerWidth: 18,
              handlerHeight: 18,
              handler: HeartSliderHandler(context, iconSize: 14),
              rightHandler: HeartSliderHandler(context, iconSize: 14),
              tooltip: CustomSliderTooltip(context, unit: 'tuổi'),
              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                Momentum.controller<CurrentUserController>(context)
                    .updateDatingSetting(
                        minAgePrefer:
                            double.tryParse(lowerValue.toString()).round(),
                        maxAgePrefer:
                            double.tryParse(upperValue.toString()).round());
              },
            ),
          );
  }

  Widget _buildHeight(User currentUser) {
    return currentUser.minHeightPrefer == null ||
            currentUser.maxHeightPrefer == null
        ? const SizedBox.shrink()
        : _buildItem(
            title: Strings.common.height,
            actions: Text(
                '${currentUser.minHeightPrefer} - ${currentUser.maxHeightPrefer} cm',
                style: context.textTheme.caption),
            body: FlutterSlider(
              values: [
                currentUser.minHeightPrefer.toDouble(),
                currentUser.maxHeightPrefer.toDouble()
              ],
              max: (200 < currentUser.maxHeightPrefer
                      ? currentUser.maxAgePrefer
                      : 200)
                  .toDouble(),
              min: (150 > currentUser.minHeightPrefer
                      ? currentUser.minHeightPrefer
                      : 150)
                  .toDouble(),
              rangeSlider: true,
              minimumDistance: 1,
              trackBar: FlutterSliderTrackBar(
                activeTrackBar:
                    BoxDecoration(color: context.colorScheme.primary),
              ),
              handlerWidth: 18,
              handlerHeight: 18,
              handler: HeartSliderHandler(context, iconSize: 14),
              rightHandler: HeartSliderHandler(context, iconSize: 14),
              tooltip: CustomSliderTooltip(context, unit: 'cm'),
              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                Momentum.controller<CurrentUserController>(context)
                    .updateDatingSetting(
                        minHeightPrefer:
                            double.tryParse(lowerValue.toString()).round(),
                        maxHeightPrefer:
                            double.tryParse(upperValue.toString()).round());
              },
            ),
          );
  }

  Widget _buildEnum<T extends Enumerable>({
    String title,
    List<T> value,
    List<T> items = const [],
    Function(T i) onPressed,
    String Function(T i) itemToString,
  }) {
    return _buildItem(
      title: title ?? '',
      body: Wrap(
        spacing: 10,
        children: items
            .map(
              (e) => OptionButton(
                title: itemToString?.call(e) ?? e.toString(),
                isSelected: value?.contains(e) ?? false,
                onPressed: () => onPressed?.call(e),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildItem({
    @required String title,
    Widget actions,
    Widget body,
    bool showBottomSeparator = true,
  }) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.bodyText1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            if (actions != null) actions
          ],
        ),
        if (body != null) ...[const SizedBox(height: 10), body],
        const SizedBox(height: 15),
        if (showBottomSeparator) Divider(color: Colors.grey[500])
      ],
    );
  }

  Widget _buildGenderButton(User user, Gender gender) => OptionButton(
      title: gender.displayValue,
      isSelected: user.genderPrefer?.contains(gender) ?? false,
      onPressed: () async {
        try {
          await Momentum.controller<CurrentUserController>(context)
              .toggleGenderButton(gender);
        } catch (e) {
          await Fluttertoast.showToast(msg: e);
        }
      });
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    var path = Path();
    path.moveTo(width, 0);
    path.quadraticBezierTo(width, 8, width - 10, 16);
    path.quadraticBezierTo(1, height / 2 - 20, 0, height / 2);
    path.quadraticBezierTo(-1, height / 2 + 20, width - 10, height - 16);
    path.quadraticBezierTo(width, height - 8, width, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HierenMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var paint = Paint();
    paint.color = Colors.white;

    var path_0 = Path();
    // path_0.moveTo(size.width * 0.14, 0);
    // path_0.lineTo(size.width, 0);
    // path_0.lineTo(size.width, size.height);
    // path_0.lineTo(size.width * 0.14, size.height);
    // path_0.lineTo(size.width * 0.14, size.height * 0.24);
    // path_0.quadraticBezierTo(size.width * 0.14, size.height * 0.20,
    //     size.width * 0.09, size.height * 0.17);
    // path_0.cubicTo(size.width * 0.05, size.height * 0.16, size.width * 0.05,
    //     size.height * 0.13, size.width * 0.09, size.height * 0.11);
    // path_0.quadraticBezierTo(size.width * 0.14, size.height * 0.09,
    //     size.width * 0.14, size.height * 0.04);
    // path_0.lineTo(size.width * 0.14, 0);

    path_0.moveTo(60, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(60, size.height);
    path_0.lineTo(60, 170);
    path_0.quadraticBezierTo(60.55, 141.68, 30, 120);
    path_0.cubicTo(18.42, 111.81, 19.14, 90.65, 30, 80);
    path_0.quadraticBezierTo(60.43, 60.1, 60, 30);
    path_0.lineTo(60, 0);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
