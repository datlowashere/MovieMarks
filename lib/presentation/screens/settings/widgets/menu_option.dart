import 'package:flutter/material.dart';

class MenuOption {
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  MenuOption({required this.title, required this.icon, required this.onTap});
}
