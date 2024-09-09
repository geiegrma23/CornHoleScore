import 'package:flutter/material.dart';
import 'quick_game_screen.dart';

class GamePlayScreen extends StatefulWidget {
  final String teamAName;
  final String teamBName;
  final bool knockbackRule;

  GamePlayScreen({
    required this.teamAName,
    required this.teamBName,
    required this.knockbackRule,
  });

  @override
  _GamePlayScreenState createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  int teamAScore = 0;
  int teamBScore = 0;
  int roundPointsA = 0;
  int roundPointsB = 0;

  // Function to add points to the current round for each team
  void addPointsToRound(int team, int points) {
    setState(() {
      if (team == 0) {
        roundPointsA += points;
        debugPrint('Team A round points: $roundPointsA');
      } else {
        roundPointsB += points;
        debugPrint('Team B round points: $roundPointsB');
      }
    });
  }

  // Function to handle the end of a round
  void endRound() {
    setState(() {
      int roundDifference = roundPointsA - roundPointsB;

      if (roundDifference > 0) {
        // Team A wins the round
        teamAScore += roundDifference;
        debugPrint('Team A wins round. New score: $teamAScore');
      } else if (roundDifference < 0) {
        // Team B wins the round
        teamBScore += -roundDifference;
        debugPrint('Team B wins round. New score: $teamBScore');
      } else {
        // Tied round, no score changes
        debugPrint('Round is tied. No score change.');
      }

      // Apply knockback rule if necessary
      if (widget.knockbackRule) {
        if (teamAScore > 21) {
          teamAScore = 15;
          debugPrint('Knockback rule applied to Team A');
        }
        if (teamBScore > 21) {
          teamBScore = 15;
          debugPrint('Knockback rule applied to Team B');
        }
      }

      // Reset round points
      roundPointsA = 0;
      roundPointsB = 0;
      debugPrint('Round points reset: Team A: $roundPointsA, Team B: $roundPointsB');

      // Check for winner
      if (teamAScore >= 21 || teamBScore >= 21) {
        _showWinnerDialog(teamAScore >= 21 ? widget.teamAName : widget.teamBName);
      }
    });
  }

  // Dialog to show the winner
  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('$winner wins!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  teamAScore = 0;
                  teamBScore = 0;
                  roundPointsA = 0;
                  roundPointsB = 0;
                });
                Navigator.of(context).pop();
              },
              child: Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => QuickGameScreen()),
                );
              },
              child: Text('New Teams'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Quit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Play'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Display total scores for both teams
            Text('${widget.teamAName} Total Score: $teamAScore', style: TextStyle(fontSize: 24)),
            Text('${widget.teamBName} Total Score: $teamBScore', style: TextStyle(fontSize: 24)),

            SizedBox(height: 20),

            // Display current round points for both teams
            Text('Current Round Points', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('${widget.teamAName} Round Points: $roundPointsA', style: TextStyle(fontSize: 20)),
            Text('${widget.teamBName} Round Points: $roundPointsB', style: TextStyle(fontSize: 20)),

            SizedBox(height: 20),

            // Buttons to add points to round
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => addPointsToRound(0, 1),
                      child: Text('+1 to ${widget.teamAName}'),
                    ),
                    ElevatedButton(
                      onPressed: () => addPointsToRound(0, 3),
                      child: Text('+3 to ${widget.teamAName}'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => addPointsToRound(1, 1),
                      child: Text('+1 to ${widget.teamBName}'),
                    ),
                    ElevatedButton(
                      onPressed: () => addPointsToRound(1, 3),
                      child: Text('+3 to ${widget.teamBName}'),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            // End round button
            ElevatedButton(
              onPressed: endRound,
              child: Text('THERE IS NO GOAL. END Round'),
            ),
          ],
        ),
      ),
    );
  }
}
