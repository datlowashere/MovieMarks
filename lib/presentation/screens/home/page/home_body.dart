import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/presentation/components/movie_item.dart';
import 'package:movie_marks/presentation/screens/home/bloc/home_bloc.dart';
import 'package:movie_marks/presentation/screens/home/bloc/home_state.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {},
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return const Scaffold(
            body: Center(
              child: MovieItem(),
            ),
          );
        },
      ),
    );
  }
}
