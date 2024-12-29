import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/presentation/screens/main/bloc/main_bloc.dart';
import 'package:movie_marks/presentation/screens/main/bloc/main_event.dart';


import 'main_body.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoadingPage =
        ModalRoute.of(context)?.settings.arguments as bool? ?? true;
    return BlocProvider<MainBloc>(
      create: (context) =>
          MainBloc()..add(MainInitialEvent(isLoadingPage: isLoadingPage)),
      child: const MainBody(),
    );
  }
}
