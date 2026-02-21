import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/game_service.dart';

/// Discussion: 60s countdown. Vote now or wait.
class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  static const int totalSeconds = 60;
  int _remainingSeconds = totalSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = totalSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        if (mounted) context.read<GameService>().startVoting();
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discussion')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Find the imposter among you', textAlign: TextAlign.center),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Text('Time remaining'),
                    const SizedBox(height: 8),
                    Text('$_remainingSeconds', style: const TextStyle(fontSize: 48)),
                    const Text('seconds'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _timer?.cancel();
                context.read<GameService>().startVoting();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Vote now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
