import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool knockbackRule = false;

  void toggleKnockbackRule(bool value) {
    setState(() {
      knockbackRule = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(
        knockbackRule: knockbackRule,
        onToggleKnockbackRule: toggleKnockbackRule,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool knockbackRule;
  final Function(bool) onToggleKnockbackRule;

  HomeScreen({required this.knockbackRule, required this.onToggleKnockbackRule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cornhole Scoring App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuickGameScreen(knockbackRule: knockbackRule),
                  ),
                );
              },
              child: Text('Quick Game'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Knockback Rule'),
                Switch(
                  value: knockbackRule,
                  onChanged: onToggleKnockbackRule,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuickGameScreen extends StatelessWidget {
  final bool knockbackRule;

  QuickGameScreen({required this.knockbackRule});

  final TextEditingController teamAController = TextEditingController();
  final TextEditingController teamBController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: teamAController,
              decoration: InputDecoration(labelText: 'Team A Name'),
            ),
            TextField(
              controller: teamBController,
              decoration: InputDecoration(labelText: 'Team B Name'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePlayScreen(
                      teamAName: teamAController.text.isNotEmpty ? teamAController.text : 'Team A',
                      teamBName: teamBController.text.isNotEmpty ? teamBController.text : 'Team B',
                      knockbackRule: knockbackRule,
                    ),
                  ),
                );
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}

class GamePlayScreen extends StatefulWidget {
  final String teamAName;
  final String teamBName;
  final bool knockbackRule;

  GamePlayScreen({required this.teamAName, required this.teamBName, required this.knockbackRule});

  @override
  _GamePlayScreenState createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  List<int> teamAScore = [0];
  List<int> teamBScore = [0];
  int roundPointsA = 0;
  int roundPointsB = 0;

  void addPointsToRound(int team, int points) {
    if (team == 0) {
      if (roundPointsA + points <= 12) {
        roundPointsA += points;
      }
    } else {
      if (roundPointsB + points <= 12) {
        roundPointsB += points;
      }
    }
    setState(() {});
  }

  void endRound() {
    int scoreA = teamAScore[teamAScore.length - 1];
    int scoreB = teamBScore[teamBScore.length - 1];

    scoreA += roundPointsA;
    scoreB += roundPointsB;

    if (widget.knockbackRule) {
      if (scoreA > 21) {
        scoreA = 15;
      }
      if (scoreB > 21) {
        scoreB = 15;
      }
    }

    teamAScore.add(scoreA);
    teamBScore.add(scoreB);

    roundPointsA = 0;
    roundPointsB = 0;

    setState(() {});
  }

  void updateScores() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Play'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${widget.teamAName}: ${teamAScore.last}', style: TextStyle(fontSize: 24)),
          Text('${widget.teamBName}: ${teamBScore.last}', style: TextStyle(fontSize: 24)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
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
              Column(
                children: [
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
            ],
          ),
          ElevatedButton(
            onPressed: endRound,
            child: Text('End Round'),
          ),
        ],
      ),
    );
  }
}
