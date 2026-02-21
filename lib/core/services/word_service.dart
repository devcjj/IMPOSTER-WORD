import 'dart:math';
import '../models/word_pair.dart';

/// Offline word pairs. Edit _pairs to add/change words.
class WordService {
  static final Random _random = Random();

  static const List<WordPair> _pairs = [
    WordPair(wordForMany: 'Dragon', wordForImposter: 'Wyvern'),
    WordPair(wordForMany: 'Sword', wordForImposter: 'Dagger'),
    WordPair(wordForMany: 'Castle', wordForImposter: 'Fortress'),
    WordPair(wordForMany: 'Potion', wordForImposter: 'Elixir'),
    WordPair(wordForMany: 'Knight', wordForImposter: 'Paladin'),
    WordPair(wordForMany: 'King', wordForImposter: 'Emperor'),
    WordPair(wordForMany: 'Island', wordForImposter: 'Peninsula'),
    WordPair(wordForMany: 'Crown', wordForImposter: 'Tiara'),
    WordPair(wordForMany: 'Lantern', wordForImposter: 'Torch'),
    WordPair(wordForMany: 'Scroll', wordForImposter: 'Tome'),
    WordPair(wordForMany: 'Wizard', wordForImposter: 'Sorcerer'),
    WordPair(wordForMany: 'Dungeon', wordForImposter: 'Labyrinth'),
    WordPair(wordForMany: 'Treasure', wordForImposter: 'Hoard'),
    WordPair(wordForMany: 'Spell', wordForImposter: 'Incantation'),
    WordPair(wordForMany: 'Shield', wordForImposter: 'Buckler'),
    WordPair(wordForMany: 'Tavern', wordForImposter: 'Inn'),
    WordPair(wordForMany: 'Quest', wordForImposter: 'Odyssey'),
    WordPair(wordForMany: 'Realm', wordForImposter: 'Kingdom'),
    WordPair(wordForMany: 'Chalice', wordForImposter: 'Goblet'),
    WordPair(wordForMany: 'Throne', wordForImposter: 'Seat'),
  ];

  WordPair getRandomPair() => _pairs[_random.nextInt(_pairs.length)];
}
