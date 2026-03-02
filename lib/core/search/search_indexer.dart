class SearchIndexer {
  const SearchIndexer();

  String normalize(String input) {
    return input
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  String buildIndex(Iterable<String?> tokens) {
    return normalize(tokens.whereType<String>().join(' '));
  }
}
