import 'package:intl/intl.dart';

// Date Formates
const EMMMdy_DateFormat = "E, MMM d, y";

String EMMMdyFormat(String date) {
  // Parse the input string into a DateTime object
  DateTime dateTime = DateTime.parse(date);

  // format date
  String formattedDate = DateFormat(EMMMdy_DateFormat).format(dateTime);

  return formattedDate;
}
