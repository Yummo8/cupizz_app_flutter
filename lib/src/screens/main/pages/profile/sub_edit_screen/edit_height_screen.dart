part of '../edit_profile_screen.dart';

class EditHeightScreen extends StatefulWidget {
  @override
  _EditHeightScreenState createState() => _EditHeightScreenState();
}

class _EditHeightScreenState extends State<EditHeightScreen> {
  double selectedHeight = 160;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedHeight = Momentum.controller<CurrentUserController>(context)
              .model
              .currentUser
              ?.height
              ?.toDouble() ??
          160;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHelper = SizeHelper(context);

    return PrimaryScaffold(
      appBar: BackAppBar(title: Strings.common.height, actions: [
        SaveButton(onPressed: () {
          Momentum.controller<CurrentUserController>(context)
              .updateProfile(height: selectedHeight.round());
          Get.back();
        })
      ]),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: FlutterSlider(
                      values: [selectedHeight],
                      max: (200 < selectedHeight ? selectedHeight : 200)
                          .toDouble(),
                      min: (150 > selectedHeight ? selectedHeight : 150)
                          .toDouble(),
                      tooltip: FlutterSliderTooltip(
                        disabled: true,
                      ),
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBar:
                            BoxDecoration(color: context.colorScheme.primary),
                      ),
                      handler: HeartSliderHandler(context),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        setState(() {
                          selectedHeight = lowerValue;
                        });
                      },
                    ),
                  ),
                  Text(
                    '${selectedHeight.round()}cm',
                    style: context.textTheme.caption,
                  )
                ],
              ),
              SizedBox(height: sizeHelper.rW(5)),
              ShowOnProfileText(),
            ],
          ),
        ),
      ),
    );
  }
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              padding: EdgeInsets.all(10.0),
              child: _buildItem(context),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
