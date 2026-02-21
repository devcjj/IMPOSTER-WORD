import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/models/player.dart';
import '../core/services/game_service.dart';

/// Voting: select player to banish, then cast vote.
class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  String? _selectedPlayerId;

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameService>();
    final players = game.players;

    return Scaffold(
      appBar: AppBar(title: const Text('Voting')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Who is the Imposter? Select the player to banish.', textAlign: TextAlign.center),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, i) {
                  final p = players[i];
                  final isSelected = _selectedPlayerId == p.id;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(p.name),
                      selected: isSelected,
                      onTap: () => setState(() => _selectedPlayerId = p.id),
                    ),
                  );
                },
              ),
            ),
            if (_selectedPlayerId != null)
              ElevatedButton(
                onPressed: () {
                  game.submitVote('device', _selectedPlayerId!);
                  game.finishVoting();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Cast vote'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
