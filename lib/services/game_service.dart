// services/game_service.dart
import 'firestore_service.dart';

class GameService {
  final FirestoreService _firestoreService = FirestoreService();
  int _score = 0;

  int get score => _score;

  Future<bool> submitWord(String word) async {
    bool wordExists = await _firestoreService.checkWordExists(word);
    if (wordExists) {
      _score++;
      return true;
    }
    return false;
  }
}
