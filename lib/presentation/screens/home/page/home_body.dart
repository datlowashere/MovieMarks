import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/presentation/components/movie_item.dart';
import 'package:movie_marks/presentation/screens/home/bloc/home_bloc.dart';
import 'package:movie_marks/presentation/screens/home/bloc/home_state.dart';
import 'package:movie_marks/presentation/screens/home/widgets/app_bar_home.dart';

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
          return Scaffold(
            backgroundColor: AppColors.charlestonGreen,
            body: SafeArea(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 29),
              child: Column(
                children: [AppBarHome()],
              ),
            )),
          );
        },
      ),
    );
  }
}
