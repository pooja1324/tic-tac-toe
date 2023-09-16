import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/bloc/tic_tac_toe_bloc.dart';
import 'package:tic_tac_toe/bloc/tic_tac_toe_event.dart';

class WinningPopup extends StatelessWidget {
  final Player player;

  const WinningPopup({required this.player, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 5,
      backgroundColor: Colors.deepOrange,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Congratulations!!!', style: TextStyle(fontSize: 32, color: Colors.white)),
            Text('Player ${player.name} won', style: const TextStyle(fontSize: 24, color: Colors.white)),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        side: const BorderSide(color: Colors.red)
                    )
                )
              ),
                onPressed: () {
                  context.read<TicTacToeBloc>().add(TicTacToeReset());
                  Navigator.pop(context);
                },
                child: const Text(
                  'Restart Game',
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
