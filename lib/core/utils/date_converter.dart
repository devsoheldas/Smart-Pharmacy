import 'package:intl/intl.dart';


String getNormalTime(String inputDateTime) {
  if (inputDateTime.isEmpty) return '';

  try {
    DateTime dateTime = DateTime.parse(inputDateTime).toLocal();

    // If time is exactly midnight (00:00:00), return empty string
    if (dateTime.hour == 0 && dateTime.minute == 0 && dateTime.second == 0) {
      return '----';
    }

    return DateFormat('hh:mm a').format(dateTime); // e.g., 07:56 AM
  } catch (e) {
    return ''; // Fallback on error
  }
}


String getNormalDate(String inputDateTime){
    if (inputDateTime.isEmpty) {
      return inputDateTime; // Return as it is if input is an empty string
    }

    DateTime dateTime = DateTime.parse(inputDateTime);
    String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);
    return formattedDate;  // 29-Jan-2025
  }

String getNormalDateMonthYear(String inputDateTime){
  if (inputDateTime.isEmpty) {
    return inputDateTime; // Return as it is if input is an empty string
  }

  DateTime dateTime = DateTime.parse(inputDateTime);
  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
  return formattedDate;  // 29-01-2025
}

String getFormattedDateTime(String inputDateTime) {
  if (inputDateTime.isEmpty) {
    return inputDateTime; // Return as it is if input is an empty string
  }

  DateTime dateTime = DateTime.parse(inputDateTime);
  String formattedDate = DateFormat('MMM dd, yyyy hh:mm a').format(dateTime);
  return formattedDate;   // Jan 29,2025 07:02 AM
}

String getTimestampWithTimeZone(DateTime dateTime){
  final String formattedDate = dateTime.toIso8601String().split('.').first; // Get the date-time part without milliseconds
  final Duration offset = dateTime.timeZoneOffset;
  final String hours = offset.inHours.abs().toString().padLeft(2, '0');
  final String minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
  final String sign = offset.isNegative ? '-' : '+';

  return '$formattedDate$sign$hours:$minutes';
}