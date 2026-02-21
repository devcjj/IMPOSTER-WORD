import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/game_service.dart';
import 'screens/setup_screen.dart';
import 'screens/reveal_screen.dart';
import 'screens/discussion_screen.dart';
import 'screens/voting_screen.dart';
import 'screens/results_screen.dart';

void main() {
  runApp(const WhispersApp());
}

class WhispersApp extends StatelessWidget {
  const WhispersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameService(),
      child: MaterialApp(
        title: 'Whispers of the Imposter',
        debugShowCheckedModeBanner: false,
        home: const GameRouter(),
      ),
    );
  }
}

/// Shows one screen based on GameService.phase. Add new phases in game_service.dart and here.
class GameRouter extends StatelessWidget {
  const GameRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameService>(
      builder: (context, game, _) {
        switch (game.phase) {
          case GamePhase.setup:
            return const SetupScreen();
          case GamePhase.reveal:
            return const RevealScreen();
          case GamePhase.discussion:
            return const DiscussionScreen();
          case GamePhase.voting:
            return const VotingScreen();
          case GamePhase.results:
            return const ResultsScreen();
        }
      },
    );
  }
}
