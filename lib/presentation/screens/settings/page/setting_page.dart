import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_bloc.dart';
import 'package:movie_marks/presentation/screens/settings/bloc/setting_event.dart';
import 'package:movie_marks/presentation/screens/settings/page/setting_body.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (_) => SettingBloc()..add(SettingInitialEvent()),
      child: const SettingBody(),
    );
  }
}
