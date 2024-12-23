import 'package:flutter/material.dart';
import 'package:movie_marks/presentation/screens/settings/page/setting_body.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return const SettingBody();
  }
}
