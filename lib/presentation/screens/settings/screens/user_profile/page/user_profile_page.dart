import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/bloc/user_profile_bloc.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/bloc/user_profile_event.dart';
import 'package:movie_marks/presentation/screens/settings/screens/user_profile/page/user_profile_body.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserProfileBloc>(
      create: (_) => UserProfileBloc()..add(UserProfileInitialEvent()),
      child: const UserProfileBody(),
    );
  }
}
