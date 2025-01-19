import 'package:intl/intl.dart';

class DateFormatHelper {
  static String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    return DateFormat('HH:mm - dd-MM-yyyy').format(dateTime);
  }
}
