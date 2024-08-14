import 'dart:collection';

extension StringMapExtension<V> on Map<String, V> {
  Map<String, V> toIgnoreCase() {
    return LinkedHashMap<String, V>(
      equals: (String a, String b) => a.toLowerCase() == b.toLowerCase(),
      hashCode: (String key) => key.toLowerCase().hashCode,
    )..addAll(this);
  }
}
