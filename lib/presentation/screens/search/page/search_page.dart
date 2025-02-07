import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/presentation/screens/search/bloc/search_bloc.dart';
import 'package:movie_marks/presentation/screens/search/bloc/search_event.dart';
import 'package:movie_marks/presentation/screens/search/page/search_body.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc()..add(const SearchInitialEvent()),
      child: const SearchBody(),
    );
  }
}
