# Whispers of the Imposter (base)

Offline single-device imposter word party game. **Minimal base**: functionality only, default Flutter UI, no theme. 

---

## File structure

```
lib/
  main.dart              # Entry, Provider, GameRouter
  core/                  # Data & game logic (no UI)
    models/
      player.dart
      word_pair.dart
    services/
      game_service.dart
      word_service.dart
  screens/               # One screen per phase
    setup_screen.dart
    reveal_screen.dart
    discussion_screen.dart
    voting_screen.dart
    results_screen.dart
```
---

## How to run

```bash
flutter pub get
flutter run
```

---

## Game flow

1. **Setup** — 3–10 players, enter names, “Begin the game”.
2. **Reveal** — Pass device; each player taps to see their word (same for all except one imposter).
3. **Discussion** — 60 s timer; “Vote now” to skip.
4. **Voting** — Select player to banish, “Cast vote”.
5. **Results** — Verdict and “Play again”.

State is in `GameService` (Provider). Screens use `context.read<GameService>()` / `context.watch<GameService>()`. No Navigator; the screen shown depends on `GameService.phase`.

---

## Dependencies

- `flutter` (SDK)
- `provider` (state)

No theme package; default Material only.
"# IMPOSTER-WORD" 
