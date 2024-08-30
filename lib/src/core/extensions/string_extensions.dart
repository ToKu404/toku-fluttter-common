extension StringExtensions on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

  String camelCaseToTitleCase() {
    return replaceAllMapped(
      RegExp('([a-z])([A-Z])'),
      (Match m) => '${m.group(1)} ${m.group(2)}',
    ).replaceFirstMapped(
      RegExp('^([a-z])'),
      (Match m) => m.group(1)?.toUpperCase() ?? '',
    );
  }

  String toUnderScoreCase() => camelCaseToTitleCase().split(' ').join('_').toLowerCase();
}
