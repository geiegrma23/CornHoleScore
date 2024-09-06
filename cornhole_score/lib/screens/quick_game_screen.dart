import 'package:flutter/material.dart';
import 'game_play_screen.dart';

class QuickGameScreen extends StatefulWidget {
  @override
  _QuickGameScreenState createState() => _QuickGameScreenState();
}

class _QuickGameScreenState extends State<QuickGameScreen> {
  final TextEditingController teamAController = TextEditingController();
  final TextEditingController teamBController = TextEditingController();
  bool knockbackRule = false;

  void _startGame() {
    if (teamAController.text.isNotEmpty && teamBController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GamePlayScreen(
            teamAName: teamAController.text,
            teamBName: teamBController.text,
            knockbackRule: knockbackRule,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter names for both teams')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: teamAController,
              decoration: InputDecoration(labelText: 'Team A Name'),
            ),
            TextField(
              controller: teamBController,
              decoration: InputDecoration(labelText: 'Team B Name'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Switch(
                  value: knockbackRule,
                  onChanged: (value) {
                    setState(() {
                      knockbackRule = value;
                    });
                  },
                ),
                Text('Enable Knockback Rule'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGame,
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
