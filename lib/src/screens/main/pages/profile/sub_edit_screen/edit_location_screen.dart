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
    _currentAddress = "";
  }

  _checkPermission() async {
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied ||
        checkPermission == LocationPermission.deniedForever) {
      LocationPermission requestPermission =
          await Geolocator.requestPermission();
      if (requestPermission == LocationPermission.denied ||
          requestPermission == LocationPermission.deniedForever) {
        _getCurrentLocation();
      } else {}
    } else {
      _getCurrentLocation();
    }
  }

  _getCurrentLocation() {
    setState(() {
      _onLoading = true;
    });
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      String address =
          "${place.locality.isExistAndNotEmpty ? '${place.locality},' : place.locality} ${place.country}";
      print(address);
      setState(() {
        _currentAddress = address;
        _onLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeHelper sizeHelper = SizeHelper(context);
    final ThemeData _theme = Theme.of(context);

    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Vị trí hẹn hò',
        actions: [
          InkWell(
            onTap: () {},
            child: Center(
              child: Text(
                "Lưu",
                style: TextStyle(color: _theme.primaryColor, fontSize: 15.0),
              ),
            ),
          ),
          SizedBox(
            width: sizeHelper.rW(8),
          ),
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
                          Text(
                            _currentAddress,
                            style: context.textTheme.bodyText1,
                          ),
                        ],
                      ),
              ),
              FlatButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                color: _theme.primaryColor.withOpacity(0.2),
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
                      "Cập nhật vị trí hẹn hò",
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
                "Vị trí hẹn hò của bạn chỉ cập nhật khi bạn chọn thay đổi ở đây.",
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
