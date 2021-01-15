import 'package:cupizz_app/src/base/base.dart';

String formateDatetime(DateTime time, [String stringFormat = 'dd/MM/yyyy']) {
  return DateFormat(stringFormat).format(time);
}
