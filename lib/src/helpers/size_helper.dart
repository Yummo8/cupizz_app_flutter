import 'package:cupizz_app/src/base/base.dart';

class SizeHelper {
  BuildContext context;
  late double _height;
  late double _width;
  late double _heightPadding;
  late double _widthPadding;

  SizeHelper(this.context) {
    final _queryData = MediaQuery.of(context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double rH(double v) {
    return _height * v;
  }

  double rW(double v) {
    if (_width < _height) {
      return _width * v;
    } else {
      return _height * v;
    }
  }

  double rHP(double v) {
    return _heightPadding * v;
  }

  double rWP(double v) {
    return _widthPadding * v;
  }

  double rT(double v) {
    return _width * v;
  }
}
