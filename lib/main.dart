import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/bloc/tic_tac_toe_bloc.dart';
import 'package:tic_tac_toe/tic_tac_toe_screen.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
      theme: ThemeData(fontFamily: 'Caveat'),
      home: BlocProvider(
        create: (context) => TicTacToeBloc(),
        child: const TicTacToeScreen(),
      ),
    );
  }
}