import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/bloc/tic_tac_toe_bloc.dart';
import 'package:tic_tac_toe/bloc/tic_tac_toe_event.dart';
import 'package:tic_tac_toe/bloc/tic_tac_toe_state.dart';
import 'package:collection/collection.dart';
import 'package:tic_tac_toe/winning_popup.dart';

class TicTacToeScreen extends StatelessWidget {
  const TicTacToeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<TicTacToeBloc, TicTacToeState>(
              builder: (context, state) {
                if (state.winner == Player.none) {
                  if (!state.board.any((row) => row.contains(Player.none))) {
                    return const Text(
                      'It\'s a Draw!',
                      style: TextStyle(
                          fontSize: 48, color: Colors.green),
                    );
                  }
                  return Text(
                    'Player ${state.currentPlayer == Player.X ? 'X' : 'O'}\'s turn',
                    style: const TextStyle(
                        fontSize: 48, color: Colors.deepOrangeAccent),
                  );
                } else {
                  return Text(
                    'Player ${state.winner == Player.X ? 'X' : 'O'} won!!!',
                    style: const TextStyle(
                        fontSize: 48, color: Colors.green),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            BlocConsumer<TicTacToeBloc, TicTacToeState>(
              listener: (context, state) {
                if (state.winningSequence.isNotEmpty) {
                  Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      TicTacToeBloc bloc = context.read<TicTacToeBloc>();
                      showDialog(
                          barrierColor: const Color(0xAAFFFFFF),
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return BlocProvider.value(
                              value: bloc,
                              child: WinningPopup(player: state.winner),
                            );
                          });
                    },
                  );
                }
              },
              builder: (context, state) {
                final board = state.board;
                return Column(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int j = 0; j < 3; j++)
                            GestureDetector(
                              onTap: () {
                                if (state.winningSequence.isEmpty) {
                                  context
                                      .read<TicTacToeBloc>()
                                      .add(TicTacToeMove(i, j));
                                }
                              },
                              child: AnimatedContainer(
                                width: 100,
                                height: 100,
                                margin: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    color: getPlayerColor(board, i, j,
                                        state.winningSequence, state.winner),
                                    border: Border.all(
                                      color: getPlayerBorderColor(board, i, j,
                                          state.winningSequence, state.winner),
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                duration: Duration(
                                    seconds:
                                        state.winner != Player.none ? 1 : 0),
                                child: Center(
                                  child: Text(
                                    board[i][j] == Player.X
                                        ? 'X'
                                        : (board[i][j] == Player.O ? 'O' : ''),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 48,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                        )
                    )
                ),
                onPressed: () {
                  context.read<TicTacToeBloc>().add(TicTacToeReset());
                },
                child: const Text(
                  'Reset Game',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }

  Color getPlayerBorderColor(
    List<List> board,
    int i,
    int j,
    List<List> winningSequence,
    Player winnerPlayer,
  ) {
    if (winningSequence
            .firstWhereOrNull((List data) => data[0] == i && data[1] == j) !=
        null) {
      switch (winnerPlayer) {
        case Player.O:
          return Colors.red;
        case Player.X:
          return Colors.green;
        case Player.none:
          return Colors.purple;
      }
    } else if (winningSequence.isNotEmpty) {
      return Colors.purple;
    } else {
      Player player = board[i][j];
      switch (player) {
        case Player.O:
          return Colors.red;
        case Player.X:
          return Colors.green;
        case Player.none:
          return Colors.purple;
      }
    }
  }

  getPlayerColor(
    List<List> board,
    int i,
    int j,
    List<List> winningSequence,
    Player winnerPlayer,
  ) {
    if (winningSequence
            .firstWhereOrNull((List data) => data[0] == i && data[1] == j) !=
        null) {
      switch (winnerPlayer) {
        case Player.O:
          return Colors.red;
        case Player.X:
          return Colors.green;
        case Player.none:
          return null;
      }
    } else if (winningSequence.isNotEmpty) {
      return Colors.white;
    } else {
      Player player = board[i][j];
      switch (player) {
        case Player.O:
          return Colors.red;
        case Player.X:
          return Colors.green;
        case Player.none:
          return null;
      }
    }
  }
}
