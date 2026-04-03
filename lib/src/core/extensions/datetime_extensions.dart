import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toDate() {
    // Define the names of the days and months in Indonesian
    final List<String> days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    final List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    // Get the day name
    final String dayName = days[weekday - 1];
    // Get the day number
    final int day = this.day;
    // Get the month name
    final String monthName = months[month - 1];
    // Get the year
    final int year = this.year;

    // Format the date
    return '$dayName $day $monthName $year';
  }

  String toTime() {
    final String time = DateFormat('HH.mm').format(this);
    return time;
  }

  String toFormattedString() {
    // Define the names of the days and months in Indonesian
    final List<String> days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    final List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    // Get the day name
    final String dayName = days[weekday - 1];
    // Get the day number
    final int day = this.day;
    // Get the month name
    final String monthName = months[month - 1];
    // Get the year
    final int year = this.year;

    // Get the time in HH.mm format
    final String time = DateFormat('HH.mm').format(this);

    // Format the date
    return '$dayName, $day $monthName $year • $time';
  }

  int toAge() {
    final now = DateTime.now();
    int age = now.year - year;

    // Check if the current date is before the birthday this year; if so, subtract 1 from the age
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }

    return age;
  }
}
