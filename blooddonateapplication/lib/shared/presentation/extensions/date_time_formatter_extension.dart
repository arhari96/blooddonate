import 'package:intl/intl.dart';

extension DateTimeDateFormatter on DateTime? {
  /// Formats the given [DateTime] in the 'dd-MM-yyyy' format.
  ///
  /// If [DateTime] is `null`, returns a dash ('-').
  String get toDDMMYYYY =>
      this == null ? "-" : DateFormat('dd-MM-yyyy').format(this!);

  /// Formats the given [DateTime] in the 'EEEE, dd-MMM-yyyy' format.
  ///
  /// If [DateTime] is `null`, returns a dash ('-').
  String get toDayDDMMMYYYY =>
      this == null ? "-" : DateFormat('EEEE, dd-MMM-yyyy').format(this!);

  String get toMMM_YY =>
      this == null ? "-" : DateFormat('MMM-yy').format(this!);

  String get toMMMYYYY =>
      this == null ? "-" : DateFormat('MMM, yyyy').format(this!);

  String get toMMM_YYYY =>
      this == null ? "-" : DateFormat('MMM - yyyy').format(this!);

  String get toHrMin24Hr => this == null
      ? "-"
      : "${this!.hour.toString().padLeft(2, '0')}: ${this!.minute.toString().padLeft(2, '0')}";

  String get toHrMin12Hr => this == null
      ? "-"
      : "${(this!.hour % 12 == 0 ? 12 : this!.hour % 12).toString().padLeft(2, '0')}:${this!.minute.toString().padLeft(2, '0')}";

  String get toSecPeriod => this == null
      ? "-"
      : "${this!.second.toString().padLeft(2, '0')} ${this!.hour < 12 ? 'AM' : 'PM'}";

  String get toHHMMSS => this == null
      ? "-"
      : "${this!.hour.toString().padLeft(2, '0')}:${this!.minute.toString().padLeft(2, '0')}:${this!.second.toString().padLeft(2, '0')}";

  /// Formats the given [DateTime] in the 'yyyy-MM-dd' format.
  ///
  /// If [DateTime] is `null`, returns a dash ('-').
  String get toYYYYMMDD =>
      this == null ? "-" : DateFormat('yyyy-MM-dd').format(this!);
}
