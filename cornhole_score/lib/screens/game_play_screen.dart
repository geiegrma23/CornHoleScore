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
  int roundPointsA = 0;  // Total points for the round for Team A
  int roundPointsB = 0;  // Total points for the round for Team B
  int roundNumber = 1;  // Track the current round

  // Function to handle scoring for Team A or Team B
  void addPointsToRound(int team, int points) {
    setState(() {
      if (team == 0) {
        roundPointsA += points;
        if (roundPointsA < 0) roundPointsA = 0;  // Ensure points don't go negative
        if (roundPointsA > 12) roundPointsA = 12;  // Max points per round is 12
        debugPrint('Team A Round Points: $roundPointsA');
      } else {
        roundPointsB += points;
        if (roundPointsB < 0) roundPointsB = 0;  // Ensure points don't go negative
        if (roundPointsB > 12) roundPointsB = 12;  // Max points per round is 12
        debugPrint('Team B Round Points: $roundPointsB');
      }
    });
  }

  // Function to handle the end of the round
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

      // Check for winner before resetting round points
      if (teamAScore >= 21 || teamBScore >= 21) {
        _showWinnerDialog(teamAScore >= 21 ? widget.teamAName : widget.teamBName);
        return;  // Stop further round processing
      }

      // Increment the round number
      roundNumber++;

      // Reset round points for the next round
      roundPointsA = 0;
      roundPointsB = 0;
      debugPrint('Round points reset.');
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
                  roundNumber = 1;  // Reset round number when the game restarts
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
                  MaterialPageRoute(
                    builder: (context) => QuickGameScreen(
                      knockbackRule: widget.knockbackRule,  // Pass the knockbackRule here
                    ),
                  ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Display the round counter
            Text('Round $roundNumber', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            // Display total scores for both teams
            Text('${widget.teamAName} Total Score: $teamAScore', style: TextStyle(fontSize: 24)),
            Text('${widget.teamBName} Total Score: $teamBScore', style: TextStyle(fontSize: 24)),

            SizedBox(height: 20),

            // Emphasize current round points section
            Text('Current Round Points', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            Text('${widget.teamAName}: $roundPointsA', style: TextStyle(fontSize: 22)),
            Text('${widget.teamBName}: $roundPointsB', style: TextStyle(fontSize: 22)),

            SizedBox(height: 20),

            // Buttons for Team A scoring
            Text('${widget.teamAName} Scoring', style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => addPointsToRound(0, -1),
                  child: Text('-1'),
                ),
                ElevatedButton(
                  onPressed: () => addPointsToRound(0, 1),
                  child: Text('+1'),
                ),
                ElevatedButton(
                  onPressed: () => addPointsToRound(0, 3),
                  child: Text('+3'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Buttons for Team B scoring
            Text('${widget.teamBName} Scoring', style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => addPointsToRound(1, -1),
                  child: Text('-1'),
                ),
                ElevatedButton(
                  onPressed: () => addPointsToRound(1, 1),
                  child: Text('+1'),
                ),
                ElevatedButton(
                  onPressed: () => addPointsToRound(1, 3),
                  child: Text('+3'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // End round button
            ElevatedButton(
              onPressed: endRound,
              child: Text('End Round'),
            ),
          ],
        ),
      ),
    );
  }
}
