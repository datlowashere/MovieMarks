import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/presentation/screens/watch_list/bloc/watch_list_bloc.dart';
import 'package:movie_marks/presentation/screens/watch_list/bloc/watch_list_event.dart';
import 'package:movie_marks/presentation/screens/watch_list/page/watch_list_body.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<WatchListBloc>(
        create: (context) => WatchListBloc()..add(WatchListInitialEvent()),
        child: const WatchListBody(),
      ),
    );
  }
}
