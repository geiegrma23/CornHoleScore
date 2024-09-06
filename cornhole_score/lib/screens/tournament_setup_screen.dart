import 'package:flutter/material.dart';
import 'game_play_screen.dart';

class TournamentSetupScreen extends StatelessWidget {
  final List<String> players;

  TournamentSetupScreen({required this.players});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournament Setup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to single elimination tournament
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePlayScreen(players: players, isDoubleElimination: false),
                  ),
                );
              },
              child: Text('Single Elimination'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to double elimination tournament
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePlayScreen(players: players, isDoubleElimination: true),
                  ),
                );
              },
              child: Text('Double Elimination'),
            ),
          ],
        ),
      ),
    );
  }
}
