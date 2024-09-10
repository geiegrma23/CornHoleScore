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
  int roundNumber = 1;

  void addPointsToRound(int team, int points) {
    setState(() {
      if (team == 0) {
        roundPointsA += points;
        if (roundPointsA < 0) roundPointsA = 0;
        if (roundPointsA > 12) roundPointsA = 12;
        debugPrint('Team A Round Points: $roundPointsA');
      } else {
        roundPointsB += points;
        if (roundPointsB < 0) roundPointsB = 0;
        if (roundPointsB > 12) roundPointsB = 12;
        debugPrint('Team B Round Points: $roundPointsB');
      }
    });
  }

  void endRound() {
    setState(() {
      int roundDifference = roundPointsA - roundPointsB;

      if (roundDifference > 0) {
        teamAScore += roundDifference;
        debugPrint('Team A wins round. New score: $teamAScore');
      } else if (roundDifference < 0) {
        teamBScore += -roundDifference;
        debugPrint('Team B wins round. New score: $teamBScore');
      } else {
        debugPrint('Round is tied. No score change.');
      }

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

      if (teamAScore >= 21 || teamBScore >= 21) {
        _showWinnerDialog(teamAScore >= 21 ? widget.teamAName : widget.teamBName);
        return;
      }

      roundNumber++;
      roundPointsA = 0;
      roundPointsB = 0;
      debugPrint('Round points reset.');
    });
  }

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
                  roundNumber = 1;
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
                      knockbackRule: widget.knockbackRule,
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
            Text('Round $roundNumber', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            Text('${widget.teamAName} Total Score: $teamAScore', style: const TextStyle(fontSize: 24, color: Colors.red)),
            Text('${widget.teamBName} Total Score: $teamBScore', style: const TextStyle(fontSize: 24, color: Colors.blue)),

            SizedBox(height: 20),

            const Text('Current Round Points', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            Text('${widget.teamAName}: $roundPointsA', style: const TextStyle(fontSize: 22, color: Colors.red)),
            Text('${widget.teamBName}: $roundPointsB', style: const TextStyle(fontSize: 22, color: Colors.blue)),

            const SizedBox(height: 20),

            Text('${widget.teamAName} Scoring', style: const TextStyle(fontSize: 20, color: Colors.red)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => addPointsToRound(0, -1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('-1'),
                ),
                ElevatedButton(
                  onPressed: () => addPointsToRound(0, 1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('+1'),
                ),
                ElevatedButton(
                  onPressed: () => addPointsToRound(0, 3),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('+3'),
                ),
              ],
            ),

            SizedBox(height: 20),

            Text('${widget.teamBName} Scoring', style: TextStyle(fontSize: 20, color: Colors.blue)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => addPointsToRound(1, -1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('-1'),
                ),
                ElevatedButton(
                  onPressed: () => addPointsToRound(1, 1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('+1'),
                ),
                ElevatedButton(
                  onPressed: () => addPointsToRound(1, 3),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('+3'),
                ),
              ],
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: endRound,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: Text('End Round'),
            ),
          ],
        ),
      ),
    );
  }
}
