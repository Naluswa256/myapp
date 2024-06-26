
import 'package:flutter/material.dart';
import 'package:myapp/services/game_service.dart';

class WordGameScreen extends StatefulWidget {
  @override
  _WordGameScreenState createState() => _WordGameScreenState();
}

class _WordGameScreenState extends State<WordGameScreen> {
  final TextEditingController _controller = TextEditingController();
  final GameService _gameService = GameService();
  String _resultMessage = '';

  void _checkWord() async {
    String word = _controller.text;
    bool isCorrect = await _gameService.submitWord(word);

    setState(() {
      _resultMessage = isCorrect ? 'Correct!' : 'Incorrect!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a word',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkWord,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text(_resultMessage),
            const SizedBox(height: 20),
            Text('Score: ${_gameService.score}'),
          ],
        ),
      ),
    );
  }
}