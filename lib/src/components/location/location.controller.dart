import 'package:app_settings/app_settings.dart';
import 'package:cupizz_app/src/base/base.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'location.model.dart';

class LocationController extends MomentumController<LocationModel> {
  @override
  LocationModel init() {
    return LocationModel(
      this,
    );
  }

  Future<bool> checkPermission(BuildContext? context,
      {bool showDialog = true}) async {
    final checkPermission = await Geolocator.checkPermission();
    if (checkPermission == LocationPermission.denied ||
        checkPermission == LocationPermission.deniedForever) {
      if (showDialog) {
        await Future.delayed(Duration(seconds: 1));
        await _showDialog(context!);
      }
      final permission = await Permission.location.request();
      if (permission == PermissionStatus.restricted ||
          permission == PermissionStatus.denied) {
        await _showFailDialog(context!);
        return false;
      } else if (permission == PermissionStatus.permanentlyDenied) {
        await _showOpenSettingDialog(context!);
        return false;
      }
    }
    await _updateLocation();
    return true;
  }

  Future _updateLocation() async {
    await trycatch(() async {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      final service = Get.find<UserService>();
      await service.updateProfile(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    });
  }

  Future _showDialog(BuildContext context) async {
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

  Future _showFailDialog(BuildContext context) async {
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

  Future _showOpenSettingDialog(BuildContext context) async {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateFail,
    );
    await popup.show<bool>(
      title: 'Opp!',
      content:
          'Bạn đã chặn Cupizz truy cập vào vị trí của bạn. Cupizz sẽ không thể ghép đôi chính xác được nếu như thiếu vị trí. Hãy vào Cài đặt và sửa đổi quyền để Cupizz có thể giúp bạn tìm được đối tác thích hợp!',
      barrierDismissible: false,
      actions: [
        popup.button(
          label: 'Cài đặt quyền',
          onPressed: () async {
            await AppSettings.openLocationSettings();
            Navigator.of(context).pop();
            await checkPermission(context);
          },
        ),
      ],
    );
  }
}
