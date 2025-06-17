import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LabeledDateRange extends DateTimeRange {
  final String label;

  LabeledDateRange({
    required super.start,
    required super.end,
    required this.label,
  });

  bool isDateInRange(DateTime other) {
    if (other.isAtSameMomentAs(start) || other.isAtSameMomentAs(end)) {
      return true;
    } else if (other.isAfter(start) && other.isBefore(end)) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    final DateFormat format = DateFormat('HH:mm');
    return '$label (${format.format(start)} - ${format.format(end)})';
  }
}
