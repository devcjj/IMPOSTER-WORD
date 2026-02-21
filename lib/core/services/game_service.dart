import 'package:flutter/foundation.dart';
import 'dart:math';
import '../models/player.dart';
import '../models/word_pair.dart';
import 'word_service.dart';

enum GamePhase { setup, reveal, discussion, voting, results }

/// Game state and logic. Screens use context.read/watch<GameService>().
class GameService extends ChangeNotifier {
  final WordService _wordService = WordService();
  final Random _random = Random();

  List<Player> _players = [];
  int _imposterIndex = -1;
  WordPair? _currentPair;
  String? _wordForCurrentPlayer;
  int _currentRevealPlayerIndex = 0;
  Map<String, String> _votes = {};
  GamePhase _phase = GamePhase.setup;

  List<Player> get players => List.unmodifiable(_players);
  int get imposterIndex => _imposterIndex;
  WordPair? get currentPair => _currentPair;
  String? get wordForCurrentPlayer => _wordForCurrentPlayer;
  int get currentRevealPlayerIndex => _currentRevealPlayerIndex;
  GamePhase get phase => _phase;
  Map<String, String> get votes => Map.unmodifiable(_votes);
  int get playerCount => _players.length;
  bool get allVotesIn => _votes.length == _players.length;

  void startGame(List<String> playerNames) {
    if (playerNames.length < 3 || playerNames.length > 10) return;
    _players = playerNames.asMap().entries.map((e) => Player(
      id: 'p${e.key}',
      name: e.value,
      isImposter: false,
    )).toList();
    _imposterIndex = _random.nextInt(_players.length);
    _players[_imposterIndex] = _players[_imposterIndex].copyWith(isImposter: true);
    _currentPair = _wordService.getRandomPair();
    _currentRevealPlayerIndex = 0;
    _votes = {};
    _phase = GamePhase.reveal;
    _assignWordForCurrentRevealPlayer();
    notifyListeners();
  }

  void _assignWordForCurrentRevealPlayer() {
    if (_players.isEmpty || _currentPair == null) return;
    final p = _players[_currentRevealPlayerIndex];
    _wordForCurrentPlayer = p.isImposter ? _currentPair!.wordForImposter : _currentPair!.wordForMany;
  }

  bool nextRevealPlayer() {
    if (_currentRevealPlayerIndex >= _players.length - 1) return false;
    _currentRevealPlayerIndex++;
    _assignWordForCurrentRevealPlayer();
    notifyListeners();
    return true;
  }

  void startDiscussion() {
    _phase = GamePhase.discussion;
    notifyListeners();
  }

  void startVoting() {
    _phase = GamePhase.voting;
    notifyListeners();
  }

  void submitVote(String voterId, String votedPlayerId) {
    _votes[voterId] = votedPlayerId;
    notifyListeners();
  }

  void finishVoting() {
    _phase = GamePhase.results;
    notifyListeners();
  }

  String? get votedOutPlayerId {
    if (_votes.isEmpty) return null;
    final counts = <String, int>{};
    for (final v in _votes.values) counts[v] = (counts[v] ?? 0) + 1;
    String? maxId;
    int maxCount = 0;
    for (final e in counts.entries) {
      if (e.value > maxCount) {
        maxCount = e.value;
        maxId = e.key;
      }
    }
    return maxId;
  }

  void reset() {
    _players = [];
    _imposterIndex = -1;
    _currentPair = null;
    _wordForCurrentPlayer = null;
    _currentRevealPlayerIndex = 0;
    _votes = {};
    _phase = GamePhase.setup;
    notifyListeners();
  }

  Player? getPlayerById(String id) {
    try {
      return _players.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
