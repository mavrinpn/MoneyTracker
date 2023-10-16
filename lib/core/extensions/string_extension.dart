extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String trimLengthWithEllipsis(int limit) {
    const terminator = '...';
    return length > limit
        ? '${substring(0, limit - terminator.length)}$terminator'
        : this;
  }
}
