import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringDateFormatter on String? {
  /// Formats the given [String] in the 'dd-MM-yyyy' format.
  ///
  /// If [String] is `null`, returns a dash ('-').
  String get toDDMMYYYY => this == null
      ? "-"
      : DateFormat('dd-MM-yyyy').format(DateTime.parse(this!));

  /// Formats the given [String] in the 'h:mm a' format.
  ///
  /// If [String] is `null`, returns a dash ('-').
  String get toHMMA => this == null || this!.isEmpty
      ? "-"
      : DateFormat('HH:mm a').format(DateTime.parse(this!));

  /// Formats the given [DateTime] in the 'yyyy-MM-dd' format.
  ///
  /// If [DateTime] is `null`, returns a dash ('-').
  String get toYYYYMMDD => this == null
      ? "-"
      : DateFormat('yyyy-MM-dd').format(DateTime.parse(this!));
  String get toMMMYYY => this == null
      ? "-"
      : DateFormat('MMM - yyyy').format(DateTime.parse(this!));
  String get toDDMMMYYYY => this == null
      ? "-"
      : DateFormat('dd-MMM-yyyy').format(DateTime.parse(this!));

  String get toDay =>
      this == null ? "-" : DateFormat('E').format(DateTime.parse(this!));

  String get toDD =>
      this == null ? "-" : DateFormat('dd').format(DateTime.parse(this!));

  String get toEEEMMMdYYYY => this == null
      ? "-"
      : DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(this!));

  String get toTimeHMPeriod {
    if (this == null || this!.isEmpty) return "-";

    List<String> time = this!.split(':');

    int hour = int.parse(time[0]);
    int minutes = int.parse(time[1]);
    int seconds = int.parse(time[2]);

    String period = hour < 12 ? "AM" : "PM";

    return "${(hour % 12 == 0 ? 12 : hour % 12).toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} $period";
  }

  double? get toSeconds {
    if (this == null) return null;

    List<String> timeParts = this!.split(':');

    double? hour = double.tryParse(timeParts[0]);
    double? minute = double.tryParse(timeParts[1]);
    double? second = double.tryParse(timeParts[2]);

    return (hour ?? 0) * 3600 + (minute ?? 0) * 60 + (second ?? 0);
  }

  TimeOfDay? get toTimeOfDay {
    return this == null
        ? null
        : TimeOfDay(
            hour: int.parse(this!.substring(0, 2)),
            minute: int.parse(this!.substring(3, 5)),
          );
  }

  String? diffInHHMM(String? fromTime) {
    if (this == null || fromTime == null) return null;

    double startSeconds = toSeconds ?? 0;
    double endSeconds = fromTime.toSeconds ?? 0;

    double differenceSeconds = endSeconds - startSeconds;

    int hours = differenceSeconds ~/ 3600;
    double remainingSeconds = differenceSeconds % 3600;
    int minutes = (remainingSeconds / 60).round();

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    return "$formattedHours:$formattedMinutes Hrs";
  }
}
