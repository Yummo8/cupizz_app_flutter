part of 'index.dart';

class TimeAgo {
  static String format(DateTime date, {DateTime clock, bool allowFromNow}) {
    return time_ago.format(date,
        clock: clock, allowFromNow: allowFromNow, locale: 'vi');
  }
}
