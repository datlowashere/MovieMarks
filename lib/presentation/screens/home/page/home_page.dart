import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/presentation/screens/home/bloc/home_bloc.dart';
import 'package:movie_marks/presentation/screens/home/bloc/home_event.dart';

import 'home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoadingPage =
        ModalRoute.of(context)?.settings.arguments as bool? ?? true;
    return BlocProvider<HomeBloc>(
      create: (context) =>
          HomeBloc()..add(HomeInitialEvent(isLoadingPage: isLoadingPage)),
      child: const HomeBody(),
    );
  }
}

