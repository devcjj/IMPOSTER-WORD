# Team structure — 3 people working in parallel

This project is a **minimal base**: only game logic and default Flutter UI. No theme, no custom widgets. Suitable for beginners and for a team of three to extend in parallel with minimal merge conflicts.

---

## Folder layout

```
lib/
  main.dart              # Entry, Provider, GameRouter (shared)
  core/                  # Person 1: Data & game logic
    models/
      player.dart
      word_pair.dart
    services/
      game_service.dart
      word_service.dart
  screens/               # Person 2 & 3: UI
    setup_screen.dart
    reveal_screen.dart
    discussion_screen.dart
    voting_screen.dart
    results_screen.dart
```

---

## Who works on what (suggested split)

| Person | Area | Files | What they can do in parallel |
|--------|------|--------|------------------------------|
| **Person 1** | Core (data + logic) | `core/models/*`, `core/services/*` | Add fields to Player/WordPair, change rules, add word pairs, add new phases |
| **Person 2** | Screens 1 | `setup_screen.dart`, `reveal_screen.dart`, `discussion_screen.dart` | Improve layout, add validation, add animations, change copy |
| **Person 3** | Screens 2 | `voting_screen.dart`, `results_screen.dart` | Same as Person 2 for voting and results |

**Shared (coordinate or rotate):**  
- `main.dart` — only when adding a new phase or screen (then add a case in `GameRouter` and a new screen file).

---

## Rules to avoid conflicts

1. **Person 1** does not change screen files. They only change `core/` and the public API of `GameService` (new methods/getters are fine; changing existing method names or parameters needs a quick sync with the team).
2. **Person 2 & 3** do not change `core/models` or game rules. They use `context.read<GameService>()` and `context.watch<GameService>()` only. They can add new screens and register them in `main.dart` with the team.
3. When adding a **new phase**: Person 1 adds the phase in `game_service.dart` and (if needed) methods; one person adds the screen and the case in `GameRouter` in `main.dart`.

---

## How to run

```bash
flutter pub get
flutter run
```

No theme or assets required; default Material style is used.
