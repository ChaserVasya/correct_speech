extension IndexesFilter<E> on List<E> {
  List<int> indexesWhere(bool Function(E) test) {
    final satisfactory = <int>[];
    for (var i = 0; i < length; i++) {
      if (test(this[i])) {
        satisfactory.add(i);
      }
    }
    return satisfactory;
  }
}
