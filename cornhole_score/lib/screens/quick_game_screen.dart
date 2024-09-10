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
        const SnackBar(content: Text('Please enter names for both teams')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Team A TextField styled with red color
            TextField(
              controller: teamAController,
              style: const TextStyle(color: Colors.red),  // Team A text in red
              decoration: const InputDecoration(
                labelText: 'Team A Name',
                labelStyle: TextStyle(color: Colors.red),  // Red label text
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),  // Red border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),  // Red border when focused
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            
            // Team B TextField styled with blue color
            TextField(
              controller: teamBController,
              style: const TextStyle(color: Colors.blue),  // Team B text in blue
              decoration: const InputDecoration(
                labelText: 'Team B Name',
                labelStyle: TextStyle(color: Colors.blue),  // Blue label text
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),  // Blue border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),  // Blue border when focused
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            
            // Start Game Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,  // Black background
                foregroundColor: Colors.white,  // White text
              ),
              onPressed: _startGame,
              child: const Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
