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

  // New lists to track individual bag scores for each team
  List<int> teamABagScores = [0, 0, 0, 0];
  List<int> teamBBagScores = [0, 0, 0, 0];

  // Function to set points for each bag for Team A or B
  void setBagScore(int team, int bagIndex, int points) {
    setState(() {
      if (team == 0) {
        teamABagScores[bagIndex] = points;
      } else {
        teamBBagScores[bagIndex] = points;
      }
    });
  }

  // Function to calculate the total score for the round
  int calculateRoundScore(List<int> bagScores) {
    return bagScores.fold(0, (prev, curr) => prev + curr);  // Sum of bag points
  }

  // Function to handle the end of a round
  void endRound() {
    setState(() {
      int teamARoundScore = calculateRoundScore(teamABagScores);
      int teamBRoundScore = calculateRoundScore(teamBBagScores);
      int roundDifference = teamARoundScore - teamBRoundScore;

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

      // Reset round points for the next round
      teamABagScores = [0, 0, 0, 0];
      teamBBagScores = [0, 0, 0, 0];
      debugPrint('Round points reset.');
    });
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

            // Display current round points for both teams (bag-by-bag)
            Text('Current Round Points (Bag by Bag)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

            // Team A bag scores
            Text('${widget.teamAName} Bags: ${teamABagScores.join(", ")}'),
            for (int i = 0; i < 4; i++)
              Row(
                children: [
                  Text('Bag ${i + 1}:'),
                  ElevatedButton(
                    onPressed: () => setBagScore(0, i, 1),
                    child: Text('On Board (+1)'),
                  ),
                  ElevatedButton(
                    onPressed: () => setBagScore(0, i, 3),
                    child: Text('In Hole (+3)'),
                  ),
                  ElevatedButton(
                    onPressed: () => setBagScore(0, i, 0),
                    child: Text('Miss (+0)'),
                  ),
                ],
              ),

            SizedBox(height: 20),

            // Team B bag scores
            Text('${widget.teamBName} Bags: ${teamBBagScores.join(", ")}'),
            for (int i = 0; i < 4; i++)
              Row(
                children: [
                  Text('Bag ${i + 1}:'),
                  ElevatedButton(
                    onPressed: () => setBagScore(1, i, 1),
                    child: Text('On Board (+1)'),
                  ),
                  ElevatedButton(
                    onPressed: () => setBagScore(1, i, 3),
                    child: Text('In Hole (+3)'),
                  ),
                  ElevatedButton(
                    onPressed: () => setBagScore(1, i, 0),
                    child: Text('Miss (+0)'),
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
