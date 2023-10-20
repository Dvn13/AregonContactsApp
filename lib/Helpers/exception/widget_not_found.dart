class WidgetNotFoundException<T, R> implements Exception {
  final R data;

  WidgetNotFoundException(this.data);
  @override
  String toString() {
    return 'Sınıfın bu durumu yok: $T, $data';
  }
}
