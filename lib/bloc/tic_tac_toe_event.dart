abstract class TicTacToeEvent {}

class TicTacToeMove extends TicTacToeEvent {
  final int row;
  final int col;

  TicTacToeMove(this.row, this.col);
}

class TicTacToeReset extends TicTacToeEvent {}
