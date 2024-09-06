import 'package:flutter/material.dart';
import 'quick_game_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool knockbackEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cornhole Score App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SwitchListTile(
              title: Text('Enable Knockback'),
              value: knockbackEnabled,
              onChanged: (bool value) {
                setState(() {
                  knockbackEnabled = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuickGameScreen(),
                  ),
                );
              },
              child: Text('Quick Game'),
            ),
          ],
        ),
      ),
    );
  }
}
