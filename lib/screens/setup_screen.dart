import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/game_service.dart';

/// Setup: player count 3–10, names, then start game.
class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  static const int minPlayers = 3;
  static const int maxPlayers = 10;

  late int _playerCount;
  final List<TextEditingController> _nameControllers = [];
  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    _playerCount = minPlayers;
    _rebuildNameFields();
  }

  @override
  void dispose() {
    for (final c in _nameControllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _rebuildNameFields() {
    for (final c in _nameControllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    _nameControllers.clear();
    _focusNodes.clear();
    for (int i = 0; i < _playerCount; i++) {
      _nameControllers.add(TextEditingController(text: 'Player ${i + 1}'));
      _focusNodes.add(FocusNode());
    }
  }

  void _startGame() {
    final names = _nameControllers
        .map((c) => c.text.trim().isEmpty ? 'Unknown' : c.text.trim())
        .toList();
    context.read<GameService>().startGame(names);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Whispers of the Imposter')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Number of players', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _playerCount > minPlayers
                      ? () => setState(() {
                            _playerCount--;
                            _rebuildNameFields();
                          })
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text('$_playerCount', style: const TextStyle(fontSize: 24)),
                ),
                IconButton(
                  onPressed: _playerCount < maxPlayers
                      ? () => setState(() {
                            _playerCount++;
                            _rebuildNameFields();
                          })
                      : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            Slider(
              value: _playerCount.toDouble(),
              min: minPlayers.toDouble(),
              max: maxPlayers.toDouble(),
              divisions: maxPlayers - minPlayers,
              onChanged: (v) {
                setState(() {
                  _playerCount = v.round();
                  _rebuildNameFields();
                });
              },
            ),
            const SizedBox(height: 16),
            ...List.generate(
              _playerCount,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: _nameControllers[i],
                  focusNode: _focusNodes[i],
                  decoration: InputDecoration(
                    labelText: 'Player ${i + 1}',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _startGame,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Begin the game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
