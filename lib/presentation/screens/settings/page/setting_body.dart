import 'package:flutter/material.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Settings +09",
        style: AppTextStyles.beVietNamProStyles.regular16Black,
      ),
    );
  }
}
