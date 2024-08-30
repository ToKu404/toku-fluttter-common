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
      'Desember'
    ];

    // Get the day name
    String dayName = days[this.weekday - 1];
    // Get the day number
    int day = this.day;
    // Get the month name
    String monthName = months[this.month - 1];
    // Get the year
    int year = this.year;

    // Format the date
    return '$dayName $day $monthName $year';
  }

  String toTime() {
    String time = DateFormat('HH.mm').format(this);
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
      'Desember'
    ];

    // Get the day name
    String dayName = days[this.weekday - 1];
    // Get the day number
    int day = this.day;
    // Get the month name
    String monthName = months[this.month - 1];
    // Get the year
    int year = this.year;

    // Get the time in HH.mm format
    String time = DateFormat('HH.mm').format(this);

    // Format the date
    return '$dayName, $day $monthName $year • $time';
  }

  int toAge() {
    final now = DateTime.now();
    int age = now.year - this.year;

    // Check if the current date is before the birthday this year; if so, subtract 1 from the age
    if (now.month < this.month || (now.month == this.month && now.day < this.day)) {
      age--;
    }

    return age;
  }
}
