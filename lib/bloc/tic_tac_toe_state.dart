import 'package:tic_tac_toe/bloc/tic_tac_toe_bloc.dart';

class TicTacToeState {
  final List<List<Player>> board;
  final List<List> winningSequence;
  final Player currentPlayer;
  final Player winner;

  TicTacToeState(this.board, this.currentPlayer, this.winner, this.winningSequence);
}