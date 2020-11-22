part of 'index.dart';

String formateDatetime(DateTime time, [String stringFormat = 'dd/MM/yyyy']) {
  return DateFormat(stringFormat).format(time);
}
