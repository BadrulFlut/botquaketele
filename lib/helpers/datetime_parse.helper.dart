import 'package:intl/intl.dart';

String dateParse({required DateTime date, String? format}) {
  DateFormat formatter = DateFormat(format ?? 'dd-mm-yyyy');
  String formattedDate = formatter.format(date);
  return formattedDate;
}
