import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/bloc/tic_tac_toe_event.dart';
import 'package:tic_tac_toe/bloc/tic_tac_toe_state.dart';

enum Player { X, O, none }

class TicTacToeBloc extends Bloc<TicTacToeEvent, TicTacToeState> {
  TicTacToeBloc() : super(TicTacToeState(List.generate(3, (_) => List.filled(3, Player.none)), Player.X, Player.none, [])){
    on<TicTacToeMove>((event, emit){
      final board = List<List<Player>>.from(state.board);
      if (board[event.row][event.col] == Player.none) {
        board[event.row][event.col] = state.currentPlayer;
        final (winner, winningSequence) = checkWinner(board, event.row, event.col);
        final currentPlayer = state.currentPlayer == Player.X ? Player.O : Player.X;
        emit(TicTacToeState(board, currentPlayer, winner, winningSequence));
      }
    });
    on<TicTacToeReset>((event, emit){
      emit(TicTacToeState(List.generate(3, (_) => List.filled(3, Player.none)), Player.X, Player.none, []));
    });
  }

  (Player, List<List>) checkWinner(List<List<Player>> board, int row, int col) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != Player.none && board[i][0] == board[i][1] && board[i][1] == board[i][2]) {
        return (board[i][0], [[i,0],[i,1],[i, 2]]);
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] != Player.none && board[0][i] == board[1][i] && board[1][i] == board[2][i]) {
        return (board[0][i], [[0,i], [1,i], [2, i]]);
      }
    }

    // Check diagonals
    if (board[0][0] != Player.none && board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
      return (board[0][0], [[0,0], [1,1], [2,2]]);
    }
    if (board[0][2] != Player.none && board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
      return (board[0][2], [[0,2], [1,1], [2,0]]);
    }

    // Check for a draw
    if (!board.any((row) => row.contains(Player.none))) {
      return (Player.none, []);
    }

    return (Player.none, []);
  }
}