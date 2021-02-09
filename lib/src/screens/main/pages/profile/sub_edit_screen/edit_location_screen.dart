part of '../edit_profile_screen.dart';

class EditLocationScreen extends StatefulWidget {
  @override
  _EditLocationScreenState createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  Position _currentPosition;
  String _currentAddress;
  bool _onLoading;

  @override
  void initState() {
    super.initState();
    _checkPermission();
    _onLoading = false;
    _currentAddress = '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _currentAddress = Momentum.controller<CurrentUserController>(context)
              .model
              .currentUser
              ?.address ??
          '';
      setState(() {});
    });
  }

  void _checkPermission() async {
    final checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied ||
        checkPermission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }

  void _getCurrentLocation() {
    setState(() {
      _onLoading = true;
    });
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e, stackTrace) {
      Fluttertoast.showToast(msg: e.toString());
      AppConfig.instance.sentry?.captureException(e, stackTrace: stackTrace);
    }).whenComplete(() => setState(() {
              _onLoading = false;
            }));
  }

  void _getAddressFromLatLng() async {
    try {
      final address =
          await Momentum.getService<SystemService>(context).getAddress(
        latitude: _currentPosition.latitude.toString(),
        longitude: _currentPosition.longitude.toString(),
      );
      setState(() {
        _currentAddress = address;
        _onLoading = false;
      });
    } catch (e, stackTrace) {
      await AppConfig.instance.sentry
          .captureException(e, stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeHelper = SizeHelper(context);
    final _theme = Theme.of(context);

    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Vị trí hẹn hò',
        actions: [
          SaveButton(
            onPressed: () {
              Momentum.controller<CurrentUserController>(context).updateProfile(
                latitude: _currentPosition.latitude,
                longitude: _currentPosition.longitude,
              );
              Router.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(sizeHelper.rW(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: sizeHelper.rH(7),
                margin: EdgeInsets.only(bottom: sizeHelper.rH(3)),
                child: _onLoading
                    ? Center(child: LoadingIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: _theme.primaryColor,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                            child: Text(
                              _currentAddress,
                              style: context.textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
              ),
              TextButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                style: TextButton.styleFrom(
                    backgroundColor: _theme.primaryColor.withOpacity(0.2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.near_me,
                      color: _theme.primaryColor,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'Cập nhật vị trí hẹn hò',
                      style:
                          TextStyle(color: _theme.primaryColor, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizeHelper.rW(5),
              ),
              Text(
                'Vị trí hẹn hò của bạn chỉ cập nhật khi bạn chọn thay đổi ở đây.',
                style: context.textTheme.subtitle1,
              ),
              SizedBox(
                height: sizeHelper.rW(5),
              ),
              ShowOnProfileText(),
            ],
          ),
        ),
      ),
    );
  }
}
