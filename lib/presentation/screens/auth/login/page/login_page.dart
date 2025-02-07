import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import 'login_body.dart';

class LoginPage extends StatelessWidget {
  final bool isStayOnPage;
  final Function()? navigate;

  const LoginPage({super.key, this.isStayOnPage = false, this.navigate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) {
        final bloc = LoginBloc();
        bloc.add(LoginInitialEvent());
        return bloc;
      },
      child: LoginBody(
        isStayOnPage: isStayOnPage,
        navigate: navigate,
      ),
    );
  }
}
