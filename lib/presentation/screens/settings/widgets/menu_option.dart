import 'dart:ui';
import 'package:flutter/material.dart';

class MenuOption {
  final String title;
  final TextStyle textStyle;
  final Widget icon;
  final VoidCallback onTap;

  MenuOption({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.textStyle,
  });
}
