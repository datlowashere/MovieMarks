import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/data/models/user_model.dart';
import 'package:movie_marks/presentation/screens/auth/verification/bloc/verification_bloc.dart';
import 'package:movie_marks/presentation/screens/auth/verification/bloc/verification_event.dart';
import 'package:movie_marks/presentation/screens/auth/verification/body/verification_body.dart';

class VerificationPage extends StatefulWidget {
  final UserModel? userModel;
  const VerificationPage({super.key, this.userModel});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerificationBloc>(
      create: (context) {
        final bloc = VerificationBloc();
        bloc.add(VerificationInitialEvent(userModel: widget.userModel ));
        return bloc;
      },
      child: const VerificationBody(),
    );
  }
}
