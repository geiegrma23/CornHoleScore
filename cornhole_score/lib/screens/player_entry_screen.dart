import 'package:flutter/material.dart';
import 'dart:math';
import 'tournament_setup_screen.dart';  // Import the TournamentSetupScreen

class PlayerEntryScreen extends StatefulWidget {
  @override
  _PlayerEntryScreenState createState() => _PlayerEntryScreenState();
}

class _PlayerEntryScreenState extends State<PlayerEntryScreen> {
  final TextEditingController _playerController = TextEditingController();
  final List<String> _players = [];

  void _addPlayer() {
    if (_playerController.text.isNotEmpty) {
      setState(() {
        _players.add(_playerController.text);
        _playerController.clear();
      });
    }
  }

  void _randomizeTeams() {
    _players.shuffle(Random());
    // Navigate to tournament setup with randomized teams
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TournamentSetupScreen(players: _players), // Use the correct class here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Players'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _playerController,
            decoration: InputDecoration(labelText: 'Enter player name'),
            onSubmitted: (_) => _addPlayer(),
          ),
          ElevatedButton(
            onPressed: _addPlayer,
            child: Text('Add Player'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _players.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_players[index]),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _randomizeTeams,
            child: Text('Randomize Teams and Continue'),
          ),
        ],
      ),
    );
  }
}
