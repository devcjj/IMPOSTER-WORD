import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/game_service.dart';

/// Reveal: pass device to each player; tap to show word. Next / Discuss.
class RevealScreen extends StatefulWidget {
  const RevealScreen({super.key});

  @override
  State<RevealScreen> createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> {
  bool _wordRevealed = false;

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameService>();
    final currentPlayer = game.players.isNotEmpty && game.currentRevealPlayerIndex < game.players.length
        ? game.players[game.currentRevealPlayerIndex]
        : null;
    final word = game.wordForCurrentPlayer ?? '—';
    final hasNext = game.currentRevealPlayerIndex < game.players.length - 1;

    return Scaffold(
      appBar: AppBar(title: const Text('Reveal')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Pass the device to', textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(currentPlayer?.name ?? '—', style: const TextStyle(fontSize: 24)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                if (!_wordRevealed) setState(() => _wordRevealed = true);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Center(
                    child: _wordRevealed
                        ? Text(word, style: const TextStyle(fontSize: 28))
                        : const Text('Tap to reveal your word', style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ),
              ),
            ),
            const Spacer(),
            if (_wordRevealed)
              ElevatedButton(
                onPressed: () {
                  if (hasNext) {
                    game.nextRevealPlayer();
                    setState(() => _wordRevealed = false);
                  } else {
                    game.startDiscussion();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(hasNext ? 'Next player' : 'Everyone has seen — Discuss'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
