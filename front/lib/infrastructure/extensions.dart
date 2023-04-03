extension ListExtensions<E> on List<E> {
  List<int> indexesWhere(bool Function(E) test) {
    final satisfactory = <int>[];
    for (var i = 0; i < length; i++) {
      if (test(this[i])) {
        satisfactory.add(i);
      }
    }
    return satisfactory;
  }

  E? singleWhereOrVoid(bool Function(E) test) {
    try {
      return singleWhere(test);
    } catch (e) {
      if (e is StateError) {
        return null;
      } else {
        rethrow;
      }
    }
  }
}

extension MapExtension<A, B> on Map<A, B> {
  Map<B, A> invert() {
    return map((a, b) => MapEntry(b, a));
  }
}
