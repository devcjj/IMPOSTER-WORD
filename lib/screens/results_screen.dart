import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/models/player.dart';
import '../core/services/game_service.dart';

/// Results: who was voted out, was they imposter, who was imposter. Play again.
class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameService>();
    final votedOutId = game.votedOutPlayerId;
    final votedOut = votedOutId != null ? game.getPlayerById(votedOutId) : null;
    final imposterList = game.players.where((p) => p.isImposter).toList();
    final Player? imposter = imposterList.isEmpty ? null : imposterList.first;
    final wasImposterVotedOut = votedOut?.isImposter ?? false;
    final wordPair = game.currentPair;

    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('The verdict', textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('Banished'),
                    const SizedBox(height: 8),
                    Text(votedOut?.name ?? '—', style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: wasImposterVotedOut ? Colors.green.shade100 : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        wasImposterVotedOut ? 'The Imposter was found!' : 'They were innocent...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: wasImposterVotedOut ? Colors.green.shade900 : Colors.red.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (imposter != null) ...[
                      const SizedBox(height: 16),
                      const Text('The Imposter was'),
                      Text(imposter.name, style: const TextStyle(fontSize: 18)),
                    ],
                    if (wordPair != null) ...[
                      const SizedBox(height: 16),
                      Text('Words: "${wordPair.wordForMany}" / "${wordPair.wordForImposter}"',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => game.reset(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Play again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
