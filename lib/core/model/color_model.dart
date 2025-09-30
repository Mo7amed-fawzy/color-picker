import 'package:flutter/material.dart';

/// Simple model for a saved color with timestamp and json helpers.
class SavedColor {
  final Color color;
  final DateTime createdAt;

  SavedColor({required this.color, DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();

  /// Convert to hex string like "#AARRGGBB"
  String toHex() {
    final argb = color.toARGB32(); // ← ده بيديك الـ int الـ 32bit
    return '#${argb.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  /// JSON serializable (useful for saving/exporting)
  Map<String, dynamic> toJson() => {
    'value': color.toARGB32(),
    'createdAt': createdAt.toIso8601String(),
  };

  factory SavedColor.fromJson(Map<String, dynamic> json) {
    final int v =
        json['value'] is int
            ? json['value'] as int
            : int.parse('${json['value']}');
    final String dt =
        json['createdAt'] as String? ?? DateTime.now().toIso8601String();
    return SavedColor(color: Color(v), createdAt: DateTime.parse(dt));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedColor &&
          runtimeType == other.runtimeType &&
          color.toARGB32() == other.color.toARGB32() &&
          createdAt == other.createdAt;

  @override
  // int get hashCode => color.value.hashCode ^ createdAt.hashCode;
  int get hashCode => color.toARGB32().hashCode ^ createdAt.hashCode;
}
