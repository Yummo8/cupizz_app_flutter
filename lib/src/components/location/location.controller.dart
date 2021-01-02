import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:momentum/momentum.dart';

import 'location.model.dart';

class LocationController extends MomentumController<LocationModel> {
  @override
  LocationModel init() {
    return LocationModel(
      this,
    );
  }

  @override
  Future bootstrapAsync() async {
    await Future.delayed(Duration(seconds: 1));
    await checkPermission(AppConfig.navigatorKey.currentContext);
  }

  Future<bool> checkPermission(BuildContext context,
      {bool showDialog = true}) async {
    final checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied ||
        checkPermission == LocationPermission.deniedForever) {
      if (showDialog) {
        await _showDialog(context);
      }
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await _showFailDialog(context);
        return false;
      }
    }
    await _updateLocation();
    return true;
  }

  void _updateLocation() async {
    await trycatch(() async {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      final service = getService<UserService>();
      await service.updateProfile(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }

  void _showDialog(BuildContext context) async {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateGeolocation,
    );
    await popup.show(
        title: 'Vị trí',
        content:
            'Hãy cung cấp vị trí của bạn. Chúng tôi sẽ sử dụng nó để ghép đôi bạn với những đối tượng phù hợp nhất.',
        barrierDismissible: false,
        actions: [
          popup.button(
            label: 'Ok',
            onPressed: Navigator.of(context).pop,
          ),
        ],
        close: null);
  }

  void _showFailDialog(BuildContext context) async {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateFail,
    );
    await popup.show<bool>(
      title: 'Opp!',
      content:
          'Chúng tôi không thể nhận được quyền truy cập vị trí của thiết bị của bạn.',
      barrierDismissible: false,
      actions: [
        popup.button(
          label: 'Thử lại',
          onPressed: () {
            checkPermission(context, showDialog: false);
            Navigator.of(context).pop();
          },
        ),
        popup.button(
          label: 'Bỏ qua',
          outline: true,
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
