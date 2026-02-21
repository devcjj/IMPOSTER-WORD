/// Word pair: one word for majority, one for imposter. Used by WordService.
class WordPair {
  final String wordForMany;
  final String wordForImposter;

  const WordPair({
    required this.wordForMany,
    required this.wordForImposter,
  });
}
