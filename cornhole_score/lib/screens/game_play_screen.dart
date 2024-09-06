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

  void addPointsToRound(int team, int points) {
    setState(() {
      if (team == 0) {
        if (roundPointsA + points <= 12) {
          roundPointsA += points;
        }
      } else {
        if (roundPointsB + points <= 12) {
          roundPointsB += points;
        }
      }
      debugPrint("Team A Round Points: $roundPointsA");
      debugPrint("Team B Round Points: $roundPointsB");
    });
  }

  void endRound() {
    setState(() {
      int roundDifference = roundPointsA - roundPointsB;

      if (roundDifference > 0) {
        teamAScore += roundDifference;
      } else if (roundDifference < 0) {
        teamBScore += -roundDifference;
      }

      if (widget.knockbackRule) {
        if (teamAScore > 21) {
          teamAScore = 15;
        }
        if (teamBScore > 21) {
          teamBScore = 15;
        }
      }

      roundPointsA = 0;
      roundPointsB = 0;

      debugPrint("Team A Score: $teamAScore");
      debugPrint("Team B Score: $teamBScore");

      if (teamAScore >= 21 || teamBScore >= 21) {
        _showWinnerDialog(teamAScore >= 21 ? widget.teamAName : widget.teamBName);
      }
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
            Text('${widget.teamAName}: $teamAScore', style: TextStyle(fontSize: 24)),
            Text('${widget.teamBName}: $teamBScore', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Round Scores', style: TextStyle(fontSize: 20)),
            Text('${widget.teamAName}: $roundPointsA', style: TextStyle(fontSize: 20)),
            Text('${widget.teamBName}: $roundPointsB', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
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
