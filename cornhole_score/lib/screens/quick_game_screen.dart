import 'package:flutter/material.dart';
import 'game_play_screen.dart';

class QuickGameScreen extends StatefulWidget {
  final bool knockbackRule;  // Accept the knockback rule from HomeScreen

  QuickGameScreen({required this.knockbackRule});  // Constructor

  @override
  _QuickGameScreenState createState() => _QuickGameScreenState();
}

class _QuickGameScreenState extends State<QuickGameScreen> {
  final TextEditingController teamAController = TextEditingController();
  final TextEditingController teamBController = TextEditingController();

  void _startGame() {
    if (teamAController.text.isNotEmpty && teamBController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GamePlayScreen(
            teamAName: teamAController.text,
            teamBName: teamBController.text,
            knockbackRule: widget.knockbackRule,  // Pass the knockback rule to GamePlayScreen
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
